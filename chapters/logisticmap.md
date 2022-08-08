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

$$
x_t = r x_t
$$

$r$ is de *groeiparameter*

- $r < 1$
- $r= 1$
- $r > 1$


gesloten uitdrukking

$$
x_t = x_0r^t
$$

$$
x_t = x_0e^{\ln(r)t}
$$

- [ ] plot exponetial growth

waarom dit onrealistisch is


## Logistische groei

$$
x_t = r(1-x_{t-1}/K) x_{t-1}
$$

$$
\sigma(x) = r(1-x/K)
$$

- [ ] figure starts
- [ ] chaos
- [ ] spiderweb diagram
- [ ] bifurction plots


## Chaos in de verdere wereld

## Oefeningen
