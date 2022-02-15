using Documenter
using ChaoticEncryption

makedocs(
    sitename = "ChaoticEncryption",
    format = Documenter.HTML(),
    modules = [ChaoticEncryption]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
