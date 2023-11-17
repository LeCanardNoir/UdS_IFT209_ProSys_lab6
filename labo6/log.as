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
		ldr		s0, [x19]	// base
		ldr		s1, [x20]	// nombre

        
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
		mov		x19, #2		// fractionStep
		fmov	s20, #0		// result
Logarithme_loop:
		cbz		x19, Logarithme_loopEnd

		sub		x19, #2
		cbnz	x19, Logarithme_loop

Logarithme_loopEnd:
		fcvt	d0, s20

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
