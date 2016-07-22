Shader "Naito/BlendTexture"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always
//#########################################################################
// THIS IS THE IMPORTANT LINE FROM THIS CODE: check out Unity's reference: https://docs.unity3d.com/Manual/SL-Blend.html
//#########################################################################
		Blend DstColor Zero //Multiply blend. f(a,b)=b

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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

			//Just return the texture as a half4, you can work with rgba
			fixed4 frag (v2f o) : SV_Target
			{
				half4 c = tex2D(_MainTex, o.uv ) ;
				return c;
			}
			ENDCG
		}
	}
}
