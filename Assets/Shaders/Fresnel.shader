Shader "Unlit/Fresnel"
{
    Properties
    {
        _FresnelPower ("Fresnel Power", Float) = 1
        [HDR] _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 viewDir : TEXCOORD0;
                float3 worldNormal : NORMAL;
            };

            float _FresnelPower;
            fixed4 _FresnelColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.viewDir = float4(_WorldSpaceCameraPos - worldPos.xyz, 0);

                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // fresnelDot is zero when normal is 90 deg angle from view dir
                float fresnelDot = dot(i.worldNormal, normalize(i.viewDir));

                fresnelDot = saturate(fresnelDot); // clamp to 0,1
                float fresnelPow = pow(1.0f - fresnelDot, _FresnelPower );

                return fresnelPow * _FresnelColor;
            }
            ENDCG
        }
    }
}
