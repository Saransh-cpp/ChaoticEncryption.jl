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

        substitution_encryption(img, keys; save_img=true, path_for_result="../test_images/encrypted.png", debug=true)
        @test isfile("../test_images/encrypted.png")

        keys = logistic_key(0.01, 3.97, 20)
        @test_throws ArgumentError("Number of keys must be equal to height * width of image.") substitution_encryption(img, keys; path_for_result="../test_images/encrypted.png")
    end

    @testset "Substitution Encryption (inplace)" begin
        img = testimage("mandrill")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)

        enc = substitution_encryption!(img, keys; save_img=true, path_for_result="../test_images/encrypted.png", debug=true)
        @test isfile("../test_images/encrypted.png")
        @test img == enc  # inplace
    end

    @testset "Substitution Decryption" begin
        img = testimage("mandrill")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)

        substitution_decryption("../test_images/encrypted.png", keys; save_img=true, path_for_result="../test_images/decrypted.png", debug=true)
        @test isfile("../test_images/decrypted.png")

        substitution_decryption(img, keys; save_img=true, path_for_result="../test_images/decrypted.png", debug=true)
        @test isfile("../test_images/decrypted.png")

        keys = logistic_key(0.01, 3.97, 20)
        @test_throws ArgumentError("Number of keys must be equal to height * width of image.") substitution_decryption(img, keys; path_for_result="../test_images/decrypted.png")

        rm("../test_images/encrypted.png")
        rm("../test_images/decrypted.png")
    end

    @testset "Substitution Decryption (inplace)" begin
        img = testimage("mandrill")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)

        dec = substitution_decryption!(img, keys; save_img=true, path_for_result="../test_images/decrypted.png", debug=true)
        @test isfile("../test_images/decrypted.png")
        @test img == dec  # inplace

        rm("../test_images/decrypted.png")
    end
end
