varying vec4 color;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded
varying vec3 Nvec, Evec, Lvec, Lvec2;

uniform sampler2D texture;

uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct, AmbientProduct2, DiffuseProduct2, SpecularProduct2;
uniform mat4 ModelView;
uniform float Shininess;

void main()
{
	vec3 N = normalize(Nvec);
	vec3 L = normalize(Lvec);
    vec3 E = normalize(Evec);

    float distToLight = length(Lvec);
	float atten = 1.0/(0.5 + 0.1*distToLight + 0.1*(distToLight*distToLight));

	vec3 H = normalize(L+E);
	vec3 ambient = AmbientProduct;

	float Kd = max(dot(L,N),0.0);
	vec3 diffuse = (Kd * DiffuseProduct);

	float Ks = pow(max(dot(N,H),0.0), Shininess);
	vec3 specular = (Ks * SpecularProduct);

	if (dot(L, N) < 0.0 ) {
	    specular = vec3(0.0, 0.0, 0.0);
    } 
    
    vec3 L2 = normalize(Lvec2);
    vec3 H2 = normalize(L+E);
	vec3 ambient2 = AmbientProduct2;

	float Kd2 = max(dot(L2,N),0.0);
	vec3 diffuse2 = (Kd2 * DiffuseProduct2);

	float Ks2 = pow(max(dot(N,H2),0.0), Shininess);
	vec3 specular2 = (Ks2 * SpecularProduct2);

	if (dot(L2, N) < 0.0 ) {
	    specular2 = vec3(0.0, 0.0, 0.0);
    } 

	vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
	
    vec4 color2 = atten  * vec4(globalAmbient + ambient + diffuse + ambient2 + specular2, 1.0);

    gl_FragColor = color2 * texture2D( texture, texCoord * 2.0 ) + vec4(specular + specular2, 1.0);
}