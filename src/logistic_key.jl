"""
    logisticKey(0.01, 3.97, 20)

Generates pseudo-random keys using the Logistic Map.

# Arguments
- `x_init::Float64`: Initial value of x. x ϵ (0, 1).
- `r::Float64`: A constant value. Values > 4 usually results in pseudo-random numbers.
- `num_keys::Int64`: Number of keys to be generated.
"""
function logisticKey(x_init::Float64, r::Float64, num_keys::Int64)
    keys = []
    x = x_init

    for i = 1:num_keys
        x = r * x * (1-x)
        key = x * 10 ^ 16 % 256
        push!(keys, trunc(Int64, key))
    end

    return keys
end
