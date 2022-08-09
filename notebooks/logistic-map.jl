### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ d8fc787a-e618-11eb-3a86-db49e5813a7d
using Plots, PlutoUI

# ╔═╡ c71870a1-7f19-4834-8d2b-5256ebd1827a
md"""
# Caterpillar growth: the logistic map

In this chapter, we study the growth of a population of caterpillars (🐛). Caterpillars are a common pest in gardens. For example, the Box tree moth (*Cydalima perspectalis*) is an invasive species in Europe, destroying many valuable Buxus shrubberies. 

![Plant damage by caterpillars, the larval stage of the Box tree moth.](https://upload.wikimedia.org/wikipedia/commons/9/95/Box_tree_moth_larval_feeding_damage.jpg)

Mathematical models can help gardeners and farmers understand how a population will evolve through time. Will it converge to a manageable level? Will the population grow out of bound, requiring the use of pesticides? Or will the population collapse on its own? 

We will model the caterpillar population through several perfectly non-overlapping generations. Here we use $x_t$ as the population size at generation or time $t$. The goal is to determine the progression

$$x_{0}, x_{1}, x_{2},\ldots, x_{t-1}, x_{t}, \ldots$$

Here, we know $x_0$ as the initial population size. All other values follow from this and the rules we assume the population follows. We make two assumptions for these rules to update the population:

1. We assume the rule is perfectly *deterministic*. Given that we know the population at time step $t-1$, we can perfectly predict the population at time $t$. 
2. The population is large enough to model it using real numbers (21.2, 178.19, 1437976.6, ...) instead of natural numbers (21, 178, 1437976, ...). This is a necessary deviation of reality as 'half' or '0.6' of a caterpillar might not really make sense. Either you might think of the population as large enough that this is negligible or that we model biomass (the equivalent number of bugs) instead of individuals.

We will consider two models. First, we look at unbounded, exponential growth. Here, the population either dies out rapidly or increases without bound, depending on the growth parameter. Next, we introduce a carrying capacity, limiting the number of caterpillars in the ecosystem. This slightly more complex model can generate much more interesting behaviour, from simple growth or extinction to oscillations and even chaos! 

Let us begin!
"""

# ╔═╡ 9dcbdc31-cbf7-43f4-9b28-759c98d406e1
md"""
## Unbounded growth

Many insects want to create as much progenity as possible, increasing their population at the expense of the resources. If we assume that every catepillar has, on average, a fixed number of descendents, we can write down the following rule:

$$x_{t} = rx_{t-1}$$

We can implement this simple rule, keeping $r$ as a keyword argument we determine later.
"""

# ╔═╡ 33a5e2e3-3fa5-4357-b713-5b228424a455
m(xₜ; r) = r * xₜ

# ╔═╡ a1d12301-0530-4a3f-81f9-7674ffab8164
r = 1.8

# ╔═╡ 09d20f2d-417e-4673-b861-185387789f7d
md"""
Here, $r>0$ is a *growth parameter*, quantifying the number of offspring per individual per generation. Remember, we work with averages, so non-integers such as 0.3 or 3.2 are allowed. This number has to be positive since one cannot have a negative number of descendants.

We can already ponder on how $r$ might influence the population:
- If $r<1$, every insect gives rise to less than one individual in each generation. Hence, the next generation has fewer individuals than the last. Over time, the population will die out.
- If $r>1$, every insect will produce more than one new individual for the next generation. The population will increase as time moves forward.
- In the edge case, when $r=1$, the population is perfectly stable and will remain of constant size in time.

Since we are modelling a pest, we likely have $r>1$. Let us pick a $r=$ $r; each caterpillar has a little bit less than two children surviving to the next generation.
"""

# ╔═╡ f39849c0-8883-45e5-83e4-ada04b739da2
md"All left to do is to pick a $x_{0}$, the initial population size at $t=0$. Let start with a modest population of five bugs."

# ╔═╡ ad631db2-0461-45f5-8e8f-390742391238
🐛₀ = 5

# ╔═╡ 34324295-fd44-4b96-88f9-6a6ea566ec2c
md"Now to apply the rule. This is the size of the population in the next generation:"

# ╔═╡ 2a9c8480-b833-4437-a05c-259e08ba435d
m(🐛₀;r)  # this is shorthand for m(🐛₀;r=r)

# ╔═╡ 5d7adeb1-ef91-474a-a8bd-d61c200b2bf4
md"To know the population size at $t=2$, we apply this twice:"

# ╔═╡ bab46d0d-f536-475f-9989-09eacf3a0962
m(m(🐛₀;r);r)

# ╔═╡ fd827f67-4928-45b9-97f6-40a08fa20d45
md"Three times for the third generation..."

# ╔═╡ 82718529-4dde-4ba1-bc22-85de90bfe57a
m(m(m(🐛₀;r);r);r)

# ╔═╡ df663a13-4a73-425e-a715-8cc4e6f25b4e
md"And so on."

# ╔═╡ 30d30de3-5258-4634-9d59-07924f053815
m(m(m(m(🐛₀;r);r);r);r)

# ╔═╡ 77b746ee-1e9d-40d0-884a-b121c2adc817
md"Luckily for us, there is an easy way to compute the population size at any time. One can show using induction that the population size is given by

$$x_t=x_{0}r^t \qquad t=0, 1, 2, \ldots$$

This is an exponential function, hence why this type of growth is called *exponential growth*.

> Exponential growth is often given by the formulla $x_{0}e^{at}$ with $a$ a parameter determinded on $r$. Can you provide $a$ as a function of $r$?
"

# ╔═╡ 88165f3f-b68a-4d93-9917-2e58a418a6aa
pop_exp(x₀, t; r) = x₀ * r^t

# ╔═╡ ba6abe8b-d2dc-49ca-8cef-051008310cbc
md"We obtain the same result as before."

# ╔═╡ c65fcc42-ead4-472b-90c8-18296f2ce31a
pop_exp.(🐛₀, 0:4; r)  # the dot applies the function to every element 0, 1, 2, 3, 4

# ╔═╡ 1ee88f3d-61c4-4182-bb0c-beeba6e78460
md"Let us plot the first ten generations."

# ╔═╡ 6c907367-14c6-4e16-91fb-0eccfa84db09
scatter(0:10, pop_exp.(🐛₀, 0:10; r), label="number of caterpillars", title="exponential growth", xlabel="generation", legend=:topleft)

# ╔═╡ 1eb01190-98b8-4101-b97e-accc384ad93f
md"A worrying increase of the pest! What happens after an even longer time?"

# ╔═╡ c5cb9c83-5ba3-40b7-9729-7353ba2bc7ce
scatter(0:50, pop_exp.(🐛₀, 0:50; r), label="number of caterpillars", title="exponential growth", xlabel="generation", legend=:topleft)

# ╔═╡ eedbc750-5123-4f3c-92dd-a9e438c22343
md"""
## The logistic map

We suggest a new rule to update the population, the *logistic map*:

$$x_{t} = r\left(1-\frac{x_{t-1}}{K}\right)x_{t-1}\,.$$

The new term says that the growth is less rapid when the population is closer to the carrying capacity. You can easily see this by considering the two extreme cases. When $x_{t-1}\approx 0$ (but still positive!), the term between brackets is approximately zero, meaning that the updating rule is virtually the same as the exponential growth. Food is plenty, and the population is growing at a maximum rate. However, when $x_{t-1}\approx K$, the term between the brackets becomes close to zero, and the population collapses!

Mathematicians often use the symbol $\sigma$ (pronounced as "sigma") as a shorthand notation for the logistic map.

Again, we can run a couple of time steps.
"""

# ╔═╡ 60f9b0c3-8c35-4729-929c-003e6f2251af
σ(x; r, K) = r * (1 - x / K) * x

# ╔═╡ 1d955659-7191-47fa-aedf-3ca03844bd27
md"We see that the growth is slowing down compared to the exponential growth! For the logistic map, there is no tidy formulla that gives the population size throughout the time. We can simulate this population by iteratively applying the logistic map:"

# ╔═╡ 278b29e3-fb81-4623-b34e-5f09d4b110c5
md"Look at the first 50 generations:"

# ╔═╡ 8d90c717-7a91-4148-9fe3-7b6d046b72d6
md"Now, we again plot the population size for these different generations."

# ╔═╡ 841299c0-ab9b-4c1c-b741-8c10379aa157
equilibrium_logistic(;r, K) = r > 1 ? K * (r - 1) / r : 0.0

# ╔═╡ 659566d2-83a6-4ef5-8fb4-df2f9a2daba9
md"Note that we first check if $r>1$ to compute this equilibrium. If $r$ is smaller than one, we know our population will die out, so we give 0."

# ╔═╡ ac591c62-c9c9-4d5c-b44d-18691a4342e7
md"Let us explore several initial populations, to show that the eventual population always converges to this $x_\text{eq}$."

# ╔═╡ 7bedb2b3-8f40-41d0-b710-12558160ba1a
md"""
Just so!

Now, let us look at a different way how the population evolves. We will plot the population size at $t-1$ on the $x$-axis and the population at the next time step $t$ on the $y$-axis. The behaviour of the function is determined by two things:
1. the logistic function (remember, just a quadratic function) that maps $x_{t-1}$ on the $x$-axis to $x_t$ on the $y$-axis;
2. the identity function that maps $x_t$ back to the $x$-axis for the next step.

The curve we obtain is spanned between these two functions, that is why this is called a *spiderweb plot*.
"""

# ╔═╡ 230a5b73-281a-4172-8e37-89925bb01479
md"We see that the population sizes converge to the equilibrium point. Remember that this was found when the logistic map returned the same value, seen when it cuts the first bissector."

# ╔═╡ 24d616ed-840a-450a-8be2-9c4b0a9c571d
md"Here, the population is no longer stable! It fluctuates wildly and unpredictably around the theoretical equilibrium. Let us check some different starting values."  

# ╔═╡ 0235e340-5ef5-4a6d-bd0d-246009c9a403
md"Above were large differences. What happens if we start with very similar starting populations, only differing with a tiny amount?"

# ╔═╡ 4491df59-07ba-4eb5-95ab-543d562032a2
md"""
It seems that for the first 20 generations, all populations are (as far as the naked eye can see) in sync. After some time though, the populations start to diverge and are vastly different. What is happening here?

Let us take a look at our spiderweb plot.
"""

# ╔═╡ decf02d9-e7d7-41f8-91ac-7377b88b0a48
md"We see for this given value of $r$, tiny differences in population size can get amplified. This means that after a couple of generations, two populations that differ only a tiny bit in size might end up entirely different. We call this phenomen **chaos**."

# ╔═╡ e70aa123-12e2-411b-80bf-f9a6eb44fa08
md"""
So the logistic map can both show growth towards an equilibrium as well as chaotic behaviour, depending on the reproduction parameter $r$. If $r<1$, it is easy to show that the population will die out.

In addition, we can also find *periodic behaviour*, where the population size alternates and repeats between two (or four) sizes). Below you can change the value of $r'$, remaking all the plots. Can you find periodic behaviour with a phase of two (two sizes)? Can you find the parameter that induces periodic behaviour with a phase of four?
""" 

# ╔═╡ 2658f6d7-7dd2-4ba8-a01b-684fe05558fd
@bind r′ Slider(0:0.005:4, default=3.6, show_value=true)

# ╔═╡ 47297b55-97cf-42f0-aee7-44e910c95912
r′  # we add the prime because it is a different variable

# ╔═╡ cac63499-515c-4774-a2ed-930375f577d6
md"""
The effect of the parameter $r$ in the logistic map can be studied via a *bifurcation plot*, this plots the population size after a long time (here, 100 generations) as a function of $r$. We obtain this plot by performing many simulations for each $r$, each time using different (random) initial population sizes.

In the plot below, we see the different regimes one can obtain using the logistic map.
"""

# ╔═╡ 0ca85f9a-44f7-4290-8232-62ed6700c7cf
md"""
This bifurcation plot neatly summarizes the behaviour of the logistic map for all values of $r$:
1. for $r<1$, we have extinction;
2. for $1 < r < 3$ we have a simple growth towards $x_\text{eq}$;
3. for $3 < r < 4$, things, are getting interesting. Some values give oscillating behaviour, others show chaotic behaviour making the next step impossible to predict.
"""

# ╔═╡ 81dbf61d-004b-429a-85dd-3f3750ce6e78
md"""
## Beyond bugs

In this first chapter, we both explored the power and the limitation of mathematical models. 

- power to model
- chaos limits predictablity
- stock market, weather etc
"""

# ╔═╡ 1818e73f-6fd6-4184-ae7b-f6c62560ccf2
function longterm_pop(x₀, ngenerations=1000; r, K)
	xₜ = x₀
	for t in 1:ngenerations
		xₜ = σ(xₜ; r, K)
	end
	return xₜ
end

# ╔═╡ 7e71f0e6-298b-40d2-a848-b8008dfed918
r_values = 0:0.01:4;

# ╔═╡ 51ca9a9d-d156-4e63-bff8-cede97268d3e
K = 1_000

# ╔═╡ 285c19e9-8277-4bef-be13-e073922b09c1
md"Oh no! It seems that the population increases without bound. If we assume that a single caterpillar weights about 3 grams, than after 50 generations we have more than $(floor(3*pop_exp(🐛₀, 50;r)/1000_000)) metric tonnes of bugs. That is the same weight as 40 milion hippopotamuses! Caterpillars are called eating machines but an average garden does not nearly contain enough plants to reach such populations.


In practice however, the caterpillars would eat all the available plants long before they could reach such large populations. An ecosystem can only support a limited number of individuals, determined by the amount of food, water, space etc that is available. The maximal number that can be supported is called the *carrying capacity* of the system and is often denoted with the letter $K$. Let us set $K$=$K for this chapter, meaning that our garden has enough plants to keep $K caterpillars fed, but not a sinle more."

# ╔═╡ 1ca7d37e-3458-4a08-b36b-82e554c0bff8
σ(🐛₀; r, K)  # this is close to what we obtain using exponential growth

# ╔═╡ f436dfd7-52b0-43e1-9964-6e91e7c3bec4
σ(σ(🐛₀; r, K); r, K)

# ╔═╡ 00e138d2-a8d8-4d14-ae63-3bebbe3ee877
σ(σ(σ(🐛₀; r, K); r, K); r, K)

# ╔═╡ 5be025a5-97ed-40a0-88df-880b8ef152dc
σ(σ(σ(σ(🐛₀;  r, K); r, K); r, K); r, K)

# ╔═╡ 375a6fbe-d864-44e2-aa63-cf3bf7699c63
function pop_logistic(x₀, ngenerations=50; r=r, K=K)
	populations = zeros(ngenerations + 1)
	populations[1] = x₀  # we start with the population at t=0
	for t in 1:ngenerations
		xₜ = populations[t]
		xₜ₊₁ = σ(xₜ; r, K)  # apply the map
		populations[t+1] = xₜ₊₁
	end
	return populations
end

# ╔═╡ 104a006f-2314-455f-bd33-dc766e7dcb63
function plot_populations(x₀s, ngenerations=50; r, K)
	p = plot(title="logistic growth\nr=$r, K=$K", xlabel="generation",
			legend = :outertop)
	for x₀ in x₀s
		scatter!(p, 0:ngenerations, pop_logistic(x₀, ngenerations; r, K),
					label="population starting with $x₀ individuals")
	end
	hline!([K], label="carrying capacity", lw=2)
	x_eq = equilibrium_logistic(;r, K)
	hline!([x_eq], label="equilibrium population", lw=2)
end

# ╔═╡ b76985ac-b95c-4fb1-a490-2c28d3e09341
function plot_logistic(r, K; show_spiderweb=false)
	p = plot(x->σ(x,r=r,K=K), 0, K, label="logistic map", xlabel="x(t-1)", ylabel="x(t)", ylims=[0, 1.5σ(K/2; K, r)],
	title="r=$r, K=$K", lw=2)
	plot!(identity, 0, K, label="first bissector", lw=2)
	x_eq = equilibrium_logistic(;r, K)
	scatter!([x_eq], [x_eq], label="equilibrium point")
	populations_logistic = pop_logistic(🐛₀, 50; r, K)
	if show_spiderweb
		for t in 1:length(populations_logistic)-1
			xₜ, xₜ₊₁ = populations_logistic[t], populations_logistic[t+1]
			plot!([xₜ, xₜ, xₜ₊₁], [xₜ, xₜ₊₁, xₜ₊₁], color="red", label="")
		end
	end
	p
end

# ╔═╡ 551828ae-a38d-4776-9335-98e98c36a141
populations_logistic = pop_logistic(🐛₀, r=r, K=K)

# ╔═╡ 09d92576-aea4-4eb8-b698-76bc48323adc
begin
	scatter(0:50, populations_logistic, label="number of caterpillars", title="logistic growth", xlabel="generation")
	hline!([K], label="carrying capacity", lw=2)
end

# ╔═╡ ecba66c5-2601-4f2b-8576-eefff88799ca
🐛eq = equilibrium_logistic(r=r, K=K)

# ╔═╡ bf356eec-52c0-495d-aa82-72383b5065d3
md"""
We see that the population rapidly converges to a value of $x_\text{eq}$=$🐛eq. We can recover this value by setting

$$x_\text{eq} = r\left(1-\frac{x_\text{eq}}{K}\right)x_\text{eq}\,.$$

As this is only a simple quadratic equation, we can quickly solve for two solutions:

- first, $x_\text{eq}=0$ is a trivial solution. If there are no caterpillars, the population will remain empty (duh!). However, this equilibrium is *unstable* and adding a single individual will kickstart the population.
- the second root is given by $x_\text{eq}=K\frac{r-1}{r}$, which we observe in the plot. This solution is stable (for our current value of $r$!) as the population converges to it.

We can pour the formula for the equilibrium population into a function. 
"""

# ╔═╡ 97b19948-4a0a-4967-b44e-c02b456476c5
md"""
Up to now, for these given values of $r$ and $K$, we summarize that the population always nicely converges to an equilibrium population $x_\text{eq}$ = $🐛eq , independently from the initial population size.

We now illustrate that when we choose a different value for $r$, we might obtain a vastly different behaviour. We will pick a new $r$, $r'$ and see how this influences the population.
"""

# ╔═╡ fe5bc126-c6fd-4c08-bb3d-b336aef7f546
plot_populations([🐛₀, 100, 500, 800]; r, K)

# ╔═╡ bb92cc25-d16a-49c7-9dc6-40a5e1764023
plot_logistic(r, K, show_spiderweb=true)

# ╔═╡ 64df95ae-fb88-455b-817c-b27dadb44869
begin
	scatter(0:50, pop_logistic(🐛₀, 50, K=K, r=r′), label="number of caterpillars", title="logistic growth (r=$r′)", xlabel="generation", legend = :outertop)
	hline!([K], label="carrying capacity", lw=2)
	hline!([equilibrium_logistic(;r=r′, K)], label="equilibrium population", lw=2)
end

# ╔═╡ 6302fd40-b419-41d0-a6db-947715ba4531
plot_populations([🐛₀, 100, 250, 500, 800]; r=r′, K)

# ╔═╡ 510b18c6-fb7e-4897-959b-20fd1a55d30e
plot_populations((5-0.002):0.001:(5+0.002), 100; r=r′, K)

# ╔═╡ 8ed9ed3c-b39e-40ed-bde9-03fc4b6954ad
plot_logistic(r′, K; show_spiderweb=true)

# ╔═╡ 0afee444-9ee3-492a-936c-0be919873dbc
bifurcation_values = [longterm_pop(K * rand(), 100; r=r, K)
								for r in r_values,
								rep in 1:500];

# ╔═╡ 4219fcb7-5e42-457c-a5aa-3442b1c6cc52
begin 
	scatter(r_values, bifurcation_values,
		color="red", ms=1.25, alpha=0.7, label="",
		xlabel="r", ylabel="population size\nafter 100 generations",
	       title="bifurcation diagram logistic map")
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.19.1"
PlutoUI = "~0.7.9"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c3598e525718abcc440f69cc6d5f60dda0a1b61e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.6+5"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "e2f47f6d8337369411569fd45ae5753ca10394c6"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.0+6"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random", "StaticArrays"]
git-tree-sha1 = "ed268efe58512df8c7e224d2e170afd76dd6a417"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.13.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dc7dedc2c2aa9faf59a55c622760a25cbefbe941"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.31.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "92d8f9f208637e8d2d28c664051a00569c01493d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.1.5+1"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "LibVPX_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3cc57ad0a213808473eafef4845a74766242e05f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.3.1+4"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "35895cf184ceaab11fd778b4590144034a167a2f"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.1+14"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "cbd58c9deb1d304f5a245a0b7eb841a2560cfec6"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.1+5"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "0c603255764a1fa0b61752d2bec14cfbd18f7fe8"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+1"

[[GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "b83e3125048a9c3158cbb7ca423790c7b1b57bea"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.57.5"

[[GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "eaf96e05a880f3db5ded5a5a8a7817ecba3c7392"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.58.0+0"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "15ff9a14b9e1218958d3530cc288cf31465d9ae2"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.3.13"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "47ce50b742921377301e15005c96e979574e130b"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.1+0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "c6a1fff2fd4b1da29d3dccaffb1e1001244d844e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.12"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[LibVPX_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "12ee7e23fa4d18361e7c2cde8f8337d4c3101bc7"
uuid = "dd192d2f-8180-539f-9fb4-cc70b1dcf69a"
version = "1.10.0+0"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6a8a2a625ab0dea913aba95c11370589e0239ff0"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.6"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "501c20a63a34ac1d015d5304da0e645f42d91c9f"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.11"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "20ed303a9370b20174b121f5c86c2663d9e37a3f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.19.1"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "c6c0f690d0cc7caddb74cef7aa847b824a16b256"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+1"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "b3fb709f3c97bfc6e948be68beeecb55a0b340ae"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.1"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "2a7a2469ed5d94a98dea0e85c46fa653d76be0cd"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.3.4"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "a43a7b58a6e7dc933b2fa2e0ca653ccf8bb8fd0e"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.6"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2f6792d523d7448bbe2fec99eca9218f06cc746d"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.8"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "000e168f5cc9aded17b6999a560b7c11dda69095"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.0"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "8ed4a3ea724dac32670b062be3ef1c1de6773ae8"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.4.4"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll"]
git-tree-sha1 = "2839f1c1296940218e35df0bbb220f2a79686670"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.18.0+4"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "acc685bcf777b2202a904cdcb49ad34c2fa1880c"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.14.0+4"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7a5780a0d9c6864184b3a2eeeb833a0c871f00ab"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "0.1.6+4"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d713c1ce4deac133e3334ee12f4adff07f81778f"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2020.7.14+2"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "487da2f8f2f0c8ee0e83f39d13037d6bbf0a45ab"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.0.0+3"

[[xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─d8fc787a-e618-11eb-3a86-db49e5813a7d
# ╟─c71870a1-7f19-4834-8d2b-5256ebd1827a
# ╟─9dcbdc31-cbf7-43f4-9b28-759c98d406e1
# ╠═33a5e2e3-3fa5-4357-b713-5b228424a455
# ╟─09d20f2d-417e-4673-b861-185387789f7d
# ╟─a1d12301-0530-4a3f-81f9-7674ffab8164
# ╟─f39849c0-8883-45e5-83e4-ada04b739da2
# ╠═ad631db2-0461-45f5-8e8f-390742391238
# ╟─34324295-fd44-4b96-88f9-6a6ea566ec2c
# ╠═2a9c8480-b833-4437-a05c-259e08ba435d
# ╟─5d7adeb1-ef91-474a-a8bd-d61c200b2bf4
# ╠═bab46d0d-f536-475f-9989-09eacf3a0962
# ╟─fd827f67-4928-45b9-97f6-40a08fa20d45
# ╠═82718529-4dde-4ba1-bc22-85de90bfe57a
# ╟─df663a13-4a73-425e-a715-8cc4e6f25b4e
# ╠═30d30de3-5258-4634-9d59-07924f053815
# ╟─77b746ee-1e9d-40d0-884a-b121c2adc817
# ╠═88165f3f-b68a-4d93-9917-2e58a418a6aa
# ╟─ba6abe8b-d2dc-49ca-8cef-051008310cbc
# ╠═c65fcc42-ead4-472b-90c8-18296f2ce31a
# ╟─1ee88f3d-61c4-4182-bb0c-beeba6e78460
# ╟─6c907367-14c6-4e16-91fb-0eccfa84db09
# ╟─1eb01190-98b8-4101-b97e-accc384ad93f
# ╟─c5cb9c83-5ba3-40b7-9729-7353ba2bc7ce
# ╟─285c19e9-8277-4bef-be13-e073922b09c1
# ╟─eedbc750-5123-4f3c-92dd-a9e438c22343
# ╠═60f9b0c3-8c35-4729-929c-003e6f2251af
# ╠═1ca7d37e-3458-4a08-b36b-82e554c0bff8
# ╠═f436dfd7-52b0-43e1-9964-6e91e7c3bec4
# ╠═00e138d2-a8d8-4d14-ae63-3bebbe3ee877
# ╠═5be025a5-97ed-40a0-88df-880b8ef152dc
# ╟─1d955659-7191-47fa-aedf-3ca03844bd27
# ╠═375a6fbe-d864-44e2-aa63-cf3bf7699c63
# ╟─278b29e3-fb81-4623-b34e-5f09d4b110c5
# ╠═551828ae-a38d-4776-9335-98e98c36a141
# ╟─8d90c717-7a91-4148-9fe3-7b6d046b72d6
# ╟─09d92576-aea4-4eb8-b698-76bc48323adc
# ╟─bf356eec-52c0-495d-aa82-72383b5065d3
# ╠═841299c0-ab9b-4c1c-b741-8c10379aa157
# ╟─659566d2-83a6-4ef5-8fb4-df2f9a2daba9
# ╠═ecba66c5-2601-4f2b-8576-eefff88799ca
# ╟─ac591c62-c9c9-4d5c-b44d-18691a4342e7
# ╟─fe5bc126-c6fd-4c08-bb3d-b336aef7f546
# ╟─7bedb2b3-8f40-41d0-b710-12558160ba1a
# ╠═bb92cc25-d16a-49c7-9dc6-40a5e1764023
# ╟─230a5b73-281a-4172-8e37-89925bb01479
# ╟─97b19948-4a0a-4967-b44e-c02b456476c5
# ╠═47297b55-97cf-42f0-aee7-44e910c95912
# ╟─64df95ae-fb88-455b-817c-b27dadb44869
# ╟─24d616ed-840a-450a-8be2-9c4b0a9c571d
# ╠═6302fd40-b419-41d0-a6db-947715ba4531
# ╟─0235e340-5ef5-4a6d-bd0d-246009c9a403
# ╟─510b18c6-fb7e-4897-959b-20fd1a55d30e
# ╟─4491df59-07ba-4eb5-95ab-543d562032a2
# ╠═8ed9ed3c-b39e-40ed-bde9-03fc4b6954ad
# ╟─decf02d9-e7d7-41f8-91ac-7377b88b0a48
# ╟─e70aa123-12e2-411b-80bf-f9a6eb44fa08
# ╠═2658f6d7-7dd2-4ba8-a01b-684fe05558fd
# ╟─cac63499-515c-4774-a2ed-930375f577d6
# ╟─4219fcb7-5e42-457c-a5aa-3442b1c6cc52
# ╟─0ca85f9a-44f7-4290-8232-62ed6700c7cf
# ╟─81dbf61d-004b-429a-85dd-3f3750ce6e78
# ╠═104a006f-2314-455f-bd33-dc766e7dcb63
# ╠═b76985ac-b95c-4fb1-a490-2c28d3e09341
# ╠═1818e73f-6fd6-4184-ae7b-f6c62560ccf2
# ╠═7e71f0e6-298b-40d2-a848-b8008dfed918
# ╠═0afee444-9ee3-492a-936c-0be919873dbc
# ╠═51ca9a9d-d156-4e63-bff8-cede97268d3e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
