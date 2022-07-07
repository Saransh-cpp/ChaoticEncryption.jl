using Images


"""
    _substitution(image, keys, type; path_for_result="./encrypted.png")

Performs substitution encryption/decryption on a given image with the given keys.

See [`substitution_encryption`](@ref) and [`substitution_decryption`](@ref) for more details.

# Arguments
- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `type::Symbol`: Can be `:encrypt` or `:decrypt`.
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

    # reshape keys for broadcasting
    keys = reshape(keys, height, width)

    # substitute all pixels in one go
    @. image = _substitute_pixel(image, keys)

    if type == :encrypt
        @info "ENCRYPTED"
    else
        @info "DECRYPTED"
    end

    save(path_for_result, image)
    image
end


"""
    _substitute_pixel(pixel::RGB, key::Int64)

Returns the pixel after XORing the R, G, and B values with the key.
Specifically developed to return an `Array` (or the complete image)
of XORed RGB values in one go.

See [`_substitution`](@ref) for more details.

# Arguments
- `pixel::RGB`: Pixel value with r, g, and b components.
- `key::Int64`: The key.

# Returns
- `pixel::RGB`: Substituted pixel.
"""
_substitute_pixel(pixel::RGB, key::Int64) = RGB(
    (trunc(Int, pixel.r * 255) ⊻ key) / 255,
    (trunc(Int, pixel.g * 255) ⊻ key) / 255,
    (trunc(Int, pixel.b * 255) ⊻ key) / 255
)


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
```jldoctest subs
julia> using Images, TestImages
 Downloading artifact: images

julia> img = testimage("mandrill");

julia> height, width = size(img)
(512, 512)

julia> keys = logistic_key(0.01, 3.97, height * width);

julia> keys |> size
(262144,)

julia> enc = substitution_encryption(img, keys);
[ Info: ENCRYPTING
[ Info: ENCRYPTED

julia> enc |> size
(512, 512)

julia> enc != img
true
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
```jldoctest subs
julia> using Images, TestImages

julia> img = testimage("mandrill");

julia> height, width = size(img)
(512, 512)

julia> keys = logistic_key(0.01, 3.97, height * width);

julia> keys |> size
(262144,)

julia> orig = copy(img);

julia> substitution_encryption!(img, keys);
[ Info: ENCRYPTING
[ Info: ENCRYPTED

julia> img != orig  # inplace
true
```
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

# Example subs
```jldoctest
julia> using Images, TestImages

julia> img = testimage("mandrill");

julia> height, width = size(img)
(512, 512)

julia> keys = logistic_key(0.01, 3.97, height * width);

julia> keys |> size
(262144,)

julia> dec = substitution_decryption(img, keys);
[ Info: DECRYPTING
[ Info: DECRYPTED

julia> dec |> size
(512, 512)

julia> dec != img
true
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

# Example subs
```jldoctest
julia> using Images, TestImages

julia> img = testimage("mandrill");

julia> height, width = size(img)
(512, 512)

julia> keys = logistic_key(0.01, 3.97, height * width);

julia> keys |> size
(262144,)

julia> orig = copy(img);

julia> substitution_decryption!(img, keys);
[ Info: DECRYPTING
[ Info: DECRYPTED

julia> img != orig  # inplace
true
```
"""
substitution_decryption!(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    path_for_result::String="./decrypted.png",
) = _substitution(image, keys, :decrypt; path_for_result=path_for_result, inplace=true)
