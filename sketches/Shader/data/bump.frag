#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform int u_orbit;   // Orbit

float orbit (in vec2 st) {
  if (u_orbit == 1) {
    return step(0.5, st.y) * (1 - step(0.5, st.x));
  } else {
    return 0.0;
  }
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.);

    float c = orbit(st);
    
    color = vec3(c);

    gl_FragColor = vec4(color,1.0);
}