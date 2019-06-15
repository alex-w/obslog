-- obslog - an elementary database model for logging astronomical observations
-- CREATE DATABASE OBSLOG

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
sessionTransparency integer,
sessionSQM real,
sessionTempC real,
sessionRHproc real,
sessionWindSpeedMS real,
sessionWindDirAz real,
sessionCloudFraction real,
sessionCloudType text,
sessionNotes text,
FOREIGN KEY (sessionSite) REFERENCES site(siteID),
FOREIGN KEY (sessionSeeing) REFERENCES codeScale(codeScaleID),
FOREIGN KEY (sessionTransparency) REFERENCES codeScale(codeScaleID)
);
-- sessionSummerTime is 1 (summer time) or (0) otherwise.

-- observation log
CREATE TABLE obslog (
obsID integer NOT NULL PRIMARY KEY AUTOINCREMENT,
obsSession integer,
obsDateTimeLocal text,
obsObject text,
obsVarStarCompStar1 real,
obsVarStarCompStar2 real,
obsVarStarTargetStarEstimate real,
obsVarStarTargetStarEstimateError real,
obsVarStarFainterThan integer,
obsVarStarAAVSOchart text,
obsVarStarAAVSOcomment text,
obsVarStarReport integer,
obsNotes text,
obsInstrument text,
obsMount text,
obsEyepiece text,
obsLens text,
obsFilter text,
obsAccessory text,
obsPartOfProject text,
FOREIGN KEY (obsSession) REFERENCES session(sessionID),
FOREIGN KEY (obsObject) REFERENCES object(objectMyName),
FOREIGN KEY (obsInstrument) REFERENCES instrument(instrumentID),
FOREIGN KEY (obsMount) REFERENCES mount(mountID),
FOREIGN KEY (obsEyepiece) REFERENCES eyepiece(eyepieceID),
FOREIGN KEY (obsLens) REFERENCES lens(lensID),
FOREIGN KEY (obsFilter) REFERENCES filter(filterID),
FOREIGN KEY (obsAccessory) REFERENCES accessory(accessoryID),
FOREIGN KEY (obsPartOfProject) REFERENCES project(projectName),
FOREIGN KEY (obsvarstarAAVSOcomment) REFERENCES codeAAVSO(codeAAVSOID),
FOREIGN KEY (obsVarStarReport) REFERENCES codeVarStarReport(codeVarStarRepID)
);


-- auxiliary tables

-- site 
CREATE TABLE site (
siteID text NOT NULL PRIMARY KEY,
siteLongitudeDG real,
siteLatitudeDG real,
siteHeightMT real,
siteTimeZone real,
siteLightPollutionRegional integer,
siteLightPollutionLocal text,
siteSafety integer,
siteTranquility integer,
siteNotes text,
FOREIGN KEY (siteSafety) REFERENCES codeScale(codeScaleID),
FOREIGN KEY (siteTranquility) REFERENCES codeScale(codeScaleID),
FOREIGN KEY (siteLightPollutionRegional) REFERENCES codeBortle(codeBortleID)
);
-- siteLongitudeDG, siteLatitudeDG: referred to WGS84 (GPS)
-- siteTimeZone: time difference with UT
-- siteLightPollutionLocal = verbal descriptors about local pollution sources

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
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc

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
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc

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
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc

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
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc

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
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc

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
-- accessoryTo is a relation, points to ID of instrument,mount,etc
-- beginLifeSpanDate, endLifeSpanDate: expressed as ISO6801 strings: "YYYY-MM-DD"
-- beginLifeSpanNote, endLifeSpanNote: references to seller, buyer, etc

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
objectVarStarType text,
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

-- constellation 
CREATE TABLE constellation (
constellationID text NOT NULL PRIMARY KEY,
constellationFullName text,
constellationGenitive text,
constellationWiki text,
constellationNotes text
);

-- AAVSO comment codes
CREATE TABLE codeAAVSO (
codeAAVSOID text NOT NULL PRIMARY KEY,
codeAAVSOMeaning text,
codeAAVSONotes text
);

-- Bortle scale codes for light pollution description
CREATE TABLE codeBortle (
codeBortleID integer NOT NULL PRIMARY KEY,
codeBortleMeaning text,
codeBortleNotes text
);

-- scale codes for seeing, transparency, site safety and site tranquility
CREATE TABLE codeScale (
codeScaleID integer NOT NULL PRIMARY KEY,
codeScaleMeaning text,
codeScaleNotes text
);

-- variable star report codes
CREATE TABLE codeVarStarReport (
codeVarStarRepID text NOT NULL PRIMARY KEY,
codeVarStarRepMeaning text,
codeVarStarRepNotes text
);

-- codes for obsVarStarReported:
-- 0 not yet reported
-- 1 reported
-- 2 not to be reported: not applicable, test obs, wrong, dubious, or any other reason

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
