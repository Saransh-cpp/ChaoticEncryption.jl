# Encryption/decryption algorithms

## Substitution

### Encryption

```@docs
substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1};
    path_for_result::String="./encrypted.png"
)
```

```@docs
substitution_encryption!(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1};
    path_for_result::String="./encrypted.png"
)
```

### Decryption

```@docs
substitution_decryption(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Array{Int64, 1};
    path_for_result::String="./decrypted.png"
)
```

```@docs
substitution_decryption!(
    image::Array{RGB{N0f8},2},
    keys::Array{Int64, 1};
    path_for_result::String="./decrypted.png"
)
```
