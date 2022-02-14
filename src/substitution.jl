using image
using FileIO


function subtitution_encryption(path::String, keys)
    image = load(path)

    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]
    print(height, width)

    z = 0

    # Initializing the encrypted image
    encryptedImage = zeros(shape=[height, width, 3], dtype=np.uint8)

    # Substituting all the pixels in original image with nested for
    for i = 1:height
        for j = 1:width
            encryptedImage[i, j] = image[i, j] ⊻ generatedKey[z]
            z += 1
        end
    end

    # Decryption using XOR
    z = 0

    # Initializing the decrypted image
    decryptedImage = np.zeros(shape=[height, width, 3], dtype=np.uint8)

    # Substituting all the pixels in encrypted image with nested for
    for i in range(height):
        for j in range(width):
            # USing the XOR operation between encrypted image pixels and keys
            decryptedImage[i, j] = encryptedImage[i, j].astype(int) ^ generatedKey[z]
            z += 1
