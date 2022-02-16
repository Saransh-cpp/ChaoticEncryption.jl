using Images
using FileIO

"""
    substitution_encryption(image, keys, path_for_result="./encrypted.png")

Performs substitution encryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the order of the keys matter.

# Arguments
- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `path_for_result::String`: The path for storing the encrypted image.

# Example
```julia-repl
julia> using Images, ChaoticEncryption

julia> img = load("path/to/image.png")
225×225 Array{RGB{N0f8},2} with eltype RGB{Normed{UInt8,8}}:
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)  …  RGB{N0f8}(0.133,0.133,0.133)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.133,0.133,0.133)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.129,0.129,0.129)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.125,0.125,0.125)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.122,0.122,0.122)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)  …  RGB{N0f8}(0.118,0.118,0.118)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.114,0.114,0.114)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.114,0.114,0.114)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.122,0.122,0.122)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.608,0.608,0.608)  RGB{N0f8}(0.612,0.612,0.612)     RGB{N0f8}(0.125,0.125,0.125)  RGB{N0f8}(0.0,0.0,0.0)       
 ⋮                                                                                         ⋱
 RGB{N0f8}(0.4,0.4,0.4)        RGB{N0f8}(0.416,0.416,0.416)  RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.082,0.082,0.082)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.447,0.447,0.447)  RGB{N0f8}(0.467,0.467,0.467)  RGB{N0f8}(0.498,0.498,0.498)     RGB{N0f8}(0.102,0.102,0.102)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.431,0.431,0.431)  RGB{N0f8}(0.427,0.427,0.427)  RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.086,0.086,0.086)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.451,0.451,0.451)  RGB{N0f8}(0.404,0.404,0.404)  RGB{N0f8}(0.388,0.388,0.388)     RGB{N0f8}(0.106,0.106,0.106)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.51,0.51,0.51)     RGB{N0f8}(0.455,0.455,0.455)  RGB{N0f8}(0.427,0.427,0.427)  …  RGB{N0f8}(0.122,0.122,0.122)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.537,0.537,0.537)  RGB{N0f8}(0.518,0.518,0.518)  RGB{N0f8}(0.525,0.525,0.525)     RGB{N0f8}(0.125,0.125,0.125)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.412,0.412,0.412)  RGB{N0f8}(0.404,0.404,0.404)  RGB{N0f8}(0.424,0.424,0.424)     RGB{N0f8}(0.098,0.098,0.098)  RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.149,0.149,0.149)  RGB{N0f8}(0.114,0.114,0.114)  RGB{N0f8}(0.098,0.098,0.098)     RGB{N0f8}(0.0,0.0,0.0)        RGB{N0f8}(0.0,0.0,0.0)       
 RGB{N0f8}(0.0,0.0,0.0)        RGB{N0f8}(0.0,0.0,0.0)        RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)        RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)

julia> keys = logistic_key(0.01, 3.97, height * width)
516242-element Array{Any,1}:
   0
  44
   7
  26
  14
 224
   ⋮
 115
  65
 126
 152
  74
 198

julia> substitution_encryption("D:\\Saransh\\Docs\\PyCon_Squared.jpg", keys)
ENCRYPTING
ENCRYPTED
```
"""
function substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1},
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
end


"""
    substitution_decryption(image, keys, path_for_result="./decrypted.png")

Performs substitution decryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the keys provided must be the same
as the ones provided during encryption.

# Arguments
- `image`: `::String` or `::Array{RGB{N0f8},2}` The path to the image or the loaded image to be decrypted.
- `keys::Array{Int64, 1}`: Keys for decryption.
- `path_for_result::String`: The path for storing the decrypted image.

# Example
```julia-repl
julia> substitution_decryption("./encrypted.png", keys)
DECRYPTING
DECRYPTED
```
"""
function substitution_decryption(
    image,
    keys::Array{Int64, 1},
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
end
