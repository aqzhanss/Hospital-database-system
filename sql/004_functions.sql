BUSSINESS RULE 

--No one from New York can not visit hospital located in Maryland in Tuesdays with Policy 'Surgery Secure'
create function fn_NoMaryland()
returns int 
AS
BEGIN 
DECLARE @RET INT = 0 
IF EXISTS (SELECT * 
			FROM tblHOSPITAL H 
			JOIN tblBUILDING B ON H.HospitalID = B.HospitalID
			JOIN tblROOM R on B.BuildingID = R.BuildingID
			JOIN tblAPPOINTMENT_PRO AP on R.RoomID = AP.RoomID
			JOIN tblAPPOINTMENT A on AP.AppointmentID = A.APpointmentID 
			JOIN tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID 
			JOIN tblPATIENT P on PS.PatientID = P.PatientID 
			JOIN tblPOLICY PO on P.PolicyID = PO.PolicyID 
			where P.PatientState = 'New York, NY'
			and H.HospState = 'Maryland, MD'
			and Datepart(Weekday, AP.BeginDateTime) = 3
			and PO.PolicyName = 'Surgery Secure')
set @RET = 1
return @RET 
end 

alter table tblAPPOINTMENT_PRO
ADD CONSTRAINT NoMaryland
CHECK (dbo.fn_NoMaryland()=0)


–"No patient diagnosed with 'Cancer' in the year 2020 can have an appointment on a Tuesday."

create function uspNoCancerin2020Tuesday()
returns int
as
begin
declare @ret int = 0
if exists 
(select * 
from tblPATIENT P
JOIN tblPATIENT_SYMPTOM PS ON P.PatientID = PS.PatientID
JOIN tblSYMPTOM S ON PS.SymptomID = S.SymptomID 
JOIN tblAPPOINTMENT A ON PS.PatientSymptomID = A.PatientSymptomID
JOIN tblAPPOINTMENT_PRO AP ON A.AppointmentID = AP.AppoIntmentID
JOIN tblDIAGNOSIS D ON AP.AppointProID = D.AppointProID
where D.DiagnosisName = 'Canser'
and AP.BeginDateTime between '2020-01-01' and '2020-12-31'
and datepart(weekday, AP.BeginDateTime) = 3)
SET @ret = 1

return @ret
end
Alter table tblAPPOINTMENT_PRO
ADD CONSTRAINT FK_uspNoCancerin2020Tuesday
 CHECK (dbo.uspNoCancerin2020Tuesday() = 0)

/*Write the SQL to create a user-defined function to enforce the following business rule:
"No patient from the state of Texas may receive a diagnosis on Wednesdays after 10:00 AM from a doctor working in the 'Cardiology' department."*/

create or alter function fn_NoPatientTexas()
returns int
as
begin 
declare @ret int = 0
if exists (select * from tblPATIENT P
join tblPatient_Symptom PS on P.PatientID = PS.PatientID
join tblAppointment A on PS.PatientSymptomID = A.PatientSymptomID
join tblAppointment_Pro AP on A.AppointmentID = AP.AppointmentID
join tblDepartment D on AP.DepartmentID = D.DepartmentID
where P.PatientState = 'Texas, TX'
and datepart(weekday, AP.BeginDateTime) = 4
and datepart(hour, AP.BeginDateTime) = 10
and D.DepartmentName = 'Cardiology')
set @ret = 1
return @ret
end

alter table tblPatient
add constraint NoPatient
check(dbo.fn_NoPatientTexas()=0)




COMPUTED COLUMN 

--how many times has a patient gone to the hospital with some kind of symptom in his lifetime
CREATE or alter FUNCTION fn_PatientSymptoms(@PK INT)
Returns int
as
begin 
declare @RET int = (select count(PS.PatientSymptomID) 
					from tblPATIENT_SYMPTOM PS
					JOIN tblPATIENT P on PS.PatientID = P.PatientID 
					where P.PatientID = @PK)
Return @RET 
end 

alter table tblPATIENT 
add CountSymptoms
as (dbo.fn_PatientSymptoms(PatientID))


--"How many different medications has a patient been prescribed in their lifetime?"

CREATE or alter FUNCTION fn_PatientMedication(@PK INT)
Returns int
as
begin 
declare @RET int = (select count(DISTINCT P.MedicationID) 
from tblMEDICATION M 
join tblPRESCRIPTION p on M.MedicationID = P.MedicationID 
join tblDIAGNOSIS D on P.DiagnosisID = D.DiagnosisID 
join tblAPPOINTMENT_PRO AP on D.AppointProID = AP.AppointProID 
join tblAPPOINTMENT A on AP.AppointmentID = A.AppointmentID 
join tblPATIENT_SYMPTOM PS on A.PatientSymptomID = PS.PatientSymptomID 
join tblPATIENT PA on PS.PatientID = PA.PatientID
where PA.PatientID = @PK)
return @ret
end

alter table tblPATIENT 
ADD PatientMedication 
as (dbo.fn_PatientMedication(PatientID))

/*Write the SQL to create a user-defined function to create a computed column called CalcPatientAge that calculates
the current age of each patient based on their DateOfBirth in the tblPATIENT table.*/

CREATE OR ALTER FUNCTION fn_CalcPatientAge(@PK INT)
RETURNS INT
AS 
  BEGIN 
  DECLARE @Ret INT = (SELECT DATEDIFF(YEAR, P.DateOfBirth, GETDATE())
                      FROM tblPATIENT P
                      WHERE P.PatientID = @PK)
                RETURN @Ret;
  END
GO

ALTER TABLE tblPATIENT
ADD CalcPatientAge AS (dbo.fn_CalcPatientAge(PatientID));
GO
