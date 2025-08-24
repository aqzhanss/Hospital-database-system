CREATE TABLE tblSYMPTOM_TYPE 
(SymptomTypeID INT identity(1,1) primary key,
SymptomTypeName varchar(50) not null,
SymptomTypeDescr varchar(500) null)

CREATE TABLE tblSYMPTOM 
(SymptomID INT identity(1,1) primary key,
SymptomTypeID int foreign key references tblSYMPTOM_TYPE(SymptomTypeID) not null,
SymptomName varchar(50) not null,
SymptomDescr varchar(500) null)

CREATE TABLE tblCARRIER
(CarrierID INT identity(1,1) primary key,
CarrierName varchar(50) not null,
CarrierDescr varchar(500) null)

CREATE TABLE tblPOLICY 
(PolicyID INT identity(1,1) primary key,
CarrierID int foreign key references tblCARRIER(CarrierID) not null,
PolicyName varchar(50) not null,
PolicyDescr varchar(500) null)

CREATE TABLE tblPATIENT
(PatientID INT identity(1,1) primary key,
PolicyID int foreign key references tblPOLICY(PolicyID) not null,
PatientFName varchar(50) not null,
PatientLname varchar(30) not null,
PatientAddress varchar(30) not null,
DateOfBirth date not null,
PatientState varchar(30) not null,
PatPhoneNum int not null)

CREATE TABLE tblPATIENT_SYMPTOM 
(PatientSymptomID INT identity(1,1) primary key,
PatientID int foreign key references tblPATIENT(PatientID) not null,
SymptomID int foreign key references tblSYMPTOM(SymptomID) not null)

CREATE TABLE tblAPPOINTMENT
(AppointmentID INT identity(1,1) primary key,
PatientSymptomID int foreign key references tblPATIENT_SYMPTOM(PatientSymptomID) not null
DateofApp date not null)

CREATE TABLE tblMEDICATION 
(MedicationID INT identity(1,1) primary key,
MedicationName varchar(50) not null,
MedicationDescr varchar(500) null)

CREATE TABLE tblAPPOINTMENT_PRO
(AppointProID INT identity(1,1) primary key,
AppointmentID int foreign key references tblAPPOINTMENT(AppointmentID) not null,
ProfessionalID int foreign key references tblPROFESSIONAL(ProfessionalID) not null,
RoleID int foreign key references tblROLE(RoleID) not null,
RoomID int foreign key references tblROOM(RoomID) not null,
DepartmentID int foreign key references tblDEPARTMENT(DepartmentID) not null
BeginDateTime datetime not null
EndDateTime datetime not null)

CREATE TABLE tblDIAGNOSIS
(DiagnosisID INT identity(1,1) primary key,
DiagnosisName varchar(50) not null,
DiagnosisDescr varchar(500) null,
AppontProID int foreign key references tblAPPOINTMENT_PRO(AppontProID) not null)

—---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tblBUILDING_TYPE
(BuildingTypeID INT IDENTITY (1,1) primary key,
BuildingTypeName varchar(50) not null,
BuildingTypeDecs varchar(500) null)

CREATE TABLE tblHOSPITAL
(HospitalID INT IDENTITY (1,1) primary key,
HospitalName varchar(50) not null,
HospitalDesc varchar(500) null,
HospState varchar(30) not null,
HospAddress varchar(30) not null)

CREATE TABLE tblBUILDING
(BuildingID INT IDENTITY (1,1) primary key,
BuildingName varchar(50) not null,
BuildingDesc varchar(500) null,
YearOpened date not null,
BldgShortName varchar(30) not null,
BuildingDescr varchar(30) null,
BuildingTypeID INT FOREIGN KEY REFERENCES tblBUILDING_TYPE(BuildingTypeID) not null,
HospitalID INT FOREIGN KEY REFERENCES tblHOSPITAL(HospitalID) not null
)


CREATE TABLE tblROOM
(RoomID INT IDENTITY (1,1) primary key,
RoomNumber varchar(50) not null,
BuildingID INT FOREIGN KEY REFERENCES tblBUILDING (BuildingID) not null
)

ALTER TABLE tblROOM
ADD RoomTypeID INT
FOREIGN KEY REFERENCES tblROOM_TYPE(RoomTypeID)



CREATE TABLE tblPROFESSIONAL
(ProfessionalID INT IDENTITY (1,1) primary key,
ProfessionalName varchar(50) not null,,
ProfessionalLname varchar(30) not null,
ProfDateOfBirth date not null,
ProfCity varchar(30) not null,
ProfAddress varchar(30) not null,
ProfEmail varchar(30) not null)

ALTER TABLE tblPROFESSIONAL
ADD ProfessionalTypeID INT
FOREIGN KEY REFERENCES tblPROFESSIONAL_TYPE(ProfessionalTypeID)


CREATE TABLE tblDEPARTMENT
(DepartmentID INT IDENTITY (1,1) primary key,
DepartmentName varchar(50) not null,
DepartmentDecs varchar(500) null)

CREATE TABLE tblPHARMACY
(PharmacyID INT IDENTITY (1,1) primary key,
Address varchar(30) not null,
OpeningHour time not null,
ClosingHour time not null,
PharmacyName varchar(50) not null,
PharmacyDecs varchar(500) null)

CREATE TABLE tblROLE
(RoleID INT IDENTITY (1,1) primary key,
RoleName varchar(50) not null,
RoleDecs varchar(500) null)


CREATE TABLE tblPRESCRIPTION
(PrescriptionID INT IDENTITY (1,1) primary key,
PharmacyID INT FOREIGN KEY REFERENCES tblPHARMACY(PharmacyID) not null
Dosage varchar(30) not null,
Instructions varchar(30) not null)

ALTER TABLE tblPRESCRIPTION
ADD CONSTRAINT FK_tblPRESCRIPTION_DiagnosisID
FOREIGN KEY (DiagnosisID)
REFERENCES  tblDIAGNOSIS(DiagnosisID)

ALTER TABLE tblPRESCRIPTION
ADD MedicationID INT
FOREIGN KEY REFERENCES tblMEDICATION(MedicationID)


CREATE TABLE tblPROFESSIONAL_TYPE
(ProfessionalTypeID INT IDENTITY(1,1) primary key, 
ProfessionalTypeName varchar(50) not null, 
ProfessionalTypeDescr varchar(500) NULL) 
GO 

CREATE TABLE tblMEDICATION_TYPE
(MedicationTypeID INT IDENTITY(1,1) primary key, 
MedicationTypeName varchar(50) not null, 
MedicationTypeDescr varchar(500) NULL) 
GO 

ALTER TABLE tblMEDICATION
ADD MedicationTypeID INT
FOREIGN KEY REFERENCES tblMEDICATION_TYPE(MedicationTypeID)


CREATE TABLE tblROOM_TYPE
(RoomTypeID INT IDENTITY(1,1) primary key, 
RoomTypeName varchar(50) not null, 
RoomTypeDescr varchar(500) NULL) 
GO 
