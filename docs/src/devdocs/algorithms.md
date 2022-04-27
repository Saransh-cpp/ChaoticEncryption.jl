# Encryption/decryption algorithms

Developer documentation for encryption and decryption algorithms.

```@docs
ChaoticEncryption._substitution(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Vector{Int64},
    type::Symbol;
    path_for_result::String="./encrypted.png"
)
```