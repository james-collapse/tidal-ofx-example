#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float u_pulse; // Brightness value
uniform float u_disp;  // Displacement value

float g(in float _x, in float _size){
    
    float a = step(0.,_x + _size);
    float b = step(0.,-_x + _size);
    return a * b;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    // Move the coordinate system to the centre
    // (0.5, 0.5) -> (0.0, 0.0)
    st -= vec2(0.5);

    // shift the coordinate system up by u_disp/10.0
    st -= vec2(0.0, u_disp/10.0);

    // Create a 'bump' from x = -0.1 to x = 0.1
    float a = g(st.x, 0.1);
    // Create a 'bump' from y = -0.1 to x = 0.1
    float b = g(st.y, 0.1);
    float c = a * b;

    vec3 p = vec3(0.0);
    p.rgb  = vec3(u_pulse);

    vec3 color = c * p;

    gl_FragColor = vec4(color,1.0);
}