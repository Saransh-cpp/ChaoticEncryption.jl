using Images

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
- `encryptedImage::Array{RGB{N0f8}, 2}`: Encrypted image.

# Example
```jldoctest
julia> using TestImages, ChaoticEncryption

julia> img = testimage("mandrill")
512×512 Array{RGB{N0f8},2} with eltype ColorTypes.RGB{FixedPointNumbers.Normed{UInt8,8}}:
 RGB{N0f8}(0.643,0.588,0.278)  …  RGB{N0f8}(0.702,0.737,0.463)
 RGB{N0f8}(0.471,0.49,0.243)      RGB{N0f8}(0.471,0.541,0.29)
 RGB{N0f8}(0.388,0.29,0.122)      RGB{N0f8}(0.376,0.314,0.192)
 RGB{N0f8}(0.251,0.31,0.188)      RGB{N0f8}(0.243,0.306,0.184)
 RGB{N0f8}(0.431,0.329,0.153)     RGB{N0f8}(0.314,0.369,0.235)
 RGB{N0f8}(0.38,0.329,0.114)   …  RGB{N0f8}(0.659,0.788,0.463)
 RGB{N0f8}(0.239,0.149,0.09)      RGB{N0f8}(0.651,0.675,0.467)
 RGB{N0f8}(0.212,0.09,0.122)      RGB{N0f8}(0.525,0.596,0.314)
 RGB{N0f8}(0.251,0.212,0.216)     RGB{N0f8}(0.467,0.518,0.29)
 RGB{N0f8}(0.216,0.125,0.09)      RGB{N0f8}(0.596,0.561,0.239)
 ⋮                             ⋱
 RGB{N0f8}(0.416,0.486,0.498)     RGB{N0f8}(0.267,0.365,0.345)
 RGB{N0f8}(0.459,0.51,0.463)      RGB{N0f8}(0.278,0.231,0.212)
 RGB{N0f8}(0.42,0.451,0.467)   …  RGB{N0f8}(0.329,0.337,0.365)
 RGB{N0f8}(0.38,0.42,0.447)       RGB{N0f8}(0.29,0.353,0.286)
 RGB{N0f8}(0.365,0.388,0.353)     RGB{N0f8}(0.349,0.325,0.333)
 RGB{N0f8}(0.376,0.451,0.525)     RGB{N0f8}(0.325,0.357,0.376)
 RGB{N0f8}(0.475,0.58,0.608)      RGB{N0f8}(0.318,0.314,0.235)
 RGB{N0f8}(0.494,0.663,0.659)  …  RGB{N0f8}(0.314,0.247,0.278)
 RGB{N0f8}(0.035,0.043,0.047)     RGB{N0f8}(0.016,0.02,0.008)

julia> height, width = size(img)
(512, 512)

julia> keys = logistic_key(0.01, 3.97, height * width)
262144-element Array{Int64,1}:
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
 185
 196
 214
  69
  22
  84
 234
 140
 253

julia> substitution_encryption(img, keys)
ENCRYPTING
ENCRYPTED
512×512 Array{RGB{N0f8},2} with eltype ColorTypes.RGB{FixedPointNumbers.Normed{UInt8,8}}:
 RGB{N0f8}(0.643,0.588,0.278)  …  RGB{N0f8}(0.969,0.973,0.196)
 RGB{N0f8}(0.016,0.004,0.259)     RGB{N0f8}(0.91,0.102,0.855)
 RGB{N0f8}(0.525,0.686,0.98)      RGB{N0f8}(0.447,0.259,0.137)
 RGB{N0f8}(0.043,0.016,0.482)     RGB{N0f8}(0.58,0.894,0.522)
 RGB{N0f8}(0.063,0.165,0.349)     RGB{N0f8}(0.78,0.788,0.671)
 RGB{N0f8}(0.475,0.298,0.02)   …  RGB{N0f8}(0.055,0.435,0.816)
 RGB{N0f8}(0.78,0.863,0.929)      RGB{N0f8}(0.243,0.204,0.937)
 RGB{N0f8}(0.392,0.271,0.302)     RGB{N0f8}(0.929,0.953,0.231)
 RGB{N0f8}(0.282,0.243,0.247)     RGB{N0f8}(0.718,0.267,0.541)
 RGB{N0f8}(0.396,0.447,0.271)     RGB{N0f8}(0.106,0.047,0.745)
 ⋮                             ⋱
 RGB{N0f8}(0.588,0.502,0.514)     RGB{N0f8}(0.992,0.894,0.882)
 RGB{N0f8}(0.29,0.741,0.286)      RGB{N0f8}(0.788,0.71,0.722)
 RGB{N0f8}(0.624,0.529,0.514)  …  RGB{N0f8}(0.855,0.847,0.827)
 RGB{N0f8}(0.467,0.49,0.392)      RGB{N0f8}(0.102,0.039,0.098)
 RGB{N0f8}(0.012,0.239,0.016)     RGB{N0f8}(0.176,0.153,0.129)
 RGB{N0f8}(0.929,0.996,0.043)     RGB{N0f8}(0.267,0.298,0.467)
 RGB{N0f8}(0.71,0.345,0.341)      RGB{N0f8}(0.204,0.208,0.349)
 RGB{N0f8}(0.902,0.192,0.188)  …  RGB{N0f8}(0.157,0.278,0.247)
 RGB{N0f8}(0.718,0.71,0.698)      RGB{N0f8}(0.976,0.973,1.0)
```
"""
function substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1};
    path_for_result::String="./encrypted.png",
)
    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    z = 1

    encryptedImage = copy(image)

    println("ENCRYPTING")

    for i = 1:height
        for j = 1:width
            rgb = encryptedImage[i, j]
            r, g, b = trunc(Int, rgb.r * 255), trunc(Int, rgb.g * 255), trunc(Int, rgb.b * 255)
            encryptedImage[i, j] = RGB((r ⊻ keys[z]) / 255, (g ⊻ keys[z]) / 255, (b ⊻ keys[z]) / 255)
            z += 1
        end
    end

    println("ENCRYPTED")
    save(path_for_result, encryptedImage)

    return encryptedImage
end


"""
    substitution_decryption(image, keys; path_for_result="./decrypted.png")

Performs substitution decryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the keys provided must be the same
as the ones provided during encryption.

# Arguments
- `image`: `::String` or `::Array{RGB{N0f8},2}`. The path to the image or the loaded image to be decrypted.
- `keys::Array{Int64, 1}`: Keys for decryption.
- `path_for_result::String`: The path for storing the decrypted image.

# Returns
- `decryptedImage::Array{RGB{N0f8}, 2}`: Decrypted image.

# Example
```jldoctest
julia> using TestImages, ChaoticEncryption

julia> img = testimage("mandrill")
512×512 Array{RGB{N0f8},2} with eltype ColorTypes.RGB{FixedPointNumbers.Normed{UInt8,8}}:
 RGB{N0f8}(0.643,0.588,0.278)  …  RGB{N0f8}(0.702,0.737,0.463)
 RGB{N0f8}(0.471,0.49,0.243)      RGB{N0f8}(0.471,0.541,0.29)
 RGB{N0f8}(0.388,0.29,0.122)      RGB{N0f8}(0.376,0.314,0.192)
 RGB{N0f8}(0.251,0.31,0.188)      RGB{N0f8}(0.243,0.306,0.184)
 RGB{N0f8}(0.431,0.329,0.153)     RGB{N0f8}(0.314,0.369,0.235)
 RGB{N0f8}(0.38,0.329,0.114)   …  RGB{N0f8}(0.659,0.788,0.463)
 RGB{N0f8}(0.239,0.149,0.09)      RGB{N0f8}(0.651,0.675,0.467)
 RGB{N0f8}(0.212,0.09,0.122)      RGB{N0f8}(0.525,0.596,0.314)
 RGB{N0f8}(0.251,0.212,0.216)     RGB{N0f8}(0.467,0.518,0.29)
 RGB{N0f8}(0.216,0.125,0.09)      RGB{N0f8}(0.596,0.561,0.239)
 ⋮                             ⋱
 RGB{N0f8}(0.416,0.486,0.498)     RGB{N0f8}(0.267,0.365,0.345)
 RGB{N0f8}(0.459,0.51,0.463)      RGB{N0f8}(0.278,0.231,0.212)
 RGB{N0f8}(0.42,0.451,0.467)   …  RGB{N0f8}(0.329,0.337,0.365)
 RGB{N0f8}(0.38,0.42,0.447)       RGB{N0f8}(0.29,0.353,0.286)
 RGB{N0f8}(0.365,0.388,0.353)     RGB{N0f8}(0.349,0.325,0.333)
 RGB{N0f8}(0.376,0.451,0.525)     RGB{N0f8}(0.325,0.357,0.376)
 RGB{N0f8}(0.475,0.58,0.608)      RGB{N0f8}(0.318,0.314,0.235)
 RGB{N0f8}(0.494,0.663,0.659)  …  RGB{N0f8}(0.314,0.247,0.278)
 RGB{N0f8}(0.035,0.043,0.047)     RGB{N0f8}(0.016,0.02,0.008)

julia> height, width = size(img)
(512, 512)

julia> keys = logistic_key(0.01, 3.97, height * width)
262144-element Array{Int64,1}:
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
 185
 196
 214
  69
  22
  84
 234
 140
 253

julia> substitution_decryption("./encrypted.png", keys)
DECRYPTING
DECRYPTED
512×512 Array{RGB{N0f8},2} with eltype ColorTypes.RGB{FixedPointNumbers.Normed{UInt8,8}}:
 RGB{N0f8}(0.643,0.588,0.278)  …  RGB{N0f8}(0.702,0.737,0.463)
 RGB{N0f8}(0.471,0.49,0.243)      RGB{N0f8}(0.471,0.541,0.29)
 RGB{N0f8}(0.388,0.29,0.122)      RGB{N0f8}(0.376,0.314,0.192)
 RGB{N0f8}(0.251,0.31,0.188)      RGB{N0f8}(0.243,0.306,0.184)
 RGB{N0f8}(0.431,0.329,0.153)     RGB{N0f8}(0.314,0.369,0.235)
 RGB{N0f8}(0.38,0.329,0.114)   …  RGB{N0f8}(0.659,0.788,0.463)
 RGB{N0f8}(0.239,0.149,0.09)      RGB{N0f8}(0.651,0.675,0.467)
 RGB{N0f8}(0.212,0.09,0.122)      RGB{N0f8}(0.525,0.596,0.314)
 RGB{N0f8}(0.251,0.212,0.216)     RGB{N0f8}(0.467,0.518,0.29)
 RGB{N0f8}(0.216,0.125,0.09)      RGB{N0f8}(0.596,0.561,0.239)
 ⋮                             ⋱
 RGB{N0f8}(0.416,0.486,0.498)     RGB{N0f8}(0.267,0.365,0.345)
 RGB{N0f8}(0.459,0.51,0.463)      RGB{N0f8}(0.278,0.231,0.212)
 RGB{N0f8}(0.42,0.451,0.467)   …  RGB{N0f8}(0.329,0.337,0.365)
 RGB{N0f8}(0.38,0.42,0.447)       RGB{N0f8}(0.29,0.353,0.286)
 RGB{N0f8}(0.365,0.388,0.353)     RGB{N0f8}(0.349,0.325,0.333)
 RGB{N0f8}(0.376,0.451,0.525)     RGB{N0f8}(0.325,0.357,0.376)
 RGB{N0f8}(0.475,0.58,0.608)      RGB{N0f8}(0.318,0.314,0.235)
 RGB{N0f8}(0.494,0.663,0.659)  …  RGB{N0f8}(0.314,0.247,0.278)
 RGB{N0f8}(0.035,0.043,0.047)     RGB{N0f8}(0.016,0.02,0.008)
```
"""
function substitution_decryption(
    image,
    keys::Array{Int64, 1};
    path_for_result::String="./decrypted.png",
)

    if typeof(image) == String
        image = load(image)
    elseif typeof(image) != Array{RGB{N0f8},2}
        throw(ArgumentError("image must be of the type ::String or ::Array{RGB{N0f8},2}"))
    end

    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    z = 1

    decryptedImage = copy(image)
    println("DECRYPTING")

    for i = 1:height
        for j = 1:width
            rgb = decryptedImage[i, j]
            r, g, b = trunc(Int, rgb.r * 255), trunc(Int, rgb.g * 255), trunc(Int, rgb.b * 255)
            decryptedImage[i, j] = RGB((r ⊻ keys[z]) / 255, (g ⊻ keys[z]) / 255, (b ⊻ keys[z]) / 255)
            z += 1
        end
    end

    println("DECRYPTED")
    save(path_for_result, decryptedImage)

    return decryptedImage
end
