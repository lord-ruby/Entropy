extern float power;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
	vec2 uv = screen_coords/love_ScreenSize.xy;
	float dx = abs(uv.x-0.5)*abs(uv.x-0.5);
	float dy = abs(uv.y-0.5)*abs(uv.y-0.5);
	float a = sqrt(dx+dy);
	a *= a;
	a = pow(a, power);
	a = 2. * (1. - a);
	if (a > 1.) {a = 1.;};
	a = 1. - a;
    return tex * vec4(1-a, 1-a, 1-a, 1);
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif