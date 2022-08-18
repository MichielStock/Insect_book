# Lieverheersbeestjes en luizenplagen: een dynamisch wereldbeeld

Het vorig hoofdstuk was onze eerste kennismaking met (groei)modellen. Realistisch of niet, deze werden gekarakterizeerd doordat ze *discreet* in de tijd waren: de tijd tikte verbij generatie per generatie. In de praktijk ervaren we tijd echter als continu, tussen vandaag en morgen zitten een oneindig aantal individuele momenten. Vandaar dat wetenschappers de relaliteit vaak beschrijven door een krachtiger soort model: de *differentiaalvergelijking*. Hier stelt de wetenschapper een verglijking op die hun systeem beschrijft, bijvoorbeeld XXXX. De oplossing van een dergelijke differentiaalverglijking is dan geen getal, maar een *functie* die het systeem beschrijft doorheen de tijd. Differntiaalvergelijkingen worden typisch pas gegeven na een stevige wiskundebasis. In dit hoofdstuk geven we een zachte introductie tot differentiaalvergelijkingen met als doel lieveheersbeestjes te beschrijven.

## Biologische bestrijding met lieveheersbeestjes

## Wiskundige intermezzo: afgeleiden van functies

- functie
- functie uit punten
- functie is continue
- afgeleide

$$
\frac{\text{d}y(t)}{\text{d}t}\approx \frac{y(t+\Delta t) - y(t)}{\Delta t}
$$

## Continue groei met differentiaalvergelijkingen

- groei van luizen
- logistische groei

$$
\dot{y} = r(1-y/K)y
$$

$$
\dot{y} = f(t,y)
$$

- remove $t$ -> *autonome*



> De kracht van differentiaalvergelijkingen om de realiteit te beschrijven

## Stapsgewijs oplossen van de differentiaalvergelijking met Euler

$$
\frac{y(t+\Delta t) - y(t)}{\Delta t} \approx f(t, y)
$$

$$
y(t+\Delta t) \approx y(t) + \Delta t \times f(t, y)
$$

- stapjes van 0.2 dagen, doe via terminal

```julia
function euler(f,        # funtie met de afgeleide
            y₀,          # initiele waarde op t₀
            (t₀, tₑ);    # start en eindtijd
            Δt=0.2)      # stapgrootte
    ts = t₀:Δt:tₑ  # de tijdstappen
    ys = [y₀]  # lijst met de functiewaarden
    for t in ts[begin:end-1]  # ga over alle tijdstappen, hehalve de laatste
        yₜ = last(ys)  # neem de vorige (laatste) waarde)
        yₜ₊₁ = yₜ + Δt * f(yₜ)  # bereken vorige stap
        push!(ys, yₜ₊₁)  # voeg deze toe aan de lijst
    end
    return ts, ys
end
```

- plot hier de tijdreeks

## Prooien en predatoren: Lotka-Volterra

## Exticties en explosies in de populatie

## De insekten voorbij