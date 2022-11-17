# Suit Painting Shader

Made with HLSL and ShaderGraph for the URP in **Unity 2021.3.10f1**

## Screenshots

## Table of Content

- [Implementation](#implementation)
  - [Creating Alternative Textures](#creating-alternative-textures)
  - [Shader Graph](#shader-graph)
    - [HLSL Custom Function](#hlsl-custom-function)
    - [Sub Graph](#sub-graph)
    - [HDR](#hdr)

### References

- [Halloween Shader tutorial by Jettelly](https://www.youtube.com/watch?v=ZhIODmbX0OE)
- [HDR in Unity](https://docs.unity3d.com/Manual/HDR.html)

## Implementation

### Creating Alternative Textures

- Using Affinity Photo, create alternative versions of the Albedo and Emission textures for the character.

![Picture](./docs/1.jpg)
![Picture](./docs/2.jpg)

### Shader Graph

- Implement a **Lit Shader Graph** to render the surface of the character suit.
- Connect the **Albedo**, **Emission** and **Normal Map**.
- Implement a custom function that transitions between the two textures that define the different suits.

![Picture](./docs/3.jpg)
![Picture](./docs/4.jpg)

#### HLSL Custom Function

- Write a custom HLSL function that will transition between two given textures.
- It takes in both texels of both textures.
- Decides which texel to use based on a threshold position in world space.
- Comparing it against the fragment position in world spaces.
- This creates a vertical transition effect.
- The threshold also takes a parametrized color.

```hlsl
void TransitionTextures_half(
    in half4 primaryTextureColor,
    in half4 secondaryTextureColor,
    in float3 fragmentWorldPosition,
    in float thresholdWorldPositionY,
    in float thresholdWidth,
    in half4 thresholdColor,
    out half4 outputColor
)
{
    if(fragmentWorldPosition.y > thresholdWorldPositionY + thresholdWidth)
    {
        outputColor = secondaryTextureColor;
    } else if (
        thresholdWorldPositionY - thresholdWidth <= fragmentWorldPosition.y &&
        thresholdWorldPositionY + thresholdWidth >= fragmentWorldPosition.y)
    {
        outputColor = thresholdColor;
    } else
    {
        outputColor = primaryTextureColor;
    }
}
```

![Picture](./docs/5.jpg)

#### Sub Graph

- Use the **Custom HLSL Function** in a **Custom Function Node** in a Sub Graph.
- This sub graph will be reused for **Albedo** and **Emission**.
- Because we also need to transition the Emission to match the main texture change.

![Picture](./docs/6.jpg)

#### HDR

- Enable HDR in the URP Asset.
- Set the precision of the Color property to HDR.
- This enables a larger range of color intensity.
- The Bloom Post Processing effect will pick this up and create a Glow effect.

![Picture](./docs/7.jpg)
![Picture](./docs/8.jpg)
