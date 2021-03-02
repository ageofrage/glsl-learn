precision mediump float;
uniform float u_time; // time
uniform vec2  u_resolution; // resolution

void main(void){
  /* ----------------------------------- 正規化 ---------------------------------- */
  vec2 normCoord = (gl_FragCoord.xy * 2.0 - u_resolution) / min(u_resolution.x, u_resolution.y);
  vec2 gridNormCoord = mod(normCoord, 0.6) - 0.3;
  float sin_t = sin(u_time);
  float cos_t = cos(u_time);
  gridNormCoord *= mat2(
    1.0, 0.0,
    0.0, 1.0
  );
  /* ---------------------------------- color --------------------------------- */
  float red = abs(sin(u_time));
  float green = abs(sin(u_time * 1.1));
  float blue = abs(sin(u_time * 0.7));
  vec3 destColor = vec3(red, blue, green);

  /* --------------------------------- パーティクル --------------------------------- */ 
  float particle = 0.0;
  for(int i = 0; i < 12; i++){
    // int型からfloat型へ変換
    float i_float = float(i + 1);
    float velocity = i_float / 2.0;
    float orbitRadius = 1.0 / 10.0;
    vec2 origin = gridNormCoord + vec2(cos(u_time * 0.5 + velocity), sin(u_time + velocity)) * orbitRadius;
    particle += 0.002 / abs(length(origin) - orbitRadius);
  }

/* ----------------------------------- 出力 ----------------------------------- */
  gl_FragColor = vec4(vec3(destColor * particle), 1.0);
}