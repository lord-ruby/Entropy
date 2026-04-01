#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP number vort_speed;
extern MY_HIGHP_OR_MEDIUMP vec4 colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 colour_2;
extern MY_HIGHP_OR_MEDIUMP number mid_flash;
extern MY_HIGHP_OR_MEDIUMP number vort_offset;
extern MY_HIGHP_OR_MEDIUMP float fade_in;
extern MY_HIGHP_OR_MEDIUMP float flame_height;

#define PIXEL_SIZE_FAC 700.
#define BLACK 0.6*vec4(79./255.,99./255., 103./255., 1./0.6)

#define timeScale 			time * 1.0
#define fireMovement 		vec2(-0.01, -0.5)
#define distortionMovement	vec2(-0.01, -0.3)
#define normalStrength		40.0
#define distortionStrength	0.1

float rand(vec2 co) {
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec2 hash( vec2 p ) {
	p = vec2( dot(p,vec2(127.1,311.7)),
			  dot(p,vec2(269.5,183.3)) );

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float hashf(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise( in vec2 p ) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(hashf(i + vec2(0.0, 0.0)), hashf(i + vec2(1.0, 0.0)), u.x),
        mix(hashf(i + vec2(0.0, 1.0)), hashf(i + vec2(1.0, 1.0)), u.x),
        u.y
    );
}

float fbm ( in vec2 p ) {
    float f = 0.0;
    p.x = mod(p.x+500, 1000);
    p.y = mod(p.y+500, 1000);
    mat2 m = mat2( 1.6,  1.2, -1.2,  1.6 );
    f  = 0.5000*noise(p); p = m*p;
    f += 0.2500*noise(p); p = m*p;
    f += 0.0625*noise(p); p = m*p;
    f = 0.5 + 0.5 * f;
    return f;
}

/** DISTORTION **/
vec3 bumpMap(vec2 uv) { 
    uv.x = mod(uv.x+500, 1000);
    uv.y = mod(uv.y+500, 1000);
    vec2 s = 1./love_ScreenSize.xy;
    float p =  fbm(uv);
    float h1 = fbm(uv + s * vec2(1., 0));
    float v1 = fbm(uv + s * vec2(0, 1.));
       
   	vec2 xy = (p - vec2(h1, v1)) * normalStrength;
    return vec3(xy + .5, 1.);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    //Convert to UV coords (0-1) and floor for pixel effect
    MY_HIGHP_OR_MEDIUMP number pixel_size = length(love_ScreenSize.xy)/PIXEL_SIZE_FAC;
    MY_HIGHP_OR_MEDIUMP vec2 uv = screen_coords.xy/love_ScreenSize.xy;
    MY_HIGHP_OR_MEDIUMP number uv_len = length(uv);
    uv.y=1.-uv.y;

    // //Adding in a center swirl, changes with time
    // MY_HIGHP_OR_MEDIUMP number speed = time*vort_speed;
    // MY_HIGHP_OR_MEDIUMP number new_pixel_angle = atan(uv.y, uv.x) + (2.2 + 0.4*min(6.,speed))*uv_len - 1. -  speed*0.05 - min(6.,speed)*speed*0.02 + vort_offset;
    // MY_HIGHP_OR_MEDIUMP vec2 mid = (love_ScreenSize.xy/length(love_ScreenSize.xy))/2.;
    // MY_HIGHP_OR_MEDIUMP vec2 sv = vec2((uv_len * cos(new_pixel_angle) + mid.x), (uv_len * sin(new_pixel_angle) + mid.y)) - mid;

	// //Now add the smoke effect to the swirled UV

    // sv *= 30.;
    // speed = time*(6.)*vort_speed + vort_offset + 1033.;
	// MY_HIGHP_OR_MEDIUMP vec2 uv2 = vec2(sv.x+sv.y);

    // for(int i=0; i < 5; i++) {
	// 	uv2 += sin(max(sv.x, sv.y)) + sv;
	// 	sv  += 0.5*vec2(cos(5.1123314 + 0.353*uv2.y + speed*0.131121),sin(uv2.x - 0.113*speed));
	// 	sv  -= 1.0*cos(sv.x + sv.y) - 1.0*sin(sv.x*0.711 - sv.y);
	// }

    // //Make the smoke amount range from 0 - 2
	// MY_HIGHP_OR_MEDIUMP number smoke_res =min(2., max(-2., 1.5 + length(sv)*0.12 - 0.17*(min(10.,time*1.2 - 4.))));
    // if (smoke_res < 0.2) {
    //     smoke_res = (smoke_res - 0.2)*0.6 + 0.2;
    // }
    
    // MY_HIGHP_OR_MEDIUMP number c1p = max(0.,1. - 2.*abs(1.-smoke_res));
    // MY_HIGHP_OR_MEDIUMP number c2p = max(0.,1. - 2.*(smoke_res));
    // MY_HIGHP_OR_MEDIUMP number cb = 1. - min(1., c1p + c2p);

    // MY_HIGHP_OR_MEDIUMP vec4 ret_col = colour_1*c1p + colour_2*c2p + vec4(cb*BLACK.rgb, cb*colour_1.a);
    // MY_HIGHP_OR_MEDIUMP number mod_flash = max(mid_flash*0.8, max(c1p, c2p)*5. - 4.4) + mid_flash*max(c1p, c2p);
    // float dist = (uv.x)*(uv.x)+(uv.y)*(uv.y);
    // ret_col.a = fade_in;
    // return ret_col*(0.15 - mod_flash) + mod_flash*vec4(1.5, .2, .55, fade_in)*1.7*((sin(dist/10. + time/2.)+3.)/2.);
    float t = time + 130;
    vec3 normal = bumpMap(uv * vec2(1.0, 0.3) + distortionMovement * t);
    vec2 displacement = clamp((normal.xy - .5) * distortionStrength, -1., 1.);
    uv += displacement; 
    vec2 uvT = (uv * vec2(1.0, 0.5)) + t * fireMovement;
    float n = pow(fbm(8.0 * uvT), 1.0);    
    
    float gradient = pow(1.0 - uv.y, 2.0) * 5.;
    float finalNoise = n * gradient;
    
    vec3 color = finalNoise * vec3(2.,2., 2.);
    vec3 col = vec3(1, 0.25, 0.2 + (sin(.7*t)+1.)/2.);
    color.x *= pow(n, 1./col.x);
    color.y *= pow(n, 1./col.y);
    color.z *= pow(n, 1./col.z);
    return vec4(color * flame_height, fade_in);
}