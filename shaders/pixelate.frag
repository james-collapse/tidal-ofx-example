#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec2 pixelate(in vec2 _st, in float _pixels){
    return ceil(_st * _pixels)/_pixels;
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);

    vec2 pixelated = pixelate(st, 16.0);

    color = vec3(pixelated,0.0);
	
	gl_FragColor = vec4(color,1.0);
}