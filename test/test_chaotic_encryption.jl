using ChaoticEncryption
using Test

@testset "ChaoticEncryption.jl" begin
    @test typeof(logistic_key(0.01, 3.97, 20)) == Array{Int64, 1}
    @test length(logistic_key(0.01, 3.97, 20)) == 20

    @test typeof(lorenz_key(0.01, 0.02, 0.03, 20)) == Tuple{Array{Int64, 1}, Array{Int64, 1}, Array{Int64, 1}}
    @test length(lorenz_key(0.01, 0.02, 0.03, 20)) == 3
    @test length(lorenz_key(0.01, 0.02, 0.03, 20)[1]) == 20
    @test length(lorenz_key(0.01, 0.02, 0.03, 20)[2]) == 20
    @test length(lorenz_key(0.01, 0.02, 0.03, 20)[3]) == 20
end
