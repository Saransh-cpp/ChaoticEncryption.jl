module ChaoticEncryption

include("lorenz_key.jl")
include("logistic_key.jl")
include("substitution.jl")
include("shuffle.jl")

export lorenz_key, logistic_key
export substitution_encryption, substitution_decryption

end
