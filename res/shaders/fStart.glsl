varying vec4 color;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded

uniform sampler2D texture;

varying vec3 Nvec, Evec, Lvec, Lvec2;

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

	if(dot(L,N) < 0.0)
	{
		specular = vec3(0.0,0.0,0.0);
	}
    // $$$$$$$$$$$$$$$$$$$$$$$4
    vec3 H = normalize(L+E);
	vec3 ambient = AmbientProduct;

	float Kd = max(dot(L,N),0.0);
	vec3 diffuse = (Kd * DiffuseProduct);

	float Ks = pow(max(dot(N,H),0.0), Shininess);
	vec3 specular = (Ks * SpecularProduct);

	if(dot(L,N) < 0.0)
	{
		specular = vec3(0.0,0.0,0.0);
	}

	vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
	
    vec4 color2 = atten  * vec4(globalAmbient + ambient + diffuse, 1.0);

    gl_FragColor = color2 * texture2D( texture, texCoord * 2.0 ) + vec4(specular, 1.0);
}