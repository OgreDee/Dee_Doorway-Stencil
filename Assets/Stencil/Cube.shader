// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Dee/Cube"
{
	Properties
	{
        _MainTex ("Texture", 2D) = "white" {}
        
		_TineColor ("TineColor", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Geometry"}
		LOD 100
        
        
        
		Pass
		{
            Name "Normal"
            
            Stencil {
              Ref 1
              Comp Equal
            }
            
            //Cull Back
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
            #include "Lighting.cginc"

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
            };

			float4 _TineColor;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            uniform float4x4 vertexs; 
			
			v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                
                o.normal = mul(unity_ObjectToWorld, v.normal);
                
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                //fixed4 col = tex2D(_MainTex, i.uv);
                //return col;
                
                i.normal = normalize(i.normal);
                fixed3 diffuse = _TineColor.xyz * (_LightColor0.xyz + UNITY_LIGHTMODEL_AMBIENT.xyz) * saturate( dot(i.normal.xyz, normalize(_WorldSpaceLightPos0.xyz)) );
                
                return float4(diffuse, 1);
            }
			ENDCG
		}
	}
    
}
