# Substitution Encryption

In the following tutorial, we will encrypt and decrypt an image using the substitution algorithm. `ChaoticEncryption.jl`, internally, `XORs` each pixel with the provided key and replaces or substitues it in the position of original pixel. The API documentation for `ChaoticEncryption.jl` is available [here](https://saransh-cpp.github.io/ChaoticEncryption.jl).

Let us start by adding in the julia packages we will be needing -

```julia
# install TestImages for this tutorial
# julia> using Pkg
# julia> Pkg.add("TestImages")
# install ChaoticEncryption.jl if you haven't already!
# julia> Pkg.add("ChaoticEncryption")

julia> using TestImages, ChaoticEncryption

```

## Generating keys

The first step in the process of encryption would be to generate the required number of keys. This can be done using the PRNGs available in `ChaoticEncryption.jl`. A detailed example describing the `Pseudo-Random Number Generators` available in `ChaoticEncryption.jl` is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/examples/PseudoRandomNumberGenerators.ipynb).

Let's load up an image using `TestImages` package!

```julia
julia> img = testimage("mandrill");

julia> height, width = size(img)
(512, 512)
```

The image can be viewed using [ImageView.jl](https://github.com/JuliaImages/ImageView.jl) -

```julia
julia> using ImageView

julia> imshow(img)
```

![image](https://user-images.githubusercontent.com/74055102/163712587-a1f98c1a-68d3-4c50-bba4-d7b6741f9afa.png)

Now we can use these dimensions to generate random keys!

```julia
julia> key = logistic_key(0.01, 3.67, height * width)
262144-element Vector{Int64}:
   0
  68
 135
  20
  13
 140
 197
 182
 248
 229
   ⋮
 168
 182
  77
  83
  74
 176
  27
 251
 206
```

## Encryption

Now we can proceed ahead and encrypt our images using the substitution algorithm! `ChaoticEncryption.jl` provides an elegant way to perform this algorithm using the function `substitution_encryption`.

The first step (as always) would be to look at the documentation, or the docstring, of `substitution_encryption`. According to the documentation, `substitution_encryption` iterates simulataneously over each pixel and key, and XORs the pixel value (all R, G, and B) with the given key.

It takes in the following arguments -

- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `path_for_result::String`: The path for storing the encrypted image.

And returns the encrypted image -

- `image::Array{RGB{N0f8}, 2}`: Encrypted image.

We can use the function `substitution_encryption` by passing in a loaded image and an array of keys.

The function -
- Returns the encrypted image.
- Saves the encrypted image (the filename or the path can be passed as an argument too).

```julia
julia> enc = substitution_encryption(img, key)
[ Info: ENCRYPTING
[ Info: ENCRYPTED
```

The encrypted image -

```julia
julia> imshow(enc)
```

![image](https://user-images.githubusercontent.com/74055102/163712657-6516df30-16c9-4445-bb45-f13b5b0b63ab.png)

## Decryption

We can similarly use the `substitution_decryption` function to decrypt our images!

The first step (again) would be to look at the documentation, or the docstring, of `substitution_decryption`.  According to the documentation (again), `subsitution_decryption` iterates simulataneously over each pixel and key, and XORs the pixel value (all R, G, and B) with the given key. Hence, the keys provided must be the same as the ones provided during encryption.

I takes in the arguments -

- `image::Union{String,Array{RGB{N0f8},2}}`: The path to the image or the loaded image to be decrypted.
- `keys::Array{Int64, 1}`: Keys for decryption.
- `path_for_result::String`: The path for storing the decrypted image.

And returns the decrypted image -

- `image::Array{RGB{N0f8}, 2}`: Decrypted image.

We can use the function `substitution_decryption` by passing in the path of the encrypted image and an array of keys.

The function -
- Returns the decrypted image.
- Saves the decrypted image (the filename or the path can be passed as an argument too).

The documentation also says that we can pass an `Array` of type `Array{RGB{N0f8},2}` as an image, which means a loaded image! Let us try this!

```julia
julia> dec = substitution_decryption(enc, key)
[ Info: DECRYPTING
[ Info: DECRYPTED
```

The encrypted image -

```julia
julia> imshow(dec)
```

![image](https://user-images.githubusercontent.com/74055102/163712686-fc4b2235-cb42-4670-a131-86ffc8993a13.png)

## In-place substitution

Additionally, `ChaoticEncryption.jl` also comes with in-place encryption and decryption methods. `substitution_encryption!` and `substitution_decryption!` acts on the image variable passed into them, rather than creating a copy of the same.

This speeds up your code by a huge factor, and should be used wherever possible!

A notebook version of this tutorial is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/examples/SubstitutionEncryption.ipynb). Don't forget to star [`ChaoticEncryption.jl`](https://saransh-cpp.github.io/ChaoticEncryption.jl) :)

The complete API documentation is available [here](https://saransh-cpp.github.io/ChaoticEncryption.jl). 
