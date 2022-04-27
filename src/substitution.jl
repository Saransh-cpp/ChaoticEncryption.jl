using Images

include("./utils.jl")


"""
    _substitution(image, keys, type; path_for_result="./encrypted.png")

Performs substitution encryption/decryption on a given image with the given keys.

See [`substitution_encryption`](@ref) and [`substitution_decryption`](@ref) for more details.

# Arguments
- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `type::String`: Can be `:encrypt` or `:decrypt`.
- `path_for_result::String`: The path for storing the encrypted image.
- `inplace::Boolean`: Perform substitution on the provided image.
"""
function _substitution(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Vector{Int64},
    type::Symbol;
    path_for_result::String="./encrypted.png",
    inplace=false,
)

    if typeof(image) == String
        image = load(image)
    end

    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    # generate a copy if not inplace
    ~inplace && (image = copy(image))

    if type == :encrypt
        @info "ENCRYPTING"
    else
        @info "DECRYPTING"
    end

    # generate arrays for r, g, b values of each pixel
    r = Array{Int64}(undef, height, width)
    g = Array{Int64}(undef, height, width)
    b = Array{Int64}(undef, height, width)

    # resize keys for broadcasting
    keys = reshape(keys, height, width)

    # collect all r, g, b values without loop
    @. r = trunc(Int, _redify(image) * 255)
    @. g = trunc(Int, _greenify(image) * 255)
    @. b = trunc(Int, _blueify(image) * 255)

    # XOR all r, g, b values and replace the values in image
    @. image = _imageify((r ⊻ keys) / 255, (g ⊻ keys) / 255, (b ⊻ keys) / 255)

    if type == :encrypt
        @info "ENCRYPTED"
    else
        @info "DECRYPTED"
    end

    save(path_for_result, image)
    image
end


"""
    substitution_encryption(image, keys; path_for_result="./encrypted.png")

Performs substitution encryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the order of the keys matter.

# Arguments
- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `path_for_result::String`: The path for storing the encrypted image.

# Returns
- `image::Array{RGB{N0f8}, 2}`: Encrypted image.

# Example
```jldoctest
julia> using Images

julia> img = load("../test_images/camera.jfif")
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 ⋮                             ⋱
 RGB{N0f8}(0.4,0.4,0.4)           RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.427,0.427,0.427)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.451,0.451,0.451)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.51,0.51,0.51)     …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.537,0.537,0.537)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.412,0.412,0.412)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)
(225, 225)

julia> keys = logistic_key(0.01, 3.97, height * width)
50625-element Vector{Int64}:
   0
  44
   7
  26
  14
 224
  16
 250
 162
 211
   ⋮
  72
 255
  80
  84
  21
 154
 197
  82
 147

julia> substitution_encryption(img, keys)
[ Info: ENCRYPTING
[ Info: ENCRYPTED
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.839,0.839,0.839)
 RGB{N0f8}(0.718,0.718,0.718)     RGB{N0f8}(0.361,0.361,0.361)
 RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.055,0.055,0.055)
 RGB{N0f8}(0.506,0.506,0.506)     RGB{N0f8}(0.58,0.58,0.58)
 RGB{N0f8}(0.584,0.584,0.584)     RGB{N0f8}(0.631,0.631,0.631)
 RGB{N0f8}(0.482,0.482,0.482)  …  RGB{N0f8}(0.639,0.639,0.639)
 RGB{N0f8}(0.545,0.545,0.545)     RGB{N0f8}(0.196,0.196,0.196)
 RGB{N0f8}(0.38,0.38,0.38)        RGB{N0f8}(0.047,0.047,0.047)
 RGB{N0f8}(0.224,0.224,0.224)     RGB{N0f8}(0.847,0.847,0.847)
 RGB{N0f8}(0.282,0.282,0.282)     RGB{N0f8}(0.827,0.827,0.827)
 ⋮                             ⋱
 RGB{N0f8}(0.573,0.573,0.573)     RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.361,0.361,0.361)     RGB{N0f8}(1.0,1.0,1.0)
 RGB{N0f8}(0.847,0.847,0.847)     RGB{N0f8}(0.314,0.314,0.314)
 RGB{N0f8}(0.349,0.349,0.349)     RGB{N0f8}(0.329,0.329,0.329)
 RGB{N0f8}(0.984,0.984,0.984)  …  RGB{N0f8}(0.082,0.082,0.082)
 RGB{N0f8}(0.031,0.031,0.031)     RGB{N0f8}(0.604,0.604,0.604)
 RGB{N0f8}(0.071,0.071,0.071)     RGB{N0f8}(0.773,0.773,0.773)
 RGB{N0f8}(0.765,0.765,0.765)     RGB{N0f8}(0.322,0.322,0.322)
 RGB{N0f8}(0.902,0.902,0.902)     RGB{N0f8}(0.576,0.576,0.576)
```
"""
substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    path_for_result::String="./encrypted.png"
) = _substitution(image, keys, :encrypt; path_for_result=path_for_result)


"""
    substitution_encryption!(image, keys; path_for_result="./encrypted.png")

Performs substitution encryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the order of the keys matter.

# Arguments
- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `path_for_result::String`: The path for storing the encrypted image.

# Returns
- `image::Array{RGB{N0f8}, 2}`: Encrypted image.

# Example
```jldoctest
julia> using Images

julia> img = load("../test_images/camera.jfif")
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 ⋮                             ⋱
 RGB{N0f8}(0.4,0.4,0.4)           RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.427,0.427,0.427)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.451,0.451,0.451)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.51,0.51,0.51)     …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.537,0.537,0.537)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.412,0.412,0.412)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)
(225, 225)

julia> keys = logistic_key(0.01, 3.97, height * width)
50625-element Vector{Int64}:
   0
  44
   7
  26
  14
 224
  16
 250
 162
 211
   ⋮
  72
 255
  80
  84
  21
 154
 197
  82
 147

julia> substitution_encryption!(img, keys)
[ Info: ENCRYPTING
[ Info: ENCRYPTED
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.839,0.839,0.839)
 RGB{N0f8}(0.718,0.718,0.718)     RGB{N0f8}(0.361,0.361,0.361)
 RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.055,0.055,0.055)
 RGB{N0f8}(0.506,0.506,0.506)     RGB{N0f8}(0.58,0.58,0.58)
 RGB{N0f8}(0.584,0.584,0.584)     RGB{N0f8}(0.631,0.631,0.631)
 RGB{N0f8}(0.482,0.482,0.482)  …  RGB{N0f8}(0.639,0.639,0.639)
 RGB{N0f8}(0.545,0.545,0.545)     RGB{N0f8}(0.196,0.196,0.196)
 RGB{N0f8}(0.38,0.38,0.38)        RGB{N0f8}(0.047,0.047,0.047)
 RGB{N0f8}(0.224,0.224,0.224)     RGB{N0f8}(0.847,0.847,0.847)
 RGB{N0f8}(0.282,0.282,0.282)     RGB{N0f8}(0.827,0.827,0.827)
 ⋮                             ⋱
 RGB{N0f8}(0.573,0.573,0.573)     RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.361,0.361,0.361)     RGB{N0f8}(1.0,1.0,1.0)
 RGB{N0f8}(0.847,0.847,0.847)     RGB{N0f8}(0.314,0.314,0.314)
 RGB{N0f8}(0.349,0.349,0.349)     RGB{N0f8}(0.329,0.329,0.329)
 RGB{N0f8}(0.984,0.984,0.984)  …  RGB{N0f8}(0.082,0.082,0.082)
 RGB{N0f8}(0.031,0.031,0.031)     RGB{N0f8}(0.604,0.604,0.604)
 RGB{N0f8}(0.071,0.071,0.071)     RGB{N0f8}(0.773,0.773,0.773)
 RGB{N0f8}(0.765,0.765,0.765)     RGB{N0f8}(0.322,0.322,0.322)
 RGB{N0f8}(0.902,0.902,0.902)     RGB{N0f8}(0.576,0.576,0.576)

julia> img  # inplace
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.839,0.839,0.839)
 RGB{N0f8}(0.718,0.718,0.718)     RGB{N0f8}(0.361,0.361,0.361)
 RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.055,0.055,0.055)
 RGB{N0f8}(0.506,0.506,0.506)     RGB{N0f8}(0.58,0.58,0.58)
 RGB{N0f8}(0.584,0.584,0.584)     RGB{N0f8}(0.631,0.631,0.631)
 RGB{N0f8}(0.482,0.482,0.482)  …  RGB{N0f8}(0.639,0.639,0.639)
 RGB{N0f8}(0.545,0.545,0.545)     RGB{N0f8}(0.196,0.196,0.196)
 RGB{N0f8}(0.38,0.38,0.38)        RGB{N0f8}(0.047,0.047,0.047)
 RGB{N0f8}(0.224,0.224,0.224)     RGB{N0f8}(0.847,0.847,0.847)
 RGB{N0f8}(0.282,0.282,0.282)     RGB{N0f8}(0.827,0.827,0.827)
 ⋮                             ⋱
 RGB{N0f8}(0.573,0.573,0.573)     RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.361,0.361,0.361)     RGB{N0f8}(1.0,1.0,1.0)
 RGB{N0f8}(0.847,0.847,0.847)     RGB{N0f8}(0.314,0.314,0.314)
 RGB{N0f8}(0.349,0.349,0.349)     RGB{N0f8}(0.329,0.329,0.329)
 RGB{N0f8}(0.984,0.984,0.984)  …  RGB{N0f8}(0.082,0.082,0.082)
 RGB{N0f8}(0.031,0.031,0.031)     RGB{N0f8}(0.604,0.604,0.604)
 RGB{N0f8}(0.071,0.071,0.071)     RGB{N0f8}(0.773,0.773,0.773)
 RGB{N0f8}(0.765,0.765,0.765)     RGB{N0f8}(0.322,0.322,0.322)
 RGB{N0f8}(0.902,0.902,0.902)     RGB{N0f8}(0.576,0.576,0.576)```
"""
substitution_encryption!(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    path_for_result::String="./encrypted.png"
) = _substitution(image, keys, :encrypt; path_for_result=path_for_result, inplace=true)


"""
    substitution_decryption(image, keys; path_for_result="./decrypted.png")

Performs substitution decryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the keys provided must be the same
as the ones provided during encryption.

# Arguments
- `image::Union{String,Array{RGB{N0f8},2}}`: The path to the image or the loaded image to be decrypted.
- `keys::Array{Int64, 1}`: Keys for decryption.
- `path_for_result::String`: The path for storing the decrypted image.

# Returns
- `image::Array{RGB{N0f8}, 2}`: Decrypted image.

# Example
```jldoctest
julia> using Images

julia> img = load("../test_images/camera.jfif")
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 ⋮                             ⋱
 RGB{N0f8}(0.4,0.4,0.4)           RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.427,0.427,0.427)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.451,0.451,0.451)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.51,0.51,0.51)     …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.537,0.537,0.537)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.412,0.412,0.412)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)
(225, 225)

julia> keys = logistic_key(0.01, 3.97, height * width)
50625-element Vector{Int64}:
   0
  44
   7
  26
  14
 224
  16
 250
 162
 211
   ⋮
  72
 255
  80
  84
  21
 154
 197
  82
 147

julia> substitution_decryption(img, keys)
[ Info: DECRYPTING
[ Info: DECRYPTED
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.839,0.839,0.839)
 RGB{N0f8}(0.718,0.718,0.718)     RGB{N0f8}(0.361,0.361,0.361)
 RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.055,0.055,0.055)
 RGB{N0f8}(0.506,0.506,0.506)     RGB{N0f8}(0.58,0.58,0.58)
 RGB{N0f8}(0.584,0.584,0.584)     RGB{N0f8}(0.631,0.631,0.631)
 RGB{N0f8}(0.482,0.482,0.482)  …  RGB{N0f8}(0.639,0.639,0.639)
 RGB{N0f8}(0.545,0.545,0.545)     RGB{N0f8}(0.196,0.196,0.196)
 RGB{N0f8}(0.38,0.38,0.38)        RGB{N0f8}(0.047,0.047,0.047)
 RGB{N0f8}(0.224,0.224,0.224)     RGB{N0f8}(0.847,0.847,0.847)
 RGB{N0f8}(0.282,0.282,0.282)     RGB{N0f8}(0.827,0.827,0.827)
 ⋮                             ⋱
 RGB{N0f8}(0.573,0.573,0.573)     RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.361,0.361,0.361)     RGB{N0f8}(1.0,1.0,1.0)
 RGB{N0f8}(0.847,0.847,0.847)     RGB{N0f8}(0.314,0.314,0.314)
 RGB{N0f8}(0.349,0.349,0.349)     RGB{N0f8}(0.329,0.329,0.329)
 RGB{N0f8}(0.984,0.984,0.984)  …  RGB{N0f8}(0.082,0.082,0.082)
 RGB{N0f8}(0.031,0.031,0.031)     RGB{N0f8}(0.604,0.604,0.604)
 RGB{N0f8}(0.071,0.071,0.071)     RGB{N0f8}(0.773,0.773,0.773)
 RGB{N0f8}(0.765,0.765,0.765)     RGB{N0f8}(0.322,0.322,0.322)
 RGB{N0f8}(0.902,0.902,0.902)     RGB{N0f8}(0.576,0.576,0.576)
```
"""
substitution_decryption(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Vector{Int64};
    path_for_result::String="./decrypted.png",
) = _substitution(image, keys, :decrypt; path_for_result=path_for_result)


"""
    substitution_decryption!(image, keys; path_for_result="./decrypted.png")

Performs substitution decryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the keys provided must be the same
as the ones provided during encryption.

# Arguments
- `image::Union{String,Array{RGB{N0f8},2}}`: The path to the image or the loaded image to be decrypted.
- `keys::Array{Int64, 1}`: Keys for decryption.
- `path_for_result::String`: The path for storing the decrypted image.

# Returns
- `image::Array{RGB{N0f8}, 2}`: Decrypted image.

# Example
```jldoctest
julia> using Images

julia> img = load("../test_images/camera.jfif")
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 ⋮                             ⋱
 RGB{N0f8}(0.4,0.4,0.4)           RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.427,0.427,0.427)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.451,0.451,0.451)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.51,0.51,0.51)     …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.537,0.537,0.537)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.412,0.412,0.412)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)
(225, 225)

julia> keys = logistic_key(0.01, 3.97, height * width)
50625-element Vector{Int64}:
   0
  44
   7
  26
  14
 224
  16
 250
 162
 211
   ⋮
  72
 255
  80
  84
  21
 154
 197
  82
 147

julia> substitution_decryption!(img, keys)
[ Info: DECRYPTING
[ Info: DECRYPTED
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.839,0.839,0.839)
 RGB{N0f8}(0.718,0.718,0.718)     RGB{N0f8}(0.361,0.361,0.361)
 RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.055,0.055,0.055)
 RGB{N0f8}(0.506,0.506,0.506)     RGB{N0f8}(0.58,0.58,0.58)
 RGB{N0f8}(0.584,0.584,0.584)     RGB{N0f8}(0.631,0.631,0.631)
 RGB{N0f8}(0.482,0.482,0.482)  …  RGB{N0f8}(0.639,0.639,0.639)
 RGB{N0f8}(0.545,0.545,0.545)     RGB{N0f8}(0.196,0.196,0.196)
 RGB{N0f8}(0.38,0.38,0.38)        RGB{N0f8}(0.047,0.047,0.047)
 RGB{N0f8}(0.224,0.224,0.224)     RGB{N0f8}(0.847,0.847,0.847)
 RGB{N0f8}(0.282,0.282,0.282)     RGB{N0f8}(0.827,0.827,0.827)
 ⋮                             ⋱
 RGB{N0f8}(0.573,0.573,0.573)     RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.361,0.361,0.361)     RGB{N0f8}(1.0,1.0,1.0)
 RGB{N0f8}(0.847,0.847,0.847)     RGB{N0f8}(0.314,0.314,0.314)
 RGB{N0f8}(0.349,0.349,0.349)     RGB{N0f8}(0.329,0.329,0.329)
 RGB{N0f8}(0.984,0.984,0.984)  …  RGB{N0f8}(0.082,0.082,0.082)
 RGB{N0f8}(0.031,0.031,0.031)     RGB{N0f8}(0.604,0.604,0.604)
 RGB{N0f8}(0.071,0.071,0.071)     RGB{N0f8}(0.773,0.773,0.773)
 RGB{N0f8}(0.765,0.765,0.765)     RGB{N0f8}(0.322,0.322,0.322)
 RGB{N0f8}(0.902,0.902,0.902)     RGB{N0f8}(0.576,0.576,0.576)

julia> img  # inplace
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.839,0.839,0.839)
 RGB{N0f8}(0.718,0.718,0.718)     RGB{N0f8}(0.361,0.361,0.361)
 RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.055,0.055,0.055)
 RGB{N0f8}(0.506,0.506,0.506)     RGB{N0f8}(0.58,0.58,0.58)
 RGB{N0f8}(0.584,0.584,0.584)     RGB{N0f8}(0.631,0.631,0.631)
 RGB{N0f8}(0.482,0.482,0.482)  …  RGB{N0f8}(0.639,0.639,0.639)
 RGB{N0f8}(0.545,0.545,0.545)     RGB{N0f8}(0.196,0.196,0.196)
 RGB{N0f8}(0.38,0.38,0.38)        RGB{N0f8}(0.047,0.047,0.047)
 RGB{N0f8}(0.224,0.224,0.224)     RGB{N0f8}(0.847,0.847,0.847)
 RGB{N0f8}(0.282,0.282,0.282)     RGB{N0f8}(0.827,0.827,0.827)
 ⋮                             ⋱
 RGB{N0f8}(0.573,0.573,0.573)     RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.361,0.361,0.361)     RGB{N0f8}(1.0,1.0,1.0)
 RGB{N0f8}(0.847,0.847,0.847)     RGB{N0f8}(0.314,0.314,0.314)
 RGB{N0f8}(0.349,0.349,0.349)     RGB{N0f8}(0.329,0.329,0.329)
 RGB{N0f8}(0.984,0.984,0.984)  …  RGB{N0f8}(0.082,0.082,0.082)
 RGB{N0f8}(0.031,0.031,0.031)     RGB{N0f8}(0.604,0.604,0.604)
 RGB{N0f8}(0.071,0.071,0.071)     RGB{N0f8}(0.773,0.773,0.773)
 RGB{N0f8}(0.765,0.765,0.765)     RGB{N0f8}(0.322,0.322,0.322)
 RGB{N0f8}(0.902,0.902,0.902)     RGB{N0f8}(0.576,0.576,0.576)
```
"""
substitution_decryption!(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    path_for_result::String="./decrypted.png",
) = _substitution(image, keys, :decrypt; path_for_result=path_for_result, inplace=true)
