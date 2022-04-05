#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_orbit_0;
uniform float u_orbit_1;    
uniform float u_orbit_2;
uniform float u_orbit_3;

float orbit (in vec2 st) {
  return u_orbit_0 * step(0.5, st.y) * (1 - step(0.5, st.x)) +
         u_orbit_1 * step(0.5, st.y) * step(0.5, st.x) +
         u_orbit_2 * (1 - step(0.5, st.y)) * (1 - step(0.5, st.x)) +
         u_orbit_3 * (1 - step(0.5, st.y)) * step(0.5, st.x);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    float c = orbit(st);

    gl_FragColor = vec4(vec3(c),1.0);
}