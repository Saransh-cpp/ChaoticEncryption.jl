using Images
using FileIO

"""
keys = logistic_key(0.01, 3.97, 719 * 718)
    
substitution_encryption("D:\\Saransh\\Docs\\PyCon_Squared.jpg", keys)
substitution_decryption("./encrypted.png", keys)
"""
function substitution_encryption(
    path_to_image::String,
    keys::Array,
    path_for_result::String="./encrypted.png",
)
    image = load(path_to_image)

    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    z = 1

    # Initializing the encrypted image
    encryptedImage = copy(image)

    println("ENCRYPTING")

    # Substituting all the pixels in original image with nested for
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

function substitution_decryption(
    path_to_image::String,
    keys::Array,
    path_for_result::String="./decrypted.png",
)
    image = load(path_to_image)

    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    z = 1

    # Initializing the encrypted image
    decryptedImage = copy(image)
    println("DECRYPTING")

    # Substituting all the pixels in original image with nested for
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
