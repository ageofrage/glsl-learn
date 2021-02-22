precision mediump float;
uniform float u_time; // time
uniform vec2  u_resolution; // resolution

void main(void){
  /* ----------------------------------- 正規化 ---------------------------------- */
  vec2 normCoord = (gl_FragCoord.xy * 2.0 - u_resolution) / min(u_resolution.x, u_resolution.y);

  /* ---------------------------------- color --------------------------------- */
  float red = abs(sin(u_time));
  float green = abs(sin(u_time * 1.1));
  float blue = abs(sin(u_time * 0.7));
  vec3 destColor = vec3(red, blue, green);

  /* --------------------------------- パーティクル --------------------------------- */ 
  float particle = 0.0;
  for(int i = 0; i < 24; i++){
    // int型からfloat型へ変換
    float i_float = float(i + 1);
    // float velocity = i_float / 10.0;
    float rad = 0.628318;
    float orbitRadius = 1.0 / 6.0;
    float sin = sin(u_time + i_float * rad);
    float cos = cos(u_time + i_float * rad);
    vec2 origin = normCoord + vec2(cos, sin) * orbitRadius;
    particle += 0.002 / abs(length(origin) - 0.4);
  }

/* ----------------------------------- 出力 ----------------------------------- */
  gl_FragColor = vec4(vec3(destColor * particle), 1.0);
}