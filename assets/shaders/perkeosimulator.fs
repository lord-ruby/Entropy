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
	vec2 uv = screen_coords;
	float drunk = sin(realtime*2.0)*2.5;
	float unitDrunk1 = (sin(realtime*1.2)+1.0)/2.0;
	float unitDrunk2 = (sin(realtime*1.8)+1.0)/2.0;

	vec2 normalizedCoord = mod((uv.xy + vec2(0, drunk)) / love_ScreenSize.xy, 1.0);
	normalizedCoord.x = pow(normalizedCoord.x, mix(1.025, 0.985, unitDrunk1));
	normalizedCoord.y = pow(normalizedCoord.y, mix(1.025, 0.985, unitDrunk2));

	vec2 normalizedCoord2 = mod((uv.xy + vec2(drunk, 0)) / love_ScreenSize.xy, 1.0);	
	normalizedCoord2.x = pow(normalizedCoord2.x, mix(0.985, 1.025, unitDrunk2));
	normalizedCoord2.y = pow(normalizedCoord2.y, mix(0.985, 1.025, unitDrunk1));

	vec2 normalizedCoord3 = uv.xy/love_ScreenSize.xy;
	
	vec4 color = Texel(texture, normalizedCoord);	
	vec4 color2 = Texel(texture, normalizedCoord2);
	vec4 color3 = Texel(texture, normalizedCoord3);

	// Mess with colors and test swizzling
	color.x = pow(color2.x, 0.85);
	color2.x = pow(color2.x, 0.85);
	
	vec4 finalColor = mix( mix(color, color2, mix(0.4, 0.6, unitDrunk1)), color3, 0.4);
	
	// 
	if (length(finalColor) > 1.4)
		finalColor.xy = mix(finalColor.xy, normalizedCoord3, 0.5);
	else if (length(finalColor) < 0.4)
		finalColor.yz = mix(finalColor.yz, normalizedCoord3, 0.5);
		
	return finalColor;	
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif