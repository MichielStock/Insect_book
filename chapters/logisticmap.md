# Modeleren van een rupsenuitbraak met de logistische vergelijking

Ecologen bestuderen hoe levende organismen interageren met andere levende organismen en met hun omgeving. Eén van de meest fundamentele vragen die ze proberen te beantwoorden is hoe een populatie van dieren, planten, bacteriën of mensen veranderd doorheen de tijd. Groeit ze? Daalt ze? Stagneert ze? Gaat de populatie op en neer? Kan ze plots imploderen? Dit soort vragen beantwoorden ecologen aan de hand van *groeimodellen*, wiskundige vergelijkingen die de (verwachte) groei doorheen de tijd voorstellen. In dit hoofdstuk bekijken we twee heel eenvoudige groeimodellen: *exponentiële groei* en *logistische groei*. We zullen leren hoe we het gedrag van deze modellen kunnen inschatten. Eén van deze modellen heeft een verrassende eigenschap: ze kan *chaotisch* zijn, in bepaalde waarden is ze totaal onvoorspelbaar. 

> Dit hoofdstuk kan eenvoudig met een rekenmachine uitgevoerd worden.

## Ontmoet de buxusmot

Vele insecten zijn nuttig, maar velen zijn ook ook plagen die de planten opvreten. Zo is de rups van de buxusmot (*Cydalima perspectalis*) een nachtmerrie voor elke tuinier met een mooie Buxshaag. De buxusmot is een invasieve soort in Europa met een grote economische cost. 

![Rupsen van de buxus mot vernietigen een plantenhaag.](https://upload.wikimedia.org/wikipedia/commons/9/95/Box_tree_moth_larval_feeding_damage.jpg)

Omdat deze rups zo schadelijk is, zijn ecologen en gewasbeschermers erg geïnteresseerd om de de groei van populaties op te volgen en te modeleren. Wiskundige modellen helpen hen in te schatten of de populatie tot een aanvaardbare grootte blijft of wanneer ze dreigt uit haar voegen te treden en bestrijding nodig is. 

Bestrijding:
- insecticiden  as cypermethrin and deltamethrin are efficient, but must be thoroughly applied inside the bush and under leaves
- Bacillus thuringiensis bacterie als biologische bestrijding
- formonenvallen

## Veronderstellingen van ons model

Een wiskundig model is altijd een *vereenvoudiging* van de werkelijkheid (FN: een fotomodel is dan weer een *idealisering* van de werkelijkheid). Hier zullen we de rupsenpopulatie modeleren in perfecte, niet-overlappende generaties. We gebruiken de notatie $x_t$ om de populatiegrootte voor te stellen op generatie of tijdstip $t$. Hier neemt $t$ de waardes 0, 1, 2, 3, ... aan. Ons doel is om een *reeks* te bekomen die te populatiegrootte doorheen de tijd voorstelt:

$$x_{0}, x_{1}, x_{2},\ldots, x_{t-1}, x_{t}, \ldots$$

Hier is $x_0$ de initiële populatiegrootte, het aantal rupsen op het begin van de metingen.

Wat we willen bekomen is een soort van regel die ons vertelt wat de populatiegroote op tijdstip $t$ (dus $x_t$) is, geven dat weten hoeveel rupsen er zijn op tijdstip $t-1$ (dus $x_{t-1}).  We maken drie veronderstellingen voor zo'n regel:

1. We gaan er van uit dat de regel *determistisch* is. Als we de grootte kennen op tijdstip $t-1$ geeft dit altijd dezelfde grootte op tijdstip $t$. We houden geen rekening met willekeurige fluctuaties.
2. We nemen aan dat onze populatie groot genoeg is zodat we de kunnen voorstellen aan de hand van *reële getallen* zoals 21,2, 178,19, en 1437976,6 in plaats van *natuurlijke getallen* zoals 21, 178 en 1437976. In werkelijkheid zijn er geen (levende) 'halve' rupsen. Voor de eenvoud nemen we aan dat de populatie groot genoeg is dat de populatie *oneindig deelbaar* is zodat kommagetallen een goede benadering zijn. FN: Voor wie zich nog altijd niet helemaal lekker voelt bij fracties van rupsen, je kan ook over $x_t$ denken als de biomassa van rupsen. Dit is het totaal gewicht van rupsen op tijdstip $t$.
3. De populatiegrootte wordt bekeken in een reeks van perfect gescheiden generaties. We zeggen dus de tijd *discreet* doortikt. Onze modellen geven de groottes aan op tijdstippen 1, 2, 3 enz maar het houdt hier geen steek om te kijken naar tijdstip 2,4. Er is niets tussen de generaties!

Ons model kan je dus zien als een soort van uurwerk dat verdertikt. Elke stap passen we dezelfde regel toe op een $x$ om van de huidige generatie naar de volgende te gaan. In de latere hoofdstukken van dit boekje zullen we elk van de bovenstaande veronderstellingen versoepelen om zo meer realistischere modellen te bekomen. 

We hebben gesproken van regels zonder erg concreet te zijn. In dit hoofdstuk beschouwen we twee regels die aanleiding geven tot twee modellen:
1. *exponetiële groei* waar de populatie ofwel snel uitsterft ofwel blijft groeien zonder rem;
2. *logistische groei* waar de populatie wel een limiet heeft en een veel rijker gedrag kan vertonen.

Laat ons beginnen!

## Ongebonden exponetiële groei

Vele insecten willen zo veel mogelijk nakomelingen als mogelijk voorbrengen. In een generatie verpopt een buxusmotrups zich tot een buxusmot, welke nieuwe eitjes legt op een nieuwe haag. Uit deze eitjes kruipen nieuwe rupsen en de cyclus herbegint. Het leven van een insect is echter niet zonder gevaar. Op elk moment in de cyclus kunnen eitjes, rupsen, poppen en motten sterven door predatie van vogels, pesticiden, uithongering of andere gevaren. Als we echter gemiddeld kijken kunnen we aannemen dat elke rups aanleiding geeft tot een bepaald aantal nieuwe rupsen in de volgende generatie. Dit geeft de volgende regel:

$$
x_t = r x_{t-1}\,
$$

waar $r> 0$ is de *groeiparameter* is. 

We kunnen deze regel eenvoudig in computercode voorstellen als

```julia
m(x; r) = r * x
```

De groeiparameter $r$ stelt het gemiddeld aantal nakomelingen per rups voor. We werken met gemiddelden, dus kommagetallen zoals 0.2 en 3.1 zijn toegestaan maar negatieve getallen houden geen steek.

> Wiskundige modellen verwerken getallen. We onderscheiden *toestanden* (hier de $x$-en) en *parameters* (hier de groeiparameter $r$). De toestand is de eenheid waarin we geïntereseerd zijn en veranderd doorheen de simulatie. De parameters zijn grootheden die vast zijn gedurende de simulatie en beïnvloeden het gedrag van het model. 

Even nadenken over wat $r$ betekent geeft de volgende conclusies:

1. Als $r<1$ is brengt elke rups minder dan één rups voort per generatie. In elke tijdstap wordt de populatie kleiner en kleiner tot ze uiteindelijk uitsteft.
2. Indien $r>0$ is zal elke rups aanleiding geven tot *meer* dan één nieuwe rups in de volgende generatie. De populatie zal groeien.
3. In het randgeval waar $r=1$ is de populatiegroote perfect stabiel. De geboorte van nieuwe rupsen compenseert voor de sterfte.

Gezien we hier naar plaaginsecten kijken is de groeiparameter hoogst waarschijnlijk groter dan 1.

waar `m` een functie is die de regel ("map") implementeert.

Laat ons eens experimenteren. Je kan dit in een Python of Julia terminal doen, of gewoon met een rekenmachine. We zetten $r=1.8$, dus elke rups leidt gemiddeld gezien tot iets minder dan twee nieuwe rupsen per generatie.

```julia
r = 1.8
```

We moeten nu enkel nog een initiële $x_0$ zetten, de populatiegrootte op $t=0$. We beginnen met een bescheiden populatie van vijf rupsen.

```
x₀ = 5
```

 We passen de functie `m` toe: 

```julia
julia> x₁ = m(x₀; r)
9.0
```

Zoals verwacht zien we net geen verdubbeling van de populatie. Om nog een generatie verder te gaan passen we ofwel de functie één keer toe op `x₁`of twee keer op `x₀`

```julia
julia> x₂ = m(x₁; r)
16.2

julia> m(m(x₀; r); r)  # zelfde resultaat
16.2
```

We kunnen zo verder naar de derde en vierde generatie gaan...

```julia
julia> x₃ = m(x₂; r)
29.16

julia> x₄ = m(x₃; r)
52.488
```

We zien dat na vier generaties, de populatie al meer dan tien keer zo groot geworden is. 

Dit model is simpel genoeg dat we een *gesloten uitdrukking* kunnen geven voor de populatiegrootte doorheen de tijd:

$$
x_t=x_{0}r^t \qquad t=0, 1, 2, \ldots
$$

Aangezien dit een exponentiële functie is wordt dit groeimodel dus *exponentiële groei* genoemd. De implementatie is eenvoudig:

```julia
pop_exp(x₀, t; r) = x₀ * r^t
```

We zien dat deze hetzelfde resultaat geeft als voordien[^code]:

```julia
julia> pop_exp.(x₀, 0:4; r)
5-element Vector{Float64}:
  5.0
  9.0
 16.200000000000003
 29.160000000000004
 52.488
 ```

[^code]: Deze lijn code is wat moeilijker dan wat we tot nu toe gezien hebben. het `0:4` genereert een reeks generaties van 0 tot 4 in stappen van 1. We willen een lijst (`Vector`) aanmaken dit voor elke generatie die grootte berekent. Door een `.` na de functie en voor de haakjes te plaatsen zal de functie voor elke generatie toegepast worden. Een equalente manier is om `[pop_exp(x₀, t; r) for t in 0:4]` te lopen. Dit is ongeveer hoe je het in de Python taal zo doen.

Laat ons een figuur maken voor tien generaties.

- [ ] plot exponetial growth

De plaag groeit erg snel, dit is verontrustend. Wat als we nog verder inde tijd kijken.

- [ ] plot exp growth 50 gen

Oei. We zien dat de populatiegrootte groeit zonder enige belemmering. Na 50 generaties zijn er meer dan 29000000000000 rupsen. Als we aannemen dat één rups ongeveer 3 gram weegt hebben we na 50 generaties meer dan 87 miljoen ton rupsen, ofwel 40 mijoen nijlpaarden. Er zijn bijlange niet genoeg Buxushagen in de wereld om dergelijke populaties te bekomen!

In de praktijk heeft elk ecosystem een bepaalde *draagkracht*, de hoeveelheid voedsel, water, ruimte die voorhanden is om een bepaalde populatie te ondersteuenen/. Onze rupsenpopulatie is geimiteerd door het aantal planten die beschikbaar zijn als voedsel. De draagkracht wordt vaak voorgesteld door de letter $K$. Laat ons aannemen dat $K=1000$. Onze tuin heeft genoeg Buxussen om 1000 rupsen te voeden en geen meer. Kunnen we de regel uitbreiden om hier rekening mee te houden?

## Logistische groei

We zoeken dus een regel die rekening houdt met de draagkracht van het systeem. We verwachten dat wanneer de populatiegrootte klein is, en er dus veel planten per rups zijn, onbelemmerde groei mogelijk is. Wanneer het aantal rupsen dicht bij de draagkracht komt, moet de groei stoppen. De regel die we voorstellen is

$$
x_{t} = r\left(1-\frac{x_{t-1}}{K}\right)x_{t-1}\,.
$$

Hier zien we dat als $x\approx 0$, het deel tussen haakjes te verwaarlozen is (ongeveer gelijk aan 1). We bekomen dus terug (ongeveer) exponentiële groei. Wanneer $x\approx K$, dan is het deel tussen haakjes ongeveer nul en zal de populatiegrootte in de volgende stap ook nul zijn. De populatie stuikt in elkaar.

Wiskundigen gebruiken gebruiken vaak het symbool $\sigma$ ("sigma") als de *logistische vergelijking*

$$
\sigma(x) = r(1-x/K)\,.
$$

In code is dit eenvoudigweg

```julia
σ(x; r, K) = r * (1 - x / K) * x
```

Laat ons opnieuw enkele stappen van de logisitische groei simuleren. Herinner je $r=1.8$ en $K=1000$.

```julia
julia> x₀ = 5
5

julia> x₁ = σ(x₀; r, K)
8.955

julia> x₂ = σ(x₁; r, K)
15.974654355

julia> x₃ = σ(x₂; r, K)
28.295036591828904

julia> x₄ = σ(x₃; r, K)
49.48996949297275
```

Vergelijk met de resulaten van de exponentiele groei, wat merk je op? De groei ziet er gelijkaardig uit, waarbij de logistische groei iets trager is. Dit komt omdat we na vier stappen nog erg ver van de draagkracht zitten: $49.49 / 1000 \approx 5\%$. Laat ons even over een langer tijdsinterval kijken.

- [ ] figure log growth

Hier zien we een kwalitatief verschil met de exponentiele groei! In plaats van ongelimiteerd door te groeien begint de groei na ongeveer zeven generaties te temperen. Vanaf generatie 12 is de populatiegrootte stabiel op ongeveer 444 rupsen. Merk op dat dit flink minder is dan de draagkracht van het systeem!

De grootte waarnaar geconveergeerd wordt heet de *evernwichtswaarde*. We zullen dit noteren met $x\_text{eq}$ ("eq" staat voor *equilibrium*). Als op dat moment de polatie stabiel is, moet houden dat

$$x_\text{eq} = r\left(1-\frac{x_\text{eq}}{K}\right)x_\text{eq}\,.$$

We kunnen dit hetschrijven als 

$$
rx_\text{eq}^2 + K(1-r)x_\text{eq} = 0\,,
$$

een kwadratische vergelijking van de vorm $ax^2+bx+c=0$. Een beetje rekenen geeft twee mogelijke oplossingen weer:
- Ten eerste, $x_\text{eq}=0$, een triviale oplossing. Indien er geen rupsen zijn zal de populatie ook leeg blijven. Dit evenwicht is echter *onstabiel*. Een enkele rups in het systeem kan de populatie op gang brengen.
- Het tweede evenwichtspunt is $x_\text{eq}=K\frac{r-1}{r}$, welke we zien op de plot. Dit is stabiel (voor deze groeisnelheid!), gezien we van verschillende startwaarden kunnen vertrekken en altijd op hetzelfde uitkomen.

- [ ] figuur startwaarden

## Schommelingen in de populatie

Wat als we andere waarden nemen voor de groeisnelheid? Indien we $r=3.34$ zien we een compleet ander gedrag. 

- [ ] figuur oscillaties 2

We zien dat de populatie niet convergeert naar een $x_\text{eq}$ maar een *periodiek* gedrag vertoont. De ene generatie is de populatiegrootte minder dan verwacht bij evenwicht, de volgende generatie terug meer enzovoort. Hier zien we dat de populatiegrootte zich elke twee generaties herhaalt, dit noemen we een periode van twee.

Indien we $r$ nog een ietsiepietsie vergroten naar 3.455 kunnen we een periode van vier waarnemen. 

- figuur oscillaties 4

## Een wispelturige populatie

Logistische groei lijkt niet zo gecompliceerd. Ofwel lijken we te convergeren naar een vaste waarde $x_\text{eq}=K\frac{r-1}{r}$, ofwel gaat de populatie op en neer volgens een regelmatig patroon. Blijft deze makkelijk te voorspellen? Een groeisnelheid van $r=3.6$ leert ons van niet.

- fig log r=3.6

Hier gaat de populatie op en neer maar zonder enige regelmaat. Soms lijkt het alsof de grootte voor een tijdje gewoon terug oscilleert om dan plots het patroon te doorbreken. Wat als we verschillende startwaarden nemen?

- [ ] figure starts

Hier zien we helemaal het omgekeerde van een convergentie: de tijdsreeksen zijn compleet verschillend. Logisch denk je misschien, want ze zijn allemaal op compleet verschillende plaatsen begonnen. Wat als we de reeksen beginnen, maar met slechts een piepklein beetje verschil? Dus we starten van $x_0=4.998, 4.999, 5, 5.001, 5.002$. Hier zou je verwachten dat de reeksen ongeveer syncroon lopen.

- figure small diff chaos

De reeksen met verschillende startwaarden lopen inderdaad samen. Voor ongeveer 20 generaties. Daarna lopen de tijdreeksen weer helemaal verschillend.

> Probeer dit zelf op je rekenmachine of via een terminal. Neem een startwaarde en simuleer voor een tiental generaties en noteer je resultaten. Start van een licht verschillende waarde en bekijk het verschil.

Voor bepaalde waarden van de groeisnelheid worden heel kleine verschillen in de populatiegrootte geamplificeerd. Dit gedrag wordt *chaos* genoemd: kleine verschillen in startcondities leiden op termijn tot grote verschillen in uitkomst. Indien onze rupsenpopulatie zich chaotisch zou gedragen is het erg moeilijk om op lange termijn te voorspellen wat de grootte zal zijn. 

## Een nieuw gezichtpunt

We zien dat de waarde van $r$ een sterke invloed uitoefend op het gedrag van de logistische groei. Een nieuwe soort figuur verschaft ons beter inzicht in wat er nu eigenlijhk gebeurt. We plotten op de x-as $x_{t-1}$ en op de y-as $x_t$ zodat we zien hoe de grootte verspringt van populate tot populatie. We beginnen met $r=1.8$, het eenvoudig convergerend gedrag.

- [ ] spiderweb

Merk op dat we twee hulplijnen getekend hebben. De eerste is de logistische vergelijking $\sigma(x) = r(1-x/K)x$, het tweede de eerste bissectrice die het vlak in twee snijdt. De laatste is nuttig omdat $x_t$ van de ene generatie de $x_{t-1}$ van de volgende generatie is. Door de evolutie van de populatie als een trap tussen deze twee curves voor te stellen zien we hier hoe de populatie naar het snijpunt tussen de curves convergeert. Dit snijpunt is natuurlijk de evenwichtspopulatie. Dit soort plot wordt soms poetisch een *spinnewebdiagram* genoemd.

Het chaotisch regime met $r=3.6$ ziet er als volgt uit.

- [ ] spiderweb diagram

De vorm van de logistische verlijking is nu een beetje anders waardoor de bissectrice na de top komt. Soms verspringt de lijn voor en na de top, wat verklaart waarom het gedrag zo onvoorspelbaar is.

Wat als we kijken naar **alle** waarden voor de groeisnelheid $r$? Dit kunnen we doen aan de hand van een *bifurcatieplot*. Wat we doen is voor elke waarde van $r$ van 0 tot 4 de logistische vergelijking toepassen voor een groot aantal stappen (hier 100) op een startwaarde. 

- [ ] bifurction plots

Hierop kan je onmiddellijk zien welke eindwaarden mogelijk zijn voor bepaalde waarden van $r$. 

Zo zien we
- voor $0<r<1$ is geen groei mogelijk, de populatie sterf uit;
- voor $1\le r < 3$ zien we convergentie naar $x_\text{eq}$;
- voor $3\le r < 4$ wordt het interessanter! We zien eerst een splitsing (een bifurcatie!) in twee. Dit is een periodieke reeks met periode 2. Voor hogere waarden gaat de periode naar vier om uiteindelijk naar een chaotisch regime over te gaan.

## De insekten voorbij
TODO: betere naam voor deze sectie

Groeimodellen vind je overal, niet enkel om de evolutie van insectenpopulaties te beschrijven, maar ook van kristallen, bacteriën enz. Ook onze maatschappij vertoont exponentiële groei, denk maar aan de wereldbevolking in de twintigste eeuw (een verdubbeling elke 37 jaar). Een bekende wet in technologie is de zogenaamde Wet van Moore dit stelt dat het aantal transistors in een computerchip elke twee jaar verdubbelt. Oneindige groei is vrijwel altijd onmogglijk, ooit moet je op de limiten van je systreem botsen. Maar exponentiele groei is vaak een uitstekende beschrijving van het *begin* van de groei. Tijdens de COVID-19 pandemie werd exponentiële groei ook vaak in de mond genomen om het aantal besmette personen te beschrijven[^R0]. Wie nog eens naar de groeicurves kijkt ziet het gevaar van een exponentiële groei. Het begin is traag, tot het plots in de hoogte schiet...

[^R0]: De befaamde $R_0$-waarde waar epidemiologen het graag over hadden komt ruwweg overeen met de groeisnelheid $r$ die wij hier bestudeerden. Via sociale distancing, mondmaskers en vaccinatie werd er alles aan gedaan om deze onder de 1 te brengen.

De logisitische vergelijking is enorm belangrijk, niet omdat ze zo biologisch realistisch is, maar omdat het één van de simpelste manieren is om een chaotische reeks te genereren. Chaostheorie, de wetenschap dat kleine oorzaken grote, onverwachte gevolgen kunnen hebben, is een relatief jonge tak van de wiskunde. Ze kon pas bloeien in de twintigste eeuw toen computers het mogelijk maakten om snel computationele experimenten uit te voeren, zoals we hier gedaan hebben. Eén van de pioniers in dit veld was de weerkundige Edward Lorenz. Terwijl hij experimenteerde met een eenvoudig weermodel rondde hij de getallen af van zes naar drie cijfers om de berekeningen sneller te laten lopen. Tot de grote schok van de wetenschappelijke gemeenschap die tot dan toe slechts in een triviale afrondingsfout zou resulteren gaf dit compleet andere uitkomsten. Tegenwoordig is het algemeen aanvaard dat systemen zoals het weer (en de stromingen van vloeistoffen in het algemeen) chaotisch zijn. Dit maakt het zo goed als onmogelijk om het weer nauwkeurig te voorspellen meer dan een week in de toekomst.

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Airplane_vortex_edit.jpg/1920px-Airplane_vortex_edit.jpg)

Het model van Lorenz is zo iconisch dat we hier even willen tonen. Het beschrijft een trajectory in een driedimentionele ruimte. De drie dimensies stellen elk een weerkundig/e variable voor. Dit traject lijkt wat op een een vlinder, waarbij het punt dat dit traject volgt schijnbaar willekeurig beslist om van de ene naar de andere vleugel te verspringen. Misschien was het deze figuur die Lorenz inspireerde om te stellen dat een vleugelslag van een vlindertje mogelijks tot een orkaan kan leiden aan de andere kant van de wereld.


![](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Lorenz_attractor_yb.svg/1920px-Lorenz_attractor_yb.svg.png)

- [ ] figure lorenz attractor

Deze bovenstaande Lorenz attractor is geen discreet model zoals we in dit hoofdstuk besproken hebben maar een stelsel van differentiaalvergelijkingen. Differntiaalvergelijkingen stellen verandingen in de tijd voor en komen alomtegenwoordig voor om natuurlijke fenomenen te beschrijven. Het is het onderwerp van het volgende hoofdstuk.

## Oefeningen

1. Bewijs aan de hand van inductie de gesloten uitdrukking voor exponentiele groei.
2. Exponentiële groei wordt vaak voorgesteld door de formule $x_t=x_0e^{at}$ met $a$ een nieuwe groeiparameter. Kan je het verband tussen $a$ en $r$ vinden?
3. Kan je op basis van $r$ in de exponentiële groei een formule vinden voor de verdubbelingstijd, dit is het aantal generaties nodig om de populatiegrootte te verdubbelen?
4. naast de logistische mapping zijn er nog andere maps. Probeer je die even uit?
   - de cosinus map $x_t = \cos(x_{t-1})$ (in code: `tent(x) = cos(x)`);
   - de tent map $x_t = \min(x_{t-1}, 1-x_{t-1})$ (in code: `tent(x) = min(x, 1-x)`);
   - Gauss map $x_t = \exp(-\alpha (x_{t-1})^2) +\beta)$ (in code: `gauss(x; α, β) = exp(α * x^2) + β`).