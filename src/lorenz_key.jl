"""
    lorenz_key(x_init, y_init, z_init, num_keys; α=10.0, ρ=28.0, β=2.667, dt=0.01)

Generates 3 vectors of pseudo-random numbers using Lorenz system of differential
equations.

The equations -

\$\\frac{dx}{dt} = α * (y - x)\$
\$\\frac{dy}{dt} = x * (ρ - z) - y\$
\$\\frac{dz}{dt} = x * y - β * z\$

# Arguments
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

# Returns
- `x::Vector{Int64}`: Generated pseudo-random keys corresponding to x values.
- `y::Vector{Int64}`: Generated pseudo-random keys corresponding to y values.
- `z::Vector{Int64}`: Generated pseudo-random keys corresponding to z values.

# Example
```jldoctest
julia> using ChaoticEncryption

julia> lorenz_key(0.01, 0.02, 0.03, 20)
([0, 0, 256, 24, 129, 42, 54, 134, 43, 179, 85, 19, 24, 44, 71, 210, 238, 152, 22, 27], [0, 0, 240, 55, 25, 163, 89, 243, 123, 5, 197, 64, 227, 54, 188, 226, 154, 134, 64, 69], [0, 0, 80, 227, 178, 204, 89, 33, 144, 139, 105, 208, 108, 155, 61, 254, 57, 102, 149, 47])
```
"""
function lorenz_key(
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
    # Initializing 3 empty lists
    x = zeros(Float64, num_keys)
    y = zeros(Float64, num_keys)
    z = zeros(Float64, num_keys)

    # Initializing initial values
    x[1], y[1], z[1] = x_init, y_init, z_init

    # System of equations
    for i = 1:num_keys - 1
        x[i + 1] = x[i] + (α * (y[i] - x[i]) * dt)
        y[i + 1] = y[i] + ((x[i] * (ρ - z[i]) - y[i]) * dt)
        z[i + 1] = z[i] + ((x[i] * y[i] - β * z[i]) * dt)
    end

    for i = 1:length(x)
        x[i] = x[i] * scaling_factor % upper_bound
        y[i] = y[i] * scaling_factor % upper_bound
        z[i] = z[i] * scaling_factor % upper_bound
    end

    x = round.(Int, x)
    y = round.(Int, y)
    z = round.(Int, z)

    return x, y, z
end
