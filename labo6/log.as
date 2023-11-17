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
		ldr		s1, [x19]	// base
		ldr		s0, [x20]	// nombre

        bl		Logarithme



        adr		x0,ptfmt2	//Param1: adresse du message et format simple précision
       		    			//Param2: A FAIRE!!
		fcvt	d0, s0
		bl 		printf		//Affichage simple précision

MainEnd:
        mov		x0,0		//Code d'erreur 0: aucune erreur
		bl		exit		//Fin du programme



Logarithme:
		SAVE
		fmov	s20, s1		//s20 contient le nombre
		fmov	s19, s0		//s19 contient la base
		ldr		s21, one	//s21 contient la valeur d'exposant pour le calcul de la partie décimale
		ldr		s22, two	//s22 contient 2 en float et ne sera JAMAIS modifié
		ldr		s24, delta
		fadd	s24, s24, s21	//s24 contient 1 + delta

		mov		x28, #0		//x28 contient le total entier
		ucvtf	s27, x28	//s27 contient le total décimal

Log_Entier_LoopCheck:
		fcmp	s20, s19	//Si NombreCourant < Base, on sort de la boucle
		b.lt	Log_Decimal_LoopCheck

		add		x28, x28, #1	//la partie entière du total est incrémentée
		fdiv	s20, s20, s19	//NombreCourant /= Base
		b.al	Log_Entier_LoopCheck	//Retour au début de la boucle

Log_Decimal_LoopCheck:
		fsqrt	s19, s19	// base = sqrt(base)
		fdiv	s21, s21, s22	// valeur d'exposant /= 2
		fcmp	s20, s24	// Si NombreCourant < 1.000001 (précision)
		b.lt	logFin		//STOP

		fcmp	s20, s19	//Si NombreCourant >= Base
		b.lt	Log_Decimal_LoopCheck	//Sinon on revient à la boucle

		fdiv	s20, s20, s19	//NombreCourant /= Base
		fadd	s27, s27, s21	// total décimal += valeur d'exposant
		b.al	Log_Decimal_LoopCheck	//On revient à la boucle

logFin:
		ucvtf	s28, x28		//Conversion de la partie entière du total en float
		fadd	s26, s28, s27	//s26 = Total = Partie entière + Partie décimale du total
		fmov	s0, s26
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
one:.single 0r1.0
two:.single 0r2.0
