# Pseudo-Random Number Generators

In the following example, we will explore the PRNGs available in `ChaoticEncryption.jl`. The API documentation for `ChaoticEncryption.jl` is available [here](https://saransh-cpp.github.io/ChaoticEncryption.jl).

Let us start by adding in the julia packages we will be needing -

```jldoctest prng
# install TestImages for this tutorial
# julia> using Pkg
# julia> Pkg.add("TestImages")
# install ChaoticEncryption.jl if you haven't already!
# julia> Pkg.add("ChaoticEncryption")

julia> using TestImages, ChaoticEncryption

```

## PRNGs in ChaoticEncryption.jl

Currently, `ChaoticEncryption.jl` includes 2 PRNGs, which are- 
1. Logistic Map
2. Lorenz System of Differential Equations

We will be adding more of them soon! If you stumble upon an interesting PRNG, feel free to create an issue or a pull request for the same!

## Logistic Map

As per the [documentation](https://saransh-cpp.github.io/ChaoticEncryption.jl/dev/apidocs/prngs/#Logistic-map), `logistic_key` generates a vectors of pseudo-random numbers using the Logistic Map.

The function uses the following equation to generate pseudo-random numbers -

```math
x_{n+1} = r * x_{n} * (1 - x_{n})
```

The function takes in the following arguments -

- `x_init::Float64`: Initial value of x. x ϵ (0, 1).
- `r::Float64`: A constant value. Values > 4 usually results in pseudo-random numbers.
- `num_keys::Int64`: Number of keys to be generated.
- `scaling_factor::Float64=10.0^16`: Factor to be multiplied to the generated value of pseudo-random
    number. Ideally, the factor should be > upper_bound.
- `upper_bound::Float64=256.0`: Upper bound of keys (not included). Use 256 for encrypting images
    as the RGB values of a pixel varies from 0 to 255.

And returns the following `Vector` -
- `keys::Vector{Int64}:`: Generated pseudo-random keys.

## Using logistic_key

After going through the documentation, let us use the function `logistic_key` with the following aarguments -
- x_init = 0.01
- r = 3.97
- num_keys = 20

```jldoctest prng
julia> keys = logistic_key(0.01, 3.97, 20)
20-element Vector{Int64}:
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
 200
 217
  97
 132
 134
 100
 135
 232
 122
 102
```

This returns a 1 dimensional `Vector` of pseudo-random `Int64` elements ranging from 0 - 255 (as the RGB values of an image range from 0 - 255)!

## Generating pseudo-random keys for an image

Now we can try to generate a pseudo-random key for each pixel in a given image. Let us load an image using the `TestImages` package for this!

```jldoctest prng
julia> img = testimage("cameraman");

julia> height, width = size(img)
(512, 512)
```

The image can be viewed using [ImageView.jl](https://github.com/JuliaImages/ImageView.jl) -

```julia
julia> using ImageView

julia> imshow(img)
```

![image](https://user-images.githubusercontent.com/74055102/163708322-0df9f306-8325-484b-8535-9a34fa358f06.png)

Generating a key for each pixel in the image

```jldoctest prng
julia> keys = logistic_key(0.01, 3.67, height * width)
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

We can now use these keys to encrypt the image! Encryption and decryption will be covered in another example :)

## Lorenz System of Differential Equations

As per the [documentation](https://saransh-cpp.github.io/ChaoticEncryption.jl/dev/apidocs/prngs/#Lorenz-system-of-differential-equations), `lorenz_key` generates 3 vectors of pseudo-random numbers using Lorenz system of differential equations.

The function uses the following system of differential equations to generate pseudo-random numbers -

```math
\frac{dx}{dt} = α * (y - x)
```
```math
\frac{dy}{dt} = x * (ρ - z) - y
```
```math
\frac{dz}{dt} = x * y - β * z
```

The function takes in the following arguments -

- `x_init::Float64`: Initial value of x.
- `y_init::Float64`: Initial value of y.
- `z_init::Float64:` Initial value of z.
- `num_keys::Int64`: Number of keys (in a single list) to be generated.
- `α::Float64`: Constant associated with Lorenz system of differential equations.
- `ρ::Float64`: Constant associated with Lorenz system of differential equations.
- `β::Float64`: Constant associated with Lorenz system of differential equations.
- `scaling_factor::Float64=10.0^16`: Factor to be multiplied to the generated value of pseudo-random
    number. Ideally, the factor should be > upper_bound.
- `upper_bound::Float64=256.0`: Upper bound of keys (not included). Use 256 for encrypting images
    as the RGB values of a pixel varies from 0 to 255.

And returns the following `Vector`s

- `x::Vector{Int64}`: Generated pseudo-random keys corresponding to x values.
- `y::Vector{Int64}`: Generated pseudo-random keys corresponding to y values.
- `z::Vector{Int64}`: Generated pseudo-random keys corresponding to z values.

## Using lorenz_key

After going through the documentation, let us use the function `lorenz_key` with the following aarguments -
- x_init = 0.01
- y_init = 0.02
- z_init = 0.03
- num_keys = 20

You can play with other arguments as well!

```jldoctest prng
julia> keys = lorenz_key(0.01, 0.02, 0.03, 20)
([0, 0, 256, 24, 129, 42, 54, 134, 43, 179, 85, 19, 24, 44, 71, 210, 238, 152, 22, 27], [0, 0, 240, 55, 25, 163, 89, 243, 123, 5, 197, 64, 227, 54, 188, 226, 154, 134, 64, 69], [0, 0, 80, 227, 178, 204, 89, 33, 144, 139, 105, 208, 108, 155, 61, 254, 57, 102, 149, 47])
```

## Generating pseudo-random keys for an image

Now we can try to generate a pseudo-random key for each pixel in a given image. Let us load an image using the `TestImages` package for this!

```jldoctest prng
julia> img = testimage("cameraman");

julia> height, width = size(img)
(512, 512)
```

Generating a key for each pixel in the image

```jldoctest prng
julia> x, y, z = lorenz_key(0.01, 0.02, 0.03, height * width)
([0, 0, 256, 24, 129, 42, 54, 134, 43, 179  …  46, 94, 18, 206, 68, 98, 72, 10, 248, 136], [0, 0, 240, 55, 25, 163, 89, 243, 123, 5  …  4, 112, 116, 100, 108, 92, 236, 80, 152, 144], [0, 0, 80, 227, 178, 204, 89, 33, 144, 139  …  128, 48, 176, 128, 176, 72, 168, 32, 208, 112])
```

`lorenz_key` returns a `Tuple` with each element being an `Vector{Int64}`. Thus, it returns a variable of the type `Tuple{Vector{Int64}, Vector{Int64}, Vector{Int64}}`.

```jldoctest prng
julia> x
262144-element Vector{Int64}:
   0
   0
 256
  24
 129
  42
  54
 134
  43
 179
   ⋮
  94
  18
 206
  68
  98
  72
  10
 248
 136
```

A notebook version of this tutorial is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/examples/PseudoRandomNumberGenerators.ipynb). Don't forget to star [`ChaoticEncryption.jl`](https://saransh-cpp.github.io/ChaoticEncryption.jl) :)

The complete API documentation is available [here](https://saransh-cpp.github.io/ChaoticEncryption.jl). 
