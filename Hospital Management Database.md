# 🏥 Hospital Management Database

## 📌 Description
This project represents a relational database for hospital management.  
The system stores and manages information about patients, doctors, symptoms, diagnoses, medications, pharmacies, insurance policies, appointments, and hospital infrastructure.

---

## 🗂 Main Tables

- tblPATIENT – patient information  
- tblSYMPTOM and tblSYMPTOM_TYPE – symptoms and their types  
- tblAPPOINTMENT – patient appointments  
- tblPROFESSIONAL and tblROLE – medical staff and their roles  
- tblDIAGNOSIS – diagnoses assigned to patients  
- tblPRESCRIPTION – prescriptions for medications  
- tblMEDICATION and tblMEDICATION_TYPE – medications and their categories  
- tblPHARMACY – pharmacies  
- tblPOLICY and tblCARRIER – insurance policies and companies  
- tblHOSPITAL, tblBUILDING, tblROOM – hospital infrastructure  

---

## 🔗 Relationships

- One patient may have multiple symptoms (tblPATIENT_SYMPTOM).  
- Symptoms lead to appointments (tblAPPOINTMENT).  
- Each appointment is linked with doctors, roles, departments, and rooms (tblAPPOINTMENT_PRO).  
- An appointment results in a diagnosis (tblDIAGNOSIS).  
- Diagnoses may generate prescriptions (tblPRESCRIPTION).  
- Medications are dispensed through pharmacies (tblPHARMACY).  

---

## ⚙️ Core Features

### 1. Patient Management
- Register patients and their symptoms.  
- Link patients with insurance policies and providers.  

### 2. Appointment Management
- Create and manage appointments.  
- Assign doctors, roles, departments, and rooms.  

### 3. Diagnosis & Treatment
- Record diagnoses.  
- Prescribe medications.  

### 4. Hospital Infrastructure
- Manage hospitals, buildings, and rooms.  
- Organize staff by departments and roles.  

---

## 🛠 Additional Features

- Stored Procedures – automate insert operations (e.g., uspInsertProf, uspInsertDiagnosis, uspInsert_AppPro).  
- Business Rules – constraints such as:  
  - Patients from New York cannot visit Maryland hospitals on Tuesdays with policy *“Surgery Secure”*.  
  - Patients diagnosed with *Cancer* in 2020 cannot have appointments on Tuesdays.  
- Computed Columns – derived values such as:  
  - Total visits of a patient.  
  - Number of prescribed medications.  
  - Patient age (CalcPatientAge).  

---

## 📊 Example Queries

- Get patients with ≥2 symptoms in 2024 and ≥3 cardiology appointments:  
`sql
SELECT P.PatientID, P.PatientFName, P.PatientLName
FROM tblPATIENT P
JOIN tblPATIENT_SYMPTOM PS ON P.PatientID = PS.PatientID
JOIN tblAPPOINTMENT A ON PS.PatientSymptomID = A.PatientSymptomID
JOIN tblAPPOINTMENT_PRO AP ON A.AppointmentID = AP.AppointmentID
JOIN tblDEPARTMENT D ON AP.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Cardiology'
GROUP BY P.PatientID, P.PatientFName, P.PatientLName
HAVING COUNT(AP.AppointProID) >= 3;