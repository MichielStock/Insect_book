# Lieverheersbeestjes en luizenplagen: een dynamisch wereldbeeld

Het vorig hoofdstuk was onze eerste kennismaking met (groei)modellen. Realistisch of niet, deze werden gekarakterizeerd doordat ze *discreet* in de tijd waren: de tijd tikte verbij generatie per generatie. In de praktijk ervaren we tijd echter als continu, tussen vandaag en morgen zitten een oneindig aantal individuele momenten. Vandaar dat wetenschappers de relaliteit vaak beschrijven door een krachtiger soort model: de *differentiaalvergelijking*. Hier stelt de wetenschapper een verglijking op die hun systeem beschrijft, bijvoorbeeld XXXX. De oplossing van een dergelijke differentiaalverglijking is dan geen getal, maar een *functie* die het systeem beschrijft doorheen de tijd. Differntiaalvergelijkingen worden typisch pas gegeven na een stevige wiskundebasis. In dit hoofdstuk geven we een zachte introductie tot differentiaalvergelijkingen met als doel lieveheersbeestjes te beschrijven.

## Biologische bestrijding met lieveheersbeestjes

In het vorige hoofdstuk keken we naar rupsen als plagen. Hier zullen we bladluizen beschouwen. Waar rupsen ware monsters zijn diie de bladeren opwreten zijn bladluizen meer verfijnd. Met hun naaldvormig mondstuk zuigen ze het sap van de planten rechtstreeks uit het vaatweefsel van de plant. Zo ontrekken ze niet alleen de plant haar kostbare suikers, maar de bladluizen zijn vaak ook dragers van gevaarlijke plantenvirussen. Het plantensap bevat voornamelijk suikers, relatief weinig aminozuren die de luizen ook nodig hebben. Daarom scheiden de luizen het sap grotendeels terug uit langs hun achterkant, ondaan van de meeste aminozuren. Deze substantie wordt *honingdauw* genoemd en is een belangrijke voedingbron voor mieren en wespen, maar kan ook schadelijke schimmels aantrekken. Luizen zijn erg vervelende beestjes voor vele soorten belangrijke gewassen, van aardappelen tot bonen tot rozen.

Omdat luizen zo schadelijk zijn, zijn er verschillende verdelgingsmiddellen die de beestjes snel om zeep helpen. Naast chemische bestrijding wordt er ook vaak *biologische bestrijding* toegepast, bladluizen zijn immers smakelijk voedsel voor vele andere insecten en vogels. Het lieveheersbeestje in het bijzonder is een echte moordmachine voor bladluizen. De larven alleen al eten zo'n 400 bladluizen, terwijl een volwassen lieveheersbeestje in hun leven nog maar liefst 5000 luizen kan verorberen. Vandaar dat men de larven van lieveheersbeestjes kan kopen om een luizenplaag onder controle te brengen[^mier]. 

[^mier]: Grappig genoeg krijgen de luizen soms bescherming vanuit onverwachte hoek. Omdat sommige mieren zich voeden met de hongdauw die de luizen uitscheiden beschermedn ze de bladluizen tegen lieverheersbeestjes.

Biologische bestrijding heeft nog een voordeel ten opzichte van chemische bestrijding: de beestjes die ingezet worden kunnen zich zelf ook nog vermendigvuldigen. Een lieveheersbeestje kan zo op een dag wel 50 eitjes leggen, die larven worden om vervolgens na zo'n 20 dagen te verpoppen tot nieuwe lieveheersbeestjes. 

Als we biologische bestrijding willen modelleren hebben we dus een complexer model nodig. We zullen twee toestanden moeten modelleren: het aantal bladluizen en het aantal lieveheersbeestjes.

## Wiskundige intermezzo: afgeleiden van functies

Voor de rupsen in het vorig hoofdstuk hadden we een formule die op basis van de populatiegrootte op stap $t$ de populatiegrootte op stat $t+1$ kon berekenen. De modellen van dit hoofdstuk zijn wat verfijnder: in plaats van rechtstreeks naar de *toestand* te kijken (hier, aantal insecten) beschrijven ze het process op basis van de *verandering* in de toestand. We hebben het niet meer over populatiegrootte maar over populatie*groei*. Voor we een model kunnen vormen moeten we groei of verandering wiskundig kunnen vastleggen. Dit kan door middel van de *afgeleide*.

Om te modelleren gebruiken we wiskundige functies die een bepaalde *input* (bv. een $x$) omzetten naar een bepaalde *output* (bv. een $y$). Denk maar aan de functie $f(x) = x^2$, die voor elke $x$ zijn kwadraat weergeeft. Hier zijn we vooral geïnteresseerd in processen die doorheen de tijd lopen, dus we nemen de $t$ als input. Laat ons een simpele functie nemen.

$$
f(t) = t\sin(t)
$$

wat we makkelijk in code kunnen omzetten:

```jl
sc("f(t) = t * sin(t)")

```

```jl
sco("f(5)")
```

Hier is een plot van deze functie:

```jl
pf = plot(f, 0, 10, label="f(x)", xlabel="x")
```

We zien hier een mooie doorlopende lijn, maar dit is echter schijn. Onze computer kan slechts één punt tergelijkertijd evalueren. Wat je ziet is een groot maar eindig aantal punten dat de computer berekend en de plotter verbindt met een vloeiende lijn. De volgende figuur staat wat dichter bij de werkelijkheid:

```jl
scatter(0:0.25:10, f.(0:.25:10), label="f(x)", xlabel="x")
```

Hier zien we dezelfde functie, maar we plotten slechts elke 0.2 tijdstappen een evaluatie. We duiden de tijdstappen aan met $\Delta t$ =0.2, waar het symbool $\Delta$ vaak gebruikt wordt om een verschil aan te duiden.

Wat we willen weten is hoe snel de functie daalt of stijgt. Dit kunnen we doen door het telkens het verschil $f(t+\Delta t) - f(t)$ te berekenen voor elke tijdstap. 


- [ ] plot verschil


We zien dat er regio's zijn waar de functie stijgt (het verschil is positief) en waar de functie daalt (het verschil is negatief). De verandering kan snel of traag zijn, dit kan je afleiden uit de (absolute waarde van) het verschil. Het verschil dat we geplot hebben hangt natuurlijk af van onze waarde van $\Delta t$ die we gekozen hebben. Indien we een kleinere waarde genomen hadden, bijvoorbeeld $\Delta t=0.1$, dan was het verschil in regel kleiner. Om hiervoor de corrigeren zullen we *delen door de tijdstap*. Dit laat ons toe om de wiskundige definitie van de afgeleide te benaderen:

$$
\frac{\text{d}f(t)}{\text{d}t}\approx \frac{f(t+\Delta t) - f(t)}{\Delta t}\,.
$$

Hier stelt $\frac{\text{d}f(t)}{\text{d}t}$ de afgeleide van de functie $f$ naar de tijd voor. Dat wil zeggen, hoe snel deze functie stijgt of daalt op tijdstip $t$. Het $\approx$ teken wil zeggen dat dit ongeveer gelijk is, en de benadering wordt beter met kleinere tijdstappen[^afgeleide].

[^afgeleide]: De exacte wiskundige definitie die je in wiskundelessen ziet is 
$$
\frac{\text{d}f(t)}{\text{d}t}=\lim_{\Delta t\rightarrow 0} \frac{f(t+\Delta t) - f(t)}{\Delta t}\,.
$$
De notatie $\lim_{\Delta t\rightarrow 0}$ betekent dat we $\Delta t$ naar nul brengen. 

We zullen deze formule eens toepassen voor $t=5$:
1. we hebben onze functie $f(t)$, bijvoorbeel $f(t)=t\sin(t)$
2. we evaluelen die in een bepaalde $t$, bijvoorbeeld $t=5$, dit geeft $f(2)\approx -4.7946$
3. dan beschouwen we een kleine verandering $\Delta t$, b.v. $\Delta t=0.1$
4. we berekenen $f(t+\Delta t)$, dus de functie iets verder in de tijd: $f(5.1)\approx -4.7898$
5. dan nemen we het verschil $f(t+\Delta t) - f(t)$, hier $-4.7898 - (-4.7946)=0.0048$
6. dit verschil delen we door het tijdstapje $\Delta t$ die we namen: $0.0048/0.1 = 0.048$

We zien hier dat de afgeleide op $t=5$ erg klein is. Als we terugkijken naar de grafiek van $f(t)$ dan zien we inderdaad dat die vlak is rond dat tijdstip, er is een lokaal minimum.

De formule die we hier gebruikten om de afgeleide te bepalen wordt de *eindige differentie methode* genoemd. Ze is zeer eenvoudig te implementeren.

```jl
sc("eindige_differentie(f, t; Δt=0.01) = (f(t + Δt) - f(t)) / Δt")
```

We hebben `Δt` als een parameter gekozen die we kunnen aanpassen.

```jl
sco("eindige_differentie(f, 2.0; Δt=0.1)")
```

Wat als we een kleinere waarde voor $\Delta t$ nemen?

```jl
sco("eindige_differentie(f, 2.0; Δt=0.01)")
```

En nog kleiner?

```jl
sco("eindige_differentie(f, 2.0; Δt=0.001)")
```

Wanneer we kleinere stapjes nemen neemt het verschil $f(t+\Delta t) - f(t)$ af maar we delen ook door een kleiner getal. Voor steeds kleinere waarden van $\Delta t$ convergeren we naar de echte afgeleide die we met een beetje calculus kunnen bepalen als $\sin(5) + 5 \cos(5)\approx 0.4593$.

```jl
plot!(pf, t->eindige_differentie(f, t; Δt=0.001), 0, 10, label="benaderde afgeleide")
```


De wiskundige notatie voor de afgeleide, $\frac{\text{d}f(t)}{\text{d}t}$, is een hele boterham om op te schrijven. Vanaf hier zullen we een simplere notatie gebruiken:

$$
\dot{f}(t) = \frac{\text{d}f(t)}{\text{d}t}\,,
$$

waar het puntje op de functie duidt op de afgeleide naar de tijd.


## Continue groei met differentiaalvergelijkingen

Aan de hand van de afgeleide van een functie kunnen we de verandering in de tijd berekenen. Wanneer we iets willen modelleren is dit extreem nuttig, want vaak is het handiger om de verandering te beschrijven in plaats van de grootheid zelf. Neem een luizenpopulatie. Wat is de grootte van hun populatie ($y(t)$) op elk moment? Dit is moeilijk te zeggen. Waar we wel iets over kunnen zeggen is de *groei*, de verandering van de populatie doorheen de tijd: $\dot{y}(t)$. Hier nemen volgend model aan:

$$
\dot{y} = ry(1-y/K)
$$

Dit ziet er bekend uit, het is immers terug de logistische functie[^logistic]! We veronderstellen opnieuw een groeisnelheid $r$, uitgedrukt in luizen per dag en een draagkracht van het systeem $K$, uitgedrukt in luizen. Wanneer de luizenpopulatie leeg is ($y=0$) is er geen groei ($\dot{y}=0$), net zoals wanneer de populatiegrootte gelijk is aan de draagkracht ($y=K$). Groei is pas mogelijk wanneer je een positieve luizenpopulatie is onder de draagkracht. Wanneer de grootte de draagkracht overstijgt is er negatieve groei, de populatie sterft uit. Hier nemen we als parameterwaarden $r=0.6$ en $K=10000$.

```jl
sc("σ(y;  r=0.6, K=10_000) = r * y * (1- y / K)")
```


[^logistic]: Merk op dat ons model hier helemaal anders ineensteekt dan het logistisch model van het vorig hoofdstuk. Toen gaf de logistische vergelijking een transformatie weer van de ene toestand (populatiegrootte) naar de andere, hier beschrijft het de groei.

```jl
plot(σ, 0, 11_000, label="Groei", xlabel="y (luizenpopulatie)")
```


Meer algemeen wordt een eenvoudige differentiaalvergelijing beschreven als:

$$
\dot{y} = f(y,t)\,,
$$

de afgeleide van de functie wordt beschreven door een andere functie $f(y,t)$ die kan afhangen van de zowel de toestand $y$ (bv. groei werd beïnvloed door de populatiegrootte) en de tijd. In ons voorbeeld hadden we geen tijdsafhankelijkheid, maar indien bijvoorbeeld de groeisnelheid zou afhangen van de peroide in het jaar zou je dit kunnen toevoegen. Zonder tijdsafhankelijkheid spreken van een *autonome* differentiaalvergelijking.

## Stapsgewijs oplossen van de differentiaalvergelijking met Euler

De meeste differentiaalvegelijkingen kunnen we niet wiskundig oplossen. Als we echter kijken naar onze benadering van de afgeleide, kunnen we echter wel een methode uitvinden om deze op te lossen. We merken op dat de standaardvorm van een differentiaalvergelijking ongeveer gelijk is aan:

$$
\frac{y(t+\Delta t) - y(t)}{\Delta t} \approx f(t, y)
$$

Als we bovenstaande verglijking wat omvormen bekomen we onderstaande formule:

$$
y(t+\Delta t) \approx y(t) + \Delta t \times f(t, y)
$$

Bovenstaande is erg nuttig! Als we de waarde voor $y(t)$ weten kunnen we een goede gok doen voor $y(t+\Delta t)$. Deze gok zal opnieuw beter worden als we een kleine stapgrootte voor $\Delta t$ nemen. Gezien we altijd een initiële waarde $y(t_0)$ nodig hebben. De formule laat ons toe stapje per stapje de oplossing $y(t)$ voor het hele tijdsinterval op te bouwen.




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

Het is natuurlijk niet zo praktisch om dit stapje per stapje in te voeren. Daarom zullen we dit in een functie gieten. 

```jl
sc("""
function euler(f,        # funtie met de afgeleide
            y₀,          # initiële waarde op t₀
            (t₀, tₑ);    # start- en eindtijd
            Δt=0.1)      # stapgrootte
    ts = t₀:Δt:tₑ  # de tijdstappen
    n_stappen = length(ts) - 1
    ys = [y₀]  # lijst met de functiewaarden
    for stap in 1:n_stappen
        t, yₜ = ts[stap], ys[stap]  # neem de vorige (laatste) waarde)
        yₜ₊₁ = yₜ + Δt * f(yₜ)  # bereken volgende stap
        push!(ys, yₜ₊₁)  # voeg deze toe aan de lijst
    end
    return ts, ys
end
""")
```

We zien dat we alle inputs geven, `f` de functie, de initële waarde `y₀`, het tijds interval `(t₀, tₑ)` en de stapgrootte `Δt` als woordargument. De functie maakt eerst een lijst `ts` aan met de tijdstappen en vervolgens een lijst `ys` met de toestanden. De laatste bevat oorspronkelijk enkel de startwaarde, welke aangevuld wordt voor de volgende tijdstappen aan de hand van een for-lus. Final geeft de functie de berekende `ts` en `ys` weer.

```jl
sco("ts, ys = euler(σ, 500.0, (0, 10), Δt=0.25)")
```

```jl
scatter(ts, ys, label="luizenpopulatie", xlabel="tijd (dagen)")
```

Hier zien we de groei van de bladluizen populatie doorheen de tijd. + UITLEG

## Prooien en predatoren: Lotka-Volterra

Prima. We weten nu hoe snel de bladluizen groeien. Wat doen we er aan? Om te voorkomen dat onze hele tuin leegegegeten worden voegen we hongerige lieveheersbeestjes toe die jagen op de luizen. We houden dus twee variabelen bij: de bladluizen en de lieveheersbeestjes. Gezien we twee variabelen opvolgen spreken we dan van een *stelsel van differentiaalvegrelijkingen*. Analoog met het vorige werken we met de volgende algemene vorm:

$$
\dot{\mathbf{y}} = f(\mathbf{y},t)\,
$$

waar we $\mathbf{y}$ en $\dot{\mathbf{y}}$ in het vet schrijven omdat het *vectoren* zijn. Een vector is een lijst met meerdere getallen[^vector], hier twee: de populatiegrootte van de luizen en lieveheersbeestjes, respectievelijk.

```jl
sco("[1, 4]  # een vector maak je met vierkante haakjes, de elementen gescheiden door een komma")
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

> De kracht van differentiaalvergelijkingen om de realiteit te beschrijven via massabalans

Newton, dingen in heel kleine deeltjes te verdelen en te sommeren, Newton, archimedes die het gebruikte om de oppervlakte van een cirkel te berekenen
twee voorbeelden: op basis van de hoogte vs spiesjes ? leidt te ver? Misschien gewoon de Riemannsom `rieman(f, (l, b), dx=(b-o)/100) = sum(f, o:dx:b) * dx`

Basis van differentiaalanalyse of calculus + opstellen DVG, Euler is meest simpele methode, wet van Newton


