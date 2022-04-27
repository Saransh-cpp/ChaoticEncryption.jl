"""
    _redify(colour)

Returns the red component of the RGB colour. Specifically
developed to return an `Array` of r values of all the pixels
of an image.

Running on an entire image - `r_vals = _redify.(img)`

# Arguments
- `colour::RGB`: Colour value with r, g, and b components.

# Returns
- `r::Float64`: r component of the RGB colour.
"""
_redify(colour::RGB) = colour.r


"""
    _greenify(colour)

Returns the green component of the RGB colour. Specifically
developed to return an `Array` of g values of all the pixels
of an image.

Running on an entire image - `g_vals = _greenify.(img)`

# Arguments
- `colour::RGB`: Colour value with r, g, and b components.

# Returns
- `g::Float64`: g component of the RGB colour.
"""
_greenify(colour::RGB) = colour.g


"""
    _blueify(colour)

Returns the blue component of the RGB colour. Specifically
developed to return an `Array` of b values of all the pixels
of an image.

Running on an entire image - `b_vals = _blueify.(img)`

# Arguments
- `colour::RGB`: Colour value with r, g, and b components.

# Returns
- `b::Float64`: b component of the RGB colour.
"""
_blueify(colour::RGB) = colour.b


"""
    _imageify(colour)

Returns the `RGB` type constructed with the provided R, G, and
B values. Specifically developed to return the image constructed
with the provided R, G, and B `Arrays`

Running on entire R, G, and B values - `img = _imageify.(r, g, b)`

# Arguments
- `r::Float64`: r component.
- `g::Float64`: g components.
- `b::Float64`: b components.

# Returns
- `rgb::RGB`: The RGB value.
"""
_imageify(r::Float64, g::Float64, b::Float64) = RGB(r, g, b)