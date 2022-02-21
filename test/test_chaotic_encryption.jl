using ChaoticEncryption
using TestImages
using Test

@testset "ChaoticEncryption.jl" begin

    @testset "Logistic Map" begin
        @test typeof(logistic_key(0.01, 3.97, 20)) == Vector{Int64}
        @test length(logistic_key(0.01, 3.97, 20)) == 20
    end

    @testset "Lorenz System of Differential Equations" begin
        @test typeof(lorenz_key(0.01, 0.02, 0.03, 20)) == Tuple{Vector{Int64}, Vector{Int64}, Vector{Int64}}
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)) == 3
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)[1]) == 20
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)[2]) == 20
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)[3]) == 20
    end

    @testset "Substitution Encryption" begin
        img = testimage("mandrill")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)
        substitution_encryption(img, keys; path_for_result="../test_images/encrypted.png")
        @test isfile("../test_images/encrypted.png")

        keys = logistic_key(0.01, 3.97, 20)
        @test_throws ArgumentError("Number of keys must be equal to height * width of image.") substitution_encryption(img, keys; path_for_result="../test_images/encrypted.png")
    end

    @testset "Substitution Decryption" begin
        img = testimage("mandrill")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)

        substitution_decryption("../test_images/encrypted.png", keys; path_for_result="../test_images/decrypted.png")
        @test isfile("../test_images/decrypted.png")

        substitution_decryption(img, keys; path_for_result="../test_images/decrypted.png")
        @test isfile("../test_images/decrypted.png")

        @test_throws ArgumentError("image must be of the type ::String or ::Array{RGB{N0f8},2}") substitution_decryption(5, keys; path_for_result="../test_images/decrypted.png")

        keys = logistic_key(0.01, 3.97, 20)
        @test_throws ArgumentError("Number of keys must be equal to height * width of image.") substitution_decryption(img, keys; path_for_result="../test_images/decrypted.png")

        rm("../test_images", recursive=true)
    end
end
