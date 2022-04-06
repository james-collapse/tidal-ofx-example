#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_orbit_0;
uniform float u_orbit_1;    
uniform float u_orbit_2;
uniform float u_orbit_3;

float s (in float t) {
  return 1.0 - smoothstep(0.1,0.9,t);
}

float orbit (in vec2 st) {
  float y0 = s(u_orbit_0);
  float y1 = s(u_orbit_1);
  float y2 = s(u_orbit_2);
  float y3 = s(u_orbit_3);

  float begin = 0.20;
  float end = 0.30;
  float begin2 = 0.70;
  float end2 = 0.80;

  return y0 * (step(begin2, st.y) - step(end2, st.y)) * (step(begin, st.x) - step(end, st.x)) +
         y1 * (step(begin2, st.y) - step(end2, st.y)) * (step(begin2, st.x) - step(end2, st.x)) +
         y2 * (step(begin, st.y) - step(end, st.y)) * (step(begin, st.x) - step(end, st.x)) + +
         y3 * (step(begin, st.y) - step(end, st.y)) * (step(begin2, st.x) - step(end2, st.x));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    float c = orbit(st);
    vec3 green = vec3(0.0, 1.0, 0.0);

    gl_FragColor = vec4(vec3(c) * green,1.0);
}