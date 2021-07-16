### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 4833fba1-5f7a-480f-8f81-cbb96f1d1a1a
using Plots, PlutoUI

# ╔═╡ 46572322-b57d-11eb-0cd2-8f3bbd1ec6f1
md"""
# Random walk of the fly

In this notebook, we will study the random walk of a fly (🪰) in one, two and three dimensions.
"""

# ╔═╡ 1eb0004d-2ba9-4eb6-bc05-586cbd98e204
md"""
## One dimensional: a fly on a stick

First, we imagine a fly on a stick. This ever restless fly is not yet in the mood to spread its wings. Instead, every time step, it will move either randomly to the left or to the right on this stick, with equal probability.

Let us use `🪰x` to keep track of the positions of the fly througout time. We use the letter x here, since we assume the fly craws over an $x$-axis, our stick. If the flies starts at the origin, position 0, negative values indicate that the fly has moved to the left, while positive values indicate it has moved to the right.

To keep this simple, in every time step, for example every second, the fly moves a single step to the left ($\Delta x=-1$) or a single step to the right ($\Delta x=0$). Our fly never sits still! We can easily simulate a random decision using the function `rand`:
"""

# ╔═╡ e88b1896-927b-4807-a951-a0cd971596f2
rand((-1, 1))  # random choice between -1 and 1

# ╔═╡ e049558f-dfc7-41cf-9a52-ebceeb9588f8
Δxs = rand((-1, 1), 5)  # five random choices between -1 and 1

# ╔═╡ 137476e0-0908-45bd-a696-62158e2a3763
md"So, above, we simulated five random directions for the fly to move on. In this example, we know that:
- at time $t=0$, the fly was at position 0;
- at time $t=1$, the fly was at position $(Δxs[1]);
- at time $t=2$, the fly was at position $(sum(Δxs[1:2]));
- at time $t=3$, the fly was at position $(sum(Δxs[1:3]));
- at time $t=4$, the fly was at position $(sum(Δxs[1:4]));
- at time $t=5$, the fly was at position $(sum(Δxs[1:5])).

To know the postion at time $t$, we just have to sum the first $t$ directions! To compute a vector with the location of the fly at every time $t$, we just have to sum all intermediate results. We can make use of the built-in function `cumsum` (*cumulative sum*), which yields this.

"

# ╔═╡ 519b9582-69f3-4344-9e8b-7f1b40ad1d3f
cumsum(Δxs)

# ╔═╡ a23dd863-1242-4506-9514-a4b6b9f25e63
md"To play around with it, let us write a small function to generate 1D random walks for a fly."

# ╔═╡ 357254e3-fa09-438b-b5b3-7720ba7596c6
function randomwalk1D(nsteps)
	Δxs = rand((-1, 1), nsteps)
	xs = cumsum(Δxs)
	return xs
end

# ╔═╡ b92228d5-15b9-40e8-99c9-e7cb3e17ecc4
nsteps = 100000

# ╔═╡ f0333ec9-fd6b-43d6-8666-1cde329745c9
tsteps = 1:nsteps

# ╔═╡ fb5d6422-12c3-4589-bf34-6de9c28148a5
🪰x = randomwalk1D(nsteps)

# ╔═╡ 5baf7fdf-2266-4c8f-9f56-e0616186949e
md"Let us take a look!"

# ╔═╡ cb40ae3e-e1f9-4fac-a2b3-4237a2c61f15
p1D = plot(🪰x, tsteps, xlabel="x", ylabel="t", label="")

# ╔═╡ 1f1ac119-e92e-4762-b796-221ea8375ae1
md"We see that even after $nsteps, our fly has remained surprisingly close to the origin. Let us simulate a couple more examples."

# ╔═╡ d775df2a-2e15-43ea-86a9-59e9b4b964ae
🪰x2 = randomwalk1D(nsteps)

# ╔═╡ 4c98def5-4c7e-4cfe-998f-f715567007df
🪰x3 = randomwalk1D(nsteps)

# ╔═╡ cf9a3ce8-b565-4502-970b-4caca30cf70a
🪰x4 = randomwalk1D(nsteps)

# ╔═╡ 38305ec5-4814-43e0-8cd5-a56fae5f12f1
begin
	plot1db = true
	plot!(p1D, 🪰x2, tsteps)
	plot!(p1D, 🪰x3, tsteps)
	plot!(p1D, 🪰x4, tsteps)
end

# ╔═╡ cd04f8cf-dd82-485b-8a51-d36fcdb0d164
md"Each walk is different, though they all stay relatively close to 0!

We can show that for random walks at time $t$:
- the expected position of the fly is the origin;
- the spread of the walks is proportional to $\frac{\sqrt{t}}{2}$, meaning that most times, the random walks will be constrained between $-2\frac{\sqrt{t}}{2}$ and $2\frac{\sqrt{t}}{2}$.

"

# ╔═╡ 05fa2583-787d-4ed7-887c-acdcf39e2df7
begin
	plot1db
	plot!(p1D, -2sqrt.(tsteps), tsteps, label="bound", ls=:dash, color="black")
	plot!(p1D, 2sqrt.(tsteps), tsteps, label="", ls=:dash, color="black")
end

# ╔═╡ a498c2c5-95eb-4fca-9c84-90293527386c
sqrt.(tsteps)

# ╔═╡ b1c63f7b-6b1b-4619-893c-503698157756
md"Since the squareroot is a slowly growing function, our fly remains close to its original position, even after a long time!"

# ╔═╡ 57bd6692-5f8d-4b85-a529-aa29874f7687
md"
## Two dimensional: a fly on a table

Let us give our fly a bit more freedom: it can now walk at the surface of a table! Now, we have to encode its position using two coordinates: $x$ and $y$.

We use a similar idea of movement: every step the fly either goes left or right and up or down at the table (so it always moves in the $x$ *and* the $y$ direction.

Since its movements are independent for each dimenion, we can just simulate this by combining two 1D random walks.
"

# ╔═╡ 8d243769-29f5-4925-800f-e7e7c0a820cc
function randomwalk2D(nsteps)
	xs = randomwalk1D(nsteps)
	ys = randomwalk1D(nsteps)
	return (x=xs, y=ys)
end

# ╔═╡ f1c79b07-911a-4a53-bf92-e6bbe2854957
md"Note that `randomwalk2D` gives two vectors: one containing the $x$ coordinates and one containing the $y$ coordinates."

# ╔═╡ 3d403ee2-6d47-42d2-b3db-885535f628d2
🪰xy = randomwalk2D(nsteps)

# ╔═╡ ffb67ff6-954b-4ba5-980c-f2728423177e
p2D = plot(🪰xy..., label="", xlabel="x", ylabel="y")

# ╔═╡ a511779c-6683-4638-9e0d-a8b796049552
md"Let us also look at some alternative paths:"

# ╔═╡ 2a0fa08e-f95d-4f83-8d0f-d5726bae3493
🪰xy2 = randomwalk2D(nsteps)

# ╔═╡ 1a060889-2320-4801-a17c-2df096a889e7
🪰xy3 = randomwalk2D(nsteps)

# ╔═╡ 19537fce-2c37-4a2d-a009-c5c690b2310c
🪰xy4 = randomwalk2D(nsteps)

# ╔═╡ d4282897-7a9b-4bec-819c-d622c671d359
begin
	plot!(p2D, 🪰xy2..., alpha=0.7)
	plot!(p2D, 🪰xy3..., alpha=0.7)
	plot!(p2D, 🪰xy4..., alpha=0.7)
	plot!(p2D, sqrt(nsteps) * 2cos.(0:0.1:2pi), 2sqrt(nsteps) * sin.(0:0.1:2pi),
		label="bound", color="black", ls=:dash)
end

# ╔═╡ dcc62e8f-85ec-423e-b964-6dd868f2d872
md"These curves are selfsimilar at different time steps:"

# ╔═╡ 97056fe6-8507-4898-b16d-a2be2bb375ba
plot(
	plot(randomwalk2D(1000)..., title="1000 steps", label="",ticks=false),
	plot(randomwalk2D(10000)..., title="10000 steps", label="",ticks=false),
	plot(randomwalk2D(100000)..., title="100000 steps", label="",ticks=false),
	plot(randomwalk2D(1000000)..., title="1000000 steps", label="",ticks=false))

# ╔═╡ 4367ac24-c24f-4dad-9a94-0b53fa4f54f3
md"
## Three dimensional: a fly in the sky

When our fly lifts off, we need three coordinates to describe its movement: ($x$, $y$, $z$).

Given similar movement rules of our fly, we can implement a simular funciton for 3D:
"

# ╔═╡ 51654f8c-523d-471f-b370-c8a7a761c7f0
function randomwalk3D(nsteps)
	xs = randomwalk1D(nsteps)
	ys = randomwalk1D(nsteps)
	zs = randomwalk1D(nsteps)
	return (x=xs, y=ys, z=zs)
end

# ╔═╡ b6199e57-23a2-4b5a-b0e8-e6aa7fa62086
🪰xyz = randomwalk3D(nsteps)

# ╔═╡ 9077d49b-04dd-4dae-9bfb-da4d1b1705fd
p3d = plot3d(🪰xyz..., label="",
	xlabel="x",
	ylabel="y",
	zlabel="z")

# ╔═╡ 20d359c3-245a-4360-85a6-6b1dc73c4aac
🪰xyz2 = randomwalk3D(nsteps)

# ╔═╡ 0e87e5e5-10f4-4b0b-aae4-5b64bd66e7cc
🪰xyz3 = randomwalk3D(nsteps)

# ╔═╡ 032181f5-7bc3-44a2-9f5a-5a6799510f48
🪰xyz4 = randomwalk3D(nsteps)

# ╔═╡ 01f51dea-d577-40e8-b67f-3364eed88cf5
begin
	plot3d!(p3d, 🪰xyz2..., alpha=0.7)
	plot3d!(p3d, 🪰xyz3..., alpha=0.7)
	plot3d!(p3d, 🪰xyz4..., alpha=0.7)
end

# ╔═╡ f3ff5bc2-3a8c-4ef0-971a-bdec60cce7d8
md"Hier bespreken dat de vlieg niet meer terug komt"

# ╔═╡ Cell order:
# ╠═46572322-b57d-11eb-0cd2-8f3bbd1ec6f1
# ╠═4833fba1-5f7a-480f-8f81-cbb96f1d1a1a
# ╠═1eb0004d-2ba9-4eb6-bc05-586cbd98e204
# ╠═e88b1896-927b-4807-a951-a0cd971596f2
# ╠═e049558f-dfc7-41cf-9a52-ebceeb9588f8
# ╠═137476e0-0908-45bd-a696-62158e2a3763
# ╠═519b9582-69f3-4344-9e8b-7f1b40ad1d3f
# ╠═a23dd863-1242-4506-9514-a4b6b9f25e63
# ╠═357254e3-fa09-438b-b5b3-7720ba7596c6
# ╠═b92228d5-15b9-40e8-99c9-e7cb3e17ecc4
# ╠═f0333ec9-fd6b-43d6-8666-1cde329745c9
# ╠═fb5d6422-12c3-4589-bf34-6de9c28148a5
# ╠═5baf7fdf-2266-4c8f-9f56-e0616186949e
# ╠═cb40ae3e-e1f9-4fac-a2b3-4237a2c61f15
# ╠═1f1ac119-e92e-4762-b796-221ea8375ae1
# ╠═d775df2a-2e15-43ea-86a9-59e9b4b964ae
# ╠═4c98def5-4c7e-4cfe-998f-f715567007df
# ╠═cf9a3ce8-b565-4502-970b-4caca30cf70a
# ╠═38305ec5-4814-43e0-8cd5-a56fae5f12f1
# ╠═cd04f8cf-dd82-485b-8a51-d36fcdb0d164
# ╠═05fa2583-787d-4ed7-887c-acdcf39e2df7
# ╠═a498c2c5-95eb-4fca-9c84-90293527386c
# ╠═b1c63f7b-6b1b-4619-893c-503698157756
# ╠═57bd6692-5f8d-4b85-a529-aa29874f7687
# ╠═8d243769-29f5-4925-800f-e7e7c0a820cc
# ╠═f1c79b07-911a-4a53-bf92-e6bbe2854957
# ╠═3d403ee2-6d47-42d2-b3db-885535f628d2
# ╠═ffb67ff6-954b-4ba5-980c-f2728423177e
# ╠═a511779c-6683-4638-9e0d-a8b796049552
# ╠═2a0fa08e-f95d-4f83-8d0f-d5726bae3493
# ╠═1a060889-2320-4801-a17c-2df096a889e7
# ╠═19537fce-2c37-4a2d-a009-c5c690b2310c
# ╠═d4282897-7a9b-4bec-819c-d622c671d359
# ╠═dcc62e8f-85ec-423e-b964-6dd868f2d872
# ╠═97056fe6-8507-4898-b16d-a2be2bb375ba
# ╠═4367ac24-c24f-4dad-9a94-0b53fa4f54f3
# ╠═51654f8c-523d-471f-b370-c8a7a761c7f0
# ╠═b6199e57-23a2-4b5a-b0e8-e6aa7fa62086
# ╠═9077d49b-04dd-4dae-9bfb-da4d1b1705fd
# ╠═20d359c3-245a-4360-85a6-6b1dc73c4aac
# ╠═0e87e5e5-10f4-4b0b-aae4-5b64bd66e7cc
# ╠═032181f5-7bc3-44a2-9f5a-5a6799510f48
# ╠═01f51dea-d577-40e8-b67f-3364eed88cf5
# ╠═f3ff5bc2-3a8c-4ef0-971a-bdec60cce7d8
