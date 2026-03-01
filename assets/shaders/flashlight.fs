#define PI 3.14159265358979323846

extern vec2 center_pos;
extern float dist;
extern float time;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float psin(float x) {
    return (1+sin(x))/2;
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(hash(i + vec2(0.0, 0.0)), hash(i + vec2(1.0, 0.0)), u.x),
        mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x),
        u.y
    );
}

float fbm(vec2 p) {
    float val = 0.0;
    float amp = 0.5;
    for (int i = 0; i < 5; i++) {
        val += amp * noise(p);
        p *= 2.0;
        amp *= 0.5;
    }
    return val;
}

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 tc, vec2 screen_coords )
{

    vec4 tex = Texel(texture, tc);
    

    vec2 uv = screen_coords / love_ScreenSize.xy;

    // Sky base turbulence
    float angle = time * 0.03;
    mat2 rot = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
    vec2 ruv = rot * (uv - 0.5) + 0.5;
    float skyBase = pow(fbm(ruv * 4.0), 1.6);

    // Orange glow wash
    float glow = smoothstep(0.1, 0.9, uv.y);
    vec3 orangeSky = mix(vec3(1.0, 0.1, 0.15), vec3(0.2, 0.05, 0.05), glow);

    // Forked lightning filaments
    vec2 fork1UV = uv * vec2(12.0, 2.5) + vec2(time * 0.1, sin(time * 0.5) * 0.2);
    float fork1 = smoothstep(0.6, 1.0, fbm(fork1UV));

    vec2 fork2UV = uv * vec2(12.0, 2.5) + vec2(time * 0.07 + 1.3, cos(uv.y * 10.0 + time));
    float fork2 = smoothstep(0.6, 1.0, fbm(fork2UV));

    float tendrilMask = clamp(fork1 + 0.5 * fork2, 0.0, 1.0);

    // Sky reaction — warm glow burst + green lightning aura
    float reactionFalloff = exp(-8.0 * abs(uv.y - 0.25));
    vec3 warmFlash = vec3(1.0, 0.5, 0.2) * tendrilMask * reactionFalloff * 0.4;
    vec3 lightningAura = vec3(0.0, 1.0, 0.6) * tendrilMask * reactionFalloff * 0.7;

    // Final blend
    vec3 baseColor = mix(vec3(skyBase), orangeSky, 0.6);
    vec3 finalColor = baseColor + warmFlash + lightningAura;

    tex.rgb = tex.rgb * ((dist - distance(center_pos, screen_coords))/dist) + finalColor * (1 - ((dist - distance(center_pos, screen_coords))/dist)) * 0.25;

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif