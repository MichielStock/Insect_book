module LogisticMap
    using Plots
    
    begin
        myblue = "#304da5"
        mygreen = "#2a9d8f"
        myyellow = "#e9c46a"
        myorange = "#f4a261"
        myred = "#e76f51"
        myblack = "#50514F"
    
        mycolors = [myblue, myred, mygreen, myorange, myyellow]
    end;

    pop_exp(x₀, t; r) = x₀ * r^t

    equilibrium_logistic(;r, K) = r > 1 ? K * (r - 1) / r : 0.0

    σ(x; r, K) = r * (1 - x / K) * x

    function pop_logistic(x₀, ngenerations=50; r, K)
        populations = zeros(ngenerations + 1)
        populations[1] = x₀  # we start with the population at t=0
        for t in 1:ngenerations
            xₜ = populations[t]
            xₜ₊₁ = σ(xₜ; r, K)  # apply the map
            populations[t+1] = xₜ₊₁
        end
        return populations
    end

    function growth_curve(ts, ys; kwargs...)
        scatter(ts, ys, xlabel="generatie", ylabel="aantal rupsen",
                    color=myblue; label="", kwargs...)
    end

    growth_curve_exp(ts, x0, r) = LogisticMap.growth_curve(ts, pop_exp.(x0, ts; r), title="Exponentële groei\nr=$r")

    growth_curve_log(ngen, x0, r, K) = LogisticMap.growth_curve(0:50, LogisticMap.pop_logistic(x0, ngen; r, K), title="Logistische groei\nr=$r")

    # show convergences different starting values

    equilibrium_logistic(;r, K) = r > 1 ? K * (r - 1) / r : 0.0

    function plot_populations(x₀s, ngenerations=50; r, K)
        p = plot(xlabel="generatie", ylabel="aantal rupsen", title="Logistische groei\nr=$r, K=$K")
        for x₀ in x₀s
            scatter!(p, 0:ngenerations, pop_logistic(x₀, ngenerations; r, K),
                        label="startgrootte is $x₀ rupsen")
        end
        hline!(p, [K], label="draagkracht", lw=2)
        x_eq = equilibrium_logistic(;r, K)
        hline!(p, [x_eq], label="evenwichtspopulatie", lw=2)
        return p
    end


    function plot_logistic(x₀, r, K; show_spiderweb=false)
        p = plot(xlabel="x(t-1)", ylabel="x(t)", title="Logistische groei\nr=$r, K=$K")
        ylims!(p, 0, 1.5σ(K/2; K, r))
        plot!(p, 0:0.1:K, x->σ(x,r=r,K=K), label="logistische vergelijking", linewidth=2)
        plot!(p, 0:0.1:K, identity, label="eerste bissectrice", linewidth=2)
        x_eq = equilibrium_logistic(;r, K)
        scatter!([x_eq], [x_eq], label="equilibrium point")
        populations_logistic = pop_logistic(x₀, 50; r, K)
        if show_spiderweb
            for t in 1:length(populations_logistic)-1
                xₜ, xₜ₊₁ = populations_logistic[t], populations_logistic[t+1]
                plot!(p, [xₜ, xₜ, xₜ₊₁], [xₜ, xₜ₊₁, xₜ₊₁], color=myred, label="")
            end
        end
        p
    end

    function longterm_pop(x₀, ngenerations=1000; r, K)
        xₜ = x₀
        for t in 1:ngenerations
           xₜ = σ(xₜ; r, K)
        end
        return xₜ
     end

    function bifurcation_plot(K)
        r_values = 0:0.002:4
     
        bifurcation_values = [longterm_pop(K * rand(), 100; r=r, K)
                                for r in r_values,
                                rep in 1:1000];
     
        p = plot(xlabel="r", ylabel="populatiegroote na 100 generaties",
              title="Bifurcatiediagram van de logisitische vergelijking")
     
        for i in axes(bifurcation_values, 2)
           scatter!(p, r_values, bifurcation_values[:,i], color=myred, markersize=1.2, alpha=0.7, label="")
        end
        return p
     end
end