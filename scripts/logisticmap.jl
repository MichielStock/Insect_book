#=
Created on 12/08/2022 11:51:31
Last update: -

@author: Michiel Stock
michielfmstock@gmail.com

Figures for logistic map.
=#

using CairoMakie, InsectBook

r = 1.8  # default growth value
x₀ = 5
K = 1000

dir = "figures/logisticmap"

# Exponential growth
# ------------------

# 10 gen

t = 0:10
y = pop_exp.(x₀, t; r)

fe10 = Figure()
ax = Axis(fe10[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Exponentële groei\nr=$r")
scatter!(ax, t, y, color=myblue)
save(joinpath(dir, "exp_10g.png"), fe10)

# 50 gen

t = 0:50
y = pop_exp.(x₀, t; r)

fe50 = Figure()
ax = Axis(fe50[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Exponentële groei\nr=$r")
scatter!(ax, t, y, color=myblue)
save(joinpath(dir, "exp_50g.png"), fe50)

# Logistic growth
# ---------------

pop_exp(x₀, t; r) = x₀ * r^t

equilibrium_logistic(;r, K) = r > 1 ? K * (r - 1) / r : 0.0

σ(x; r, K) = r * (1 - x / K) * x
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

y = pop_logistic(x₀; r, K)

fl50 = Figure()
ax = Axis(fl50[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Logistische groei\nr=$r, K=$K")
scatter!(ax, t, y, color=myblue)
save(joinpath(dir, "log_50g_conv.png"), fl50)

# show convergences different starting values

function plot_populations(x₀s, ngenerations=50; r, K)
    f = Figure()
    ax = Axis(f[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Logistische groei\nr=$r, K=$K")
	for x₀ in x₀s
		scatter!(ax, 0:ngenerations, pop_logistic(x₀, ngenerations; r, K),
					label="startgrootte is $x₀ rupsen")
	end
	hlines!(ax, [K], label="draagkracht", linewidth=2)
	x_eq = equilibrium_logistic(;r, K)
	hlines!(ax, [x_eq], label="evenwichtspopulatie", linewidth=2)
    axislegend(ax)
    return f
end

flogstartingcond = plot_populations([x₀, 100, 500, 800], 50; r, K)
save(joinpath(dir, "log_starts_conv.png"), flogstartingcond)

# oscillations
# ------------

r_osc = 3.34  # period of 2

y = pop_logistic(x₀; r=r_osc, K)

flosc = Figure()
ax = Axis(flosc[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Logistische groei\nr=$(r_osc), K=$K")
scatter!(ax, t, y, color=myblue)
save(joinpath(dir, "log_50g_osc2.png"), flosc)

r_osc4 = 3.455  # period of 6

y = pop_logistic(x₀; r=r_osc4, K)

flosc = Figure()
ax = Axis(flosc[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Logistische groei\nr=$(r_osc), K=$K")
scatter!(ax, t, y, color=myblue)
save(joinpath(dir, "log_50g_osc4.png"), flosc)

# Chaos
# -----

r_chaos = 3.6

y = pop_logistic(x₀; r=r_chaos, K)

flchaos = Figure()
ax = Axis(flchaos[1, 1], xlabel="generatie", ylabel="aantal rupsen", title="Logistische groei\nr=$(r_chaos), K=$K")
scatter!(ax, t, y, color=myblue)
save(joinpath(dir, "log_50g_chaos.png"), flchaos)

fchaos_starts = plot_populations([x₀, 100, 500, 800], 50; r=r_chaos, K)
save(joinpath(dir, "log_starts_chaos.png"), fchaos_starts)

fchaos_tiny_starts = plot_populations((x₀-3e-3):1e-3:(x₀+3e-3), 50; r=r_chaos, K)
save(joinpath(dir, "log_starts_chaos_tiny.png"), fchaos_tiny_starts)

# SPIDERWEB
# ---------

function plot_logistic(r, K; show_spiderweb=false)
    f = Figure()
    ax = Axis(f[1, 1], xlabel="x(t-1)", ylabel="x(t)", title="Logistische groei\nr=$r, K=$K")
    ylims!(ax, 0, 1.5σ(K/2; K, r))
	lines!(ax, 0:0.1:K, x->σ(x,r=r,K=K), label="logistische vergelijking", linewidth=2)
	lines!(ax, 0:0.1:K, identity, label="eerste bissector", linewidth=2)
	x_eq = equilibrium_logistic(;r, K)
	scatter!([x_eq], [x_eq], label="equilibrium point")
	populations_logistic = pop_logistic(x₀, 50; r, K)
	if show_spiderweb
		for t in 1:length(populations_logistic)-1
			xₜ, xₜ₊₁ = populations_logistic[t], populations_logistic[t+1]
			lines!(ax, [xₜ, xₜ, xₜ₊₁], [xₜ, xₜ₊₁, xₜ₊₁], color=myred)
		end
	end
    axislegend(ax)
	f
end

fspconv = plot_logistic(r, K, show_spiderweb=true)
save(joinpath(dir, "log_spiderweb_conv.png"), fspconv)

fsposc = plot_logistic(r_osc, K, show_spiderweb=true)
save(joinpath(dir, "log_spiderweb_osc.png"), fsposc)

fspchaos = plot_logistic(r_chaos, K, show_spiderweb=true)
save(joinpath(dir, "log_spiderweb_chaos.png"), fspchaos)

# bifurcation diagram
# -------------------

function longterm_pop(x₀, ngenerations=1000; r, K)
	xₜ = x₀
	for t in 1:ngenerations
		xₜ = σ(xₜ; r, K)
	end
	return xₜ
end

r_values = 0:0.002:4

bifurcation_values = [longterm_pop(K * rand(), 100; r=r, K)
								for r in r_values,
								rep in 1:1000];

                            
fbif = Figure()
ax = Axis(fbif[1, 1], xlabel="r", ylabel="populatiegroote na 100 generaties",
        title="Bifurcatiediagram van de logisitische vergelijking")
for i in axes(bifurcation_values, 2)
    scatter!(ax, r_values, bifurcation_values[:,i], color=myred, markersize=1.2, alpha=0.7)
end
save(joinpath(dir, "log_bifurcation_diagram.png"), fbif)


# TODO: might simulate Lorenze eq/.