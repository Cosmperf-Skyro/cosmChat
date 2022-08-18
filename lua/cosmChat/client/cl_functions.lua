function respW(pixels, base)
    base = base or 1920
    return ScrW()/(base/pixels)
end
 
function respH(pixels, base)
    base = base or 1080
    return ScrH()/(base/pixels)
end