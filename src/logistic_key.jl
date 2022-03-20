"""
    logistic_key(x_init, r, num_keys; scaling_factor=10.0^16, upper_bound=256.0)

Generates a vector of pseudo-random keys using the Logistic Map.

The equation -

\$x_{n+1} = r * x_{n} * (1 - x_{n})\$

# Arguments
- `x_init::Float64`: Initial value of x. x ϵ (0, 1).
- `r::Float64`: A constant value. Values > 4 usually results in pseudo-random numbers.
- `num_keys::Int64`: Number of keys to be generated.
- `scaling_factor::Float64=10.0^16`: Factor to be multiplied to the generated value of pseudo-random
    number. Ideally, the factor should be > upper_bound.
- `upper_bound::Float64=256.0`: Upper bound of keys (not included). Use 256 for encrypting images
    as the RGB values of a pixel varies from 0 to 255.

# Returns
- `keys::Vector{Int64}:`: Generated pseudo-random keys.

# Example
```jldoctest
julia> logistic_key(0.01, 3.97, 20)
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
"""
function logistic_key(
    x_init::Float64,
    r::Float64,
    num_keys::Int64;
    scaling_factor::Float64=10.0^16,
    upper_bound::Float64=256.0
)
    keys = Vector{Int64}(undef, num_keys)
    x = x_init

    for i = 1:num_keys
        x = r * x * (1 - x)
        key = x * scaling_factor % upper_bound
        keys[i] = trunc(Int, key)
    end

    return keys
end
