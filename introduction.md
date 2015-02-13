# Introduction

## Remerciments

Nous tenons à remercier tout particulièrement Jean-Paul Roy pour son fabuleux
ouvrage ["Premier cours de programmation avec Scheme"][1] ainsi que le livre
"Structure and Interpretation of Computer Programs" écrits par Harold Abelson et
Gerald Jay Sussman avec le concours de Julie Sussman qui est disponnible
librement sur internet sur le site de [MIT-PRESS][2]

[1]:http://deptinfo.unice.fr/~roy/PCPS/
[2]:https://mitpress.mit.edu/sicp/

Ce petit guide ne se substitus en rien à ces merveilleux livres.

## Les langages de programmation

Ces derniers ont vu le jours dans les années 1950 pour la petite histoire le
langage que nous allons étudier [Racket][3] dérive d'un langage appellé
[Scheme][4] qui proviens d'une ancienne famille qui remonte aux alentours de
1958 il s'agit des [LISP][5].

Leur but premier étant de permettre la communication avec un ordinateur et aussi
d'echanger avec d'autres programmeurs au moyen d'un langage non-ambigue.

Dans notre cas nous nous intérresseront à Racket en particulier.
Treve de détails historiques! Nous distillerons plus d'informations sur les
langages en eux-mêmes au travers des chapitres.

[3]:http://racket-lang.org/
[4]:https://fr.wikipedia.org/wiki/Scheme
[5]:https://fr.wikipedia.org/wiki/Lisp

## Installation de l'environnement Racket

### DrRacket
Avant de commencer il vous faudra installer un environnement de programmation
digne de se nom. Partant du principe que vous voulez démarrer rapidement nous
vous proposonts d'utiliser **DrRacket** qui est disponnible à cette adresse:

[http://download.racket-lang.org/](http://download.racket-lang.org/).


*Note*: Pour les utilisateurs d'une distribution Linux ils existe des paquets dans
vos gestionnaire de paquet favoris recherchez *Racket* ou *plt-scheme*

### WeScheme
Cependant si vous ne pouvez ou ne voulez pas installer de logiciel nous vous
recommandons **WeScheme** un éditeur web disponible à l'adresse suivante:

[http://www.wescheme.org/](http://www.wescheme.org/)

# Racket

## L'interpreteur Racket

Nous supposeront que vous avez réussi à installer et lancer votre environnement
favoris et que vous avez devant vos yeux une invite de commande resemblant à
cela:

```racket
>
```

Cet interpreteur est aussi appellé « REPL » pour « Read-Eval-Print-Loop » ou
« toplevel » nous permet de *d'évaluer* des *expressions* Racket, nous
reviendrons sur l'évaluer et les expressions plus en détails ce sont des
concepts essentiels! :)

Une *expression* est un morceau de code qui représente une *valeur*. Par exemple
le nombre `5`.

```racket
> 5
5
```

On vois donc que le morceau de code Racket `5` à pour valeur 5.
« 5 » est donc une expression dont la valeur est le nombre 5.

Vous pouvez vous amuser à écrire des expressions dans l'interpreteur
pour voir ce qu'il va se passer comme:

```racket
> 5
5
> "Bonjour, Racket!"
"Bonjour, Racket!"
> ; Ahah Tu ne peut pas me lire je suis un commentaire car je commence par ';'.
```

### S-Expressions

Avant de commencer a taper des expressions ils faut savoir quelque chose sur
Racket. Il s'agit d'un LISP et tout les lisp ont la particularité d'avoir une
syntaxe basé sur les [Symbolic-Expressions][6] abbrégé *S-Expr*, elle est basé
sur le principe que toutes nos expressions seront préfixées par leur operateur
et suivit d'autres S-expressions.

[6]:https://fr.wikipedia.org/wiki/S-expression

#### Explications

Pour écrire une simple addition nous avons l'habitude d'écrire ainsi:
```
5 + 3
```
avec des operateurs *infixes*.

Et si vous tentez de l'écrire dans l'interpreteur il ne va pas vous
comprendre...

```racket
> 5 + 3
5
#<procedure:+>
3
```

Ouch! c'est loin de ce que nous attendions en effet comme cité précédament
racket ne jure que par des S-Expressions!

Nous devrons donc écrire notre expression arithmetique comme cela:
```racket
> (+ 5 3)
8
```

Et Racket nous le calcule (super rapidement) car un ordinateur est avant tout
conçu pour calculer. ;)

Mais parbleu! Que de parenthèses me direz vous! Et puis c'est étrange cet ordre
l'operateur avant les opérandes cet ordre s'appel l'ordre *prefix*.

Et bien oui c'est différent mais néanmoins puissant car des situations comme
cette derniere n'existent pas avec les S-expressions:

```
5 + 3 * 2 + 5
```

A l'école on nous à appris multiplication était prioritaire ce qui est vrai
cependant si on ne connaissais pas cette règle il y aurais une ambiguité.
Nous pourrions la lever avec des parenthèses comme ceci:

```
((5 + (3 * 2)) + 5)
```

Ou comme cela:

```
((5 + 3) * (2 + 5))
```

En effet si ont omet les règles de priorité il y a plusieurs
façons de lire une expressions hors les ordinateurs ne sont pas allez à l'école
et donc parfois selon les langages la priorité des operateurs infixe peut changer...

Et bien avec les S-Expressions il n'y à qu'une seule façon d'évaluer une
expressions prefixée dans notre cas `5 + 3 * 2 + 5` s'écrirait avec les régles
de priorité usuelles:

```racket
> (+ 5 (+ 5 (* 3 2)))
16
```

On note bien que l'operateur ici `+` est en premier il prefixe donc l'expression
et que les operandes peuvent sont d'autres expressions comme `5` ou bien
`(* 3 2)` l'évaluation s'effectuera sur la partie la plus interne de notre
S-Expr c'est à dire par `(* 3 2)` qui donne `6` et donc `(+ 5 6)` soit `11` puis
`(+ 5 11)` ce qui donne bien `16`!.

*Note*: Pour la petite histoire les « S-Exp » ont le même pouvoir d'expressivité
que « XML ».

Petit retour sur le concept d'expression que nous employons partout.
`(+ 5 3)` est une expression dont la valeur est le résultat de l'évalutation ou
du calcul vaut `8`.

Bien entendu on dispose de tout les operateurs usuels ce petit tableau vous fait
la correspondance:

| Fonctions      | Mathématiques | Racket     |
| -------------- |:-------------:| ----------:|
| Addition       |   x + y       | (+ x y)    |
| Soustraction   |   x - y       | (- x y)    |
| Multiplication |   x * y       | (\* x y)   |
| Division       |   x / y       | (/ x y)    |
<!--
| Sinus          |   sin x       | (sin x)    |
| Puissance      |   x ^ y       | (expt x y) |
| Exponentielle  |   e ^ x       | (exp x)    |
| Logarithme     |   log x       | (log x)    |
-->

Si vous ne connaissez pas certaines de ces fonctions aucun soucis nous
reviendrons dessus en temps et en heure! Mais on vois bien que nos parenthèses
ne sont qu'une histoire de syntaxe!

## Variables

En programmation comme en mathématiques l'ont peut donner un nom à une valeur,
pour eviter de devoir la recalculer et de la réecrire sans arret et aussi
pour ne plus s'encombrer l'esprit avec c'est à dire abstraire son contenu!

En racket on le fait au travers de la forme `(define nom valeur)`.

```racket
> (define a 5)
```

Votre professeur de mathématiques aurait écrit «¤Soit *a* un nombre dont la
valeur est 5¤».

Racket acquièse en silence mais il à pris compte de votre *définition* vous
pouvez verifez par vous même! Si il n'avait pas accepté votre définition il
l'aurait déjà signalé.

```racket
> a ; Dit voir tu connais la valeur de a mon bon Racket?
5
```

Merci Racket! `a` ici est une variable. En général on connais pas la valeur à
l'avance néanmoins.

D'ailleurs comme si vous pensiez que les expressions allaient nous lachez sachez
que le nom d'une variable comme «¤a¤» est une expression! Dont la valeur est ce
que nous avons définit plus tôt ici `5`.

Du coup on à gagner le droit d'exprimer valeurs qui *dépendent* de cette
variable et non de sa valeur! Comme:

```racket
> (+ a 1) ; Notez bien on ne modifie pas a.
6
> (define b 5)
> (+ a b)
10
```

On vera plus tard que l'ont peut faire des chôses très puissantes mais
dangeureuses avec nos variables. Mais notez bien que si vous faites:

```racket
> (define a 5)
> a
5
> (define a 6) ; Héhé Racket je te piège!
> a
6
```

Vous avez juste *caché* (shadowed en anglais) la définition précédente!
Nous reviendront dessus. :)















