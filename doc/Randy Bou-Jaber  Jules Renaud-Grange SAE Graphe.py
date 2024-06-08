#-------------------------------------------------------------------------------
# Name:        SAE 2-02 Exploration algorithmique d'un problème (Graphe)
# Author:      Randy Bou-Jaber & Jules Renaud-Grange
# Created:     16/03/2024
#-------------------------------------------------------------------------------

import copy

# Définition de l'état vide et du dictionnaire d'automates

auto_vide = {
        "alphabet":[],
        "etats": [],
        "transitions":[],
        "I":[],
        "F":[]}

autoMap = {}

# 1 Mots, langages et automates

#1.1 Mots
def pref(u):
    lst = []
    for i in range(len(u)+1) :
        lst.append(u[:i])
    return lst

def suf(u):
    lst = []
    for i in range(len(u)+1):
        lst.append(u[i:])
    return lst

def fact(u):
    lst = []
    for i in range(len(u)+1):
        for j in range(len(u)+1):
            chaine = u[i:j]
            if chaine not in lst :
                lst.append(chaine)
    return lst

def miroir(u):
    chaine=''
    for i in range(1, len(u)+1):
        chaine+=u[-i]
    return chaine

#1.2 Langages
def concatene(l1, l2):
    lst = []
    for u in l1:
        for v in l2:
            chaine=u+v
            lst.append(chaine)
    return lst

def puis(L, n):
    if n == 0:
        return ['']
    else:
        return [w+w2 for w in L for w2 in puis(L, n-1)]

"""On ne peut pas faire de fonctions pour L* car les possibilités de mots sont
infinies."""

def tousmots(l1, longueur):
    lst = []
    for i in range(1,longueur+1):
        lst.extend(puis(l1,i))
    return lst

#1.3 Automates
def defauto():
    automate=dict()
    lst_alphabet=[]
    lst_etat=[]
    lst_transitions=[]
    compte=0
    lst_initiaux=[]
    lst_finaux=[]
    while True:
        lettre=input("Entrez votre alphabet (écrivez 'stop' pour arrêter la saisie)")
        if(lettre == "stop"):
            break
        if lettre not in lst_alphabet and lettre.isalpha() and len(lettre)==1:
            lst_alphabet.append(lettre)
        else:
            print("Erreur : lettre doublon ou incorrecte")
    automate["alphabet"] = lst_alphabet
    while True:
        etat=input("Entrez vos états (écrivez 'stop' pour arrêter la saisie)")
        if(etat == "stop"):
            break
        if etat not in lst_etat and etat.isnumeric():
            lst_etat.append(etat)
        else :
            print("Erreur : état doublon")
    automate["etats"] = lst_etat
    while True:
        compte+=1
        print("Transition", compte)
        etat1=input("Entrez un état (ou entrez 'stop' pour arrêter la saisie)")
        if(etat1 == "stop"):
            break
        par=input("Entrez une lettre")
        etat2=input("Entrez un deuxième état")
        if etat1 in lst_etat and etat2 in lst_etat and par in lst_alphabet:
            lst_transitions.append([etat1, par, etat2])
    automate["transitions"] = lst_transitions
    while True:
        initial=input("Entrez un ou plusieurs états initiaux (entrez 'stop' pour arrêter la saisie)")
        if(initial=="stop"):
            break
        if initial in lst_etat and initial not in lst_initiaux:
            lst_initiaux.append(initial)
        else:
            print("Erreur : état entré doublon ou non présent dans la liste des états déclarés.")
    automate["I"] = lst_initiaux
    while True:
        final=input("Entrez un ou plusieurs états finaux (entrez 'stop' pour arrêter la saisie)")
        if(final=="stop"):
            break
        if final in lst_etat and final not in lst_finaux:
            lst_finaux.append(final)
        else:
            print("Erreur : état entré doublon ou non présent dans la liste des états déclarés.")
    automate["F"] = lst_finaux
    return automate

def lirelettre(etats, transitions, char):
    lst = []
    for etat in etats:
        for i in range(len(transitions)):
            if etat == transitions[i][0]:
                if transitions[i][1] == char and transitions[i][2] not in lst:
                    lst.append(transitions[i][2])
    return lst

def liremot(transitions, etats, mot):
    lst = []
    for etat in etats:
        result = cherche_mot(transitions, etat, mot, 0)
        if result is not False and result not in lst:
            lst.append(result)
    return lst

def cherche_mot(transitions, etat, mot, i):
    if i == len(mot):
        return etat
    for t in transitions:
        if (t[0] == etat and t[1] == mot[i]):
            return cherche_mot(transitions, t[2], mot, i+1)
    return False

def accepte(auto, mot):
    for etat in auto['I']:
        if cherche_accepte_mot(auto,etat,mot,0):
            return True
    return False

def cherche_accepte_mot(auto, etat, mot, i):
    if i == len(mot):
        if etat in auto['F']:
            return True
        else :
            return False
    for t in auto['transitions']:
        if (t[0] == etat and t[1] == mot[i]):
            if cherche_accepte_mot(auto, t[2], mot, i+1):
                return True
    return False

def langage_accept(auto, n):
    lst = []
    for mot in tousmots(auto['alphabet'],n):
        if accepte(auto, mot):
            lst.append(mot)
    return lst

"""On ne peut pas faire un fonction qui renvoie le langage accepté par un automate
car celui-ci peut être infini."""

# 2 Déterminisation
def deterministe(auto):
    if len(auto['I']) > 1:
        return False
    else :
        map = {n: "" for n in auto['etats']}
        for tr in auto['transitions']:
            if tr[1] in map[tr[0]]:
                return False
            map[tr[0]] += tr[1]
    return True

def determinise(auto):
    if auto == auto_vide:
        print("Automate vide, déterminisation impossible.")
        return auto
    new = {
        'alphabet': auto['alphabet'],
        'etats': [],
        'transitions': [],
        'I': [],
        'F': []
    }
    etats_init = list(auto['I'])
    new['etats'].append(etats_init)
    new['I'].append(etats_init)

    queue = [etats_init]
    while queue:
        etat_act = queue.pop(0)
        for lettre in auto['alphabet']:
            etat_suiv = set()
            for etat in etat_act:
                for tr in auto['transitions']:
                    if tr[0] == etat and tr[1] == lettre:
                        etat_suiv.add(tr[2])
            etat_suiv = list(etat_suiv)

            if etat_suiv not in new['etats']:
                new['etats'].append(etat_suiv)
                queue.append(etat_suiv)

            new['transitions'].append([etat_act, lettre, etat_suiv])

    contient_list_vide = False
    for etat in new['etats']:
        if len(etat) == 0:
            contient_list_vide = True
        if any(s in auto['F'] for s in etat):
            new['F'].append(etat)

    if contient_list_vide:
        new['etats'] = retire_les_etats_vides(new['etats'])
        new['transitions'] = retire_les_transitions_vides(new['transitions'])
        new['I'] = retire_les_etats_vides(new['I'])
        new['F'] = retire_les_etats_vides(new['F'])
    return new

def retire_les_etats_vides(etats):
   return [etat for etat in etats if etat != []]

def retire_les_transitions_vides(transitions):
   return [tr for tr in transitions if (tr[0] != [] and tr[2] != [])]

def renommage(auto):
    new = {
        'alphabet': auto['alphabet'],
        'etats': [],
        'transitions': [],
        'I': [],
        'F': []}
    dct = {''.join(map(str, ele)): pos for pos, ele in enumerate(auto['etats'])}
    for etat in auto['etats']:
        etat_str = ''.join(map(str, etat))
        new['etats'].append(dct[etat_str])

    for tr in auto['transitions']:
        etat_i_str = ''.join(map(str, tr[0]))
        etat_f_str = ''.join(map(str, tr[2]))
        new['transitions'].append([dct[etat_i_str],tr[1],dct[etat_f_str]])

    for etat in auto['I']:
        etat_str = ''.join(map(str, etat))
        new['I'].append(dct[etat_str])

    for etat in auto['F']:
        etat_str = ''.join(map(str, etat))
        new['F'].append(dct[etat_str])
    return new

# 3 Complémentation

def complet(auto):
    for etat in auto["etats"]:
        for lettre in auto["alphabet"]:
            if not any(transition[1] == lettre and transition[0] == etat for transition in auto["transitions"]):
                return False
    return True

def complete(auto):
    if auto == auto_vide:
        print("Automate vide, impossible.")
        return auto

    """auto_complet = {
        'alphabet': auto['alphabet'],
        'etats': auto['etats'],
        'transitions': auto['transitions'],
        'I': auto['I'],
        'F': auto['F']
    }"""
    auto_complet = {
        'alphabet': [],
        'etats': [],
        'transitions': [],
        'I': [],
        'F': []
    }

    for lettre in auto['alphabet']:
        auto_complet['alphabet'].append(lettre)
    for etat in auto['etats']:
        auto_complet['etats'].append(etat)
    for transition in auto['transitions']:
        auto_complet['transitions'].append(transition)
    for initial in auto['I']:
        auto_complet['I'].append(initial)
    for final in auto['F']:
        auto_complet['F'].append(final)

    auto_complet["etats"].append(auto_complet["etats"][-1]+1)
    for etat in auto_complet["etats"]:
        for lettre in auto_complet["alphabet"]:
            if not any(transition[1] == lettre and transition[0] == etat for transition in auto_complet["transitions"]):
                auto_complet["transitions"].append([etat, lettre, auto_complet["etats"][-1]])
    return auto_complet

def complement(auto):
    if auto == auto_vide:
        print("Automate vide.")
        return auto

    auto_complement = complete(renommage(determinise(auto)))
    complement = []
    for etat in auto_complement["etats"]:
        if etat not in auto_complement["F"]:
            complement.append(etat)
        else:
            auto_complement["F"].remove(etat)
    auto_complement.update({"F": complement})
    return auto_complement

# 4 Automate Produit

def inter(auto1, auto2):
    if auto1 == auto_vide:
        return auto2
    if auto2 == auto_vide:
        return auto1

    auto_inter = {
        'alphabet': auto1['alphabet'],
        'etats': [],
        'transitions': [],
        'I': [],
        'F': []
    }
    for etat1 in auto1['etats']:
        for etat2 in auto2['etats']:
            if(etat1 in auto1['F'] and etat2 in auto2['F']):
                auto_inter['F'].append((etat1, etat2))
    auto_inter['I'].append((auto1['I'][0], auto2['I'][0]))
    auto_inter['etats'].append(auto_inter['I'][0])
    queue = [auto_inter['I'][0]]
    while queue:
        etat_act = queue.pop(0)
        for lettre in auto_inter['alphabet']:
            arriv1, arriv2 = -1, -1
            etat_suiv = set()
            etat1, etat2 = etat_act
            for transition in auto1['transitions']:
                if transition[0] == etat1 and transition[1] == lettre:
                    arriv1 = transition[2]
            for transition in auto2['transitions']:
                if transition[0] == etat2 and transition[1] == lettre:
                    arriv2 = transition[2]
            if -1 not in (arriv1, arriv2):
                auto_inter['transitions'].append([etat_act, lettre, (arriv1, arriv2)])
            if(arriv1, arriv2) not in auto_inter['etats'] and -1 not in (arriv1, arriv2):
                auto_inter['etats'].append((arriv1, arriv2))
                queue.append((arriv1, arriv2))
    return auto_inter

def difference(auto1, auto2):
    if auto1 == auto_vide:
        return auto2
    if auto2 == auto_vide:
        return auto1

    auto_difference = inter(complete(auto1), complete(auto2))
    if auto_difference is None:
        return None

    final = []
    for etat1 in auto1['F']:
        for etatf in auto1['F']:
            final.append((etat1, etatf))
    auto_difference.update({'F':final})
    return auto_difference

# 5 Propriété de fermeture

def emonde(auto):
    for etat in auto['etats']:
        if not(accessible(auto,etat) and co_accessible(auto,etat)):
            return False
    return True

def accessible(auto, etat):
    etats_accessibles = []
    etats_visites = []
    if etat not in auto["etats"]:
        print("Etat non présent dans la liste des états déclarés de l'automate.")
        return False

    for i in auto["I"]:
        if i == etat:
            return True
        etats_accessibles.append(i)

    while len(etats_accessibles) > 0:
        etat_courant = etats_accessibles.pop(0)
        if etat_courant == etat:
            return True

        for tr in auto["transitions"]:
            if tr[0] == etat_courant and tr[2] not in etats_visites:
                etats_accessibles.append(tr[2])
        etats_visites.append(etat_courant)
    return False

def co_accessible(auto, etat):
    etats_co_accessibles = []
    etats_visites = []
    if etat not in auto["etats"]:
        print("Etat non présent dans la liste des états déclarés de l'automate.")
        return False

    for i in auto["F"]:
        if i == etat:
            return True
        etats_co_accessibles.append(i)

    while len(etats_co_accessibles) > 0:
        etat_courant = etats_co_accessibles.pop(0)
        if etat_courant == etat:
            return True

        for tr in auto["transitions"]:
            if tr[2] == etat_courant and tr[0] not in etats_visites:
                    etats_co_accessibles.append(tr[0])
        etats_visites.append(etat_courant)
    return False

def automate_prefixe(auto):
    if not emonde(auto):
        return None
    new = {
        'alphabet': auto['alphabet'],
        'etats': auto['etats'],
        'transitions': auto['transitions'],
        'I': auto['I'],
        'F': auto['etats']}
    return new

def automate_suffixe(auto):
    if not emonde(auto):
        return None
    new = {
        'alphabet': auto['alphabet'],
        'etats': auto['etats'],
        'transitions': auto['transitions'],
        'I': auto['etats'],
        'F': auto['F']}
    return new

def automate_facteur(auto):
    if not emonde(auto):
        return None
    new = {
        'alphabet': auto['alphabet'],
        'etats': auto['etats'],
        'transitions': auto['transitions'],
        'I': auto['etats'],
        'F': auto['etats']}
    return new

def automate_miroir(auto):
    if not emonde(auto):
        return None
    new = {
        'alphabet': auto['alphabet'],
        'etats': auto['etats'],
        'transitions': retourne_transitions(auto['transitions']),
        'I': auto['F'],
        'F': auto['I']}
    return new

def retourne_transitions(transitions):
    new_transitions = []
    for tr in transitions:
        new_transitions.append([tr[2],tr[1],tr[0]])
    return new_transitions

# 6 Minimisation

def minimise(auto):
    if not deterministe(auto):
        return None
    if auto == auto_vide:
        return auto
    etats_act = [[etat for etat in auto['etats'] if etat not in auto['F']],auto['F']]
    etats_pre = []
    while etats_act != etats_pre:
        etats_pre = copy.deepcopy(etats_act)
        dct = {etat:{'a':None,'b':None} for etat in auto['etats']}

        for tr in auto['transitions']:
            arrive = [etat for etat in etats_act if tr[2] in etat]
            dct[tr[0]][tr[1]] = arrive

        etats_act = []
        temp_dct = {}
        for etat in auto['etats']:
            grp_act = [grp for grp in etats_pre if etat in grp][0]
            grp_a = dct[etat]['a'][0]
            grp_b = dct[etat]['b'][0]
            total = [grp_act,grp_a,grp_b]

            exist = False
            for grp in temp_dct.keys():
                if total == temp_dct[grp]:
                    exist = True
                    temp_dct[grp + str(etat)] = temp_dct.pop(grp)
                    last_grp = [int(char) for char in grp]
                    new_grp = [int(char) for char in (grp + str(etat))]
                    etats_act[etats_act.index(last_grp)] = new_grp
                    break

            if not exist:
                temp_dct[str(etat)] = total
                etats_act.append([etat])

    new ={
        "alphabet": auto['alphabet'],
        "etats": etats_act,
        "transitions":minimise_transitions(etats_act,auto['transitions']),
        "I":minimise_initial(etats_act,auto['I']),
        "F":minimise_final(etats_act,auto['F'])}
    return new

def minimise_transitions(etats,transitions):
    new_transitions = []
    for tr in transitions:
        new_tr = [None,tr[1],None]
        for grp in etats:
            if tr[0] in grp:
                new_tr[0] = grp
            if tr[2] in grp:
                new_tr[2] = grp
        if new_tr not in new_transitions:
            new_transitions.append(new_tr)
    return new_transitions

def minimise_initial(etats,etats_i):
    new_i = []
    for etat in etats_i:
        for grp in etats:
            if etat in grp and grp not in new_i:
                new_i.append(grp)
    return new_i

def minimise_final(etats,etats_f):
    new_f = []
    for etat in etats_f:
        for grp in etats:
            if etat in grp and grp not in new_f:
                new_f.append(grp)
    return new_f

# Annexe (Menu, affichage...)

def affiche_auto(auto):
    print("automate :")
    print("alphabet :\t",auto['alphabet'])
    print("états :\t\t",auto['etats'])
    print("états initiaux :",auto['I'])
    print("états finaux :\t",auto['F'])
    print("transitions :\t",auto['transitions'])

def Lire_Langage():
    alphabet = []
    while True:
        lettre=input("Entrez votre alphabet (écrivez 'stop' pour arrêter la saisie) :")
        if(lettre == "stop"):
            return alphabet
        if lettre not in alphabet and lettre.isalpha() and len(lettre)==1:
            alphabet.append(lettre)
        else:
            print("Erreur : lettre doublon ou incorrecte")

def selectionne_auto():
    user = ''
    while user not in ['Y','N']:
        user = input("voulez-vous selectionner un automate enregistré ? (Y/N):")
    match user:
        case 'Y':
            print("\nchoisir un automate parmi :\n",autoMap.keys())
            user = ''
            while user not in autoMap.keys():
                user = input()
            return autoMap[user]
        case 'N':
            print("création d'un nouvel automate :")
            name = input("nom de l'automate :")
            new_auto = defauto()
            autoMap[name] = new_auto
            return new_auto

def menu():
    user = ''
    while(True):
        print(" ____________________________ ")
        print("| ----- Menu Principal ----- |")
        print("|1: Tests sur un mot         |")
        print("|2: Tests sur un language    |")
        print("|3: Tests sur un automate    |")
        print("|9: Quitter                  |")
        print("|____________________________|")
        user = input()
        match user:
            case '1':
                test_Mot()
                continue
            case '2':
                test_Langage()
                continue
            case '3':
                test_Automate()
                continue
            case '9':
                return

def test_Mot():
    mot = input("entrer un mot :")
    print("préfixes de ",mot," :\n",pref(mot))
    print("suffixes de ",mot," :\n",suf(mot))
    print("facteurs de ",mot," :\n",fact(mot))
    print("miroir de ",mot," : ",miroir(mot))
    print("\n")

def test_Langage():
    user = ''
    while(True):
        print(" ____________________________ ")
        print("| --- Menu: Test Langage --- |")
        print("|1: Concatenation            |")
        print("|2: Mots de longeurs n       |")
        print("|3: Mots de longueur max n   |")
        print("|9: Quitter                  |")
        print("|____________________________|")
        user = input()
        match user:
            case '1': # concatene(l1,l2)
                print("Concatenation :\nlangage 1:")
                langage1 = Lire_Langage()
                print("langage 2:")
                langage2 = Lire_Langage()
                print(concatene(langage1,langage2))
                continue
            case '2': # puis(l,n)
                langage = Lire_Langage()
                n = ''
                while not n.isnumeric():
                    n = input(" longueur des mots :")
                    if not n.isnumeric():
                        print("la longueur doit être un nombre entier.")
                print(puis(langage,int(n)))
                continue
            case '3': # tousmots(l,n)
                langage = Lire_Langage()
                n = ''
                while not n.isnumeric():
                    n = input(" longueur max des mots :")
                    if not n.isnumeric():
                        print("la longueur max doit être un nombre entier.")
                print(tousmots(langage,int(n)))
                continue
            case '9':
                return

def test_Automate():
    user = ''
    while(True):
        print(" ____________________________ ")
        print("| --- Menu: Test Automate -- |")
        print("|1: Lecture d'un automate    |")
        print("|2: Déterminisation          |")
        print("|3: Complémentation          |")
        print("|4: Automate produit         |")
        print("|5: Propriété de fermeture   |")
        print("|6: Minimisation             |")
        print("|9: Quitter                  |")
        print("|____________________________|")
        user = input()
        match user:
            case '1':
                test_Automate_Lecture()
                continue
            case '2':
                rename = ''
                while rename not in ['Y','N']:
                    rename = input("renommage ? (Y/N) :")
                autoUser = selectionne_auto()
                if rename == 'Y':
                    affiche_auto(renommage(determinise(autoUser)))
                else:
                    affiche_auto(determinise(autoUser))
                continue
            case '3':
                test_Automate_complementation()
                continue
            case '4':
                test_Automate_Produit()
                continue
            case '5':
                test_Automate_Propriete_de_Fermeture()
                continue
            case '6':
                rename = ''
                while rename not in ['Y','N']:
                    rename = input("renommage ? (Y/N) :")
                autoUser = selectionne_auto()
                if rename == 'Y':
                    affiche_auto(renommage(minimise(autoUser)))
                else:
                    affiche_auto(minimise(autoUser))
                continue
            case '9':
                return

def test_Automate_Lecture():
    user = ''
    while(True):
        print(" ______________________________ ")
        print("| -- Menu: Lecture Automate -- |")
        print("|1: Lis un mot (facteur)       |")
        print("|2: Accepte un mot             |")
        print("|3: Mots acceptés de taille max|")
        print("|9: Quitter                    |")
        print("|______________________________|")
        user = input()
        match user:
            case '1':
                autoUser = selectionne_auto()
                mot = input("entrer un mot :")
                print(liremot(autoUser['transitions'],autoUser['etats'],mot))
                continue
            case '2':
                autoUser = selectionne_auto()
                mot = input("entrer un mot :")
                print(accepte(autoUser,mot))
                continue
            case '3':
                autoUser = selectionne_auto()
                n = ''
                while not n.isnumeric():
                    n = input(" longueur max des mots :")
                    if not n.isnumeric():
                        print("la longueur max doit être un nombre entier.")
                print(langage_accept(autoUser,int(n)))
                continue
            case '9':
                return

def test_Automate_complementation():
    user = ''
    while(True):
        print(" ______________________________ ")
        print("| -- Menu: Complémentation --- |")
        print("|1: Complète un automate       |")
        print("|2: automate complement        |")
        print("|9: Quitter                    |")
        print("|______________________________|")
        user = input()
        match user:
            case '1':
                autoUser = selectionne_auto()
                affiche_auto(complete(autoUser))
                continue
            case '2':
                autoUser = selectionne_auto()
                affiche_auto(complement(autoUser))
                continue
            case '9':
                return

def test_Automate_Produit():
    user = ''
    while(True):
        print(" ______________________________ ")
        print("| -- Menu: Automate Produit -- |")
        print("|1: Intersection de 2 automates|")
        print("|2: Différence de 2 automates  |")
        print("|9: Quitter                    |")
        print("|______________________________|")
        user = input()
        match user:
            case '1':
                print("automate 1 :")
                autoUser1 = selectionne_auto()
                print("automate 2 :")
                autoUser2 = selectionne_auto()

                rename = ''
                while rename not in ['Y','N']:
                    rename = input("renommage ? (Y/N) :")
                if rename == 'Y':
                    affiche_auto(renommage(inter(autoUser1,autoUser2)))
                else:
                    affiche_auto(inter(autoUser1,autoUser2))
                continue

            case '2':
                print("automate 1 :")
                autoUser1 = selectionne_auto()
                print("automate 2 :")
                autoUser2 = selectionne_auto()

                rename = ''
                while rename not in ['Y','N']:
                    rename = input("renommage ? (Y/N) :")
                if rename == 'Y':
                    affiche_auto(renommage(difference(autoUser1,autoUser2)))
                else:
                    affiche_auto(difference(autoUser1,autoUser2))
                continue

            case '9':
                return

def test_Automate_Propriete_de_Fermeture():
    user = ''
    while(True):
        print(" ______________________________ ")
        print("| Menu: Propriété de fermeture |")
        print("|1: Automate prefixe           |")
        print("|2: Automate suffixe           |")
        print("|3: Automate facteur           |")
        print("|4: Automate miroir            |")
        print("|9: Quitter                    |")
        print("|______________________________|")
        user = input()
        match user:
            case '1':
                autoUser = selectionne_auto()
                result = automate_prefixe(autoUser)
                print("\n")
                affiche_auto(result)
                print("\nAffichage du langage :")
                n = ''
                while not n.isnumeric():
                    n = input(" longueur max des mots :")
                    if not n.isnumeric():
                        print("la longueur max doit être un nombre entier.")
                print(langage_accept(result,int(n)))
                continue
            case '2':
                autoUser = selectionne_auto()
                result = automate_suffixe(autoUser)
                print("\n")
                affiche_auto(result)
                print("\nAffichage du langage :")
                n = ''
                while not n.isnumeric():
                    n = input(" longueur max des mots :")
                    if not n.isnumeric():
                        print("la longueur max doit être un nombre entier.")
                print(langage_accept(result,int(n)))
                continue
            case '3':
                autoUser = selectionne_auto()
                result = automate_facteur(autoUser)
                print("\n")
                affiche_auto(result)
                print("\nAffichage du langage :")
                n = ''
                while not n.isnumeric():
                    n = input(" longueur max des mots :")
                    if not n.isnumeric():
                        print("la longueur max doit être un nombre entier.")
                print(langage_accept(result,int(n)))
                continue
            case '4':
                autoUser = selectionne_auto()
                result = automate_miroir(autoUser)
                print("\n")
                affiche_auto(result)
                print("\nAffichage du langage :")
                n = ''
                while not n.isnumeric():
                    n = input(" longueur max des mots :")
                    if not n.isnumeric():
                        print("la longueur max doit être un nombre entier.")
                print(langage_accept(result,int(n)))
                continue
            case '9':
                return

def ajoute_automate_exemple():
    auto ={
        "alphabet":['a','b'],
        "etats": [1,2,3,4],
        "transitions":[[1,'a',2],[2,'a',2],[2,'b',3],[3,'a',4]],
        "I":[1],
        "F":[4]}
    autoMap['auto'] = auto

    auto0 ={
        "alphabet":['a','b'],
        "etats": [0,1,2,3],
        "transitions":[[0,'a',1],[1,'a',1],[1,'b',2],[2,'a',3]],
        "I":[0],
        "F":[3]}
    autoMap['auto0'] = auto0

    auto1 ={
        "alphabet":['a','b'],
        "etats": [0,1],
        "transitions":[[0,'a',0],[0,'b',1],[1,'b',1],[1,'a',1]],
        "I":[0],
        "F":[1]}
    autoMap['auto1'] = auto1

    auto2 ={
        "alphabet":['a','b'],
        "etats": [0,1],
        "transitions":[[0,'a',0],[0,'a',1],[1,'b',1],[1,'a',1]],
        "I":[0],
        "F":[1]}
    autoMap['auto2'] = auto2
    
    auto3 ={
        "alphabet":['a','b'],
        "etats": [0,1,2],
        "transitions":[[0,'a',1],[0,'a',0],[1,'b',2],[1,'b',1]], 
        "I":[0],
        "F":[2]}
    autoMap['auto3'] = auto3

    auto4 ={ 
        "alphabet":['a','b'],
        "etats": [0,1,2],
        "transitions":[[0,'a',1],[1,'b',2],[2,'b',2],[2,'a',2]],
        "I":[0],
        "F":[2]}
    autoMap['auto4'] = auto4
    
    auto5 ={ 
        "alphabet":['a','b'],
        "etats": [0,1,2],
        "transitions":[[0,'a',0],[0,'b',1],[1,'a',1],[1,'b',2],[2,'a',2],[2,'b',0]],
        "I":[0],
        "F":[0,1]}
    autoMap['auto5'] = auto5

    auto6 ={
        "alphabet":['a','b'],
        "etats": [0,1,2,3,4,5],
        "transitions":[[0,'a',4],[0,'b',3],[1,'a',5],[1,'b',5],[2,'a',5],[2,'b',2],[3,'a',1],[3,'b',0],[4,'a',1],[4,'b',2],[5,'a',2],[5,'b',5]],
        "I":[0],
        "F":[0,1,2,5]}
    autoMap['auto6'] = auto6
    
    autoPerso ={
        "alphabet":['a','b','c'],
        "etats": [1,2,3,4],
        "transitions":[[1,'a',2],[2,'a',2],[2,'b',3],[3,'c',4]],
        "I":[1],
        "F":[4]}
    autoMap['autoPerso'] = autoPerso  

if __name__ == '__main__':
    ajoute_automate_exemple()
    menu()