Shader "Naito/ScreenBlendSprite"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
	}

	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}

		Cull Off
		Lighting Off
		ZWrite Off
		// Blend One OneMinusSrcAlpha

		
		
		// Blend DstColor One
		// Blend One One
		// BlendOp LogicalInvert
		// Blend One One
		
		

		Pass
		{
			
			//Invert
			BlendOp Sub
			Blend One One
			//EndInvert
			
			//Multiply 2X
			BlendOp Add
			Blend DstColor SrcColor

			//Invert
			BlendOp Sub
			Blend One One
			
			//EndInvert
			
			

			
			
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#include "BaseSprite.cginc"
			




			fixed4 frag(v2f IN) : SV_Target
			{
				fixed4 c = SampleSpriteTexture (IN.texcoord) * IN.color;
				// c.rgb *= c.a;
				return c;
			}
		ENDCG
		}




		

		
	}
}
