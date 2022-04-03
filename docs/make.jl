using Images
using Documenter
using ChaoticEncryption

DocMeta.setdocmeta!(ChaoticEncryption, :DocTestSetup, :(using ChaoticEncryption); recursive = true)
makedocs(
    sitename = "ChaoticEncryption",
    format = Documenter.HTML(sidebar_sitename=false),
    modules = [ChaoticEncryption, Images],
    doctest = false,
    pages = [
        "Home" => "index.md",
        "API Documentation" => "apidocs.md",
        "Developer Documentation" => "devdocs.md"
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/Saransh-cpp/ChaoticEncryption.jl.git"
)
