INSERT INTO STATEMENTS FOR TYPE TABLES
INSERT INTO tblSYMPTOM_TYPE (SymptomTypeName, SymptomTypeDescr) 
VALUES ('Physical', 'Symptoms related to physical conditions'), ('Mental', 'Symptoms related to mental health'), ('Chronic', 'Symptoms persisting over a long period'), ('Acute', 'Symptoms that are sudden and severe'), ('Infectious', 'Symptoms caused by infections');

INSERT INTO tblBUILDING_TYPE (BuildingTypeName, BuildingTypeDecs) 
VALUES ('Residential', 'Buildings used for housing'), ('Commercial', 'Buildings used for business activities'), ('Administrative', 'Buildings used for management operations'), ('Research', 'Buildings used for scientific research'), ('Educational', 'Buildings used for teaching and learning');

INSERT INTO tblROLE (RoleName, RoleDecs) 
VALUES ('Doctor', 'Medical professional providing healthcare services'), ('Nurse', 'Assists doctors and cares for patients'), ('Technician', 'Handles medical equipment and diagnostics'), ('Pharmacist', 'Prepares and dispenses medications'), ('Administrator', 'Manages hospital operations and staff');

INSERT INTO MEDICATION_TYPE (MedicationTypeName, MedicationTypeDesc)
VALUES 
('Antibacterial drugs', 'Medications used to treat bacterial infections'),
('Hormonal drugs', 'Medications that affect the hormonal balance in the body'),
('Analgesics', 'Pain-relieving medications'),
('Antiviral drugs', 'Medications used to treat viral infections'),
('Immunomodulators', 'Medications to strengthen or regulate the immune system');

INSERT INTO tblPROFESSIONAL_TYPE (ProfessionalTypeName, ProfessionalTypeDescr)
VALUES 
('Medical Staff', 'Includes doctors, nurses, and other healthcare providers'),
('Support Staff', 'Includes technicians, cleaners, and security personnel.'),
('Administrative Staff', 'Includes managers, accountants, and HR personnel.'),
('Research Staff', 'Includes researchers and laboratory staff involved in clinical studies.'),
('IT Staff', 'Includes programmers, system administrators, and IT security specialists.');

INSERT INTO tblSYMPTOM_TYPE(SymptomTypeName, SymptomTypeDescr)
values ('Pain', 'A physical discomfort that can occur in various parts of the body. Examples include headaches, back pain, and joint pain.'),
('Fever', 'A temporary increase in body temperature, often due to an infection or inflammation.'),
('Fatigue', 'A feeling of extreme tiredness or lack of energy that can be caused by physical exertion, stress, or underlying medical conditions.'),
('Cough', 'A sudden and often repetitive reflex to clear the throat or respiratory tract of irritants, mucus, or foreign particles.'),
('Nausea', ' A sensation of unease and discomfort in the stomach, often preceding vomiting, which can result from motion sickness, infections, or digestive problems.')

insert into tblCARRIER(CarierName, CarierDescr)
VALUES ('Allianz','Global insurance and financial services provider'),('AXA','International insurance and asset management company'),(' State Farm','Leading U.S. insurance provider for auto, home, and life'),('MetLife','Global life insurance and employee benefits provider'),('Prudential','Comprehensive insurance and investment services')


insert into tblSYMPTOM(SymptomName, SymptomDescr, SymptomTypeID)
select Symptom , Description,(select SymptomTypeID from tblSYMPTOM_TYPE where SymptomTypeName = Symptoms.SymptomTypeName)
from Symptoms

  
INSERT INTO tblHOSPITAL(HospitalName,HospitalDesc,HospState, HospAddress)
SELECT HospitalName, HospitalDesc, HospitalState, HospitalAddress FROM Hospitals_USA 

SELECT * from realistic_medication
INsert into tblMEDICATION(MedicationName, MedicationDescr, MedicationTypeID)
SELECT MedicationName, MedicationDesc, MedicationTypeID from realistic_medication



INSERT INTO tblROLE(RoleName, RoleDecs)
VALUES ('Administrator ', 'Manages the hospitals overall operations and staff.'),
('Surgeon', 'Specialist who performs surgical operations.'),
('Nurse', 'Provides patient care and assists doctors in medical procedures.'),
('Receptionist', 'Handles patient appointments and coordinates visits.'),
('Lab Technician', 'Conducts laboratory tests for diagnostic purposes.'),
('Radiologist', 'Performs imaging diagnostics such as X-rays and MRIs.'),
('Pharmacist', 'Dispenses medications and ensures proper prescriptions are followed.'),
('General Practitioner', 'Provides primary healthcare and initial patient assessment.'),
('Anesthesiologist', 'Administers anesthesia and monitors patients during surgery.'),
('Medical Records Officer', 'Manages and organizes patients medical records and documents.')

insert into tblCARRIER(CarierName, CarierDescr)
VALUES ('Allianz','Global insurance and financial services provider'),('AXA','International insurance and asset management company'),(' State Farm','Leading U.S. insurance provider for auto, home, and life'),('MetLife','Global life insurance and employee benefits provider'),('Prudential','Comprehensive insurance and investment services')

insert into tblROOM_TYPE(RoomTypeName, RoomTypeDescr)
values('General Ward', 'A room for multiple patients with similar medical conditions. These rooms typically have several beds and are shared by patients.'),
('Intensive Care Unit (ICU)','A specialized room for patients who require intensive monitoring and care, often equipped with advanced medical equipment.'),
('Single Room','A private room for one patient, offering more privacy and comfort than a general ward, with additional amenities such as an en-suite bathroom.'),
('Delivery Room','A room specifically designed for women during labor and childbirth, equipped with the necessary medical tools to ensure the safety of both the mother and the baby.'),
('VIP Room','A private and luxurious room for patients seeking extra comfort, privacy, and exclusive services. VIP rooms often include high-end furnishings, larger spaces, and enhanced amenities.')



INSERT INTO tblDEPARTMENT (DepartmentName, DepartmentDecs)
VALUES
('Emergency Department', 'Provides immediate medical care for emergency situations.'),
('Cardiology', 'Focuses on the diagnosis and treatment of heart conditions.'),
('Neurology', 'Specializes in nervous system disorders.'),
('Pediatrics', 'Offers medical care for infants, children, and adolescents.'),
('Oncology', 'Provides diagnosis and treatment for cancer patients.'),
('Radiology', 'Conducts imaging studies such as X-rays and MRIs for diagnosis.'),
('Orthopedics', 'Treats conditions related to bones, joints, and the musculoskeletal system.'),
('Surgery', 'Performs surgical operations and manages pre- and post-operative care.');


insert into tblBUILDING(BuildinglName, BuildingDesc, YearOpened, BuildingTypeID, HospitalID)
select BuildingName, BuildingDescr, YearOpened, BuildingTypeName, HospitalID
from Building2
