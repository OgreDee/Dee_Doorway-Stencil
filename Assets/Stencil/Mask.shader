Shader "Dee/Mask"
{
	Properties
	{
        _MainTex ("Texture", 2D) = "white" {}
		_TineColor ("TineColor", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Geometry-50"}
		LOD 100
        
		Pass
		{
            Name "Stencil"
            
            Cull Off
            ColorMask 0
            ZWrite Off
            Stencil{
                Ref 1
                Comp Always
                Pass Replace
            }
            
            //Cull Back
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
			};

			float4 _TineColor;
            
            uniform float4x4 vertexs; 
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//return float4(_TineColor.rg * i.uv, _TineColor.ba);
                return _TineColor;
			}
			ENDCG
		}
	}
    
}
