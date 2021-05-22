### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ 888c3ca9-763d-40b0-af02-1b019ccd2a65
using LinearAlgebra, Plots

# ╔═╡ facd0378-bb04-11eb-2dac-f5c5075715b6
md"""
# Mosquito life cycle with Leslie matrices

![](https://www.epa.gov/sites/production/files/styles/medium/public/2013-06/lifecycle.jpg)

"""

# ╔═╡ 51f80bb1-66cb-46a2-b85e-bb4dfa671381
f_adult = 10

# ╔═╡ 57d54bd0-2d8a-4607-a947-c6b5c4814b10
s_egg = 0.1

# ╔═╡ 9dfbfc8a-d6b8-4731-b3cf-fd7e1856f940
p_egg_larva = 0.15

# ╔═╡ e020a31a-4f51-4b06-84bf-07909720e57c
s_larva = 0.2

# ╔═╡ 5d8a779f-9f4b-404b-8d1f-ac32bb5f8ea3
p_larva_puppa = 0.2

# ╔═╡ 9d27c59e-85ba-4bce-a282-0c0ec317cd09
s_puppa = 0.1

# ╔═╡ 36192c82-486d-42c0-b29c-cb2ef0b4cc0d
p_puppa_adult = 0.6

# ╔═╡ 989cb058-f5d0-427a-be43-e33131ce4131
s_adult = 0.8

# ╔═╡ f6985d28-8cf0-46f3-a37e-6e115c50e534
L = [s_egg 0 0 f_adult;
	p_egg_larva s_larva 0 0;
	0 p_larva_puppa s_puppa 0;
	0 0 p_puppa_adult s_adult]

# ╔═╡ 2bd7a378-b3e5-4277-a832-69864cd92e2c
x₀ = [10000, 0, 0, 0]

# ╔═╡ aa8c70d7-e835-47bc-ab21-4d63b53ad405
x₁ = L * x₀

# ╔═╡ 1991c6be-6f45-469a-abe8-1e11a9fceeaf
x₂ = L * x₁

# ╔═╡ d270e369-896c-442f-8f8f-c2928c7751ed
x₃ = L * x₂

# ╔═╡ faa5d603-a90c-4c59-8419-73d3b37d6ac1
L * L * L * x₀ ≈ x₃

# ╔═╡ 41004310-ee38-4229-96d3-71c07c98c57c
x₁₀₀ = L^100 * x₀

# ╔═╡ 749a0b65-1637-461e-96b8-08b2c5a7644f
eigen(L)

# ╔═╡ 5fd462cd-01c0-4544-b572-93d166256f8d
function simulate_pop(x₀, L; nsteps=100)
	X = zeros(nsteps+1, length(x₀))
	X[1,:] .= x₀
	for t in 1:nsteps
		X[t+1,:] .= L * X[t,:]
	end
	return X
end

# ╔═╡ 03119757-8b71-427a-ae80-e861ec57b27b
X = simulate_pop(x₀, L, nsteps=100)

# ╔═╡ 52680083-f880-440f-a482-466b480bacad
plot(X, labels=["eggs" "larva" "puppa" "adults"], xlabel="time (days)")

# ╔═╡ 749fbcd7-3947-4efb-87a6-13891a9cee2e


# ╔═╡ Cell order:
# ╠═facd0378-bb04-11eb-2dac-f5c5075715b6
# ╠═51f80bb1-66cb-46a2-b85e-bb4dfa671381
# ╠═57d54bd0-2d8a-4607-a947-c6b5c4814b10
# ╠═9dfbfc8a-d6b8-4731-b3cf-fd7e1856f940
# ╠═e020a31a-4f51-4b06-84bf-07909720e57c
# ╠═5d8a779f-9f4b-404b-8d1f-ac32bb5f8ea3
# ╠═9d27c59e-85ba-4bce-a282-0c0ec317cd09
# ╠═36192c82-486d-42c0-b29c-cb2ef0b4cc0d
# ╠═989cb058-f5d0-427a-be43-e33131ce4131
# ╠═f6985d28-8cf0-46f3-a37e-6e115c50e534
# ╠═2bd7a378-b3e5-4277-a832-69864cd92e2c
# ╠═aa8c70d7-e835-47bc-ab21-4d63b53ad405
# ╠═1991c6be-6f45-469a-abe8-1e11a9fceeaf
# ╠═d270e369-896c-442f-8f8f-c2928c7751ed
# ╠═faa5d603-a90c-4c59-8419-73d3b37d6ac1
# ╠═41004310-ee38-4229-96d3-71c07c98c57c
# ╠═888c3ca9-763d-40b0-af02-1b019ccd2a65
# ╠═749a0b65-1637-461e-96b8-08b2c5a7644f
# ╠═5fd462cd-01c0-4544-b572-93d166256f8d
# ╠═03119757-8b71-427a-ae80-e861ec57b27b
# ╠═52680083-f880-440f-a482-466b480bacad
# ╠═749fbcd7-3947-4efb-87a6-13891a9cee2e
