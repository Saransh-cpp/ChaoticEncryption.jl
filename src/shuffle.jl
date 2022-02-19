using Images

function shuffle_encryption(
    image::Array{RGB{N0f8},2},
    keys::Array{Array{Int64, 1}, 1},
    path_for_result::String="./encrypted.png",
)
    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    encryptedImage = copy(image)

    println("ENCRYPTING")

    k = 1
    for i = 1:height
        for j = 1:width
            encryptedImage[i, j] = encryptedImage[keys[k][1], keys[k][2]]
            k += 1
        end
    end

    println("ENCRYPTED")
    save(path_for_result, encryptedImage)

    return encryptedImage
end


# using TestImages
# using Shuffle

# img = testimage("mandrill")
# height, width = size(img)
# x_key, y_key = collect(1:width), collect(1:height)
# shuffle!(x_key)
# shuffle!(y_key)

# keys = Array{Array{Int64, 1}, 1}()

# for x in x_key
#     for y in y_key
#         push!(keys, [x, y])
#     end
# end

# shuffle_encryption(img, keys)