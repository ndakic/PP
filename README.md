## MiniC kompajler - MICKO


Prevodi:
	- sa jezika miniC (izvorni jezik)
	- na hipotetski asemblerski jezik (ciljni jezik)

Implementacija:
	- generator skenera: FLEX
	- generator parsera: BISON
	- sav dodatni kod napisan na programskom jeziku C

Faze kompajliranja:
	- Leksička analiza
	- Sintaksna analiza
	- Semantička analiza
	- Generisanje koda
	- Optimizacija


Leksička analiza (skener) - prepoznavanje simbola (reči) - primer: upotreba nedozvoljenih karaktera
Sintaksna analiza (parser) - prepoznavanje iskaza (rečenica) - primer: izostavljanje otvorene zagrade iza IF-a
Semantička analiza - prepoznavanje značenja iskaza (rečenica) - primer: korišćenje nedefinisane promenjive