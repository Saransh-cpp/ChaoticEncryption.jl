# Unreleased

## Breaking changes
- All the types have been migrated to `Julia v1.7.2` ([#32](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/32), @Saransh-cpp)

## Documentation
- Updated all the examples to go with `Julia v1.7.2` migration ([#34](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/34), @Saransh-cpp)
- All the docstrings have been updated to follow `Julia v1.7.2` and to pass the `doctests` ([#32](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/32), @Saransh-cpp)

# ChaoticEncryption v0.1.1

## Documentation
- Improved the docstring examples ([#24](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/24), @Saransh-cpp)
- Added doctests ([#24](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/24), @Saransh-cpp)

## Misc
- Created a `CHANGELOG` file ([#25](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/25), @Saransh-cpp)
- Created a new logo ([#23](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/23), @Saransh-cpp)
- Added issue and PR templates ([#22](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/22), @Saransh-cpp)

# ChaoticEncryption v0.1.0

**NOTE:** Most of the additions/changes were made directly to the `master` branch (i.e. not through a PR), hence, most of the changes won't have a PR associated with them. This will change in the next versions of `ChaoticEncryption.jl`!

## Features
- Implemented the Logistic Map Pseudo-Random Number Generator (@Saransh-cpp)
- Implemented the Lorenz System of Differential Equations Pseudo-Random Number Generator (@Saransh-cpp)
- Implemented the substitution encryption and decryption algorithm (@Saransh-cpp)
- Now the encryption and decryption functions will return the encrypted image ([#11](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/11), @Saransh-cpp)
- Allow users to pass a loaded image instead of image's path ([#19](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/19), @Saransh-cpp)

## Bug fixes
- Fixed the implementation of positional arguments ([#19](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/19), @Saransh-cpp)

## Documentation
- Added GitHub's special markdown files ([#1](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/1), @Saransh-cpp)
- Added docstrings and latexified them ([#7](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/7), @Saransh-cpp)
- Update `README.md` with all the relevant information ([#8](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/8), @Saransh-cpp)
- Added complete documentation and deployed it on GitHub Pages (https://saransh-cpp.github.io/ChaoticEncryption.jl/) (@Saransh-cpp)
- Added example notebooks ([#11](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/11), @Saransh-cpp)

## CI
- Created the CI pipeline (@Saransh-cpp)
- Optimized the CI pipeline ([#18](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/18), @Saransh-cpp)
- Added CI for documentation deployment (@Saransh-cpp)

## Misc
- Removed redundant dependencies ([#19](https://github.com/Saransh-cpp/ChaoticEncryption.jl/pull/19), @Saransh-cpp)