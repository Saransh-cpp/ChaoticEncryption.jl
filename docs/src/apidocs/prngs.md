# Pseudo-Random Number Generators

## Logistic map

```@docs
logistic_key(
    x_init::Float64,
    r::Float64,
    num_keys::Int64;
    scaling_factor::Float64=10.0^16,
    upper_bound::Float64=256.0
)
```

## Lorenz system of differential equations

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
