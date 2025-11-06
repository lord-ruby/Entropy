#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 brimstone_badge;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec2 uibox_pos;
extern MY_HIGHP_OR_MEDIUMP vec2 uibox_size;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

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

vec4 HSVtoRGB(vec4 hsv) {
    vec4 rgb;

    float h = hsv.x * 6.0;
    float c = hsv.z * hsv.y;
    float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
    float m = hsv.z - c;

    if (h < 1.0) {
        rgb = vec4(c, x, 0.0, hsv.a);
    } else if (h < 2.0) {
        rgb = vec4(x, c, 0.0, hsv.a);
    } else if (h < 3.0) {
        rgb = vec4(0.0, c, x, hsv.a);
    } else if (h < 4.0) {
        rgb = vec4(0.0, x, c, hsv.a);
    } else if (h < 5.0) {
        rgb = vec4(x, 0.0, c, hsv.a);
    } else {
        rgb = vec4(c, 0.0, x, hsv.a);
    }

    rgb.rgb += m;

    return rgb;
}

#define PI 3.14159265358979323846

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}



vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;
    vec2 uv = (screen_coords - uibox_pos) / (uibox_size.xy * screen_scale * 2);
    uv.x = uv.x * (love_ScreenSize.x/love_ScreenSize.y);
    uv.y = uv.y / (20.);

    vec4 hsl = HSL(vec4(tex.r, tex.g, tex.b, tex.a));

    //float fuckyouGSL = min(0, 0.001 * (brimstone_badge.x + uibox_size.x + uibox_pos.x + screen_scale + time));

    float t = time + brimstone_badge.y * 0.32151;

    float scale_const = 1;

    float cx = uv.x * scale_const * 0.7;
    float cy = uv.y * scale_const * 100;

    //t *= 5;


    hsl.x = 0;
    hsl.y = 0.9;
    hsl.z = 0;

    float pulse = pow(2 * abs(pow(
        mod(-0.16 * cy - 0.15 * t 
        - sin(5.2 * cx + 0.3 * t)/2
        - sin(12.3 * cx + 0.11 * t)/5
        , 1), 2) - 0.5), 2);

    float flame1 = max(0, pow((sin(11.3 * cx - sin(7.17 * t))), 2) + pow((sin(2.44 * cy + 8.17 * t - sin(2.19 * t + cx))), 2));
    float flame2 = max(0, pow((sin(23.9 * cx - sin(6.94 * t))), 2) + pow((sin(1.21 * cy + 13.41 * t - sin(0.83 * t + cx))), 2));
    float flame3 = max(0, pow((sin(44.1 * cx - sin(4.77 * t))), 2) + pow((sin(0.66 * cy + 9.14 * t - sin(1.23 * t + cx))), 2));
    //float flame4 = max(0, pow((sin(44.1 * cx - sin(4.77 * t))), 2) + pow((sin(0.66 * cy + 9.14 * t - sin(1.23 * t + cx))), 2));
    
    hsl.z += (flame1 + flame2 + flame3 + 1)/2 * pulse;

    hsl.z = pow(hsl.z, 2)/(pow(hsl.z, 2) + 1);
    
    //hsl.z += flame1 + flame2;// * pulse;

    number low = min(tex.r, min(tex.g, tex.b));
    number high = max(tex.r, max(tex.g, tex.b));
	number delta = high-low -0.1;


    vec4 rgb = HSVtoRGB(hsl);

    //rgb.r += flame1;
    //rgb.b += flame2;
    //rgb.g += flame3;

    return vec4(rgb.r, rgb.g, rgb.b, 1);
}