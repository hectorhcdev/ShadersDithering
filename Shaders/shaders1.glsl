uniform vec2 sketchSize;
uniform sampler2D texture;
uniform sampler2D noiseTexture;

float scale=0.5;
float res=8.0;

float color2gray(vec3 source){
	return length(source*vec3(0.25,0.75,0.0));
}

vec3 getNoisePixels(){
	return texture2D(noiseTexture, vec2(mod(gl_FragCoord.xy/vec2(res,res),1.0))).xyz;
}


void main(void) {
		
	vec2 uv=gl_FragCoord.xy / sketchSize.xy;
	vec3 ditherMask=getNoisePixels();
	vec3 source=texture2D(texture, uv).rgb;
	
	float grayscale=color2gray(source);
	float ditherGrayscale=(ditherMask.x + ditherMask.y + ditherMask.z) / 3.0;
	
	ditherGrayscale-=scale;
	float ditheredResult=grayscale + ditherGrayscale;
	float bit=ditheredResult>=0.5? 1.0 : 0.0;
	
	gl_FragColor=vec4(bit,bit,bit,1);
	
}