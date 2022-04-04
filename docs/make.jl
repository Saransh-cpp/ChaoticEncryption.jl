using Images
using Documenter
using ChaoticEncryption

DocMeta.setdocmeta!(ChaoticEncryption, :DocTestSetup, :(using ChaoticEncryption); recursive = true)
makedocs(
    sitename = "ChaoticEncryption",
    format = Documenter.HTML(sidebar_sitename=false),
    modules = [ChaoticEncryption, Images],
    doctest = true,
    strict = :doctest,
    pages = [
        "Home" => "index.md",
        "API Documentation" => [
            "Pseudo-Random Number Generators" => "apidocs/prngs.md",
            "Encryption/decryption algorithms" => "apidocs/algorithms.md"
        ],
        "Developer Documentation" => "devdocs.md"
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/Saransh-cpp/ChaoticEncryption.jl.git",
    push_preview = true,
    versions = ["stable" => "v^", "v#.#.#", "dev"],
)
