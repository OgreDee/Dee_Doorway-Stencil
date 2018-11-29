Shader "Dee/WormholeRubbit"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _EdgeColor("Border Color", Color) = (1,1,1,1)
        _EdgeLength("Edge Length", Range(0.001, 0.03)) = 0.02
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
        
		LOD 100

		Pass
		{
            Cull Back
            ZWrite On
            
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "DoorWay.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;
                float3 worldPos : TEXCOORD1;
                float3 localPos : TEXCOORD2;
            };


			sampler2D _MainTex;
			float4 _MainTex_ST;
            
            
            
            float4 _EdgeColor;
            float _EdgeLength;
			
			v2f vert (appdata v)
			{
				v2f o;
				
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = mul(unity_ObjectToWorld, v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.localPos = v.vertex.xyz;
                
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				i.normal = normalize(i.normal);
                fixed4 diffuse = _LightColor0 * saturate( dot(i.normal.xyz, normalize(_WorldSpaceLightPos0.xyz)) ) +UNITY_LIGHTMODEL_AMBIENT;
                
                DOORWAY_CLIP(i)
                
                return lerp(diffuse, lerp(_EdgeColor, diffuse, dd / _EdgeLength), step(dd, _EdgeLength));
			}
			ENDCG
		}
	}
}
