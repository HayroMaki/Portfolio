-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u1
-- https://www.phpmyadmin.net/
--
-- Hôte : 10.2.0.5
-- Généré le : mer. 10 jan. 2024 à 22:09
-- Version du serveur :  5.7.30-log
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jules.renaud-grange_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `Atteinte`
--

CREATE TABLE `Atteinte` (
  `Code` varchar(8) NOT NULL,
  `libelle` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Atteinte`
--

INSERT INTO `Atteinte` (`Code`, `libelle`) VALUES
('CT', 'Continental'),
('MD', 'Mondial'),
('NA', 'National'),
('RG', 'Régional');

-- --------------------------------------------------------

--
-- Structure de la table `Club`
--

CREATE TABLE `Club` (
  `Nom` varchar(50) NOT NULL,
  `DateCreation` date DEFAULT NULL,
  `NomPresident` varchar(50) DEFAULT NULL,
  `Nationalite` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Club`
--

INSERT INTO `Club` (`Nom`, `DateCreation`, `NomPresident`, `Nationalite`) VALUES
('Fnatic', '2004-07-23', 'Sam Mathews', 'GB'),
('G2 Esport', '2013-01-01', 'Alban Dechelotte', 'DE'),
('Karmine Corp', '2020-11-16', 'Arthur Perticoz', 'FR'),
('SK Telecom T1', '2004-01-01', 'Joe Marsh', 'KR'),
('Team Vitality', '2013-08-05', 'Nicolas Mauer', 'FR');

-- --------------------------------------------------------

--
-- Structure de la table `Contrat`
--

CREATE TABLE `Contrat` (
  `IDJ` varchar(5) DEFAULT NULL,
  `IDE` varchar(10) DEFAULT NULL,
  `DateDebut` date NOT NULL,
  `DateFin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Contrat`
--

INSERT INTO `Contrat` (`IDJ`, `IDE`, `DateDebut`, `DateFin`) VALUES
('00002', 'FNC', '2011-01-01', '2017-01-01'),
('00001', 'SKT T1', '2013-01-01', NULL),
('00004', 'FNC', '2021-01-01', NULL),
('00003', 'Kcorp', '2022-10-02', NULL),
('00005', 'Kcorp', '2022-10-02', '2023-09-16'),
('00006', 'Kcorp', '2021-07-26', '2023-09-16'),
('00007', 'Kcorp', '2022-04-19', '2023-09-16'),
('00008', 'Vitality', '2020-01-15', NULL),
('00009', 'Vitality', '2022-04-16', NULL),
('00010', 'Vitality', '2022-10-02', NULL),
('00011', 'Vitality', '2022-10-02', '2023-07-09'),
('00012', 'Vitality', '2022-03-30', '2023-09-22');

-- --------------------------------------------------------

--
-- Structure de la table `Equipe`
--

CREATE TABLE `Equipe` (
  `ID` varchar(10) NOT NULL,
  `Nom` varchar(50) DEFAULT NULL,
  `DateCreation` date DEFAULT NULL,
  `DateDissolution` date DEFAULT NULL,
  `Nationalite` varchar(2) DEFAULT NULL,
  `Club` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Equipe`
--

INSERT INTO `Equipe` (`ID`, `Nom`, `DateCreation`, `DateDissolution`, `Nationalite`, `Club`) VALUES
('47R', '47Ronins', NULL, NULL, 'FR', NULL),
('BDS', 'Team BDS', NULL, NULL, NULL, NULL),
('COMPLEX', 'Complexity', '2018-03-01', NULL, 'US', NULL),
('FALCONS', 'Team Falcons', NULL, NULL, NULL, NULL),
('Faze', 'Faze Clan', '2021-03-19', NULL, 'US', NULL),
('FNC', 'Fnatic', '2004-01-01', NULL, 'GB', 'Fnatic'),
('G2', 'G2 ESport', '2016-09-07', NULL, 'DE', 'G2 Esport'),
('GG', 'Gen.G Mobil1', '2022-09-28', NULL, 'US', NULL),
('Kcorp', 'Karmine Corp', '2020-03-30', NULL, 'FR', 'Karmine Corp'),
('KRU', 'Krü ESport', '2021-10-14', '2023-11-28', 'AR', NULL),
('LIQUID', 'Team Liquid', NULL, NULL, NULL, NULL),
('Moist', 'Moist ESport', '2022-05-05', NULL, 'US', NULL),
('NIP', 'Ninjas in Pyjamas', NULL, NULL, NULL, NULL),
('RuleOne', 'Rule One', '2022-10-26', NULL, 'US', NULL),
('SECRET', 'Team Secret', NULL, NULL, 'BR', NULL),
('SKT T1', 'SK Telecom T1', '2004-01-01', NULL, 'KR', 'SK Telecom T1'),
('SSG', 'Spacestation Gaming', '2018-02-14', NULL, 'US', NULL),
('TwMinds', 'Twisted Minds', '2022-03-25', NULL, NULL, NULL),
('Vitality', 'Team Vitality', '2018-02-12', NULL, 'FR', 'Team Vitality');

-- --------------------------------------------------------

--
-- Structure de la table `Genre`
--

CREATE TABLE `Genre` (
  `Code` varchar(5) NOT NULL,
  `Libelle` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Genre`
--

INSERT INTO `Genre` (`Code`, `Libelle`) VALUES
('FOOT', 'Jeux de Football'),
('FPS', 'Jeux de tir tactique'),
('JA', 'Jeux d\'action'),
('MOBA', 'Jeux d\'arène en ligne'),
('RACE', 'Jeux de Course');

-- --------------------------------------------------------

--
-- Structure de la table `GenreJeu`
--

CREATE TABLE `GenreJeu` (
  `CodeJ` varchar(10) DEFAULT NULL,
  `CodeG` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `GenreJeu`
--

INSERT INTO `GenreJeu` (`CodeJ`, `CodeG`) VALUES
('CS-GO', 'FPS'),
('VAL', 'FPS'),
('LoL', 'MOBA'),
('RL', 'JA'),
('RL', 'FOOT'),
('RL', 'RACE');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `Historique jeu des joueur`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `Historique jeu des joueur` (
`Pseudo_joueur` varchar(50)
,`Jeu` varchar(50)
,`Mode_jeu` varchar(50)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `Historique Tournois`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `Historique Tournois` (
`Pseudo` varchar(50)
,`Equipe` varchar(50)
,`role` varchar(50)
,`Club` varchar(50)
,`Tournoi` varchar(50)
,`Date debut tournoi` date
,`Date fin tournoi` date
,`Jeu` varchar(50)
,`Mode de jeu` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure de la table `Jeu`
--

CREATE TABLE `Jeu` (
  `Code` varchar(10) NOT NULL,
  `Nom` varchar(50) DEFAULT NULL,
  `DateCreation` date DEFAULT NULL,
  `Développeur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Jeu`
--

INSERT INTO `Jeu` (`Code`, `Nom`, `DateCreation`, `Développeur`) VALUES
('CS-GO', 'Counter Strike Global Offensive', '2012-08-21', 'Valve'),
('LoL', 'League of legends', '2009-10-27', 'Riot Games'),
('RL', 'Rocket League', '2015-07-07', 'Psyonix'),
('VAL', 'Valorant', '2020-06-20', 'Riot Games');

-- --------------------------------------------------------

--
-- Structure de la table `Jouer`
--

CREATE TABLE `Jouer` (
  `ID_joueur` varchar(5) NOT NULL,
  `ID_modejeu` varchar(10) NOT NULL,
  `codeJ` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Jouer`
--

INSERT INTO `Jouer` (`ID_joueur`, `ID_modejeu`, `codeJ`) VALUES
('00001', '5V5', 'LoL'),
('00002', '5V5', 'LoL'),
('00003', '3V3', 'RL'),
('00005', '3V3', 'RL'),
('00006', '3V3', 'RL'),
('00007', '3V3', 'RL'),
('00008', '3V3', 'RL'),
('00009', '3V3', 'RL'),
('00010', '1V1', 'RL'),
('00010', '3V3', 'RL'),
('00011', '3V3', 'RL'),
('00012', '3V3', 'RL'),
('00004', '5V5', 'VAL');

-- --------------------------------------------------------

--
-- Structure de la table `Joueur`
--

CREATE TABLE `Joueur` (
  `ID` varchar(5) NOT NULL,
  `Pseudo` varchar(50) DEFAULT NULL,
  `Nom` varchar(50) DEFAULT NULL,
  `Prenom` varchar(50) DEFAULT NULL,
  `Nationalite` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Joueur`
--

INSERT INTO `Joueur` (`ID`, `Pseudo`, `Nom`, `Prenom`, `Nationalite`) VALUES
('00001', 'Faker', 'Sang-hyeok', 'Lee', 'KR'),
('00002', 'xPeke', 'Martinez', 'Enrique', 'ES'),
('00003', 'Vatira', 'Touret', 'Axel', 'FR'),
('00004', 'Alfajer', 'Beder', 'Emir', 'TR'),
('00005', 'ExoTiiK', 'Bigeard', 'Brice', 'FR'),
('00006', 'itachi', 'Benayachi', 'Amine', 'MA'),
('00007', 'Eversax', 'Wagner', 'Benjamin', 'BE'),
('00008', 'Alpha54', 'Champenois', 'Yanis', 'FR'),
('00009', 'Radosin', 'Radovanovic', 'Andrea', 'FR'),
('00010', 'zen', 'Bernier', 'Alexis', 'FR'),
('00011', 'saizen', 'Corcuff', 'Thiméo', 'FR'),
('00012', 'Ferra', 'Francal', 'Victor', 'FR');

-- --------------------------------------------------------

--
-- Structure de la table `Modejeu`
--

CREATE TABLE `Modejeu` (
  `ID` varchar(10) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Modejeu`
--

INSERT INTO `Modejeu` (`ID`, `Nom`, `Description`) VALUES
('1V1', 'Duel', 'Mode de jeu opposant 2 joueurs de deux équipes différentes'),
('3V3', '3 Versus 3', 'Mode de jeu où deux équipes de 3 joueurs s\'affronte'),
('5V5', '5 Versus 5', 'Mode où deux équipe de 5 joueurs s\'affronte');

-- --------------------------------------------------------

--
-- Structure de la table `Nationalite`
--

CREATE TABLE `Nationalite` (
  `Code` varchar(2) NOT NULL,
  `Libelle` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Nationalite`
--

INSERT INTO `Nationalite` (`Code`, `Libelle`) VALUES
('AR', 'Argentine'),
('AU', 'Australie'),
('BE', 'Belgique'),
('BR', 'Brésil'),
('CN', 'Chine'),
('DE', 'Allemagne'),
('ES', 'Espagne'),
('FR', 'France'),
('GB', 'Royaume-Unis'),
('KR', 'Corée'),
('MA', 'Maroc'),
('TR', 'Turquie'),
('TW', 'Taîwan'),
('US', 'Etat-Unis'),
('VN', 'Viet Nam');

-- --------------------------------------------------------

--
-- Structure de la table `Participe_Partie`
--

CREATE TABLE `Participe_Partie` (
  `ID_partie` varchar(10) NOT NULL,
  `ID_equipe` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Participe_Partie`
--

INSERT INTO `Participe_Partie` (`ID_partie`, `ID_equipe`) VALUES
('RLCS23A02', 'BDS'),
('RLCS23A05', 'BDS'),
('RLCS23B10', 'BDS'),
('RLCS23P05', 'BDS'),
('RLCS23P07', 'BDS'),
('RLCS23A03', 'COMPLEX'),
('RLCS23A08', 'COMPLEX'),
('RLCS23A09', 'COMPLEX'),
('RLCS23A02', 'FALCONS'),
('RLCS23A07', 'FALCONS'),
('RLCS23A09', 'FALCONS'),
('RLCS23P04', 'FALCONS'),
('RLCS23B04', 'Faze'),
('RLCS23B08', 'Faze'),
('20230819', 'FNC'),
('RLCS23B02', 'G2'),
('RLCS23B05', 'G2'),
('RLCS23B10', 'G2'),
('RLCS23P01', 'G2'),
('RLCS23B01', 'GG'),
('RLCS23B05', 'GG'),
('RLCS23P03', 'GG'),
('20230804', 'Kcorp'),
('RLCS23A01', 'Kcorp'),
('RLCS23A05', 'Kcorp'),
('RLCS23A10', 'Kcorp'),
('RLCS23P03', 'Kcorp'),
('RLCS23P06', 'Kcorp'),
('RLCS23A04', 'KRU'),
('RLCS23A06', 'KRU'),
('RLCS23A09', 'KRU'),
('RLCS23A03', 'LIQUID'),
('RLCS23A06', 'LIQUID'),
('RLCS23P02', 'LIQUID'),
('RLCS23P05', 'LIQUID'),
('RLCS23B03', 'Moist'),
('RLCS23B08', 'Moist'),
('RLCS23B10', 'Moist'),
('RLCS23A04', 'NIP'),
('RLCS23A08', 'NIP'),
('RLCS23B02', 'RuleOne'),
('RLCS23B07', 'RuleOne'),
('RLCS23B09', 'RuleOne'),
('RLCS23A01', 'SECRET'),
('RLCS23A07', 'SECRET'),
('RLCS23B04', 'SSG'),
('RLCS23B06', 'SSG'),
('RLCS23B09', 'SSG'),
('RLCS23P02', 'SSG'),
('RLCS23B01', 'TwMinds'),
('RLCS23B07', 'TwMinds'),
('RLCS23B03', 'Vitality'),
('RLCS23B06', 'Vitality'),
('RLCS23P04', 'Vitality'),
('RLCS23P06', 'Vitality'),
('RLCS23P07', 'Vitality');

-- --------------------------------------------------------

--
-- Structure de la table `Participe_Tournoi`
--

CREATE TABLE `Participe_Tournoi` (
  `ID_equipe` varchar(10) NOT NULL,
  `ID_joueur` varchar(10) NOT NULL,
  `ID_tournoi` varchar(10) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Participe_Tournoi`
--

INSERT INTO `Participe_Tournoi` (`ID_equipe`, `ID_joueur`, `ID_tournoi`, `role`) VALUES
('FNC', '00002', 'LEC_2012', 'Joueur'),
('Kcorp', '00003', 'RLCS_23', 'Joueur'),
('Kcorp', '00005', 'RLCS_23', 'Joueur'),
('Kcorp', '00006', 'RLCS_23', 'Joueur'),
('Kcorp', '00007', 'RLCS_23', 'Coach'),
('SKT T1', '00001', 'LEC_2023', 'Joueur'),
('Vitality', '00008', 'RLCS_23', 'Joueur'),
('Vitality', '00009', 'RLCS_23', 'Joueur'),
('Vitality', '00010', 'RLCS_23', 'Joueur'),
('Vitality', '00011', 'RLCS_23', 'Remplaçant'),
('Vitality', '00012', 'RLCS_23', 'Coach');

-- --------------------------------------------------------

--
-- Structure de la table `Partie`
--

CREATE TABLE `Partie` (
  `ID` varchar(10) NOT NULL,
  `Niveau` varchar(10) DEFAULT NULL,
  `dateDeroulement` date DEFAULT NULL,
  `ID_Tournoi` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Partie`
--

INSERT INTO `Partie` (`ID`, `Niveau`, `dateDeroulement`, `ID_Tournoi`) VALUES
('20230804', 'Pro', '2023-08-04', 'LFL_2023'),
('20230819', 'Pro', '2023-08-19', 'LEC_2023'),
('20230902', 'Pro', '2023-09-02', 'LEC_2023'),
('RLCS23A01', '1', NULL, 'RLCS_23'),
('RLCS23A02', '1', NULL, 'RLCS_23'),
('RLCS23A03', '1', NULL, 'RLCS_23'),
('RLCS23A04', '1', NULL, 'RLCS_23'),
('RLCS23A05', '2', NULL, 'RLCS_23'),
('RLCS23A06', '2', NULL, 'RLCS_23'),
('RLCS23A07', '0', NULL, 'RLCS_23'),
('RLCS23A08', '0', NULL, 'RLCS_23'),
('RLCS23A09', '0', NULL, 'RLCS_23'),
('RLCS23A10', '0', NULL, 'RLCS_23'),
('RLCS23B01', '1', NULL, 'RLCS_23'),
('RLCS23B02', '1', NULL, 'RLCS_23'),
('RLCS23B03', '1', NULL, 'RLCS_23'),
('RLCS23B04', '1', NULL, 'RLCS_23'),
('RLCS23B05', '2', NULL, 'RLCS_23'),
('RLCS23B06', '2', NULL, 'RLCS_23'),
('RLCS23B07', '0', NULL, 'RLCS_23'),
('RLCS23B08', '0', NULL, 'RLCS_23'),
('RLCS23B09', '0', NULL, 'RLCS_23'),
('RLCS23B10', '0', NULL, 'RLCS_23'),
('RLCS23P01', 'Quart', NULL, 'RLCS_23'),
('RLCS23P02', 'Quart', NULL, 'RLCS_23'),
('RLCS23P03', 'Quart', NULL, 'RLCS_23'),
('RLCS23P04', 'Quart', NULL, 'RLCS_23'),
('RLCS23P05', 'Demi', NULL, 'RLCS_23'),
('RLCS23P06', 'Demi', NULL, 'RLCS_23'),
('RLCS23P07', 'Finale', NULL, 'RLCS_23');

-- --------------------------------------------------------

--
-- Structure de la table `Permet_acces`
--

CREATE TABLE `Permet_acces` (
  `ID_Tournoi_1` varchar(8) NOT NULL,
  `ID_Tournoi_accessible` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Permet_acces`
--

INSERT INTO `Permet_acces` (`ID_Tournoi_1`, `ID_Tournoi_accessible`) VALUES
('LFL_2023', 'LEC_2023');

-- --------------------------------------------------------

--
-- Structure de la table `Posseder`
--

CREATE TABLE `Posseder` (
  `ID_modejeu` varchar(10) NOT NULL,
  `ID_jeu` varchar(10) NOT NULL,
  `ID_tournoi` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Posseder`
--

INSERT INTO `Posseder` (`ID_modejeu`, `ID_jeu`, `ID_tournoi`) VALUES
('5V5', 'LoL', 'LEC_2023'),
('5V5', 'LoL', 'LFL_2023'),
('3V3', 'RL', 'RLCS_23');

-- --------------------------------------------------------

--
-- Structure de la table `Sponsor`
--

CREATE TABLE `Sponsor` (
  `Nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Sponsor`
--

INSERT INTO `Sponsor` (`Nom`) VALUES
('Adidas'),
('Aldi'),
('BMW'),
('Chupa Chups'),
('CIC'),
('Coca Cola'),
('Disney'),
('Honda'),
('Hummel'),
('Logitech'),
('Michelin'),
('Orange'),
('Red Bull'),
('Tezos');

-- --------------------------------------------------------

--
-- Structure de la table `Sponsorisation`
--

CREATE TABLE `Sponsorisation` (
  `NomSpon` varchar(50) DEFAULT NULL,
  `NomClub` varchar(50) DEFAULT NULL,
  `fonds` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Sponsorisation`
--

INSERT INTO `Sponsorisation` (`NomSpon`, `NomClub`, `fonds`) VALUES
('Orange', 'Karmine Corp', NULL),
('Red Bull', 'SK Telecom T1', NULL),
('Logitech', 'Karmine Corp', NULL),
('Tezos', 'Team Vitality', NULL),
('Aldi', 'Team Vitality', NULL),
('BMW', 'Fnatic', NULL),
('Chupa Chups', 'Karmine Corp', NULL),
('CIC', 'Karmine Corp', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `Studio_Dev`
--

CREATE TABLE `Studio_Dev` (
  `Nom` varchar(50) NOT NULL,
  `DateCreation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Studio_Dev`
--

INSERT INTO `Studio_Dev` (`Nom`, `DateCreation`) VALUES
('Psyonix', '2000-04-30'),
('Riot Games', '2006-09-01'),
('Valve', '1996-08-24');

-- --------------------------------------------------------

--
-- Structure de la table `Tournoi`
--

CREATE TABLE `Tournoi` (
  `ID` varchar(10) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `NomOrganisateur` varchar(50) DEFAULT NULL,
  `Code_atteinte` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Tournoi`
--

INSERT INTO `Tournoi` (`ID`, `Nom`, `dateDebut`, `dateFin`, `NomOrganisateur`, `Code_atteinte`) VALUES
('CF_2023', 'Coupe de France', '2023-09-23', '2023-10-01', 'Riot Games', 'NA'),
('LEC_2012', 'League of Legends EMEA Championship', '2016-03-01', '2016-08-01', 'Riot Games', 'MD'),
('LEC_2023', 'League of Legends EMEA Championship', '2023-06-17', '2023-07-03', 'Riot Games', 'MD'),
('LFL_2023', 'Ligue Française League of Legends', '2023-01-18', '2023-08-11', 'Riot Games', 'NA'),
('RLCS_23', ' Rocket League Championship Series', '2023-08-08', '2023-08-13', 'Psyonix', 'MD');

-- --------------------------------------------------------

--
-- Structure de la vue `Historique jeu des joueur`
--
DROP TABLE IF EXISTS `Historique jeu des joueur`;
-- Erreur de lecture de structure pour la table jules.renaud-grange_db.Historique jeu des joueur : #1142 - La commande 'SHOW VIEW' est interdite à l'utilisateur: 'jules.renaud-grange'@'@etudiant.univ-mlv.fr' sur la table 'Historique jeu des joueur'

-- --------------------------------------------------------

--
-- Structure de la vue `Historique Tournois`
--
DROP TABLE IF EXISTS `Historique Tournois`;
-- Erreur de lecture de structure pour la table jules.renaud-grange_db.Historique Tournois : #1142 - La commande 'SHOW VIEW' est interdite à l'utilisateur: 'jules.renaud-grange'@'@etudiant.univ-mlv.fr' sur la table 'Historique Tournois'

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Atteinte`
--
ALTER TABLE `Atteinte`
  ADD PRIMARY KEY (`Code`);

--
-- Index pour la table `Club`
--
ALTER TABLE `Club`
  ADD PRIMARY KEY (`Nom`),
  ADD KEY `Nationalite` (`Nationalite`);

--
-- Index pour la table `Contrat`
--
ALTER TABLE `Contrat`
  ADD KEY `IDJ` (`IDJ`),
  ADD KEY `IDE` (`IDE`);

--
-- Index pour la table `Equipe`
--
ALTER TABLE `Equipe`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Nationalite` (`Nationalite`),
  ADD KEY `Club` (`Club`);

--
-- Index pour la table `Genre`
--
ALTER TABLE `Genre`
  ADD PRIMARY KEY (`Code`);

--
-- Index pour la table `GenreJeu`
--
ALTER TABLE `GenreJeu`
  ADD KEY `CodeJ` (`CodeJ`),
  ADD KEY `CodeG` (`CodeG`);

--
-- Index pour la table `Jeu`
--
ALTER TABLE `Jeu`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `Développeur` (`Développeur`);

--
-- Index pour la table `Jouer`
--
ALTER TABLE `Jouer`
  ADD PRIMARY KEY (`ID_joueur`,`ID_modejeu`,`codeJ`),
  ADD KEY `Jouer_ibfk_1` (`codeJ`),
  ADD KEY `ID_modejeu` (`ID_modejeu`);

--
-- Index pour la table `Joueur`
--
ALTER TABLE `Joueur`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Nationalite` (`Nationalite`);

--
-- Index pour la table `Modejeu`
--
ALTER TABLE `Modejeu`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `Nationalite`
--
ALTER TABLE `Nationalite`
  ADD PRIMARY KEY (`Code`);

--
-- Index pour la table `Participe_Partie`
--
ALTER TABLE `Participe_Partie`
  ADD PRIMARY KEY (`ID_partie`,`ID_equipe`),
  ADD KEY `ID_equipe` (`ID_equipe`);

--
-- Index pour la table `Participe_Tournoi`
--
ALTER TABLE `Participe_Tournoi`
  ADD PRIMARY KEY (`ID_equipe`,`ID_joueur`,`ID_tournoi`),
  ADD KEY `ID_joueuer` (`ID_joueur`),
  ADD KEY `ID_tournoi` (`ID_tournoi`);

--
-- Index pour la table `Partie`
--
ALTER TABLE `Partie`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_Tournoi` (`ID_Tournoi`);

--
-- Index pour la table `Permet_acces`
--
ALTER TABLE `Permet_acces`
  ADD PRIMARY KEY (`ID_Tournoi_1`,`ID_Tournoi_accessible`),
  ADD KEY `ID_Tournoi_accessible` (`ID_Tournoi_accessible`);

--
-- Index pour la table `Posseder`
--
ALTER TABLE `Posseder`
  ADD PRIMARY KEY (`ID_modejeu`,`ID_jeu`,`ID_tournoi`),
  ADD KEY `ID_tournoi` (`ID_tournoi`),
  ADD KEY `Posseder_ibfk_1` (`ID_jeu`);

--
-- Index pour la table `Sponsor`
--
ALTER TABLE `Sponsor`
  ADD PRIMARY KEY (`Nom`);

--
-- Index pour la table `Sponsorisation`
--
ALTER TABLE `Sponsorisation`
  ADD KEY `NomSpon` (`NomSpon`),
  ADD KEY `NomClub` (`NomClub`);

--
-- Index pour la table `Studio_Dev`
--
ALTER TABLE `Studio_Dev`
  ADD PRIMARY KEY (`Nom`);

--
-- Index pour la table `Tournoi`
--
ALTER TABLE `Tournoi`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Code_atteinte` (`Code_atteinte`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Club`
--
ALTER TABLE `Club`
  ADD CONSTRAINT `Club_ibfk_1` FOREIGN KEY (`Nationalite`) REFERENCES `Nationalite` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Contrat`
--
ALTER TABLE `Contrat`
  ADD CONSTRAINT `Contrat_ibfk_1` FOREIGN KEY (`IDJ`) REFERENCES `Joueur` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Contrat_ibfk_2` FOREIGN KEY (`IDE`) REFERENCES `Equipe` (`ID`);

--
-- Contraintes pour la table `Equipe`
--
ALTER TABLE `Equipe`
  ADD CONSTRAINT `Equipe_ibfk_1` FOREIGN KEY (`Nationalite`) REFERENCES `Nationalite` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Equipe_ibfk_2` FOREIGN KEY (`Club`) REFERENCES `Club` (`Nom`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `GenreJeu`
--
ALTER TABLE `GenreJeu`
  ADD CONSTRAINT `GenreJeu_ibfk_1` FOREIGN KEY (`CodeJ`) REFERENCES `Jeu` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `GenreJeu_ibfk_2` FOREIGN KEY (`CodeG`) REFERENCES `Genre` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Jeu`
--
ALTER TABLE `Jeu`
  ADD CONSTRAINT `Jeu_ibfk_1` FOREIGN KEY (`Développeur`) REFERENCES `Studio_Dev` (`Nom`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Jouer`
--
ALTER TABLE `Jouer`
  ADD CONSTRAINT `Jouer_ibfk_1` FOREIGN KEY (`codeJ`) REFERENCES `Jeu` (`Code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Jouer_ibfk_2` FOREIGN KEY (`ID_joueur`) REFERENCES `Joueur` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Jouer_ibfk_3` FOREIGN KEY (`ID_modejeu`) REFERENCES `Modejeu` (`ID`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Joueur`
--
ALTER TABLE `Joueur`
  ADD CONSTRAINT `Joueur_ibfk_1` FOREIGN KEY (`Nationalite`) REFERENCES `Nationalite` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Participe_Partie`
--
ALTER TABLE `Participe_Partie`
  ADD CONSTRAINT `Participe_Partie_ibfk_1` FOREIGN KEY (`ID_equipe`) REFERENCES `Equipe` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Participe_Partie_ibfk_2` FOREIGN KEY (`ID_partie`) REFERENCES `Partie` (`ID`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Participe_Tournoi`
--
ALTER TABLE `Participe_Tournoi`
  ADD CONSTRAINT `Participe_Tournoi_ibfk_1` FOREIGN KEY (`ID_equipe`) REFERENCES `Equipe` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Participe_Tournoi_ibfk_2` FOREIGN KEY (`ID_joueur`) REFERENCES `Joueur` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Participe_Tournoi_ibfk_3` FOREIGN KEY (`ID_tournoi`) REFERENCES `Tournoi` (`ID`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Partie`
--
ALTER TABLE `Partie`
  ADD CONSTRAINT `Partie_ibfk_1` FOREIGN KEY (`ID_Tournoi`) REFERENCES `Tournoi` (`ID`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Permet_acces`
--
ALTER TABLE `Permet_acces`
  ADD CONSTRAINT `Permet_acces_ibfk_1` FOREIGN KEY (`ID_Tournoi_1`) REFERENCES `Tournoi` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Permet_acces_ibfk_2` FOREIGN KEY (`ID_Tournoi_accessible`) REFERENCES `Tournoi` (`ID`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Posseder`
--
ALTER TABLE `Posseder`
  ADD CONSTRAINT `Posseder_ibfk_1` FOREIGN KEY (`ID_jeu`) REFERENCES `Jeu` (`Code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Posseder_ibfk_2` FOREIGN KEY (`ID_modejeu`) REFERENCES `Modejeu` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Posseder_ibfk_3` FOREIGN KEY (`ID_tournoi`) REFERENCES `Tournoi` (`ID`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Sponsorisation`
--
ALTER TABLE `Sponsorisation`
  ADD CONSTRAINT `Sponsorisation_ibfk_1` FOREIGN KEY (`NomSpon`) REFERENCES `Sponsor` (`Nom`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Sponsorisation_ibfk_2` FOREIGN KEY (`NomClub`) REFERENCES `Club` (`Nom`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Tournoi`
--
ALTER TABLE `Tournoi`
  ADD CONSTRAINT `Tournoi_ibfk_1` FOREIGN KEY (`Code_atteinte`) REFERENCES `Atteinte` (`Code`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
