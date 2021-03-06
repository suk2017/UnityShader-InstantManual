﻿Shader "USIM/Normal_Post"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			sampler2D _CameraDepthNormalsTexture;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
			
				/*  方法一 */
				fixed3 normal = DecodeViewNormalStereo(tex2D(_CameraDepthNormalsTexture, i.uv));
				fixed3 normal01 = normal * 0.5 + 0.5;
				return fixed4(normal01, 1.0);
				
				
				/*  方法二 */
				//float depth;
				//fixed3 normal;
				//DecodeDepthNormal(tex2D(_CameraDepthNormalsTexture, i.uv), depth, normal);
				//fixed3 normal01 = normal * 0.5 + 0.5;
				//return fixed4(normal01, 1.0);

			}
			ENDCG
		}
	}
}
