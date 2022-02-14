"""
    lorenz_key(x_init, y_init, z_init, num_keys, α=10.0, ρ=28.0, β=2.667, dt=0.01)

Generates 3 lists of pseudo-random numbers using Lorenz system of differential
equations.

The equations -

    dx/dt = α * (y - x)
    dy/dt = x * (ρ - z) - y
    dz/dt = x * y - β * z

# Arguments
- `x_init::Float64`: Initial value of x.
- `y_init::Float64`: Initial value of y.
- `z_init::Float64:` Initial value of z.
- `num_keys::Int64`: Number of keys (in a single list) to be generated.
- `α::Float64`: Constant associated with Lorenz system of differential equations.
- `ρ::Float64`: Constant associated with Lorenz system of differential equations.
- `β::Float64`: Constant associated with Lorenz system of differential equations.

# Returns
- `x::Array{Any, 1}`: Generated pseudo-random keys corresponding to x values.
- `y::Array{Any, 1}`: Generated pseudo-random keys corresponding to y values.
- `z::Array{Any, 1}`: Generated pseudo-random keys corresponding to z values.
"""
function lorenz_key(
    x_init::Float64,
    y_init::Float64,
    z_init::Float64,
    num_keys::Int64,
    α::Float64=10.0,
    ρ::Float64=28.0,
    β::Float64=2.667,
    dt::Float64=0.01
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

    return x, y, z
end