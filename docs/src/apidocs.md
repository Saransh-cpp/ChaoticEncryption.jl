# API documentation

API documentation for user-facing code.

## Pseudo-Random Number Generators

```@docs
logistic_key(
    x_init::Float64,
    r::Float64,
    num_keys::Int64;
    scaling_factor::Float64=10.0^16,
    upper_bound::Float64=256.0
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
    dt::Float64=0.01,
    scaling_factor::Float64=10.0^16,
    upper_bound::Float64=256.0
)
```

## Encryption/decryption algprithms

```@docs
substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1};
    path_for_result::String="./encrypted.png"
)
```

```@docs
substitution_decryption(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Array{Int64, 1};
    path_for_result::String="./decrypted.png"
)
```
