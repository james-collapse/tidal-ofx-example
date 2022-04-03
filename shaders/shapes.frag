#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float square(in vec2 st,
    		 in float width_min,
             in float height_min,
    		 in float width_max,
    		 in float height_max) {
    vec2 bl = step(vec2(width_min, height_min), st);
    float pct = bl.x * bl.y;
    vec2 tr = step(vec2(1.0 - width_max, 1.0 - height_max), 1.0 - st);
    pct *= tr.x * tr.y;
    return pct;
}

float line(in float point,
           in float centre,
           in float width) {
    return step(centre - width, point) - step(centre + width, point);
}

float circle(in vec2 _st,
    		 in float _radius,
             in vec2 _centre) {
    return step(_radius, distance(_st,_centre));
}

float circle_smooth(in vec2 _st,
    		        in float _radius,
                    in float _t,
                    in vec2 _centre) {
    return smoothstep(_radius - _t, _radius, distance(_st,_centre));
}

float circle_dot(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

float outline(in vec2 _st,
    		in float _radius,
            in vec2 _centre) {
    return step(_radius - 0.005, distance(_st, _centre))
         - step(_radius + 0.005, distance(_st, _centre));
}

vec3 invert(in vec3 _input){
    return vec3(1.0) - _input;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    float pct2 = square(st, 0.1, 0.1, 0.2, 0.2);
    color = vec3(pct2);

    gl_FragColor = vec4(color,1.0);
}