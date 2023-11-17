/*******************************************************************************
	Ce programme est un exemple d'un calcul simple qui utilise les
	opérations à virgule flottante.

	Calcule le logarithme d'un nombre simple précision lu au clavier, puis
	affiche le résultat à l'écran en double précision.

	Entrées:
		(clavier) Nombre duquel on veut calculer le logarithme (float)
		(clavier) Base du logarithme (float)

	Sorties:
		(écran)	Racine carrée simple précision (double)




	Auteur: Mikaël Fortin

	Note importante sur le format %f:
	En lecture (pour scanf), %f sera toujours simple précision.
	En écriture, (pour printf), %f sera toujours double précision.
*******************************************************************************/


.include "/root/SOURCES/ift209/tools/ift209.as"
.global Main


.section ".text"



Main:
		SAVE				//Sauvegarde l'environnement de l'appelant

		adr		x0,ptfmt1	//Param1: adresse du message à afficher
		bl		printf		//Affiche le message initial

		adr		x0,scfmt1	//Param1: adresse du format de lecture
		adr		x1,scantemp	//Param2: Place l'adresse du tampon dans x0
		mov		x19,x1		//Conserve l'adresse du tampon dans x19
		add		x2,x19,4	//2ième pointeur
		mov		x20, x2
		bl		scanf		//Lecture d'un float au clavier

                            //Récupère les valeurs float A FAIRE!!!	
		ldr		s0, [x20]	// base
		ldr		s1, [x19]	// nombre

        
        bl		Logarithme

		
                
        adr		x0,ptfmt2	//Param1: adresse du message et format simple précision
       		    			//Param2: A FAIRE!!
		//fcvt	d0, s0
		//fcvt	d1, s1
		bl 		printf		//Affichage simple précision

MainEnd:
        mov		x0,0		//Code d'erreur 0: aucune erreur
		bl		exit		//Fin du programme



Logarithme:
	SAVE
		// s0 == base, s1 == nombre
		ldr		s3, zeroFloat		// s1 / s0
		ldr		s4, zeroFloat		// result
		ldr		s5, zeroFloat		// rootSqurt(s0) recurcive
		ldr		s6, oneFloat		// chiffre 1
Logarithme_loopInt:
		fdiv	s3, s1, s0
		fadd	s4, s4, s6
		fcmp	s3, s0
		b.lt	Logarithme_loopFloat
		b.al	Logarithme_loopInt

Logarithme_loopFloat:



Logarithme_loopEnd:
		fcvt	d0, s4

logFin:
	RESTORE
	ret


/* Formats de lecture et d'écriture pour printf et scanf */
.section ".rodata"

ptfmt1:		.asciz "Entrez deux nombres simple précision:"
ptfmt2:		.asciz "Le logarithme calculé en double précision est: %f\n"
scfmt1:		.asciz "%f%f"


/* Espace réservé pour recevoir le résultat de scanf. */

.section ".bss"

			.align 	 4
scantemp:	.skip	 8

.section ".data"

delta:.single 0r0.00001
zeroFloat: 		.single 0r0
oneFloat: 		.single 0r1
