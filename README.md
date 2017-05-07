# AT
git repo für das haskell-AT

## Organisatorisches

* Treffen montags, 16:15, S1|15/021; SS17
* Kontakt: vpfanschilling+GP(bei)gmail.com
* Wenn ihr Updates/Anmerkungen/Korrekturen/Ergänzungen zu diesem Repo habt, gerne pull request oder email.
* Mailingliste: Bitte schreibt mir eine Mail, falls ihr noch nicht auf der Mailingliste steht.

## Semesterplan

* Vorkenntnisse: Programmierkentnisse und git sind hilfreich.
* Einstieg in haskell
* Besondere Kontrollstrukturen und Bibliotheken
* Ende des Semesters: noch offen 
  * FP-konzepte in anderen Sprachen 
  * Probleme, die für FP besonders geeignet oder ungeeignet sind
  * praktische Projekte
  * Hier könnte deine Idee stehen

## Was ist haskell?

Haskell ist eine pur-funktionale, statisch typisierte, faul ausgewertete Programmiersprache

#### Hä?

* Funktionen haben keine Nebeneffekte, es sei denn, sie wurden deklariert.
* Der Compiler weiß, welchen Typ welcher Ausdruck hat, und wird stinksauer wenn es nicht aufgeht. (feature, not bug)
* Ausdrücke werden nicht direkt ausgewertet, erst wenn ich sie brauche.
  * `[0..]` repräsentiert die unendliche Liste der natürlichen Zahlen
  * Ich kann damit arbeiten (`take 20 [0..]`), aber ich kann sie nicht auswerten.

## Getting started
Alles, was du brauchst, ist ein Texteditor, eine Kommandozeile und ein Compiler. Notepad++ (windows) und gedit (linux) haben Syntax-Unterstützung für haskell. Wir werden den ghc-compiler verwenden. Dieser und viele weitere nützliche tools werden u.A. durch Stack bereitgestellt (https://docs.haskellstack.org/en/stable/README/).

    stack setup
    
installiert dann den aktuellen ghc für euch.

    stack ghci
    
öffnet einen haskell-interpreter (:? für hilfe) und

    stack ghc
    
bietet euch den haskell-compiler. (`stack ghc -- --help` für Hilfe).

## Hilfe, der Compiler hasst mich

* Die üblichen Fehlerquellen erschlagen?
* Cheat sheet abgesucht?
* gerne email an mich
* Nach Auflösung gerne auch eine Anmerkung in den cheat sheet für andere.
