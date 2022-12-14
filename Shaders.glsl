float sdCircle( vec2 p, float r )
{
    return (length(p) - r);
}

float sdMoon(vec2 p, float d, float ra, float rb )
{
    p.y = abs(p.y);
    float a = (ra*ra - rb*rb + d*d)/(2.0*d);
    float b = sqrt(max(ra*ra-a*a,0.0));
    if( d*(p.x*b-p.y*a) > d*d*max(b-p.y,0.0) )
    return length(p-vec2(a,b));
    return max( (length(p)-ra),
    -(length(p-vec2(d,0))-rb));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (1.0*fragCoord)/(iResolution.xy);
    uv.y *= (iResolution.y/iResolution.x);
    

    float distCircle = sdCircle(uv-vec2(0.45,0.275),0.25);
    float distMoon = sdMoon(uv-vec2(0.45,0.275),0.05,0.25,0.25);

    // Time varying pixel color
    float currentTime = 0.5 + 0.5*cos(iTime);
    
    vec3 dynamicCol = 0.2 + 0.4*cos(iTime+uv.xyx+vec3(0.5,2,0.5));
    float func = mix(distMoon, distCircle, currentTime);
    vec3 col = mix(dynamicCol, vec3(0.7,0.4,0.2),step(0.005,func));

    // Output to screen
    fragColor = vec4(col,3.0);
    
}