-- obslog - an elementary database model for logging astronomical observations
-- version 1.4
-- 2020-06-10

-- FOR ALL TABLES
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc


BEGIN;

PRAGMA foreign_keys = ON;


-- CENTRAL TABLES

-- session 
CREATE TABLE session (
sessionID integer NOT NULL PRIMARY KEY AUTOINCREMENT,
sessionSite text,
sessionDateTimeStart text,
sessionDateTimeEnd text,
sessionSummerTime integer,
sessionSeeing integer,
sessionTransp integer,
sessionSQM real,
sessionTempC real,
sessionRHprc real,
sessionWindSpeMS real,
sessionWindDirAz real,
sessionCloudFrac real,
sessionCloudType text,
sessionNotes text,
FOREIGN KEY (sessionSite) REFERENCES site(siteID),
FOREIGN KEY (sessionSeeing) REFERENCES codeScale(codeScaleID),
FOREIGN KEY (sessionTransp) REFERENCES codeScale(codeScaleID)
);
-- sessionSummerTime is 1 (summer time) or 0 (otherwise).


-- observation log
CREATE TABLE obslog (
obsID integer NOT NULL PRIMARY KEY AUTOINCREMENT,
obsSession integer,
obsDateTimeLocal text,
obsObject text,
obsVSComp1 real,
obsVSComp2 real,
obsVSMagEst real,
obsVSMagEstErr real,
obsVSFainterThan integer,
obsVSAAVSOchart text,
obsVSAAVSOcode text,
obsReport integer,
obsNotes text,
obsInstrument text,
obsMount text,
obsEyepiece text,
obsLens text,
obsFilter text,
obsAccessory text,
obsProject text,
FOREIGN KEY (obsSession) REFERENCES session(sessionID),
FOREIGN KEY (obsObject) REFERENCES object(objectMyName),
FOREIGN KEY (obsInstrument) REFERENCES instrument(instrumentID),
FOREIGN KEY (obsMount) REFERENCES mount(mountID),
FOREIGN KEY (obsEyepiece) REFERENCES eyepiece(eyepieceID),
FOREIGN KEY (obsLens) REFERENCES lens(lensID),
FOREIGN KEY (obsFilter) REFERENCES filter(filterID),
FOREIGN KEY (obsAccessory) REFERENCES accessory(accessoryID),
FOREIGN KEY (obsProject) REFERENCES project(projectName),
FOREIGN KEY (obsVSAAVSOcode) REFERENCES codeAAVSO(codeAAVSOID),
FOREIGN KEY (obsReport) REFERENCES codeReport(codeReportID)
);


-- auxiliary tables

-- site 
CREATE TABLE site (
siteID text NOT NULL PRIMARY KEY,
siteLonDG real,
siteLatDG real,
siteHghMT real,
siteTimeZone real,
siteSkyQuality integer,
siteSafety integer,
siteTranquility integer,
siteNotes text,
FOREIGN KEY (siteSafety) REFERENCES codeScale(codeScaleID),
FOREIGN KEY (siteTranquility) REFERENCES codeScale(codeScaleID),
FOREIGN KEY (siteSkyQuality) REFERENCES codeBortle(codeBortleID)
);
-- siteLonDG, siteLatDG: referred to WGS84 (GPS)
-- siteTimeZone: time difference with UT


-- instrument 
CREATE TABLE instrument (
instrumentID text NOT NULL PRIMARY KEY,
instrumentType text,
instrumentBrand text,
instrumentApertureMM real,
instrumentFocalLengthMM real,
instrumentNotes text,
beginLifeSpanDate text,
beginLifeSpanNote text,
endLifeSpanDate text,
endLifeSpanNote text
);


-- mount 
CREATE TABLE mount (
mountID text NOT NULL PRIMARY KEY,
mountType text,
mountBrand text,
mountNotes text,
beginLifeSpanDate text,
beginLifeSpanNote text,
endLifeSpanDate text,
endLifeSpanNote text
);


-- eyepiece 
CREATE TABLE eyepiece (
eyepieceID text NOT NULL PRIMARY KEY,
eyepieceType text,
eyepieceBrand text,
eyepieceModel text,
eyepieceFocalLengthMM real,
eyepieceAfovDG real,
eyepieceEyeReliefMM real,
eyepieceFieldStopMM real,
eyepieceBarrelSizeIN real,
eyepieceBarrelThread boolean,
eyepieceNotes text,
beginLifeSpanDate text,
beginLifeSpanNote text,
endLifeSpanDate text,
endLifeSpanNote text
);


-- lens 
CREATE TABLE lens (
lensID text NOT NULL PRIMARY KEY,
lensType text,
lensBrand text,
lensAmplificationFactor real,
lensBarrelSizeIN real,
lensNotes text,
beginLifeSpanDate text,
beginLifeSpanNote text,
endLifeSpanDate text,
endLifeSpanNote text
);


-- filter 
CREATE TABLE filter (
filterID text NOT NULL PRIMARY KEY,
filterType text,
filterBrand text,
filterBarrelSizeIN real,
filterNotes text,
beginLifeSpanDate text,
beginLifeSpanNote text,
endLifeSpanDate text,
endLifeSpanNote text
);


-- accessory 
CREATE TABLE accessory (
accessoryID text NOT NULL PRIMARY KEY,
accessoryType text,
accessoryBrand text,
accessoryFunction text,
accessoryTo text,
accessoryNotes text,
beginLifeSpanDate text,
beginLifeSpanNote text,
endLifeSpanDate text,
endLifeSpanNote text
);
-- accessoryTo is a relation, points to ID of instrument,mount, etc.


-- object 
CREATE TABLE object (
objectMyName text NOT NULL PRIMARY KEY,
objectCommonName text,
objectType text,
objectConstellation text,
objectBayer text,
objectFlamsteed integer,
objectHipparcos text,
objectAAVSO text,
objectVSType text,
objectMessier integer,
objectNGC integer,
objectIC integer,
objectCollinder integer,
objectMelotte integer,
objectOtherCatalogName text,
objectOtherCatalogDsgn text,
objectLink text,
objectNotes text,
FOREIGN KEY (objectType) REFERENCES objectType(objectType),
FOREIGN KEY (objectConstellation) REFERENCES constellation(constellationID)
);


-- objectType 
CREATE TABLE objectType (
objectType text NOT NULL PRIMARY KEY,
objectTypeDescription text,
objectTypeNotes text
);
INSERT INTO objectType VALUES('AS','Asteroid','https://en.wikipedia.org/wiki/Asteroid');
INSERT INTO objectType VALUES('CO','Comet','https://en.wikipedia.org/wiki/Comet');
INSERT INTO objectType VALUES('DP','Dwarf planet','https://en.wikipedia.org/wiki/Dwarf_planet');
INSERT INTO objectType VALUES('GC','Globular cluster','https://en.wikipedia.org/wiki/Globular_cluster');
INSERT INTO objectType VALUES('GX','Galaxy','https://en.wikipedia.org/wiki/Galaxy');
INSERT INTO objectType VALUES('MT','Meteor','https://en.wikipedia.org/wiki/Meteoroid');
INSERT INTO objectType VALUES('NB','Nebula','https://en.wikipedia.org/wiki/Nebula');
INSERT INTO objectType VALUES('NS','Natural satellite','https://en.wikipedia.org/wiki/Natural_satellite');
INSERT INTO objectType VALUES('OC','Open cluster','https://en.wikipedia.org/wiki/Open_cluster');
INSERT INTO objectType VALUES('PL','Planet','https://en.wikipedia.org/wiki/Planet');
INSERT INTO objectType VALUES('SC','Star cloud','https://en.wikipedia.org/wiki/Star_cluster');
INSERT INTO objectType VALUES('ST','Star','https://en.wikipedia.org/wiki/Star');


-- constellation 
CREATE TABLE constellation (
constellationID text NOT NULL PRIMARY KEY,
constellationFullName text,
constellationGenitive text,
constellationWiki text,
constellationNotes text
);
INSERT INTO constellation VALUES('And','Andromeda','Andromedae','https://en.wikipedia.org/wiki/Andromeda_(constellation)',NULL);
INSERT INTO constellation VALUES('Ant','Antlia','Antliae','https://en.wikipedia.org/wiki/Antlia',NULL);
INSERT INTO constellation VALUES('Aps','Apus','Apodis','https://en.wikipedia.org/wiki/Apus',NULL);
INSERT INTO constellation VALUES('Aql','Aquila','Aquilae','https://en.wikipedia.org/wiki/Aquila_(constellation)',NULL);
INSERT INTO constellation VALUES('Aqr','Aquarius','Aquarii','https://en.wikipedia.org/wiki/Aquarius_(constellation)',NULL);
INSERT INTO constellation VALUES('Ara','Ara','Arae','https://en.wikipedia.org/wiki/Ara_(constellation)',NULL);
INSERT INTO constellation VALUES('Ari','Aries','Arietis','https://en.wikipedia.org/wiki/Aries_(constellation)',NULL);
INSERT INTO constellation VALUES('Aur','Auriga','Aurigae','https://en.wikipedia.org/wiki/Auriga_(constellation)',NULL);
INSERT INTO constellation VALUES('Boo','Boötes','Boötis','https://en.wikipedia.org/wiki/Bo%C3%B6tes',NULL);
INSERT INTO constellation VALUES('CMa','Canis Major','Canis majoris','https://en.wikipedia.org/wiki/Canis_Major',NULL);
INSERT INTO constellation VALUES('CMi','Canis Minor','Canis Minoris','https://en.wikipedia.org/wiki/Canis_Minor',NULL);
INSERT INTO constellation VALUES('CVn','Canes Venatici','Canum Venaticorum','https://en.wikipedia.org/wiki/Canes_Venatici',NULL);
INSERT INTO constellation VALUES('Cae','Caelum','Caeli','https://en.wikipedia.org/wiki/Caelum',NULL);
INSERT INTO constellation VALUES('Cam','Camelopardalis','Camelopardalis','https://en.wikipedia.org/wiki/Camelopardalis',NULL);
INSERT INTO constellation VALUES('Cap','Capricornus','Capricorni','https://en.wikipedia.org/wiki/Capricornus',NULL);
INSERT INTO constellation VALUES('Car','Carina','Carinae','https://en.wikipedia.org/wiki/Carina_(constellation)',NULL);
INSERT INTO constellation VALUES('Cas','Cassiopeia','Cassiopeiae','https://en.wikipedia.org/wiki/Cassiopeia_(constellation)',NULL);
INSERT INTO constellation VALUES('Cen','Centaurus','Centauri','https://en.wikipedia.org/wiki/Centaurus',NULL);
INSERT INTO constellation VALUES('Cep','Cepheus','Cephei','https://en.wikipedia.org/wiki/Cepheus_(constellation)',NULL);
INSERT INTO constellation VALUES('Cet','Cetus','Ceti','https://en.wikipedia.org/wiki/Cetus',NULL);
INSERT INTO constellation VALUES('Cha','Chamaeleon','Chamaeleontis','https://en.wikipedia.org/wiki/Chamaeleon',NULL);
INSERT INTO constellation VALUES('Cir','Circinus','Circini','https://en.wikipedia.org/wiki/Circinus_(constellation)',NULL);
INSERT INTO constellation VALUES('Cnc','Cancer','Cancri','https://en.wikipedia.org/wiki/Cancer_(constellation)',NULL);
INSERT INTO constellation VALUES('Col','Columba','Columbae','https://en.wikipedia.org/wiki/Columba_(constellation)',NULL);
INSERT INTO constellation VALUES('Com','Berenices','Comae Berenices','https://en.wikipedia.org/wiki/Coma_Berenices',NULL);
INSERT INTO constellation VALUES('CrA','Corona Australis','Coronae Australis','https://en.wikipedia.org/wiki/Corona_Australis',NULL);
INSERT INTO constellation VALUES('CrB','Corona Borealis','Coronae Borealis','https://en.wikipedia.org/wiki/Corona_Borealis',NULL);
INSERT INTO constellation VALUES('Crt','Crater','Crateris','https://en.wikipedia.org/wiki/Crater_(constellation)',NULL);
INSERT INTO constellation VALUES('Cru','Crux','Crucis','https://en.wikipedia.org/wiki/Crux',NULL);
INSERT INTO constellation VALUES('Crv','Corvus','Corvi','https://en.wikipedia.org/wiki/Corvus_(constellation)',NULL);
INSERT INTO constellation VALUES('Cyg','Cygnus','Cygni','https://en.wikipedia.org/wiki/Cygnus_(constellation)',NULL);
INSERT INTO constellation VALUES('Del','Delphinus','Delphini','https://en.wikipedia.org/wiki/Delphinus',NULL);
INSERT INTO constellation VALUES('Dor','Dorado','Doradus','https://en.wikipedia.org/wiki/Dorado',NULL);
INSERT INTO constellation VALUES('Dra','Draco','Draconis','https://en.wikipedia.org/wiki/Draco_(constellation)',NULL);
INSERT INTO constellation VALUES('Equ','Equuleus','Equulei','https://en.wikipedia.org/wiki/Equuleus',NULL);
INSERT INTO constellation VALUES('Eri','Eridanus','Eridani','https://en.wikipedia.org/wiki/Eridanus_(constellation)',NULL);
INSERT INTO constellation VALUES('For','Fornax','Fornacis','https://en.wikipedia.org/wiki/Fornax',NULL);
INSERT INTO constellation VALUES('Gem','Gemini','Geminorum','https://en.wikipedia.org/wiki/Gemini_(constellation)',NULL);
INSERT INTO constellation VALUES('Gru','Grus','Gruis','https://en.wikipedia.org/wiki/Grus_(constellation)',NULL);
INSERT INTO constellation VALUES('Her','Hercules','Herculis','https://en.wikipedia.org/wiki/Hercules_(constellation)',NULL);
INSERT INTO constellation VALUES('Hor','Horologium','Horologii','https://en.wikipedia.org/wiki/Horologium_(constellation)',NULL);
INSERT INTO constellation VALUES('Hya','Hydra','Hydrae','https://en.wikipedia.org/wiki/Hydra_(constellation)',NULL);
INSERT INTO constellation VALUES('Hyi','Hydrus','Hydri','https://en.wikipedia.org/wiki/Hydrus',NULL);
INSERT INTO constellation VALUES('Ind','Indus','Indi','https://en.wikipedia.org/wiki/Indus_(constellation)',NULL);
INSERT INTO constellation VALUES('LMi','Leo Minor','Leonis Minoris','https://en.wikipedia.org/wiki/Leo_Minor',NULL);
INSERT INTO constellation VALUES('Lac','Lacerta','Lacertae','https://en.wikipedia.org/wiki/Lacerta',NULL);
INSERT INTO constellation VALUES('Leo','Leo','Leonis','https://en.wikipedia.org/wiki/Leo_(constellation)',NULL);
INSERT INTO constellation VALUES('Lep','Lepus','Leporis','https://en.wikipedia.org/wiki/Lepus_(constellation)',NULL);
INSERT INTO constellation VALUES('Lib','Libra','Librae','https://en.wikipedia.org/wiki/Libra_(constellation)',NULL);
INSERT INTO constellation VALUES('Lup','Lupus','Lupi','https://en.wikipedia.org/wiki/Lupus_(constellation)',NULL);
INSERT INTO constellation VALUES('Lyn','Lynx','Lyncis','https://en.wikipedia.org/wiki/Lynx_(constellation)',NULL);
INSERT INTO constellation VALUES('Lyr','Lyra','Lyrae','https://en.wikipedia.org/wiki/Lyra',NULL);
INSERT INTO constellation VALUES('Men','Mensa','Mensae','https://en.wikipedia.org/wiki/Mensa_(constellation)',NULL);
INSERT INTO constellation VALUES('Mic','Microscopium','Microscopii','https://en.wikipedia.org/wiki/Microscopium',NULL);
INSERT INTO constellation VALUES('Mon','Monoceros','Monocerotis','https://en.wikipedia.org/wiki/Monoceros',NULL);
INSERT INTO constellation VALUES('Mus','Musca','Muscae','https://en.wikipedia.org/wiki/Musca',NULL);
INSERT INTO constellation VALUES('Nor','Norma','Normae','https://en.wikipedia.org/wiki/Norma_(constellation)',NULL);
INSERT INTO constellation VALUES('Oct','Octans','Octantis','https://en.wikipedia.org/wiki/Octans',NULL);
INSERT INTO constellation VALUES('Oph','Ophiuchus','Ophiuchi','https://en.wikipedia.org/wiki/Ophiuchus',NULL);
INSERT INTO constellation VALUES('Ori','Orion','Orionis','https://en.wikipedia.org/wiki/Orion_(constellation)',NULL);
INSERT INTO constellation VALUES('Pav','Pavo','Pavonis','https://en.wikipedia.org/wiki/Pavo_(constellation)',NULL);
INSERT INTO constellation VALUES('Peg','Pegasus','Pegasi','https://en.wikipedia.org/wiki/Pegasus_(constellation)',NULL);
INSERT INTO constellation VALUES('Per','Perseus','Persei','https://en.wikipedia.org/wiki/Perseus_(constellation)',NULL);
INSERT INTO constellation VALUES('Phe','Phoenix','Phoenicis','https://en.wikipedia.org/wiki/Phoenix_(constellation)',NULL);
INSERT INTO constellation VALUES('Pic','Pictor','Pictoris','https://en.wikipedia.org/wiki/Pictor',NULL);
INSERT INTO constellation VALUES('PsA','Piscis Austrinus','Piscis Austrinus','https://en.wikipedia.org/wiki/Piscis_Austrinus',NULL);
INSERT INTO constellation VALUES('Psc','Pisces','Piscium','https://en.wikipedia.org/wiki/Pisces_(constellation)',NULL);
INSERT INTO constellation VALUES('Pup','Puppis','Puppis','https://en.wikipedia.org/wiki/Puppis',NULL);
INSERT INTO constellation VALUES('Pyx','Pyxis','Pyxidis','https://en.wikipedia.org/wiki/Pyxis',NULL);
INSERT INTO constellation VALUES('Ret','Reticulum','Reticuli','https://en.wikipedia.org/wiki/Reticulum',NULL);
INSERT INTO constellation VALUES('Scl','Sculptor','Sculptoris','https://en.wikipedia.org/wiki/Sculptor_(constellation)',NULL);
INSERT INTO constellation VALUES('Sco','Scorpius','Scorpii','https://en.wikipedia.org/wiki/Scorpius',NULL);
INSERT INTO constellation VALUES('Sct','Scutum','Scuti','https://en.wikipedia.org/wiki/Scutum',NULL);
INSERT INTO constellation VALUES('Ser','Serpens','Serpentis','https://en.wikipedia.org/wiki/Serpens',NULL);
INSERT INTO constellation VALUES('Sex','Sextans','Sextantis','https://en.wikipedia.org/wiki/Sextans',NULL);
INSERT INTO constellation VALUES('Sge','Sagitta','Sagittae','https://en.wikipedia.org/wiki/Sagitta',NULL);
INSERT INTO constellation VALUES('Sgr','Sagittarius','Sagittarii','https://en.wikipedia.org/wiki/Sagittarius_(constellation)',NULL);
INSERT INTO constellation VALUES('Tau','Taurus','Tauri','https://en.wikipedia.org/wiki/Taurus_(constellation)',NULL);
INSERT INTO constellation VALUES('Tel','Telescopium','Telescopii','https://en.wikipedia.org/wiki/Telescopium',NULL);
INSERT INTO constellation VALUES('TrA','Triangulum Australe','Trianguli Australis','https://en.wikipedia.org/wiki/Triangulum_Australe',NULL);
INSERT INTO constellation VALUES('Tri','Triangulum','Trianguli','https://en.wikipedia.org/wiki/Triangulum',NULL);
INSERT INTO constellation VALUES('Tuc','Tucana','Tucanae','https://en.wikipedia.org/wiki/Tucana',NULL);
INSERT INTO constellation VALUES('UMa','Ursa Major','Ursae Majoris','https://en.wikipedia.org/wiki/Ursa_Major',NULL);
INSERT INTO constellation VALUES('UMi','Ursa Minor','Ursae Minoris','https://en.wikipedia.org/wiki/Ursa_Minor',NULL);
INSERT INTO constellation VALUES('Vel','Vela','Velorum','https://en.wikipedia.org/wiki/Vela_(constellation)',NULL);
INSERT INTO constellation VALUES('Vir','Virgo','Virginis','https://en.wikipedia.org/wiki/Virgo_(constellation)',NULL);
INSERT INTO constellation VALUES('Vol','Volans','Volantis','https://en.wikipedia.org/wiki/Volans',NULL);
INSERT INTO constellation VALUES('Vul','Vulpecula','Vulpeculae','https://en.wikipedia.org/wiki/Vulpecula',NULL);


-- AAVSO comment codes
CREATE TABLE codeAAVSO (
codeAAVSOID text NOT NULL PRIMARY KEY,
codeAAVSOMeaning text,
codeAAVSONotes text
);
INSERT INTO codeAAVSO VALUES('B','Sky is bright, moon, twilight, light pollution, aurorae.',NULL);
INSERT INTO codeAAVSO VALUES('D','Unusual Activity (fading, flare, bizarre behavior, etc.)',NULL);
INSERT INTO codeAAVSO VALUES('I','Identification of star uncertain.',NULL);
INSERT INTO codeAAVSO VALUES('K','Non-AAVSO chart.',NULL);
INSERT INTO codeAAVSO VALUES('L','Low in the sky, near horizon, in trees, obstructed view.',NULL);
INSERT INTO codeAAVSO VALUES('S','Comparison sequence problem.',NULL);
INSERT INTO codeAAVSO VALUES('U','Clouds, dust, smoke, haze, etc.',NULL);
INSERT INTO codeAAVSO VALUES('V','Faint star, near observing limit, only glimpsed.',NULL);
INSERT INTO codeAAVSO VALUES('W','Poor seeing.',NULL);
INSERT INTO codeAAVSO VALUES('Y','Outburst.',NULL);
INSERT INTO codeAAVSO VALUES('Z','Magnitude of star uncertain.',NULL);


-- Bortle scale codes for light pollution description
CREATE TABLE codeBortle (
codeBortleID integer NOT NULL PRIMARY KEY,
codeBortleMeaning text,
codeBortleNotes text
);
INSERT INTO codeBortle VALUES(1,'Excellent dark-sky site',NULL);
INSERT INTO codeBortle VALUES(2,'Typical truly dark site',NULL);
INSERT INTO codeBortle VALUES(3,'Rural sky',NULL);
INSERT INTO codeBortle VALUES(4,'Rural/suburban transition',NULL);
INSERT INTO codeBortle VALUES(5,'Suburban sky',NULL);
INSERT INTO codeBortle VALUES(6,'Bright suburban sky',NULL);
INSERT INTO codeBortle VALUES(7,'Suburban/urban transition',NULL);
INSERT INTO codeBortle VALUES(8,'City sky',NULL);
INSERT INTO codeBortle VALUES(9,'Inner-city sky',NULL);


-- scale codes for seeing, transparency, site safety and site tranquility
CREATE TABLE codeScale (
codeScaleID integer NOT NULL PRIMARY KEY,
codeScaleMeaning text,
codeScaleNotes text
);
INSERT INTO codeScale VALUES(1,'poor',NULL);
INSERT INTO codeScale VALUES(2,'acceptable',NULL);
INSERT INTO codeScale VALUES(3,'good',NULL);
INSERT INTO codeScale VALUES(4,'very good',NULL);
INSERT INTO codeScale VALUES(5,'excellent',NULL);


-- report codes
CREATE TABLE codeReport (
codeReportID text NOT NULL PRIMARY KEY,
codeReportMeaning text,
codeReportNotes text
);
INSERT INTO codeReport VALUES('0','not yet reported',NULL);
INSERT INTO codeReport VALUES('1','already reported',NULL);
INSERT INTO codeReport VALUES('2','do not report','not to be reported: test, wrong, dubious, or any other reason');



-- planning tables

-- project
CREATE TABLE project (
projectName text NOT NULL PRIMARY KEY,
projectSummary text,
projectObjectives text,
projectDateStart text,
projectDateEnd text,
projectResources text,
projectTeam text,
projectNotes text,
projectStatus text,
projectDateCreated text,
projectDateUpdated text,
projectDateArchived text,
projectEvaluation text
);

COMMIT;
