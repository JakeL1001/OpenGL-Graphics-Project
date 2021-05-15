varying vec4 color;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded

uniform sampler2D texture;
uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform float Shininess;
uniform float texScale;
uniform vec3 pos;

void main()
{
    //vec3 lightDir   = normalize(lightPosition - pos);
    //vec3 viewDir    = normalize(ModelView - pos);
    //vec3 halfwayDir = normalize(lightDir + viewDir);

    //float spec = pow(max(dot(normal, halfwayDir), 32.0), shininess);
    //vec3 specular = lightColor * spec;

    gl_FragColor = color * texture2D( texture, texCoord * 2.0 );
}