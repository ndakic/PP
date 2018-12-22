# Programski prevodioci


##### Zadatak programskih prevodioca je da prevede programe koju su napisani jednim (izvornim) programskim jezikom u programe istog značenja koji su napisani u drugim (ciljnim) programskim jezikom.

## Faze kompajliranja:
- Leksička analiza
- Sintaksna analiza
- Semantička analiza
- Generisanje koda
- Optimizacija

### Leksička analiza

Prepoznavanje simbola (reči). <br>
Otkrivanje pogrešnih simbola -> leksičke greške. <br>
primer: upotreba nedozvoljenih karaktera npr. cou#nt 

Za nju je zadužen skener. <br>
Skener preuzima znak po znak ulaznog teksta i pokušava da prepozna simbol.<br>

## Sintaksna analiza

Prepoznavanje iskaza (rečenica). <br>
Otkrivanje pogrešnih iskaza. Sintaksne greške. <br>
primer: izostavljanje otvorene male zagrade iza if iskaza. <br>

Zadatak parsera je da proveri da li je ulazni niz simbola u skladu sa gramatikom.

## Semantička analiza

Prepoznavanje značenja iskaza (rečenica). <br>
Otkrivanje semantički pogrešnih iskaza -> semantičke greške <br>
primer: korišćenje nedefinisane promenjive. <br>