# ChaoticEncryption.jl

<div align="center">
  
  [![Build Status](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/CI.yml?query=branch%3Amaster)
  [![Documentation](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/documentation.yml/badge.svg)](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/documentation.yml)
  [![Dev](https://img.shields.io/badge/Docs-Dev-brightgreen)](https://saransh-cpp.github.io/ChaoticEncryption.jl/dev/)
  [![Coverage](https://codecov.io/gh/Saransh-cpp/ChaoticEncryption.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Saransh-cpp/ChaoticEncryption.jl)

</div>

Encrypt and decrypt image files using Pseudo-Random Number Generators and various encryption techniques!

## Installation
Once this package is available on Julia's Registry (very soon) -
```julia-repl
julia> using Pkg
julia> Pkg.add("ChaoticEncryption")
```
or
```julia-repl
julia> ]add ChaoticEncryption
```

Right now, the package can be installed by following the steps below -

1. Clone [this](https://github.com/Saransh-cpp/ChaoticEncryption.jl) repository -
```
git clone https://github.com/Saransh-cpp/ChaoticEncryption.jl
```
2. Change directory and activate `Julia REPL` -
```
cd ChaoticEncryption.jl
julia
```
3. Install the package and its dependencies -
```julia-repl
julia> ]dev .
```

## Features

- [X] Logistic Map PRNG
- [X] Lorenz System of Differential Equations PRNG
- [X] Substitution encryption and decryption
- [ ] Shuffle encryption and decryption
- [ ] More PRNGs
- [ ] More encryption and decryption techniques
- [ ] Website: frontend
- [ ] Website: backend

## Usage example
A single encryption layer can be added as -
```julia
using Images
using ChaoticEncryption

img = load("path/to/image.jpg")
height, width = size(img)

keys = logistic_key(0.01, 3.97, height * width)  # generate keys using logistic map
substitution_encryption("path/to/image.jpg", keys)  # encrypt
```
This image can then be decrypted using -
```julia
substitution_decryption("path/to/encrypted.png", keys)  # decrypt
```

## Examples

The example for a particular function is available in the function's docstring itself. These docstrings or the API documentation is also available [here](https://saransh-cpp.github.io/ChaoticEncryption.jl/dev/).

Other than the docstrings, comprehensive `Jupyter` notebooks displaying the features of `ChaoticEncryption.jl` are available in the [`examples`](https://github.com/Saransh-cpp/ChaoticEncryption.jl/tree/master/examples) directory.

## Testing

To run the tests, execute the following in your `Julia REPL` -
```julia-repl
julia> ]test ChaoticEncryption
```

More information on tests is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/CONTRIBUTING.md#testing).

To run calculate coverage while running tests, execute the following in your `Julia REPL` -
```julia-repl
julia> using Pkg
julia> Pkg.add("Coverage")
julia> Pkg.test("ChaoticEncryption"; coverage=true)
```

More information on coverage is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/CONTRIBUTING.md#coverage).

## Documentation

The documentation is available here - https://saransh-cpp.github.io/ChaoticEncryption.jl/dev/

The documentation can be built locally by executing -
```
julia docs/make.jl
```
The deployment will be visible on the webpage served at http://127.0.0.1:8000.

More information on documentation is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/CONTRIBUTING.md#documentation).

## Infrastructure

A detailed guide on `ChaoticEncryption.jl`'s infrastructure is available [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/CONTRIBUTING.md#infrastructure).

## Results
### Original Image
![image](https://user-images.githubusercontent.com/74055102/154138746-cd49b7a7-bdf2-47c2-8260-35a90084c60a.png)
### Encrypted Image
![encrypted](https://user-images.githubusercontent.com/74055102/154138976-5e60fe23-3644-4299-bc39-7d6b637cc744.png)
### Decrypted Image
![decrypted](https://user-images.githubusercontent.com/74055102/154139009-bd2a1de0-03a7-432e-bc34-2647f8c42425.png)

## Contributing to ChaoticEncryption.jl

All contributions to this repository are welcome. Please go through our [contribution guidelines](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/CONTRIBUTING.md) to make the whole process smoother.