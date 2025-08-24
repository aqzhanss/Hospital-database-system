SYNTHETIC TRANSACTION SYMTOM_PATIENT

create or alter procedure uspGetPatientID
@PFName varchar (50),
@PLName varchar (50),
@PDOB Date,
@PID int output
as
set @PID = (select top 1 PatientID from tblPATIENT
where PatientFName = @PFName
and PatientLname = @PLName
and DateOfBirth = @PDOB)




Create or alter procedure uspGetSympID
@SName varchar(50),
@SID int output
as
set @SID = (select top 1 SymptomID from tblSYMPTOM where SymptomName = @SName)


create or alter procedure uspInsertPatSym
@SN varchar(50),
@F varchar(50),
@L varchar(50),
@Birth date
as
declare @SymID int, @PatID int 
exec uspGetSympID 
@SName = @SN,
@SID = @SymID output
if @SymID is null 
begin 
print 'jw';
throw 5632156, 'fjiee', 1 
end 

exec uspGetPatientID
@PFName = @F,
@PLName = @L,
@PDOB = @Birth,
@PID = @PatID output 
if @PatID is null 
begin 
print 'jw';
throw 563215, 'fjiee', 1 
end 
BEgin transaction t1
INSERT into tblPATIENT_SYMPTOM(PatientID, SymptomID)
VALUES (@PatID, @SymID)
IF @@ERROR <> 0 
BEgin 
print 'fjiei'
Rollback transaction t1
end
else 
Commit transaction t1
select * from tblSYMPTOM
select * from tblPATIENT

exec uspInsertPatSym
@SN ='Dizziness',
@F = 'Nubia',
@L = 'Aaby',
@Birth ='1955-01-31'




Create or alter procedure uspPopPat_Sym
@Run int
as 
declare @SName varchar(50), @FN varchar(50),@LN varchar(50),@Birth1 date
declare @PatRowCount int = (select count(*) from tblPATIENT)
declare @SymRowCount int = (SELECT count(*) from tblSYMPTOM)
DECLARE @SymptomID int, @PatientID int 

while @Run > 0
begin 
set @SymptomID = (select Rand() * @SymRowCount +1)
if @SymptomID = 1
set @SymptomID = (select Rand() * @SymRowCount +1)
if @SymptomID = 2
set @SymptomID = (select Rand() * @SymRowCount +1)

SET @SName = (select SymptomName from tblSYMPTOM where SymptomID = @SymptomID)

SET @PatientID = (select rand()*@PatRowCount +1)

SET @FN = (select PatientFName from tblPatient where PatientID = @PatientID)
set @LN = (select PatientLname from tblPatient where PatientID = @PatientID)
set @Birth1 = (select DateOfBirth from tblPatient where PatientID = @PatientID)

exec uspInsertPatSym 
@SN = @SName,
@F = @FN,
@L = @LN,
@Birth = @Birth1
SET @Run=@Run-1
End


TBL APPOINT_PRO 
SYNTETIC TRANSACTION 

CREATE OR ALTER PROCEDURE uspPopAppPro
@Run int

AS
DECLARE @BeginDateTime1 datetime,
@EndDateTime1 datetime,
@PLN1 varchar(50),
@PFN1 varchar(50),
@PBD1 date,
@PatFN1 varchar(50),
@PatLN1 varchar(50),
@PatB1 date, 
@SN1 varchar(50),
@DateOfA1 date, 
@RN1 varchar(50),
@RNum1 varchar(50),
@BN1 varchar(50),
@RTN1 varchar(50),
@DN1 varchar(50)

declare @AppID int, @ProfID int, @RoleID int, @RoomID int, @DepID int

declare @AppRC int = (select count(*) from tblAppointment)
declare @ProfRC int = (select count(*) from tblProfessional)
declare @RoleRC int = (select count(*) from tblRole)
declare @RoomRC int = (select count(*) from tblRoom)
declare @DepRC int = (select count(*) from tblDepartment)

while @Run > 0 begin 

SET @AppID = FLOOR((RAND() * @AppRC) + 1)
set @PatFN1 = (select PatientFName from tblAPPOINTMENT A
				join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID
				join tblPatient P on PS.PatientID = P.PatientID
				where A.AppointmentID = @AppID)
set @PatLN1 = (select PatientLname from tblAPPOINTMENT A
				join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID
				join tblPatient P on PS.PatientID = P.PatientID   where A.AppointmentID = @AppID)
set @PatB1 = (select DateOfBirth from tblAPPOINTMENT A    
				join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID
				join tblPatient P on PS.PatientID = P.PatientID   
				where A.AppointmentID = @AppID)
set @SN1 = (select S.SymptomName from tblAPPOINTMENT A    
			join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID
			join tblSYMPTOM S on PS.SymptomID = S.SymptomID    
			where A.AppointmentID = @AppID)
set @DateOfA1 = (select DateOfApp from tblAPPOINTMENT     
				where AppointmentID = @AppID)

set @ProfID = (SELECT FLOOR(RAND() * @ProfRC) + 1)
set @PLN1 = (select ProfessionalName from tblPROFESSIONAL   
			where ProfessionalID = @ProfID)
set @PFN1 = (select ProfessionalLname from tblPROFESSIONAL   
			where ProfessionalID = @ProfID)
set @PBD1 = (select ProfDateOfBirth from tblPROFESSIONAL   
			where ProfessionalID = @ProfID)

set @RoleID = (SELECT FLOOR(RAND() * @RoleRC) + 1)
set @RN1 = (select RoleName from tblROLE   
			where RoleID = @RoleID)

set @RoomID = (SELECT FLOOR(RAND() * @RoomRC) + 1)
set @RNum1 = (select RoomNumber from tblROOM   
			where RoomID = @RoomID)
set @BN1 = (select B.BuildinglName from tblROOM R   
			join tblBUILDING B on R.BuildingID = B.BuildingID
			where RoomID = @RoomID)
set @RTN1 = (select RT.RoomTypeName from tblROOM R
			join tblROOM_TYPE RT on R.RoomTypeID = RT.RoomTypeID   where RoomID = @RoomID)

set @DepID = (SELECT FLOOR(RAND() * @DepRC) + 1)
set @DN1 = (select DepartmentName from tblDEPARTMENT    
			where DepartmentID = @DepID)

SET @BeginDateTime1 = DATEADD(SECOND, (RAND() * 86400), CAST(GETDATE() AS DATETIME))
set @EndDateTime1 = DATEADD(HOUR, (RAND() * 3) + 1, @BeginDateTime1);

EXEC uspInsert_AppPro
@BeginDateTime = @BeginDateTime1,@EndDateTime = @EndDateTime1,
@PLN = @PLN1,@PFN = @PFN1,
@PBD = @PBD1,@PatFN = @PatFN1,
@PatLN = @PatLN1,@PatB = @PatB1,
@SN = @SN1,@DateOfA = @DateOfA1,
@RN = @RN1,
@RNum = @RNum1,@BN = @BN1,
@RTN = @RTN1,@DN = @DN1;

Set @Run = @Run-1 end 



—----------------------------------------------------------------------------------------------------------------------------
STORED PROCEDURES

TBL APPOINTMENT:
create or alter procedure uspGetAppointmentID
@DOA date,
@PatSympID int output
as
begin transaction T1
insert into tblAPPOINTMENT(DateofApp, PatientSymptomID)
values (@DOA, @PatSympID)
if @@ERROR <> 0
begin
  print 'Smth wrong'
  rollback transaction T1
end
else
  commit transaction T1

TBL MEDICATION_TYPE, MEDICATION:

create or alter procedure uspGetMedicationTypeID
  @MTname varchar(50),
  @MTID int output
  as
  set @MTID = (select top 1 MedicationTypeID from tblMEDICATION_TYPE
               where MedicationTypeName = @MTname)
  go

  create or alter procedure uspGetMedicationID
  @Mname varchar(50),
  @MDescr varchar(500)
  as 
 declare @MID int 

 exec uspGetMedicationTypeID
 @MTName = @Mname,
 @MTID = @MID output
 if @MID is null
 begin 
    print 'smth wrong';
	throw 56256, 'MedicationID is null',1;
end

begin transaction M1
insert into tblMEDICATION (MedicationName, MedicationDescr, MedicationTypeID)
values (@Mname, @MDescr, @MID)
if @@ERROR<>0
begin
  print 'Smth wrong'
  rollback transaction M1
end
else
  commit transaction M1
  go



Tbl PROFESSIONAL:

CREATE OR ALTER PROCEDURE uspGetProfTypeID 
@ProTypeName varchar(50),
@ProTypeID INT OUTPUT 
as
SET @ProTypeID = (SELECT top 1 ProfessionalTypeID 
                  FROM tblPROFESSIONAL_TYPE
          WHERE ProfessionalTypeName = @ProTypeName)


go

CREATE OR ALTER PROCEDURE uspInsertProf
@PTname varchar(50),
@ProfFname varchar(50),
@ProfLname varchar(50),
@ProfDB date,
@ProfCity varchar(50),
@ProfAdd varchar(50),
@ProfEmail varchar(50)
as
DECLARE @PTID INT

EXEC uspGetProfTypeID
@ProTypeName = @PTname,
@ProTypeID = @PTID OUTPUT


IF @PTID is null
Begin 
     Print 'Hey..you need to check your code';
   throw 56256, 'ProTypeID is null',1;
End

BEGIN TRANSACTION A1
Insert into tblPROFESSIONAL(ProfessionalName, ProfDateOfBirth, ProfessionalTypeID, ProfessionalLname, ProfCity, ProfAddress, ProfEmail)
Values(@ProfFname, @ProfDB, @PTID, @ProfLname, @ProfCity, @ProfAdd, @ProfEmail)


IF @@ERROR <>0
Begin
     Print 'Something caused issue'
   Rollback transaction A1
end
else
commit transaction A1
GO
------------------------------------------------------------------------------------------------------------------

EXEC uspInsertProf
@PTname = 'Medical Staff',
@ProfFname = 'Akzhan',
@ProfLname = 'Nartaikyzy',
@ProfDB = '2006-12-15',
@ProfCity = 'New York, NY',
@ProfAdd = 'Manhattan 1',
@ProfEmail = 'akzhan.al@gmail.com'
VVVCREATE OR ALTER PROCEDURE uspGetProfTypeID 
@ProTypeName varchar(50),
@ProTypeID INT OUTPUT 
as
SET @ProTypeID = (SELECT top 1 ProfessionalTypeID 
                  FROM tblPROFESSIONAL_TYPE
          WHERE ProfessionalTypeName = @ProTypeName)


go

CREATE OR ALTER PROCEDURE uspInsertProf
@PTname varchar(50),
@ProfFname varchar(50),
@ProfLname varchar(50),
@ProfDB date,
@ProfCity varchar(50),
@ProfAdd varchar(50),
@ProfEmail varchar(50)
as
DECLARE @PTID INT

EXEC uspGetProfTypeID
@ProTypeName = @PTname,
@ProTypeID = @PTID OUTPUT


IF @PTID is null
Begin 
     Print 'Hey..you need to check your code';
   throw 56256, 'ProTypeID is null',1;
End

BEGIN TRANSACTION A1
Insert into tblPROFESSIONAL(ProfessionalName, ProfDateOfBirth, ProfessionalTypeID, ProfessionalLname, ProfCity, ProfAddress, ProfEmail)
Values(@ProfFname, @ProfDB, @PTID, @ProfLname, @ProfCity, @ProfAdd, @ProfEmail)


IF @@ERROR <>0
Begin
     Print 'Something caused issue'
   Rollback transaction A1
end
else
commit transaction A1
GO
------------------------------------------------------------------------------------------------------------------

EXEC uspInsertProf
@PTname = 'Medical Staff',
@ProfFname = 'Akzhan',
@ProfLname = 'Nartaikyzy',
@ProfDB = '2006-12-15',
@ProfCity = 'New York, NY',
@ProfAdd = 'Manhattan 1',
@ProfEmail = 'akzhan.al@gmail.com'

Tbl BUILDING:

CREATE OR ALTER PROCEDURE uspGetBuildingTypeID
@BuildingTypeName varchar(50),
@BuildingTypeID INT OUTPUT
AS
SET @BuildingTypeID = (SELECT BuildingTypeID FROM tblBUILDING_TYPE
                       WHERE BuildingTypeName = @BuildingTypeName)
GO

CREATE OR ALTER PROCEDURE uspGetHospID
@HospitalName varchar(50),
@HospAddress varchar(100),
@HospitalID INT output
as
SET @HospitalID = (SELECT HospitalID FROM tblHOSPITAL
                   WHERE HospitalName = @HospitalName
				   and HospAddress = @HospAddress)
go

CREATE OR ALTER PROCEDURE uspInsertBuilding
@HName varchar(50),
@HAdd varchar(100),
@BTName varchar(50),
@BTDecs varchar(100),
@BName varchar(50),
@BDesc varchar(100),
@YO int
as 
declare @BTID INT, @HID INT;

EXEC uspGetBuildingTypeID
@BuildingTypeName = @BTName,
@BuildingTypeID = @BTID OUTPUT;

IF @BTID is null
Begin 
     Print 'Hey..you need to check your code';
   throw 56256, 'BuildingTypeID is null',1;
End


EXEC uspGetHospID
@HospitalName = @HName,
@HospAddress = @HAdd,
@HospitalID = @HID;

IF @HID is null
Begin 
     Print 'Hey..you need to check your code';
   throw 56256, 'HospitalID is null',1;
End

BEGIN TRANSACTION A2
INSERT INTO tblBUILDING (BuildingTypeID, HospitalID,BuildinglName, BuildingDesc, YearOpened)
VALUES (@BTID, @HID, @BName, @BDesc, @YO);

IF @@ERROR <>0
Begin
     Print 'Something caused issue'
   Rollback transaction A2
end
else
commit transaction A2
GO

TBL PHARMACY:

create or alter procedure uspGetPharmacyID
 @PhName varchar(50),
 @PharmacyDecs varchar(500),
 @OpHour time,
 @ClHour time,
 @Addr varchar(100),
 @PhID int output
as
begin transaction T1
insert into tblPHARMACY(PharmacyName, PharmacyDecs, OpeningHour, ClosingHour, Address)
values (@PhName, @PharmacyDecs, @OpHour, @ClHour, @Addr)
if @@ERROR <> 0
begin
  print 'Smth wrong'
  rollback transaction T1
end
else
  commit transaction T1


TBL POLICY
CREATE OR ALTER PROCEDURE uspGetCarrierID
    @CarrierName varchar(50),
	@CarrierDescr varchar(500),
    @CarrierID int OUTPUT
AS
BEGIN
    SET @CarrierID = (SELECT CarrierID FROM tblCARRIER WHERE CarrierName = @CarrierName and CarrierDescr = @CarrierDescr)
END
GO

CREATE OR ALTER PROCEDURE usp_INSERT_tblPolicy
@Pname varchar(50),
@Pdescr varchar(500),
@Cname varchar(50),
@Cdescr varchar(500)
AS
declare @CID int
exec uspGetCarrierID
@CarrierName = @Cname,
@CarrierDescr = @Cdescr,
@CarrierID = @CID output

if @CID is null
begin
print'CName is wrong';
throw 55555, 'Try again', 1
end

begin transaction t1
insert into tblPOLICY(PolicyName, PolicyDescr, CarrierID)
values(@Pname, @Pdescr, @CID)
if @@error <> 0
begin 
print 'Try Again'
rollback transaction t1
 end

else
 commit transaction t1


TBL CARRIER
CREATE OR ALTER PROCEDURE uspGetCarrierID
@CName varchar(50),
@CDescr varchar(500)
AS
Insert into tblCARRIER(CarrierName, CarrierDescr)
VALUES (@CName, @CDescr)





TBL SYMPTOM
CREATE OR ALTER PROCEDURE uspGetSymptomTypeID
    @SymptomTName varchar(50),
	@SymptomTDescr VARCHAR(500),
    @SymptomTID int OUTPUT
AS
BEGIN
    SET @SymptomTID = (SELECT SymptomTypeID FROM tblSYMPTOM_TYPE WHERE SymptomTypeName = @SymptomTName and SymptomTypeDescr = @SymptomTDescr)
END
GO
CREATE OR ALTER PROCEDURE DA_INSERT_tblSymptom
@Sname varchar(50),
@STdescr varchar(500),
@SymptomDescr varchar(500),
@STName varchar(50)
as
declare @STID int
exec uspGetSymptomTypeID
@SymptomTName = @STName,
@SymptomTID = @STID output

if @STID is null
begin
print 'SName is wrong';
throw 55555, 'Try again', 1
end

begin transaction t1
insert into tblSYMPTOM(SymptomName, SymptomDescr, SymptomTypeID)
values(@Sname, @SymptomDescr, @STID)
if @@error <> 0
begin 
print 'Try Again'
rollback transaction t1
 end

else
 commit transaction t1


TBL ROOM:

CREATE OR ALTER PROCEDURE uspGetBuildingID
@BuildinglName varchar(50),
@BuildingID INT OUTPUT
as 
SET @BuildingID = (SELECT BuildingID FROM tblBUILDING
                   WHERE BuildinglName = @BuildinglName)
go
CREATE OR ALTER PROCEDURE uspGetRoomTypeID
@RoomTypeName varchar(50),
@RoomTypeID INT OUTPUT
AS
SET @RoomTypeID = (SELECT RoomTypeID FROM tblROOM_TYPE
                   WHERE RoomTypeName = @RoomTypeName)

CREATE OR ALTER PROCEDURE uspInsertRoom
@RoomNumber INT,
@BName varchar(50),
@RTName varchar(50)
as 
DECLARE @BID INT, @RTID INT;

EXEC uspGetBuildingID
@BuildinglName = @BName,
@BuildingID = @BID OUTPUT

IF @BID is null
Begin 
     Print 'Hey..you need to check your code';
   throw 56257, 'BuildingID is null',1;
End

EXEC uspGetRoomTypeID
@RoomTypeName = @RTName,
@RoomTypeID = @RTID output

IF @BID is null
Begin 
     Print 'Hey..you need to check your code';
   throw 56254, 'BuildingID is null',1;
End

BEGIN TRANSACTION A3
INSERT INTO tbltblROOM(RoomNumber, BuildingID, RoomTypeID)
VALUES (@RoomNumber, @BID, @RTID);

IF @@ERROR <>0
Begin
     Print 'Something caused issue'
   Rollback transaction A3
end
else
commit transaction A3
GO


TBL APPOINTMENT_PRO

CREATE OR ALTER PROCEDURE uspGetProfID
@Lname varchar(50),
@Fname varchar(50),
@Birth date,
@ProfID int output 
AS
SET @ProfID = (SELECT ProfessionalID from tblPROFESSIONAL where ProfessionalName = @Fname and ProfessionalLname = @Lname and ProfDateOfBirth = @Birth)

CREATE OR ALTER PROCEDURE uspGetAppID
@PatFname varchar(50),
@PatLname varchar(50),
@PBirth date,
@SymptomName varchar(50),
@DateOfApp date,
@AppID int output 
as 
set @AppID = (select AppointmentID from tblAPPOINTMENT A
				join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID
				join tblPATIENT P on PS.PatientID = P.PatientID
				join tblSYMPTOM S on PS.SymptomID = S.SymptomID
				WHERE S.SymptomName = @SymptomName
				and P.PatientFName = @PatFname
				and P.PatientLname = @PatLname
				and P.DateOfBirth = @PBirth
				and A.DateOfApp = @DateOfApp)

CREATE OR ALTER PROCEDURE uspGetRoleID
@Rname varchar(50),
@RoleID int output
AS
SET @RoleID = (Select top 1 RoleID from tblROLE where RoleName = @Rname)

CREATE OR ALTER PROCEDURE uspGetRoomID
@RoomNum varchar(50),
@BuldingName varchar(50),
@RoomTname varchar(50),
@RoomID int output 
AS 
SET @RoomID = (SELECT R.RoomID
				FROM tblROOM R 
				JOIN tblROOM_TYPE RT on R.RoomTypeID = RT.RoomTypeID
				join tblBUILDING B on R.BuildingID = B.BuildingID
				where B.BuildinglName = @BuldingName
				and RT.RoomTypeName = @RoomTname
				and R.RoomNumber = @RoomNum) 

CREATE OR ALTER PROCEDURE uspGetDepID
@DepName varchar(50),
@DepID int output
AS
SET @DepID = (SELECT DepartmentID from tblDEPARTMENT WHERE DepartmentName = @DepName)

CREATE OR ALTER PROCEDURE uspInsert_AppPro
@BeginDateTime datetime,
@EndDateTime datetime,
@PLN varchar(50),
@PFN varchar(50),
@PBD date,
@PatFN varchar(50),
@PatLN varchar(50),
@PatB date, 
@SN varchar(50),
@DateOfA date, 
@RN varchar(50),
@RNum varchar(50),
@BN varchar(50),
@RTN varchar(50),
@DN varchar(50)

AS 
DECLARE @PID INT, @RID int, @RoomID1 int, @DID int, @AID int 
exec uspGetProfID
@Lname = @PLN,
@Fname = @PFN,
@Birth = @PBD,
@ProfID = @PID output 

IF @PID is null 
begin 
print 'Patient doesnt exists';
throw 50664, 'try again1', 1
end 

exec uspGetAppID
@PatFname = @PatFN,
@PatLname = @PatLN,
@PBirth = @PatB,
@SymptomName = @SN,
@DateOfApp = @DateOfA,
@AppID =  @AID output 

IF @AID is null 
BEGIN 
print 'Appointment doesnt exist';
throw 56489, 'try again2', 1
end 

exec uspGetRoleID
@Rname = @RN,
@RoleID = @RID output

if @RID is null 
begin 
print 'Role doesnt exist';
throw 55689, 'try again3', 1
end 

exec uspGetRoomID
@RoomNum = @RNum,
@BuldingName = @BN,
@RoomTname = @RTN,
@RoomID =@RoomID1 output 

IF @RoomID1 is null
begin 
print 'Room doesnt exist';
throw 56489, 'try again4', 1 
end 

exec uspGetDepID
@DepName = @DN,
@DepID = @DID output

if @DID is null
begin 
print 'Dept doesnt exist';
throw 56489, 'try again5', 1 
end 

begin transaction t1
insert into tblAPPOINTMENT_PRO(AppointmentID, ProfessionalID, RoleID, RoomID, DepartmentID, BeginDateTime, EndDateTime)
Values (@AID, @PID, @RID, @RoomID1, @DID, @BeginDateTime, @EndDateTime)
if @@ERROR <> 0
begin 
print 'Try again'
Rollback Transaction t1
end 
else 
Commit transaction t1



TBL PATIENT

CREATE OR ALTER PROCEDURE uspGetPolicyID
    @PolicyName varchar(50),
	@PolicyDescr varchar(500),
    @PolicyID int OUTPUT
AS
BEGIN
    SET @PolicyID = (SELECT PolicyID FROM tblPOLICY WHERE PolicyName = @PolicyName and PolicyDescr = @PolicyDescr)
END
GO
CREATE OR ALTER PROCEDURE uspINSERT_tblPATIENT
@Fname varchar(50),
@Lname varchar(50),
@PName varchar(50),
@PDescr varchar(500),
@State varchar(50),
@Birth date
as
declare @POID int
exec uspGetPolicyID
@PolicyName = @PName,
@PolicyDescr = @PDescr, 
@PolicyID = @POID output

if @POID is null
begin
print 'PName is wrong';
throw 55555, 'Try again', 1
end

begin transaction t1
insert into tblPATIENT(PatientFName,PatientLName, PatientState, DateOfBirth)
values(@Fname, @Lname, @State, @Birth)
if @@error <> 0
begin 
print 'Try Again'
rollback transaction t1
 end

else
 commit transaction t1


TBL DIAGNOSIS

CREATE OR ALTER PROCEDURE uspGetAppProID
@PatFname varchar(50),
@PatLname varchar(50),
@PatB date,
@SymName varchar(50),
@DateOfApp date,
@ProfFname varchar(50),
@ProfLname varchar(50),
@ProfBirth date,
@RoleName varchar(50),
@RoomN varchar(50),
@Bname varchar(50),
@RoomTName varchar(50),
@DepName varchar(50),
@BegDate datetime,
@EndDate datetime,
@AppProID int output 
as
set @AppProID = (select AP.AppointProID From tblAPPOINTMENT_PRO AP 
				join tblAPPOINTMENT A on AP.AppointmentID = A.AppointmentID
				join tblROOM RO on AP.RoomID = RO.RoomID
				join tblROLE R on AP.RoleID = R.RoleID
				join tblDEPARTMENT D on AP.DepartmentID = D.DepartmentID
				join tblPROFESSIONAL PR on AP.ProfessionalID = PR.ProfessionalID
				join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID
				join tblPATIENT P on PS.PatientID = P.PatientID
				join tblSYMPTOM S on PS.SymptomID = S.SymptomID
				join tblBUILDING B on RO.BuildingID = B.BuildingID 
				join tblROOM_TYPE RT on RO.RoomTypeID = RT.RoomTypeID
				where P.PatientFName = @PatFname
				and P.PatientLname = @PatLname
				and P.DateOfBirth = @PatB
				and S.SymptomName = @Symname
				and A.DateOfApp = @DateOfApp
				and PR.ProfessionalName = @ProfFname
				and PR.ProfessionalLname = @ProfLname
				and PR.ProfDateOfBirth = @ProfBirth
				and R.RoleName = @RoleName
				and RO.RoomNumber = @RoomN
				and B.BuildinglName = @Bname
				and RT.RoomTypename = @RoomTname
				and D.DepartmentName = @DepName
				and AP.BeginDateTime = @BegDate
				and Ap.EndDateTime = @EndDate) 

create or alter procedure uspInsertDiagnosis
@PatFname1 varchar(50),
@PatLname1 varchar(50),
@PatB1 date,
@SymName1 varchar(50),
@DateOfApp1 date,
@ProfFname1 varchar(50),
@ProfLname1 varchar(50),
@ProfBirth1 date,
@RoleName1 varchar(50),
@RoomN1 varchar(50),
@Bname1 varchar(50),
@RoomTName1 varchar(50),
@DepName1 varchar(50),
@BegDate1 datetime,
@EndDate1 datetime,
@Dname varchar(50),
@Ddesc varchar(500)

AS
declare @APID int
EXEC uspGetAppProID
    @PatFname = @PatFname1,
    @PatLname = @PatLname1,
    @PatB = @PatB1,
    @SymName = @SymName1,
    @DateOfApp = @DateOfApp1,
    @ProfFname = @ProfFname1,
    @ProfLname = @ProfLname1,
    @ProfBirth = @ProfBirth1,
    @RoleName = @RoleName1,
    @RoomN = @RoomN1,
    @Bname = @Bname1,
    @RoomTName = @RoomTName1,
    @DepName = @DepName1,
    @BegDate = @BegDate1,
    @EndDate = @EndDate1,
    @AppProID = @APID OUTPUT

IF @APID is null
BEGIN 
PRINT 'Parameters are wrong';
Throw 569845, 'try again', 1 
end 

begin transaction t1
INSERT INTO tblDIAGNOSIS(AppointProID, DiagnosisName, DiagnosisDescr)
VALUES (@APID, @Dname, @Ddesc)
IF @@ERROR <>0
BEGIN 
PRINT 'try again'
rollback transaction t1
end else commit transaction t1

TBL PRESCRIPTION 
 create or alter procedure GetPhamacyID
 @PhName varchar(50),
 @PharmacyDecs varchar(500),
 @OpHour time,
 @ClHour time,
 @Addr varchar(100),
 @PhID int output

 AS
 set @PhID = ( select PharmacyID from tblPharmacy
              where PharmacyName = @Phname and
			  Pharmacydecs = @PharmacyDecs
			  and OpeningHour = @OpHour
			  and ClosingHour = @ClHour
			  and Address = @Addr)
go

create or alter procedure GetMedicationID
@Mname varchar(50),
@Mdescr varchar(500),
@MTName varchar(50),
@MTDescr varchar (500),
@MID int output

as
set @MID = (select top 1 MedicationID from tblMEDICATION M
            join tblMedication_Type MT on M.MedicationTypeID = MT.MedicationTypeID
			where MedicationName = @Mname
			and MedicationDescr = @MDescr
			and MedicationTypeName = @MTName
			and MedicationTypeDescr = @MTDescr)

go 

create or alter procedure GetDiagnosisID
@DName varchar(50),
@Ddescr varchar(500),
@DID int output,
@BDate Date,
@EDate DAte

as
set @DID = (select top 1 DiagnosisID from tblDiagnosis D
            join tblAppointment_Pro AP on D.AppointProID = AP.AppointProID
			where DiagnosisName = @DName
			and DiagnosisDescr = @Ddescr
			and BeginDateTime = @BDate
			and EndDateTime = @EDate)
go 

create or alter procedure insertPrescriptionID
@PhName1 varchar(50),
 @PharmacyDecs1 varchar(500),
 @OpHour1 time,
 @ClHour1 time,
 @Addr1 varchar(100),
 @Mname1 varchar(50),
@Mdescr1 varchar(500),
@MTName1 varchar(50),
@MTDescr1 varchar (500),
@DName1 varchar(50),
@Ddescr1 varchar(500),
@BDate1 Date,
@EDate1 Date,
@Dosage varchar(50),
@Instructions varchar(100)

as
declare @DiagID int , @MedID int , @PharID int;
exec GetPhamacyID
@PhName = @PhName1,
 @PharmacyDecs = @PharmacyDecs1,
 @OpHour = @Ophour1,
 @ClHour = @ClHour1,
 @Addr = @Addr1,
 @PhID = @PharID output
if @PharID is null
begin
print 'smth wrong';
throw 26565, 'PharID is null', 1;
end

exec GetMedicationID
@Mname = @Mname1,
@Mdescr = @Mdescr1,
@MTName =@MTName1,
@MTDescr=@MTDescr1,
@MID = @MedID output

if @MedID is null
begin
print 'smth wrong';
throw 26565, 'MedID is null', 1;
end

exec GetDiagnosisID
@DName = @DName1,
@Ddescr = @Ddescr1,
@BDate = @BDate1,
@EDate = @EDate1,
@DID = @DiagID output
if @DiagID is null
begin
print 'smth wrong';
throw 26565, 'DiagID is null', 1;
end

begin transaction J1
insert into tblPrescription(DiagnosisID, MedicationID, PharmacyID, Dosage, Instructions)
values (@DiagID, @MedID, @PharID, @Dosage, @Instructions)
if @@ERROR <> 0
begin
  print 'Smth wrong'
  rollback transaction J1
end
else
  commit transaction J1
 

TBL PATIENT_SYMPTOM
CREATE OR ALTER PROCEDURE uspGetPatientID
    @PatientFName varchar(50),
	@PatientLName varchar(50),
	@DateOFBirth date,
    @PatientID int OUTPUT
AS
BEGIN
    SET @PatientID = (SELECT PatientID FROM tblPATIENT WHERE PatientFName = @PatientFName and PatientLName = @PatientLName and DateOFBirth = @DateOFBirth)
END
GO

 CREATE OR ALTER PROCEDURE uspGetSymptomID
    @SymptomName varchar(50),
	@SymptomTypeName varchar(50),
    @SymptomID int OUTPUT
AS
BEGIN
    SET @SymptomID = (SELECT SymptomID FROM tblSYMPTOM S JOIN tblSYMPTOM_TYPE ST ON S.SymptomTypeID = ST.SymptomTypeID WHERE SymptomName = @SymptomName and SymptomTypeName = @SymptomTypeName)
END
GO
CREATE OR ALTER PROCEDURE uspINSERT_tblPATIENT_SYMPTOM
@Fname varchar(50),
@Lname varchar(50),
@Birth date,
@SName varchar(50),
@Stypename varchar(50)
as
declare @PID int
exec uspGetPatientID
	@PatientFName = @Fname,
	@PatientLName = @Lname,
	@DateOFBirth = @Birth,
	@PatientID = @PID output

if @PID is null
begin
print 'PName is wrong';
throw 55555, 'Try again', 1
end

declare @SID int
exec uspGetPatientID
	@SymptomName = @SName,
	@SymptomTypeName = Stypename,
	@SymptomID = @SID output

if @SID is null
begin
print 'SName is wrong';
throw 55555, 'Try again', 1
end

begin transaction t1
insert into tblPATIENT_SYMPTOM(PatientID, SymptomID)
values(@PID, @SID)
if @@error <> 0
begin 
print 'Try Again'
rollback transaction t1
 end

else
 commit transaction t1

