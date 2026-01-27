#define PI 3.14159265358979323846

extern vec2 center_pos;
extern float dist;
extern float time;

float rand(vec2 c){
    return fract(sin(dot(c.xy,vec2(12.9898,78.233)))*43758.5453);
}

float lindist(float a,float b){
    return abs(a-b);
}

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
	return hsl;
}

vec2 polar_coords(vec2 pos,vec2 origin){
    vec2 normalized=pos-origin;
    origin=vec2(0.,0.);
    float r=distance(normalized,origin);
    float theta=atan(normalized.y,normalized.x);
    
    return vec2(r,theta);
}

float min_dist=dist;
float max_dist=2*dist;

float get_t(vec2 pos){
    float d=distance(center_pos,pos);
    float t=0.;
    if(min_dist<d&&d<max_dist){
        t=1.;
    }
    return t;
}

vec3 hash( vec3 p ) // replace this by something better
{
	p = vec3( dot(p,vec3(127.1,311.7, 74.7)),
			  dot(p,vec3(269.5,183.3,246.1)),
			  dot(p,vec3(113.5,271.9,124.6)));

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}
float noise( in vec3 p )
{
    vec3 i = floor( p );
    vec3 f = fract( p );
	
	vec3 u = f*f*(3.0-2.0*f);

    return mix( mix( mix( dot( hash( i + vec3(0.0,0.0,0.0) ), f - vec3(0.0,0.0,0.0) ), 
                          dot( hash( i + vec3(1.0,0.0,0.0) ), f - vec3(1.0,0.0,0.0) ), u.x),
                     mix( dot( hash( i + vec3(0.0,1.0,0.0) ), f - vec3(0.0,1.0,0.0) ), 
                          dot( hash( i + vec3(1.0,1.0,0.0) ), f - vec3(1.0,1.0,0.0) ), u.x), u.y),
                mix( mix( dot( hash( i + vec3(0.0,0.0,1.0) ), f - vec3(0.0,0.0,1.0) ), 
                          dot( hash( i + vec3(1.0,0.0,1.0) ), f - vec3(1.0,0.0,1.0) ), u.x),
                     mix( dot( hash( i + vec3(0.0,1.0,1.0) ), f - vec3(0.0,1.0,1.0) ), 
                          dot( hash( i + vec3(1.0,1.0,1.0) ), f - vec3(1.0,1.0,1.0) ), u.x), u.y), u.z );
}

// This is what actually changes the look of card
vec4 effect(vec4 colour,Image texture,vec2 tc,vec2 screen_coords)
{
    vec4 tex=Texel(texture,tc);
    
    float t=0.;
    float c=3;
    float iterated=0.;
    vec2 sc=screen_coords;//alias
    vec2 cep=center_pos;//ditto
    
    for(float ix=-c;ix<=c;ix++){
        for(float iy=-c;iy<=c;iy++){
            t+=get_t(vec2(screen_coords.x+ix,screen_coords.y+iy));
            iterated++;
        }
    }
    t/=iterated;
    
    vec4 inverted=tex;
    inverted.g=0;
    inverted.b = 0;
    inverted = HSL(inverted);
    inverted.r = time/3.;
    inverted = RGB(inverted);

    vec3 stars_direction = normalize(vec3((screen_coords/love_ScreenSize.xy) * 2.0f - 1.0f, 1.0f)); // could be view vector for example
	float stars_threshold = 8.0f; // modifies the number of stars that are visible
	float stars_exposure = 200.0f; // modifies the overall strength of the stars
	float stars = pow(clamp(noise(stars_direction * 200.0f), 0.0f, 1.0f), stars_threshold) * stars_exposure;
	stars *= mix(0.4, 1.4, noise(stars_direction * 100.0f + vec3(time * 5.))); // time based flickering

    inverted += vec4(vec3(stars),1.0);

    tex=(t*inverted)+((1-t)*tex);
    
    float strength=lindist(t,0.5);
    if(strength<.2){
        tex.rgb=vec3(0);
    }
    
    float cdist=distance(center_pos,screen_coords);
    float max_mult = 2;
    float rad = dist / 10.0;
    if (cdist < min_dist) {
        float str = (rad - abs(min_dist-cdist)) / rad;
        tex.rgb *= max(str*max_mult,1.0);
    }

    if (cdist > max_dist) {
        float str = (rad - abs(max_mult-cdist)) / rad;
        tex.rgb *= max(str*max_mult,1.0);
    }
    
    return tex;
}

#ifdef VERTEX
vec4 position(mat4 transform_projection,vec4 vertex_position)
{
    return transform_projection*vertex_position;
}
#endif