# Lieverheersbeestjes en luizenplagen: een dynamisch wereldbeeld

Het vorig hoofdstuk was onze eerste kennismaking met (groei)modellen. Realistisch of niet, deze werden gekarakterizeerd doordat ze *discreet* in de tijd waren: de tijd tikte verbij generatie per generatie. In de praktijk ervaren we tijd echter als continu, tussen vandaag en morgen zitten een oneindig aantal individuele momenten. Vandaar dat wetenschappers de relaliteit vaak beschrijven door een krachtiger soort model: de *differentiaalvergelijking*. Hier stelt de wetenschapper een verglijking op die hun systeem beschrijft, bijvoorbeeld XXXX. De oplossing van een dergelijke differentiaalverglijking is dan geen getal, maar een *functie* die het systeem beschrijft doorheen de tijd. Differntiaalvergelijkingen worden typisch pas gegeven na een stevige wiskundebasis. In dit hoofdstuk geven we een zachte introductie tot differentiaalvergelijkingen met als doel lieveheersbeestjes te beschrijven.

## Biologische bestrijding met lieveheersbeestjes

In het vorige hoofdstuk keken we naar rupsen als plagen. Hier zullen we bladluizen beschouwen. Waar rupsen ware monsters zijn diie de bladeren opwreten zijn bladluizen meer verfijnd. Met hun naaldvormig mondstuk zuigen ze het sap van de planten rechtstreeks uit het vaatweefsel van de plant. Zo ontrekken ze niet alleen de plant haar kostbare suikers, maar de bladluizen zijn vaak ook dragers van gevaarlijke plantenvirussen. Het plantensap bevat voornamelijk suikers, relatief weinig aminozuren die de luizen ook nodig hebben. Daarom scheiden de luizen het sap grotendeels terug uit langs hun achterkant, ondaan van de meeste aminozuren. Deze substantie wordt *honingdauw* genoemd en is een belangrijke voedingbron voor mieren en wespen, maar kan ook schadelijke schimmels aantrekken. Luizen zijn erg vervelende beestjes voor vele soorten belangrijke gewassen, van aardappelen tot bonen tot rozen.

Omdat luizen zo schadelijk zijn, zijn er verschillende verdelgingsmiddellen die de beestjes snel om zeep helpen. Naast chemische bestrijding wordt er ook vaak *biologische bestrijding* toegepast, bladluizen zijn immers smakelijk voedsel voor vele andere insecten en vogels. Het lieveheersbeestje in het bijzonder is een echte moordmachine voor bladluizen. De larven alleen al eten zo'n 400 bladluizen, terwijl een volwassen lieveheersbeestje in hun leven nog maar liefst 5000 luizen kan verorberen. Vandaar dat men de larven van lieveheersbeestjes kan kopen om een luizenplaag onder controle te brengen[^mier]. 

[^mier]: Grappig genoeg krijgen de luizen soms bescherming vanuit onverwachte hoek. Omdat sommige mieren zich voeden met de hongdauw die de luizen uitscheiden beschermedn ze de bladluizen tegen lieverheersbeestjes.

Biologische bestrijding heeft nog een voordeel ten opzichte van chemische bestrijding: de beestjes die ingezet worden kunnen zich zelf ook nog vermendigvuldigen. Een lieveheersbeestje kan zo op een dag wel 50 eitjes leggen, die larven worden om vervolgens na zo'n 20 dagen te verpoppen tot nieuwe lieveheersbeestjes. 

Als we biologische bestrijding willen modelleren hebben we dus een complexer model nodig. We zullen twee toestanden moeten modelleren: het aantal bladluizen en het aantal lieveheersbeestjes.

## Wiskundige intermezzo: afgeleiden van functies

In het modeleren beschouwen gebruiken we *functies* die een transformatie doorvoeren van hun input naar output. 


- bv $f(t)=t\sin(t)$ `f(t) = t * sin(t)`
- functie uit punten
- functie is continue
- afgeleide

$$
\frac{\text{d}f(t)}{\text{d}t}\approx \frac{f(t+\Delta t) - f(t)}{\Delta t}
$$

Wat will dit zeggen:
1. we hebben een functie $f(t)$, bijvoorbeel $f(t)=t\sin(t)$
2. we evaluelen die in een bepaalde $t$, bijvoorbeeld $t=2$, dit geeft $f(2)\approx1.81859$
3. dan beschouwen we een kleine verandering $\Delta t$, b.v. $\Delta t=0.1$
4. we berekenen $f(t+\Delta t)$, dus de functie iets verder in de tijd: $f(2.1)\approx1.8128$
5. dan nemen we het verschil $f(t+\Delta t) - f(t)$, hier $1.8128 - 1.81859=-0.05855$
6. dit verschil delen we door het tijdstapje $\delta t$ die we namen: $-0.05855/0.1 = -0.5855$

De formule die we hier gebruiken om de afgeleide te bepalen wordt de *eindige differentie methode* genoemd. Ze is zeer eenvoudig te implementeren.

```julia
eindige_differentie(f, t; Δt=0.01) = (f(t + Δt) - f(t)) / Δt
```

```julia
julia> eindige_differentie(f, 2.0; Δt=0.1)
-0.05855183688728616
```

Wat als we een kleinere waarde voor $\Delta t$ nemen?

```julia
julia> eindige_differentie(f, 2.0; Δt=0.01)
0.06371786322902917
```

En nog kleiner?

```julia
julia> eindige_differentie(f, 2.0; Δt=0.001)
0.07567799367991235
```

Wanneer we kleinere stapjes nemen neemt het verschil $f(t+\Delta t) - f(t)$ af maar we delen ook door een kleiner getal. Voor steeds kleinere waarden van $\Delta t$ convergeren we naar de echte afgeleide.

- [ ] add plot fin diff

## Continue groei met differentiaalvergelijkingen

- groei van luizen
- logistische groei NOOT: verschil logistisch model

$$
\dot{y} = ry(1-y/K)
$$
 
evenwicht is 0 (geen luizen aanwezig) of R (vol).

merk op dat het model helemaal anders is dan log  model vorig hoofdstuk. Daar gave de formule de populattiegroote, hier de groei
wnn y=R stopt hier de populatie met groeien, voordien stortte ze in

$$
\dot{y} = f(y,t)
$$

- remove $t$ -> *autonome*



> De kracht van differentiaalvergelijkingen om de realiteit te beschrijven via massabalans

## Stapsgewijs oplossen van de differentiaalvergelijking met Euler

$$
\frac{y(t+\Delta t) - y(t)}{\Delta t} \approx f(t, y)
$$

$$
y(t+\Delta t) \approx y(t) + \Delta t \times f(t, y)
$$

```julia
julia> Δt = 0.2
0.2

julia> y₀ = 500
500

julia> y = y₀
500

julia> y = y + Δt * f(y)
557.0

julia> y = y + Δt * f(y)
620.117012

julia> y = y + Δt * f(y)
689.9165121371384

julia> y = y + Δt * f(y)
766.9946760689613

julia> y = y + Δt * f(y)
851.9746671998191

julia> y = y + Δt * f(y)
945.5012972611945
```

# TODO: verfijn dit

```julia
function euler(f,        # funtie met de afgeleide
            y₀,          # initiele waarde op t₀
            (t₀, tₑ);    # start- en eindtijd
            Δt=0.2)      # stapgrootte
    ts = t₀:Δt:tₑ  # de tijdstappen
    ys = [y₀]  # lijst met de functiewaarden
    for t in t₀:Δt:(tₑ-Δt)
        yₜ = last(ys)  # neem de vorige (laatste) waarde)
        yₜ₊₁ = yₜ + Δt * f(yₜ)  # bereken volgende stap
        push!(ys, yₜ₊₁)  # voeg deze toe aan de lijst
    end
    return ts, ys
end
```

- plot hier de tijdreeks

## Prooien en predatoren: Lotka-Volterra

- We kunnen de groei van de bladluizenpopulatie nu beschrijven. Deze groeit tot hun draagcapaciteit.
- Om te voorkomen dat onze hele tuin leegegegeten worden voegen we hongerige lieveheersbeestjes toe die jagen op de luizen. 
- Gezien we twee variabelen opvolgen spreken we dan van een *stelsel van differentiaalvegrelijkingen*.
- Analoog met voordien is de algemene vorm

$$
\dot{\mathbf{y}} = f(\mathbf{y},t)\,
$$

waar we $\mathbf{y}$ en $\dot{\mathbf{y}}$ in het vet schrijven omdat het *vectoren* zijn. Een vector is een lijst met meerdere getallen[^vector], hier twee: de populatiegrootte van de luizen en lieveheersbeestjes, respectievelijk. 

```julia
julia> [1, 4]  # een vector maak je met vierkante haakjes, de elementen gescheiden door een komma
2-element Vector{Int64}:
 1
 4
```

[^vector]: In dit boekje hebben we het voornamelijk over computercode en beschouwen we een vector als een lijst met getallen. De mooie wiskundige definitie is dat een vector een ding is met een magnitude en een richting. Vaak wordt dit voorgesteld door een pijltje, met de lengte de magnitude en de richting ... de richting. Bijvoorbeeld, vector $\mathbf{a} = (1, -1)$ wijst naar rechtsonder en heeft een magnitude van $\sqrt{1^2+(-1)^2}=\sqrt{2}$.

Voor ons stelsel zullen we stellen dat $\mathbf{y} = (y_1, y_2)$ waat $y_1$ nu de grootte van de luizen populatie voorstelt en $y_2$ de grootte van de de lieveheersbeestjespopulatie. Analoog beschrijft $\dot{\mathbf{y}} = (\dot{y}_1, \dot{y}_2)$ de groei van de twee populaties. Concreet hebben we als stelsel:

$$
\begin{bmatrix}
\dot{y}_1\\ \dot{y}_2
\end{bmatrix}
=
\begin{bmatrix}
r(1 - y_1 / K)y_1 - 0.01y_1y_2 \\
- 0.05y_2 + 0.002y_1y_2
\end{bmatrix}
$$

Dit soort model wordt een *Lotka-Volterra model* genoemd. Het wordt in de ecologie vaak gebruikt om relaties tussen prooi en predatoren te beschrijven. Klassiek worden hier konijnen en vossen gebruikt, wij bekijken insecten.

Het stelsel ziet er complex uit. Ze bestaat uit twee vergelijkingen met elk twee termen:
- De verandering van de luizenpopulatie doorheen de tijd $\dot{y}_1$:
  - $r(1 - y_1 / K)y_1$ is terug de logistische groei van de luizen, bepaalde door de huidige populatiegrootte, de groeisnelheid en de draagkracht.
  - $- 0.01y_1y_2$ beschrijft de predatie van de lieveheersbeestjes op de luizen. We zien dat dit proportioneel is met zowel de luizen als de lieveheersbeestjes, hoe meer er van beide soorten zijn, hoe meer luizen er opgegeten worden. De term is negatief want de luizen verdwijnen. We hebben de parameter van 0.01, die will zeggen dat er 0.01 luizen per lieveheersbeestje per dag gegeten worden.
- De verandering van de lieveerhestbestjespopulatie doorheen de tijd $\dot{y}_2$
  - $- 0.05y_2$ dit is de netto afsterfte van de lieveheersbeestjes, elke dag sterft 5% van de beestjes af.
  - $+ 0.002y_1y_2$ is opnieuw de predatie vande lieveheesbeestjes op de luizen. Voor de lieveheersbeestjes is dit echter een postieve bijdrage: de luizen dienen als voedsel die de lieveheersbeestjes gebruiken om te groeien en vermenigvuldigen.

TODO: kies realistischere waarden!

Groei van luizen + lieveheersbeestjes, twee vergelijkingen die samen een stelsel vormen



stationaire oplossingen:
- niets
- enkel luizen
- co-exstence

plot fasediagram

Doe tijdstapje in terminal

## Exticties en explosies in de populatie

toon oscillaties

## De insecten voorbij

Newton, dingen in heel kleine deeltjes te verdelen en te sommeren, Newton, archimedes die het gebruikte om de oppervlakte van een cirkel te berekenen
twee voorbeelden: op basis van de hoogte vs spiesjes ? leidt te ver? Misschien gewoon de Riemannsom `rieman(f, (l, b), dx=(b-o)/100) = sum(f, o:dx:b) * dx`

Basis van differentiaalanalyse of calculus + opstellen DVG, Euler is meest simpele methode, wet van Newton


