# Introduction

## Remerciements

Nous tenons à remercier tout particulièrement Jean-Paul Roy pour son fabuleux
ouvrage ["Premier cours de programmation avec Scheme"][1], ainsi que le livre
"Structure and Interpretation of Computer Programs", écrit par Harold Abelson et
Gerald Jay Sussman avec le concours de Julie Sussman, disponible
librement sur internet sur le site de [MIT-PRESS][2]

[1]:http://deptinfo.unice.fr/~roy/PCPS/
[2]:https://mitpress.mit.edu/sicp/

Ce petit guide ne saurait remplacer ces merveilleux livres.

## Les langages de programmation

Ces derniers ont vu le jour dans les années 1950. Pour la petite histoire, le
langage que nous allons étudier, [Racket][3], est un dérivé d'un langage appelé
[Scheme][4], provenant d'une ancienne famille qui remonte aux alentours de
1958, les [LISP][5].

Leur but premier est de permettre la communication avec un ordinateur et aussi
d'échanger avec d'autres programmeurs au moyen d'un langage non-ambigu.

Ici nous nous intéresserons à Racket en particulier.
Trêve de détails historiques! Nous distillerons plus d'informations sur les
langages eux-mêmes au travers des chapitres.

[3]:http://racket-lang.org/
[4]:https://fr.wikipedia.org/wiki/Scheme
[5]:https://fr.wikipedia.org/wiki/Lisp

## Installation de l'environnement Racket

### DrRacket
Avant de commencer il vous faudra installer un environnement de programmation
digne de ce nom. Partant du principe que vous voulez démarrer rapidement, nous
vous proposons d'utiliser **DrRacket** qui est disponible à cette adresse:

[http://download.racket-lang.org/](http://download.racket-lang.org/).


*Note*: Pour les utilisateurs d'une distribution Linux ils existe des paquets dans
vos gestionnaires de paquet favoris recherchez *Racket* ou *plt-scheme*

### WeScheme
Cependant si vous ne pouvez ou ne voulez pas installer de logiciel nous vous
recommandons **WeScheme** un éditeur web disponible à l'adresse suivante:

[http://www.wescheme.org/](http://www.wescheme.org/)

# Racket

## L'interpréteur Racket

Nous supposerons que vous avez réussi à installer et lancer votre environnement
favori et que vous avez devant vos yeux une invite de commande ressemblant à
ceci:

```racket
>
```

Cet interpréteur, aussi appelé « REPL » pour « Read-Eval-Print-Loop » ou
« toplevel » nous permet *d'évaluer* des *expressions* Racket. Nous
reviendrons sur l'évaluation et les expressions plus en détail, ce sont des
concepts essentiels! :)

Une *expression* est un morceau de code qui représente une *valeur*. Par exemple
le nombre `5`.

```racket
> 5
5
```

On voit donc que le morceau de code Racket `5` a pour valeur 5.
« 5 » est donc une expression dont la valeur est le nombre 5.

Vous pouvez vous amuser à écrire des expressions dans l'interpréteur
pour voir ce qu'il va se passer comme:

```racket
> 5
5
> "Bonjour, Racket!"
"Bonjour, Racket!"
> ; Ahah Tu ne peut pas me lire je suis un commentaire car je commence par ';'.
```

### S-Expressions

Avant de commencer a taper des expressions, il faut savoir quelque chose sur
Racket. Il s'agit d'un LISP et tout les LISP ont la particularité d'avoir une
syntaxe basée sur les [Symbolic-Expressions][6], abrégées *S-Expr*, elle est basée
sur le principe que toutes nos expressions seront préfixées par leur opérateur
et suivies d'autres S-expressions.

[6]:https://fr.wikipedia.org/wiki/S-expression

#### Explications

Pour écrire une simple addition nous avons l'habitude d'écrire ainsi:
```
5 + 3
```
avec des opérateurs *infixes*.

Et si vous tentez de l'écrire dans l'interpréteur il ne va pas vous
comprendre...

```racket
> 5 + 3
5
#<procedure:+>
3
```

Ouch! c'est loin de ce que nous attendions! En effet comme cité précédemment,
racket ne jure que par des S-Expressions!

Nous devrons donc écrire notre expression arithmétique comme cela:
```racket
> (+ 5 3)
8
```

Et Racket nous le calcule (super rapidement) car un ordinateur est avant tout
conçu pour calculer. ;)

Mais parbleu! Que de parenthèses me direz vous! Et puis, c'est étrange cet ordre,
l'opérateur avant les opérandes! Cet ordre s'appelle l'ordre *préfixe*.

Et bien oui, c'est différent mais néanmoins puissant car des situations comme
cette dernière n'existent pas avec les S-expressions:

```
5 + 3 * 2 + 5
```

A l'école on nous a appris que la multiplication était prioritaire, ce qui est vrai,
cependant si on ne connaissait pas cette règle il y aurait une ambiguïté.
Nous pourrions la lever avec des parenthèses comme ceci:

```
((5 + (3 * 2)) + 5)
```

Ou comme cela:

```
((5 + 3) * (2 + 5))
```

En effet, si on omet les règles de priorité, il y a plusieurs
façons de lire une expressions. Or, les ordinateurs ne sont pas allés à l'école,
donc parfois selon les langages la priorité des opérateurs *infixe* peut changer...

Et bien avec les S-Expressions, il n'y a qu'une seule façon d'évaluer une
expressions préfixée. Dans notre cas `5 + 3 * 2 + 5` s'écrirait avec les règles
de priorité usuelles:

```racket
> (+ 5 (+ 5 (* 3 2)))
16
```

On note bien que l'opérateur `+` est en premier. Il préfixe donc l'expression.
On remarque également que les opérandes sont des expressions, par exemple `5` ou bien
`(* 3 2)`.
L'évaluation s'effectuera sur la partie la plus interne de notre
S-Expr, c'est à dire par `(* 3 2)`, qui donne `6`, puis `(+ 5 6)` soit `11`, et enfin
`(+ 5 11)` ce qui donne bien `16`!.

*Note*: Pour la petite histoire les « S-Exp » ont le même pouvoir d'expressivité
que le langage de formatage « XML ».

Petit retour sur le concept d'expression que nous employons partout:
`(+ 5 3)` est une expression, dont la valeur est le résultat de l'évaluation, ici `8`.

Bien entendu on dispose de tout les opérateurs usuels ce petit tableau vous fait
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


Si vous ne connaissez pas certaines de ces fonctions, aucun soucis nous
reviendrons dessus en temps et en heure! Mais on vois bien que nos parenthèses
ne sont qu'une histoire de syntaxe!
-->
## Variables

En programmation comme en mathématiques on peut donner un nom à une valeur,
afin d'éviter de devoir la recalculer, la réécrire sans arrêt et aussi
pour ne plus s'encombrer l'esprit avec. On rend ainsi abstrait son contenu!

En racket on le fait au travers de la forme `(define nom valeur)`.

```racket
> (define a 5)
```

Votre professeur de mathématiques aurait écrit «¤Soit *a* un nombre dont la
valeur est 5¤».

Racket acquiesce en silence mais il a prit compte de votre *définition*. Vous
pouvez vérifiez par vous même! S'il n'avait pas accepté votre définition il
l'aurait déjà signalé.

```racket
> a ; Dit voir tu connais la valeur de a mon bon Racket?
5
```

Merci Racket! `a` ici est une variable. En général on ne connait pas la valeur à
l'avance néanmoins.

D'ailleurs si vous pensiez que les expressions allaient nous lâcher sachez
que le nom d'une variable comme «a» est une expression! Expression dont la valeur est ce
que nous avons définit plus tôt, ici `5`.

Du coup on a gagner le droit d'exprimer des valeurs qui *dépendent* de cette
variable et non de sa valeur! Comme:

```racket
> (+ a 1) ; Notez bien on ne modifie pas a.
6
> (define b 5)
> (+ a b)
10
```

Nous verrons plus tard que l'on peut faire des choses très puissantes mais
dangereuses avec nos variables. Mais notez bien que si vous faites:

```racket
> (define a 5)
> a
5
> (define a 6) ; Héhé Racket je t'ai piégé!
> a
6
```

Vous avez juste *caché* (shadowed en anglais) la définition précédente!
Nous y reviendrons. :)















