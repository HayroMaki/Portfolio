#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Structures :
struct rationnel{
    int num;
    int den;};
typedef struct rationnel Rationnel;

struct polynome{
    int degre;
    Rationnel * poly;};
typedef struct polynome Polynome;

// Fonctions principales :
Polynome lirePolynome();
void afficherPolynome(Polynome);
Polynome sommePolynome(Polynome, Polynome);
Polynome produitPolynome(Polynome, Polynome);
Rationnel evaluerPolynome(Polynome, int);
Polynome deriveePolynome(Polynome);

// Fonctions secondaires :
int pgcd(int, int);
void afficheRationnel(Rationnel);
Rationnel simplifier(Rationnel);
Rationnel sommeRationnel(Rationnel, Rationnel);
Rationnel produitRationnel(Rationnel, Rationnel);

// Menu :
void menu();
void testEvaluerPolynome(Polynome);
void testSommePolynome(Polynome);
void testProduitPolynome(Polynome);


int main() {
    menu();
    return 0;
}

// Fonctions principales :

Polynome lirePolynome() {
    Polynome p;
    // Demande le degré à l'utilisateur et alloue la mémoire en fonction :
    printf("Degre du polynome : ");
    scanf("%d", &p.degre);
    p.poly = malloc((p.degre + 1) * sizeof(Rationnel));

    // Remplit la liste de Rationnels :
    printf("Coefficients du polynome (numerateur/denominateur) :\n");
    for (int i = 0; i <= p.degre; i++) {
        printf("Coefficient de x^%d : ", i);
        scanf("%d/%d", &(p.poly[i].num), &(p.poly[i].den));

        // simplifie le Rationnel :
        p.poly[i] = simplifier(p.poly[i]);
    }
    return p;
}

void afficherPolynome(Polynome p) {
    // Parcours à l'envers en partant du degré du Polynome :
    for (int i = p.degre; i >= 0; i--) {

        // affiche le signe :
        if (i < p.degre) {
            printf(" + ");
        }

        // affiche le Rationnel :
        if (p.poly[i].den != p.poly[i].num || i == 0) {
            afficheRationnel(p.poly[i]);
        }

        //affiche x et sa puissance :
        if (i > 0) {
            printf("x");
            if (i > 1) {
                printf("^%d", i);
            }
        }
    }
    printf("\n");
}

Polynome sommePolynome(Polynome p1, Polynome p2) {
    Polynome p;
    // Détermine le degré du Polynome résultat et alloue la mémoire en fonction :
    p.degre = (p1.degre > p2.degre) ? p1.degre : p2.degre; // = max(p1.degre, p2.degre);
    p.poly = malloc((p.degre + 1) * sizeof(Rationnel));

    // calcul de la somme :
    for (int i = 0; i <= p.degre; i++) {

        // si les coefficients sont du même degré, on fait la somme :
        if (i <= p1.degre && i <= p2.degre) {
            p.poly[i] = sommeRationnel(p1.poly[i], p2.poly[i]);
        }

        // si on a que p1, on le copie :
        else if (i <= p1.degre) {
            p.poly[i] = p1.poly[i];
        }

        // si on a que p2, on le copie :
        else {
            p.poly[i] = p2.poly[i];
        }

        // simplifie le Rationnel :
        p.poly[i] = simplifier(p.poly[i]);
    }
    return p;
}

Polynome produitPolynome(Polynome p1, Polynome p2) {
    Polynome resultat;
    Rationnel *polyList;

    // Calcul le degré du Polynome résultat,
    // alloue la mémoire en fonction du degré
    // et initialise tous les Rationnels à 0 :
    resultat.degre = p1.degre + p2.degre;
    polyList = (Rationnel *)malloc((resultat.degre + 1) * sizeof(Rationnel));
    for (int i = 0; i <= resultat.degre; i++) {
        polyList[i].num = 0;
        polyList[i].den = 1;
    }

    // calcul le produit :
    int degre;
    for (int i = 0; i <= p1.degre; i++) {
        for (int j = 0; j <= p2.degre; j++) {
            degre = i + j;

            // aditionne le Rationnel actuelle de tempPoly[newDegre] au produit des Rationnels à i et j :
            polyList[degre] = sommeRationnel(polyList[degre], produitRationnel(p1.poly[i], p2.poly[j]));

            // simplifie le Rationnel :
            polyList[degre] = simplifier(polyList[degre]);
        }
    }
    resultat.poly = polyList;
    return resultat;
}

Rationnel evaluerPolynome(Polynome p, int x) {
    Rationnel resultat;
    resultat.num = 0;
    resultat.den = 1;

    // pour chaque Rationnel, multiplie par x^i et fais la somme afin d'obtenir un seul Rationnel en sortie :
    Rationnel temp;
    for (int i = 0; i <= p.degre; i++) {
        temp.den = p.poly[i].den;
        temp.num = p.poly[i].num * pow(x, i);
        resultat = sommeRationnel(resultat, temp);
    }

    // renvoi le Rationnel simplifié :
    return simplifier(resultat);
}

Polynome deriveePolynome(Polynome p) {
    Polynome resultat;

    // Détermine le degré du Polynome de sortie et alloue la mémoire en fonction :
    resultat.degre = p.degre - 1;
    resultat.poly = (Rationnel *)malloc((resultat.degre + 1) * sizeof(Rationnel));

    // Parcours en ignorant le degré 0 et multiplie le numérateur par i :
    for (int i = 1; i <= p.degre; i++) {
        resultat.poly[i - 1].num = p.poly[i].num * i;
        resultat.poly[i - 1].den = p.poly[i].den;

        // simplifie le Rationnel :
        resultat.poly[i - 1] = simplifier(resultat.poly[i - 1]);
    }

    return resultat;
}

// Fonctions secondaires :

int pgcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return pgcd(b, a % b);
}

void afficheRationnel(Rationnel r) {
    // Si le dénominateur est égal à 1,
    // on l'affiche sous forme d'entier :
    if (r.den == 1) {
        printf("%d", r.num);
    } else {
        printf("%d/%d", r.num, r.den);
    }
}

Rationnel simplifier(Rationnel r) {
    int pgcd_num_den = pgcd(r.num, r.den);
    r.num /= pgcd_num_den;
    r.den /= pgcd_num_den;
    return r;
}

Rationnel sommeRationnel(Rationnel r1, Rationnel r2) {
    Rationnel result;
    result.num = r1.num * r2.den + r1.den * r2.num;
    result.den = r1.den * r2.den;
    return simplifier(result);
}

Rationnel produitRationnel(Rationnel r1, Rationnel r2) {
    Rationnel result;
    result.num = r1.num * r2.num;
    result.den = r1.den * r2.den;
    return simplifier(result);
}

// Menu :

void menu() {
    Polynome p1 = lirePolynome();
    // Affichage du menu :
    while (1) {
        printf("\n\n");
        printf("p1(x) = ");
        afficherPolynome(p1);
        printf(" ___________________________________ \n");
        printf("|- -- --- Menu de selection --- -- -|\n");
        printf("|                                   |\n");
        printf("|1. Valeur a x du Polynome          |\n");
        printf("|2. Derivee du Polynome             |\n");
        printf("|3. Somme de deux Polynomes         |\n");
        printf("|4. Produit de deux Polynomes       |\n");
        printf("|                                   |\n");
        printf("|9. Quitter                         |\n");
        printf("|___________________________________|\n");

        // Detection du choix de l'utilisateur :
        int user;
        scanf("%i",&user);
        switch (user) {
            case 1:
                testEvaluerPolynome(p1);
                continue;
            case 2:
                printf("\nderivee de p1(x) : ");
                afficherPolynome(deriveePolynome(p1));
                continue;
            case 3:
                testSommePolynome(p1);
                continue;
            case 4:
                testProduitPolynome(p1);
                continue;
            case 9:
                return;
            default:
                continue;
        }
    }
}

void testEvaluerPolynome(Polynome p) {
    int x;
    printf("Valeur de x : ");
    scanf("%d", &x);
    Rationnel rat = evaluerPolynome(p,x);
    printf("valeur de p1(%d) : ",x);
    afficheRationnel(rat);
}

void testSommePolynome(Polynome p1) {
    Polynome p2 = lirePolynome();
    afficherPolynome(p2);
    printf("somme de p1 et p2 :");
    afficherPolynome(sommePolynome(p1,p2));
}

void testProduitPolynome(Polynome p1) {
    Polynome p2 = lirePolynome();
    afficherPolynome(p2);
    printf("produit de p1 et p2 :");
    afficherPolynome(produitPolynome(p1,p2));
}