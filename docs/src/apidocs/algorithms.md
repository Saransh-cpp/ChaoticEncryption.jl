# Encryption/decryption algorithms

## Substitution

### Encryption

```@docs
substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    save_img::Bool=false,
    path_for_result::String="./encrypted.png",
    debug::Bool=false,
)
```

```@docs
substitution_encryption!(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    save_img::Bool=false,
    path_for_result::String="./encrypted.png",
    debug::Bool=false,
)
```

### Decryption

```@docs
substitution_decryption(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Vector{Int64};
    save_img::Bool=false,
    path_for_result::String="./decrypted.png",
    debug::Bool=false
)
```

```@docs
substitution_decryption!(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    save_img::Bool=false,
    path_for_result::String="./decrypted.png",
    debug::Bool=false,
)
```
