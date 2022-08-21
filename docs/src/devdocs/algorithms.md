# Encryption/decryption algorithms

Developer documentation for encryption and decryption algorithms.

These lower level APIs can also be used by the users, but are not recommended
for beginners.

```@docs
ChaoticEncryption._substitution(
    image::Union{String,Array{RGB{N0f8},2}},
    keys::Vector{Int64},
    type::Symbol;
    path_for_result::String="./encrypted.png",
    inplace=false,
)
ChaoticEncryption._substitute_pixel!(
    pixel::RGB,
    key::Int64
)
```