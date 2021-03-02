precision mediump float;
uniform float u_time; // time
uniform vec2  u_resolution; // resolution

const float PI = 3.14159;
const float golden_ratio = (1.0 + sqrt(5.0)) / 2.0;
const float golden_rad = 2.0 * PI * (1.0 + golden_ratio);

float rad(float rad){
  return PI * rad;
}

vec2 modCoord(vec2 coord, float modNum){
  vec2 gridCoord = mod(coord, modNum) - modNum / 2.0;
  return gridCoord;
}

void main(void){
  /* ----------------------------------- 正規化 ---------------------------------- */
  vec2 normCoord = (gl_FragCoord.xy * 2.0 - u_resolution) / min(u_resolution.x, u_resolution.y);
  vec2 gridNormCoord = modCoord(normCoord, 0.0);
  gridNormCoord *= mat2(
    cos(u_time), -sin(u_time),
    sin(u_time), cos(u_time)
  );
  /* ---------------------------------- color --------------------------------- */
  vec3 destColor = vec3(0.05, 0.05, 0.0);

  /* --------------------------------- パーティクル --------------------------------- */ 
  float particle = 0.0;
  for(int i = 1; i <= 300; i++){
    // int型からfloat型へ変換
    float i_float = float(i + 1);
    float i_rad = golden_rad * i_float;
    float orbitRadius = sqrt(i_float) / sqrt(300.0) * sin(u_time * 0.3) * 2.0;
    vec2 origin = gridNormCoord + vec2(cos(i_rad), sin(i_rad)) * orbitRadius;
    particle += 0.025 / abs(length(origin));
  }

/* ----------------------------------- 出力 ----------------------------------- */
  gl_FragColor = vec4(vec3(destColor * particle), 0.8);
}