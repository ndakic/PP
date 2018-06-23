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
Prepoznavanje simbola vrši uz pomoć dijagrama prelaza. <br>
Dijagram prelaza je usmereni graf u čiji sastav ulaze:
- čvorovi koji predstavljaju stanja skenera
- usmerene veze između čvorova koje ukazuju na moguće prelaze iz jednog u drugo stanje
- labele usmerenih veza
- znakovi od kojih se mogu obrazovati labele

Podrazumeva se da početno stanje skenera odgovara početnom čvoru. <br>
Skener radi tako što preuzima znak i proverava da li on odgovara nekoj labeli (stanju) koja izlazi iz trenutnog čvora. <br>
Ako odgovara, skener prelazi u to stanje. <br>
Ako ne odgovara, tada je otkrivena leksička greška. <br>

Dijagram prelaza može biti prikazan i u obliku tabele prelaza. <br>
A tabela prelaza se može definisati gramatikom simbola. <br>
Za ovu svrhu se koriste regularne gramatike. <br>
Njihova pravila imaju oblik regularnih definicija: 
- Ime vrste simbola
- Opis simbola u formi regularnog izraza

Generator skenera

Pomoću regularnih izaza mogu opisati simboli a to je dovoljno za automatsko generisanje tabele prelaza. <br>
Primeri generatora skenera: 
- Lex
- Flex


## Sintaksna analiza

Prepoznavanje iskaza (rečenica). <br>
Otkrivanje pogrešnih iskaza. Sintaksne greške. <br>
primer: izostavljanje otvorene male zagrade iza if iskaza. <br>

Zadatak parsera je da proveri da li je ulazni niz simbola u skladu sa gramatikom.

	niz karaktera -> skener -> niz tokena -> parser -> da/ne + stablo parsiranja

Gramatika jezika se izvršava na formalan način u BNF obliku. <br>
BNF gramatika se sastoji od pravila koja određuju dozvoljene načine ređanja pojmova i simbola. <br>

Pravilo ima:
			- levu stranu
			- desnu stranu
	Leva strana pravila može biti zamenjena sekvencom pojmova koju sadrži desna strana pravila.

Postoje dve metode parsiranja:
- Silazno parsiranje: Leva strana pravila se zamenjuje desnom. Pokušaj da se iz polaznog pojma gramatike po njenim pravilima izvede niz simbola identičan ulaznom nizu simbola.
			- sa leva: u svakom koraku se zamenjuje krajnje levi pojam.
			- sa desna: u svakom koraku se zamenjuje krajnje desni pojam.
- Uzlazno parsiranje: Desna strana pravila se zamenjuje levom. Pokušaj da se ulazni niz simbola redukuje (sažme) po pravilima gramatike u njen polazni pojam.
* Parser pokušava da prepozna desnu stranu pravila i da je sažme u levu stranu pravila gramatike,
								  sve dok ne stigne do polaznog pojma.

LR Parseri (left to right)
- koriste uzlazno parsiranje
- mogu se automatski izgenerisati ako se na osnovu zadate gramatike automatski proizvede tabela akcija i prelaza i tako definiše
	ponašanje generisanog LR parsera. To je zadatak Generatora LR parsera.

Parser (generator LR parsera) 
- Domet generisanog LR parsera je prepoznavanje ispravnih ili pogrešnih nizova simbola.
- primeri generatora LR parsera su: 
		- BISON kompajler
		- YACC kompajler



MiniC Kompajler - MICKO

Prevodi: 
- sa jezika miniC
- na hipotetski asemblerski jezik

Implementacija:
- Generator skenera: FLEX
- Generator parsera: BISON


## Semantička analiza

Prepoznavanje značenja iskaza (rečenica). <br>
Otkrivanje semantički pogrešnih iskaza -> semantičke greške <br>
primer: korišćenje nedefinisane promenjive. <br>


Značenje (semantika) programskog jezika se opisuje na neformalan način.

Semantička pravila za MiniC:
- Standardni identifikatori
- Opseg vidljivosti identifikatora
- Identifikatori mogu biti vidljivi samo iza njihove definicije
- Jednoznačnost identifikatora
- Ispravnost korišćenja identifikatora
- Provera tipova

Organizacija memorije za MiniC:
- Globalni identifikatori su statični: postoje sve vreme izvršavanja programa
- Lokalni identifikatori su dinamički:
  - postoje samo za vreme izvršavanja funkcija
  - zbog toga im se dodaje memorijska lokacija sa steka

(Stek) frejm = deo steka koji se zauzima za izvršavanje neke funkcije.

		argument n
		argument 1
		povratna adresa
		prethodni pokazivač frejma	   <- %14 frejm pokazivač
		lokalna promenjiva 1
		lokalna promenjiva m           <- %15  Stek pokazivač

Argumenti i lokalne promenjive se adresiraju u od na %14 (frejm pokazivač).
Jer se u vreme kompilacije ne znaju apsolutne adrese parametara i lokalnih promenjivih.

Tabela simbola:
- čuva sve identifikatore iz kompajliranog programa
- i sve informacije o tim identifikatorima
- rukuje sa njom pomoću više operacija -> ubaci, pretraži, ispiši, izbriši element 


Leksička analiza - SKENER <br>
Deli ulazni string na simbole programskog jezika npr. ključna reč, ime promenljive ili broj

Sintaksna analiza - PARSER <br>
Proverava da li su simboli navedeni u ispravnom redosledu tokom parsiranja se pravi stablo parsiranja koje odražava. strukturu programa npr. nedostaje otvorena mala zagrada ili tačka-zarez.

Semantička analiza - PARSER <br>
Proverava konzistentnost programa npr. da li je promenljiva, koja se koristi, prethodno deklarisana i da li se koristi u skladu sa svojim tipom.

Generisanje koda - PARSER <br>
Prevodi program na ciljni jezik: hipotetski asemblerski jezik


MICKO - Tabela simbola: Sve faze kompajliranja koriste tabelu simbola.



#### Hipotetski asemblerski jezik

Podrazumeva se da registri i memorijske lokacije zauzimaju po 4 bajta.
Ukupno ima 16 registara.

%0, %1 - redni broj (oznaka) registra
%0 - %12 - radni registri : za opštu namenu.
registar %13 - služi za povratu vrednost funckije
registar %14 - služi kao pokazivač frejma
registar %15 - služi kao pokazivač steka

labela - main:
sistemska labela - @exit1:
$5, %24 - odgovara celim brojevima (neposredni operand)
$lablea - odgovara adresi labele

(%0) - odgovara navedenoj oznaci registra a njegova vrednost sadržaju memorijske lokacije. (indirekti operand)
        -8(%14), 4(%14) - indeksni operand

CMPX - naredba poređenja
     format: CMPX ulazni operand, ulazni operand
     x: s - označeni, u - neoznačeni, f - realni

JMP ulazni operand - naredba bezuslovnog skoka, smešta u programski brojač vrednost ulaznog operanda, omogućujući tako
nastavak izvršavanja od ciljne naredbe koju adresira ova vrednost.

JEQ, JNE, JGTx, JLTX, JGEx, JLEx ulazni operand - naredbe uslovnog skoka, smeštaju vrednostu u programski brojač
samo ako je ispunjen uslov.

PUSH ulazni operand, POP izlazni operand - naredbe rukovanja stekom - omogućuju smeštanje na vrh steka vrednost ulaznog
operanda, odnosno preuzimanje vrednosti sa vrha steka i njeno smeštanje u izlazni operand. <br>
Podrazumeva se da %15 služi kao pokazivač steka.

CALL ulazni operand - naredba poziva podprograma smešta na vrh steka zatečeni sadržaj programskg brojača, a u programski
brojač smešta vrednost ulaznog operanda.

RET - naredba povratka iz podprograma, preuzima vrednost sa vrha steka i smešta je u programski brojač.

ADDx, SUBx, MULx, DIVx ulazni operand, ulazni operand, izlazni operand - naredbe za sabiranje, oduzimanje, množenje i
deljenje operanada.

MOV ulazni operand, izlazni operand - naredba za prebacivanje vrednosti.

TOF, TOI - naredbe za konverziju

WORD n - direktiva zauzima n memorijskih lokacija

free_reg_num - na osnovu ove promenjive se zauizimaju i oslobađaju registri.
var_num	- brojač lokalnih promenjivih
lab_num - aktuelni broj labele

#### Međukod

Faze kompajliranja
- front-end:
  - leksička analiza
  - sintaksna analiza
  - semantička analiza
- back-end:
  - generisanje koda
  - optimizacija                         

Faze kompajliranja se grupišu na:
- faze zavisne od izvornog jezika (analiza) pripadaju prednjem modulu kompajlera (front-end)
- faze zavisne od ciljnog jezika (sinteze) pripadaju zadnjem modulu kompajlera (back-end)

Praktična važnost podele kompjalera na prednji i zadnji modul:
  - prevođenje sa jednog izvornog jezika na više ciljnih
  - prevođenje sa više izvornih jezika na jedan ciljni
  - olakšano prilagođavanje kompajlerima novim zahtevima i okolnostima 

Komunikacija prednjeg i zadnjeg modula kompajlera
  - podrazumeva uvođenje međukoda

Međukod predstavlja: 
- ciljni jezik za prednji modul kompajlera
- izvorni jezik za zadnji modul kompajlera

Međujezik - jezik između izvornog jezika i ciljnog jezika.
- na nivou apstrakcije:	
   - više detalja od izvornog jezika
   - manje detalja od ciljnog jezika

Uvođenje međukoda dovodi do pojave faze generisanja međukoda i podele faze optimizacije na dve posebne faze.
Za međukod je važno da olakša implementaciju faza generisanja međukoda i koda, kao i faze optimizacije.

Pregled faze kompajliranja:
- front-end
  - Leksička analiza 
  - Sintaksna analiza
  - Semantička analiza
  - Generisanje međukoda
  - Optimizacija međukoda
- back-end
  - Generisanje koda
  - Optimizacija koda

Kompajler može sadržati samo prednji modul
  - tada je njegov ciljni jezik međukod koga izvršava poseban program - interpreter (liniju po liniju prevodi i odmah je izvrši).


Osvrt na kompajlere

Na osnovu broja prolaza, kompajleri mogu biti:
- jednoprolazni - sve faze u jednom prolazu.
- dvoprolazni - prvi prolaz odgovara prednjem modulu a drugi zadnjem.

Kompajleri čiji ciljni jezik ne pripada računaru na kome se oni izvršavaju se nazivaju kros-kompajleri (cross-compiler)
Postupak u kome kompajler kompajlira sam sebe ili neku svoju verziju ili drugi kompajler se naziva bootstraping je uobičajen u
toku pravljenja kompajlera za drugi računar ili za usavršavanje kompajlera za isti računar.
