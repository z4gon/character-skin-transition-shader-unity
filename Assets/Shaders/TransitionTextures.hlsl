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
