"""
`ChaoticEncryption.jl` comes loaded with Pseudo-Random Number Generators and various
encryption techniques, which can be used to encrypt and decrypt any image file. The
package is under active development, but the existing API is stable and might not
change significantly.

For complete documentation, refer - https://saransh-cpp.github.io/ChaoticEncryption.jl
"""
module ChaoticEncryption

include("lorenz_key.jl")
include("logistic_key.jl")
include("substitution.jl")
include("utils.jl")

export lorenz_key, logistic_key

export substitution_encryption,
       substitution_encryption!,
       substitution_decryption,
       substitution_decryption!

end
