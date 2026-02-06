CREATE TABLE Hospital_Wing(
	wing_ID NUMBER(5) CONSTRAINT Hospital_Wing_PK PRIMARY KEY,
	name VARCHAR2(20) CONSTRAINT Hospital_Wing_name_UN UNIQUE NOT NULL,
	floor NUMBER(3),
	description VARCHAR2(25),
	location VARCHAR2(15)
);


CREATE TABLE Wing_Phones(
	phone_number NUMBER(20) NOT NULL,
	description VARCHAR2(30),
	Hospital_Wing_wing_ID NUMBER(5) CONSTRAINT Wing_Phones_Hospital_Wing_FK REFERENCES Hospital_Wing(wing_ID),
	CONSTRAINT Wing_Phones_PK PRIMARY KEY(Hospital_Wing_wing_ID, phone_number)
);


CREATE TABLE Room(
	Room_ID NUMBER(5) CONSTRAINT Room_PK PRIMARY KEY,
	room_number VARCHAR2(5) CONSTRAINT Room_room_number_UN UNIQUE NOT NULL,
	category VARCHAR2(25),
	capacity NUMBER(4) CONSTRAINT capacity_CK CHECK(capacity > 0) NOT NULL,
	bed_type VARCHAR2(20),
	Hospital_Wing_wing_ID NUMBER(5) CONSTRAINT Room_room_number_wing_ID_UN UNIQUE NOT NULL,
	CONSTRAINT Room_Hospital_Wing_FK FOREIGN KEY(Hospital_Wing_wing_ID) REFERENCES Hospital_Wing(wing_ID)
);


CREATE TABLE Nurse(
	nurse_ID NUMBER(5) CONSTRAINT Nurse_PK PRIMARY KEY,
	amka VARCHAR2(15) CONSTRAINT Nurse_amka_UN UNIQUE NOT NULL,
	nurse_personel_number NUMBER(5) CONSTRAINT Nurse_nurse_personel_number_UN UNIQUE NOT NULL,
	first_name VARCHAR2(20) NOT NULL,
	last_name VARCHAR2(20) NOT NULL,
	date_of_birth DATE,
	hire_date DATE,
	Room_Room_ID NUMBER(5) CONSTRAINT Nurse_Room_FK REFERENCES Room(Room_ID) NOT NULL,
	Nurse_nurse_ID NUMBER(5) CONSTRAINT Nurse_Nurse_FK REFERENCES Nurse(nurse_ID) NOT NULL
);


CREATE TABLE Nurse_Phones(
	phone_number NUMBER(20) NOT NULL,
	description VARCHAR2(20),
	Nurse_nurse_ID NUMBER(5) CONSTRAINT Nurse_Phones_Nurse_FK REFERENCES Nurse(nurse_ID),
	CONSTRAINT Nurse_Phones_PK PRIMARY KEY(phone_number, Nurse_nurse_ID)
);


CREATE TABLE Nurse_Address(
	Nurse_Address_ID NUMBER(5) CONSTRAINT Nurse_Address_PK PRIMARY KEY,
	street VARCHAR2(25) NOT NULL,
	nu_number VARCHAR2(20),
	postal_code VARCHAR2(20) NOT NULL,
	city VARCHAR2(25) NOT NULL,
	Nurse_nurse_ID NUMBER(5) CONSTRAINT Nurse_Address_Nurse_FK REFERENCES Nurse(nurse_ID) NOT NULL
);


CREATE TABLE Speciality(
	Speciality_ID NUMBER(5) CONSTRAINT Speciality_PK PRIMARY KEY,
	speciality_name VARCHAR2(20) NOT NULL,
	description VARCHAR2(20)
);


CREATE TABLE Doctor(
	Doctor_ID NUMBER(5) CONSTRAINT Doctor_PK PRIMARY KEY,
	amka VARCHAR2(15) CONSTRAINT Doctor_amka_UN UNIQUE NOT NULL,
	doctor_pnumber NUMBER(5) CONSTRAINT Doctor_doctor_pnumber_UN UNIQUE NOT NULL,
	first_name VARCHAR2(20) NOT NULL,
	last_name VARCHAR2(20) NOT NULL,
	Speciality_Speciality_ID NUMBER(5) CONSTRAINT Doctor_Speciality_FK REFERENCES Speciality(Speciality_ID) NOT NULL
);


CREATE TABLE Doctor_Phones(
	phone_number NUMBER(20) NOT NULL,
	description VARCHAR2(25),
	Doctor_Doctor_ID NUMBER(5) CONSTRAINT Doctor_Phones_Doctor_FK REFERENCES Doctor(Doctor_ID),
	CONSTRAINT Doctor_Phones_PK PRIMARY KEY(phone_number, Doctor_Doctor_ID)
);


CREATE TABLE Doctor_Address(
	Doctor_Address_ID NUMBER(5) CONSTRAINT Doctor_Address_PK PRIMARY KEY,
	street VARCHAR2(25) NOT NULL,
	doc_number VARCHAR2(20),
	postal_code VARCHAR2(20) NOT NULL,
	city VARCHAR2(25) NOT NULL,
	Doctor_Doctor_ID NUMBER(5) CONSTRAINT Doctor_Address_Doctor_FK REFERENCES Doctor(Doctor_ID) NOT NULL
);


CREATE TABLE Doctor_Group(
	role_in_team VARCHAR2(25) NOT NULL,
	Hospital_Wing_wing_ID NUMBER(5) CONSTRAINT Doctor_Group_Hospital_Wing_FK REFERENCES Hospital_Wing(wing_ID),
	Doctor_Doctor_ID NUMBER(5) CONSTRAINT Doctor_Group_Doctor_FK REFERENCES Doctor(Doctor_ID),
	CONSTRAINT Doctor_Group_PK PRIMARY KEY(Hospital_Wing_wing_ID, Doctor_Doctor_ID)
);


CREATE TABLE Patient(
	patient_ID NUMBER(5) CONSTRAINT Patient_PK PRIMARY KEY,
	amka VARCHAR2(15) CONSTRAINT Patient_amka_UN UNIQUE NOT NULL,
	first_name VARCHAR2(20) NOT NULL,
	last_name VARCHAR2(25) NOT NULL,
	date_of_birth DATE,
	Doctor_Doctor_ID NUMBER(5) CONSTRAINT Patient_Doctor_FK REFERENCES Doctor(Doctor_ID) NOT NULL
);


CREATE TABLE Patient_Phones(
	phone_number NUMBER(20) NOT NULL,
	description VARCHAR2(25),
	Patient_patient_ID NUMBER(5) CONSTRAINT Patient_Phones_Patient_FK REFERENCES Patient(patient_ID),
	CONSTRAINT Patient_Phones_PK PRIMARY KEY(phone_number, Patient_patient_ID)
);


CREATE TABLE Patient_Address(
	patient_Address_ID NUMBER(5) CONSTRAINT Patient_Address_PK PRIMARY KEY,
	street VARCHAR2(25) NOT NULL,
	pa_number VARCHAR2(20),
	postal_code VARCHAR2(20) NOT NULL,
	city VARCHAR2(25) NOT NULL,
	Patient_patient_ID NUMBER(5) CONSTRAINT Patient_Address_Patient_FK REFERENCES Patient(patient_ID) NOT NULL
);


CREATE TABLE Hospitalization(
	h_id NUMBER(5) CONSTRAINT Hospitalization_PK PRIMARY KEY,
	admission_date DATE NOT NULL,
	discharge_date DATE,
	diagnosis_notes VARCHAR2(25),
	Patient_patient_ID NUMBER(5) CONSTRAINT Hospitalization_Patient_FK REFERENCES Patient(patient_ID) NOT NULL,
	Doctor_Doctor_ID NUMBER(5) CONSTRAINT Hospitalization_Doctor_FK REFERENCES Doctor(Doctor_ID) NOT NULL,
	Room_Room_ID NUMBER(5) CONSTRAINT Hospitalization_Room_FK REFERENCES Room(Room_ID) NOT NULL,
	CONSTRAINT discharge_date_CK CHECK(discharge_date >= admission_date)
);


CREATE TABLE Prescr(
	prescription_id NUMBER(5) CONSTRAINT Prescr_PK PRIMARY KEY,
	date_issued DATE NOT NULL,
	Hospitalization_h_id NUMBER(5) CONSTRAINT Prescr_Hospitalization_FK REFERENCES Hospitalization(h_id) NOT NULL
);


CREATE TABLE Med(
	medication_id NUMBER(5) CONSTRAINT Med_PK PRIMARY KEY,
	name VARCHAR2(25) NOT NULL,
	recommended_daily_dose NUMBER(5) CONSTRAINT reccommended_daily_dose_CK CHECK(recommended_daily_dose > 0) NOT NULL
);


CREATE TABLE Prescr_per_Med(
  dosage_per_day NUMBER(5) CONSTRAINT PrescrPerMed_dosage_CK CHECK(dosage_per_day > 0) NOT NULL,
  quantity NUMBER(5) CONSTRAINT PrescrPerMed_quantity_CK CHECK(quantity > 0) NOT NULL,
  duration_days NUMBER(10) CONSTRAINT PrescrPerMed_duration_CK CHECK(duration_days > 0) NOT NULL,
  Med_medication_id NUMBER(5) CONSTRAINT Prescr_per_Med_FK REFERENCES Med(medication_id),
  Prescr_prescription_id NUMBER(5) CONSTRAINT Prescr_per_Med_Prescr_FK REFERENCES Prescr(prescription_id),
  CONSTRAINT Prescr_per_Med_PK PRIMARY KEY(Med_medication_id, Prescr_prescription_id)
);