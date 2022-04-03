#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float rand (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec3 bottomHalf (in vec2 st, in float speed, in float res) {
    st.x -= u_time*speed;
    vec2 i = floor(st);
    float y = rand(i);
    float s = 1.0 - step(res/2.0, st.y);
    return vec3(y*s);
}

vec3 topHalf (in vec2 st, in float speed, in float res) {
    st.x += u_time*speed;
    vec2 i = floor(st);
    float y = rand(i);
    float s = step(res/2.0, st.y);
    return vec3(y*s);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);
    
    float res = 16.0;
    st *= res;

    vec3 a = bottomHalf(st, 2.0, res);
    vec3 b = topHalf(st, 8.0, res);

    color = a + b;
	
	gl_FragColor = vec4(color,1.0);
}