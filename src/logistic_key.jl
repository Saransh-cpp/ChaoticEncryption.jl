"""
    logistic_key(x_init, r, num_keys)

Generates pseudo-random keys using the Logistic Map.

The equation -

    x_(n+1) = r * x_n * (1 - x_n)

# Arguments
- `x_init::Float64`: Initial value of x. x ϵ (0, 1).
- `r::Float64`: A constant value. Values > 4 usually results in pseudo-random numbers.
- `num_keys::Int64`: Number of keys to be generated.

# Returns
- `keys::Array{Int64, 1}`: Generated pseudo-random keys.

# Example
```julia-repl
julia> logistic_key(0.01, 3.97, 20)
20-element Array{Int64,1}:
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
```
"""
function logistic_key(x_init::Float64, r::Float64, num_keys::Int64)
    keys = Array{Int64, 1}()
    x = x_init

    for i = 1:num_keys
        x = r * x * (1 - x)
        key = x * 10 ^ 16 % 256
        push!(keys, trunc(Int, key))
    end

    return keys
end
