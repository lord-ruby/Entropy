extern float power;
extern float realtime;

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

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
	vec2 uv = screen_coords/love_ScreenSize.xy;
	float dx = abs(uv.x-0.5);
	float dy = abs(uv.y-0.5);

	float dist = 3*sqrt(dx*dx + dy*dy)*(0.25+power/10);

	float a = min(dist, 1);

	a *= a;

	float noise = pNoise(uv + realtime/2., 10) + pNoise(uv*2.5 - realtime*1.6, 20) + pNoise(uv*11.6 + realtime * 0.1, 7) + pNoise(uv*11.6 - realtime * 0.21, 7);

	noise = (pow(noise, 3) + pow(noise, 4)) + 0.05*power;

	vec4 col = vec4(1,0,0,1);
	col = col * noise + vec4(0,0,0,1) * (1-noise);

    return tex*(1-a)+col*(a);
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif