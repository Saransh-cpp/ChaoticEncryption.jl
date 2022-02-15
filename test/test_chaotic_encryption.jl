using ChaoticEncryption
using Images
using Test

@testset "ChaoticEncryption.jl" begin

    @testset "Logistic Map" begin
        @test typeof(logistic_key(0.01, 3.97, 20)) == Array{Int64, 1}
        @test length(logistic_key(0.01, 3.97, 20)) == 20
    end

    @testset "Lorenz System of Differential Equations" begin
        @test typeof(lorenz_key(0.01, 0.02, 0.03, 20)) == Tuple{Array{Int64, 1}, Array{Int64, 1}, Array{Int64, 1}}
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)) == 3
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)[1]) == 20
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)[2]) == 20
        @test length(lorenz_key(0.01, 0.02, 0.03, 20)[3]) == 20
    end

    @testset "Substitution Encryption" begin
        img = load("./test_images/camera.jfif")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)
        substitution_encryption("test_images/camera.jfif", keys, "./test_images/encrypted.png")
        @test isfile("./test_images/encrypted.png")
    end

    @testset "Substitution Decryption" begin
        img = load("./test_images/encrypted.png")
        height, width = size(img)
        keys = logistic_key(0.01, 3.97, height * width)
        substitution_decryption("./test_images/encrypted.png", keys, "./test_images/decrypted.png")
        @test isfile("./test_images/decrypted.png")
        rm("./test_images/encrypted.png")
        rm("./test_images/decrypted.png")
    end
end
