# ChaoticEncryption.jl

Encrypt and decrypt image files using Pseudo-Random Number Generators!

```@meta
CurrentModule = ChaoticEncryption
```

## Index

```@index
```

## Pseudo-Random Number Generators

```@docs
logistic_key(
    x_init::Float64,
    r::Float64,
    num_keys::Int64
)
```

```@docs
lorenz_key(
    x_init::Float64,
    y_init::Float64,
    z_init::Float64,
    num_keys::Int64;
    α::Float64=10.0,
    ρ::Float64=28.0,
    β::Float64=2.667,
    dt::Float64=0.01
)
```

## Encryption methods

```@docs
substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1};
    path_for_result::String="./encrypted.png"
)
```

```@docs
substitution_decryption(
    image,
    keys::Array{Int64, 1};
    path_for_result::String="./decrypted.png"
)
```
