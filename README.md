<p align="center">
    <img src="https://user-images.githubusercontent.com/74055102/154795300-93829a7f-5859-4450-be20-8bd28ea4bcca.png#gh-light-mode-only"/>
    <img src="https://user-images.githubusercontent.com/74055102/154795225-d439004c-267e-4d96-91c1-ffd9213eddbe.png#gh-dark-mode-only"/>
</p>

<div align="center">
  
  [![Build Status](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/CI.yml?query=branch%3Amaster)
  [![Documentation](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/documentation.yml/badge.svg)](https://github.com/Saransh-cpp/ChaoticEncryption.jl/actions/workflows/documentation.yml)
  [![version](https://juliahub.com/docs/ChaoticEncryption/version.svg)](https://juliahub.com/ui/Packages/ChaoticEncryption/dtMkN)
  [![Dev](https://img.shields.io/badge/Docs-Dev-brightgreen)](https://saransh-cpp.github.io/ChaoticEncryption.jl/dev/)
  [![Coverage](https://codecov.io/gh/Saransh-cpp/ChaoticEncryption.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Saransh-cpp/ChaoticEncryption.jl) [![Join the chat at https://gitter.im/ChaoticEncryption-jl/community](https://badges.gitter.im/ChaoticEncryption-jl/community.svg)](https://gitter.im/ChaoticEncryption-jl/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

</div>

# ChaoticEncryption.jl

Encrypt and decrypt image files using Pseudo-Random Number Generators and various encryption techniques! `ChaoticEncryption.jl` comes loaded with Pseudo-Random Number Generators and various encryption techniques, which can be used to encrypt and decrypt any image file. The package is under active development, but the existing API is stable and might not change significantly.

## Installation
This package is available on Julia's Registry!
```julia-repl
julia> using Pkg
julia> Pkg.add("ChaoticEncryption")
```
or
```julia-repl
julia> ]add ChaoticEncryption
```

For developer installation or installation from source, refer [here](https://github.com/Saransh-cpp/ChaoticEncryption.jl/blob/master/CONTRIBUTING.md#local-installation).

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
