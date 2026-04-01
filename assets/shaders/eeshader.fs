#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

// Card rotation
extern PRECISION vec2 eeshader;

extern PRECISION number dissolve;
extern PRECISION number realtime;
extern PRECISION number     time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;
extern Image second_image;
extern PRECISION number distort_mod;
extern PRECISION number redshift;



number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	hsl.y = 0.0;
	hsl.z = hsl.z;
	return hsl;
}

#define PI 3.14159265358979323846

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float noise(vec2 p, float freq ){
	float unit = 1./freq;
	vec2 ij = floor(p/unit);
	vec2 xy = mod(p,unit)/unit;
	//xy = 3.*xy*xy-2.*xy*xy*xy;
	xy = .5*(1.-cos(PI*xy));
	float a = rand((ij+vec2(0.,0.)));
	float b = rand((ij+vec2(1.,0.)));
	float c = rand((ij+vec2(0.,1.)));
	float d = rand((ij+vec2(1.,1.)));
	float x1 = mix(a, b, xy.x);
	float x2 = mix(c, d, xy.x);
	return mix(x1, x2, xy.y);
}

float pNoise(vec2 p, int res){
	float persistance = .5;
	float n = 0.;
	float normK = 0.;
	float f = 4.;
	float amp = 1.;
	int iCount = 0;
	p.x = mod(p.x+2000, 4000);
	p.y = mod(p.y+2000, 4000);
	for (int i = 0; i<50; i++){
		n+=amp*noise(p, f);
		f*=2.;
		normK+=amp;
		amp*=persistance;
		if (iCount == res) break;
		iCount++;
	}
	float nf = n/normK;
	return nf*nf*nf*nf;
}

float cf(float x) {
	if(x > .5) return 1.;
	return 0.;
}

vec2 cfv2(vec2 x) {
	return vec2(cf(x.x), cf(x.y));
}

vec4 dissolve_mask(vec4 final_pixel, vec2 texture_coords, vec2 uv);
// texture_coords = coolds of a original_pixel within the atlas texture
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel( texture, texture_coords);
    vec2 real_uv = screen_coords;
	vec2 uv = screen_coords/love_ScreenSize.xy;

    float dummy = 2;
    if(shadow) {dummy = 3;}
    if(uv.x > uv.x * 2) {uv = eeshader*dissolve*burn_colour_1.x*burn_colour_2.x*time*dummy*texture_details.x*image_details.x;}

    float sprite_width = texture_details.z / image_details.x; // Normalized width
    float min_x = texture_details.x * sprite_width; // min X
    float max_x = (texture_details.x + 1.) * sprite_width; // max X

    float tilt_normalized = eeshader.x;

    float shiftX = 2.5 * sin(uv.y * (10.16 + 30.0 * uv.y * uv.y) + tilt_normalized * 1.5) // sine shift + affected by card rotation
                                            / image_details.x; // shift X so normalize by X

    float newX = min(max_x, max(min_x, texture_coords.x + shiftX));
    
	float horizontDistance = abs(uv.y);
	float smallWaves = sin((uv.y+realtime*.01)*45.)*.06;
	float horizontalRipples = smallWaves / (horizontDistance*horizontDistance*1000. + 1.)*distort_mod;

	
	float squiglyVerticalPoints = uv.x + smallWaves*.08;
	float verticalRipples = sin((squiglyVerticalPoints+realtime*.01)*60.) * .005*distort_mod;
	
	vec4 img = Texel(texture, vec2(texture_coords.x + verticalRipples*uv.y*uv.y*0.66, texture_coords.y - horizontalRipples*uv.y*uv.y*0.66));

	vec2 distort1 = vec2(cos(realtime + uv.y * .1) * 0.05 - cos(realtime) * 0.1, realtime*0.3);
    vec2 distort2 = vec2(sin(realtime + uv.y * .05) * 0.025 - cos(realtime) * 0.1, realtime*0.5);
	float spark1 = cf(pNoise((uv + distort1)*25., 10));
    float spark2 = cf(pNoise((uv + distort2)*25., 10));
    float brightness = 8.;
    float spark = (spark1 + spark2) * exp(-dot(uv-0.5, uv-0.5) * 2.);
    vec3 col = vec3(1.0, 0.2, 0.3) * spark * vec3(1.0, spark, spark);

	vec2 _distort1 = vec2(cos(realtime + uv.y * .01) * 0.05 - cos(realtime) * 0.1, realtime*0.1);
    vec2 _distort2 = vec2(sin(realtime + uv.y * .005) * 0.025 - cos(realtime) * 0.1, realtime*0.15);
	float _spark1 = 1.-pNoise(uv + _distort1, 10);
    float _spark2 = 1.-pNoise(uv + _distort2, 10);
    float _brightness = 8.;
    float _spark = (_spark1 + _spark2) * exp(-dot(uv-0.5, uv-0.5) * 2.);
    vec3 _col = vec3(1.0, 0.3, 0.3) * _spark * vec3(1.0, _spark, _spark);
	return img + vec4(col, 1)*0.7 + vec4(_col,1)*0.15 + vec4(redshift,0,0,1)*0.01;
}



vec4 dissolve_mask(vec4 final_pixel, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : final_pixel.xyz, shadow ? final_pixel.a*0.3: final_pixel.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (final_pixel.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            final_pixel.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            final_pixel.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : final_pixel.xyz, res > adjusted_dissolve ? (shadow ? final_pixel.a*0.3: final_pixel.a) : .0);
}



extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif