# Hospital Management Database Schema

A complete relational database schema for a Hospital Management System,
designed and implemented using **Oracle SQL** in the **Oracle APEX environment**.

This database models core hospital operations including medical staff,
patients, hospitalizations, prescriptions, and hospital infrastructure.

---

## Features

- Structured representation of hospital wings, rooms, and departments
- Management of doctors, nurses, specialities, and medical teams
- Patient records with contact information and addresses
- Hospitalization tracking with admission and discharge constraints
- Prescription and medication management
- Use of **primary keys**, **foreign keys**, **unique constraints**, and **check constraints**
- Fully normalized relational design (up to 3NF)
- Implemented in Oracle SQL within the **Oracle APEX** environment

---

## Database Entities

Main entities:

- **Hospital_Wing**
- **Room**
- **Doctor**, **Nurse**, **Speciality**
- **Patient**
- **Hospitalization**
- **Prescription (Prescr)** and **Medication (Med)**

Auxiliary tables handle:

- Phone numbers
- Addresses
- Many-to-many relationships (e.g. Doctor–Hospital Wing, Prescription–Medication)

---

## Technologies

- **Oracle SQL**
- **Oracle APEX**
- Relational Database Design
- Entity–Relationship Modeling
- Constraint-based Data Integrity
- Normalization & Schema Optimization

---

## Academic Context / Purpose

Developed as part of a **Database Systems** course project in **Oracle APEX**.  
Demonstrates best practices in relational schema design, data integrity,
and logical modeling for a real-world hospital scenario.
