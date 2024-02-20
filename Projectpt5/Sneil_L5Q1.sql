 sys/sys as sysdba

 connect sys/sys as sysdba

 DROP USER c##shaquille_Neil_L5Q1 CASCADE;

 CREATE USER c##shaquille_Neil_L5Q1 IDENTIFIED BY 127;

GRANT CONNECT, resource TO c##shaquille_Neil_L5Q1;

ALTER USER c##shaquille_Neil_L5Q1 QUOTA 100M on users;

connect c##shaquille_Neil_L5Q1/127;

SPOOL C:\Users\Shaquille\Projectpt5\Shaquille_neil_L5Q1.txt

SELECT to_char(sysdate,'DD MM YYYY Year Month Day HH:MI:SS Am') 
FROM DUAL;

-- CREATING TABLES --

CREATE TABLE COURSE(CourseID NUMBER, CourseName varchar2(50),Credits NUMBER);

CREATE TABLE TERM(TermID NUMBER, Description varchar2(50));

CREATE TABLE LOCATION(LocID NUMBER, Building VARCHAR2(50), Room NUMBER);

CREATE TABLE STUDENT(StudID NUMBER, SName varchar2(50),Birthdate DATE);

CREATE TABLE ENROLLMENT(StudID NUMBER, CSectionID NUMBER,GRADE VARCHAR2(2));

CREATE TABLE COURSE_SECTION(CSectionID NUMBER, MaxCapacity NUMBER,CourseID NUMBER, TermID NUMBER, LOCID NUMBER);


-- PRIMARY KEYS --
ALTER TABLE COURSE
ADD CONSTRAINT course_cid_PK PRIMARY KEY(CourseID);

ALTER TABLE TERM
ADD CONSTRAINT term_tid_PK PRIMARY KEY(TermID);

ALTER TABLE LOCATION
ADD CONSTRAINT location_lid_PK PRIMARY KEY(LocID); 

ALTER TABLE STUDENT
ADD CONSTRAINT student_sid_PK PRIMARY KEY(StudID); 

ALTER TABLE ENROLLMENT
ADD CONSTRAINT ENROLLMENT_sid_csid_PK PRIMARY KEY(StudID,CSectionID); 

ALTER TABLE COURSE_SECTION
ADD CONSTRAINT course_section_csid_PK PRIMARY KEY(CSectionID); 

-- FOREIGN KEYS --

ALTER TABLE COURSE_SECTION
ADD CONSTRAINT course_section_cid_FK FOREIGN KEY (CourseID)
REFERENCES COURSE(CourseID)
ADD CONSTRAINT course_section_tid_FK FOREIGN KEY (TermID)
REFERENCES TERM(TermID)
ADD CONSTRAINT course_section_lid_FK FOREIGN KEY (LocID)
REFERENCES LOCATION(LocID);

ALTER TABLE ENROLLMENT
ADD CONSTRAINT enrollment_sid_FK FOREIGN KEY (StudID)
REFERENCES STUDENT(StudID)
ADD CONSTRAINT enrollment_csid_FK FOREIGN KEY (CSectionID)
REFERENCES COURSE_SECTION(CSectionID);

-- Making sure specific columns always have values --

ALTER TABLE COURSE
MODIFY (CourseName CONSTRAINT course_CourseName_NN NOT NULL);

ALTER TABLE STUDENT
MODIFY (SName CONSTRAINT student_SName_NN NOT NULL);

ALTER TABLE LOCATION
MODIFY (Building CONSTRAINT location_Building_NN NOT NULL);

ALTER TABLE COURSE_SECTION
MODIFY (MaxCapacity CONSTRAINT course_section_MaxCapacity_NN NOT NULL);

ALTER TABLE TERM
MODIFY (Description CONSTRAINT term_Description_NN NOT NULL);


-- Adding column STATUS to TERM and adding constraints check with two values --

ALTER TABLE TERM
ADD (STATUS VARCHAR2(10))
ADD CONSTRAINT term_status_CK CHECK (STATUS IN ('OPEN','CLOSED'));

-- Adding unique constraint to column room of table LOCATION --
ALTER TABLE LOCATION
ADD CONSTRAINT location_Room_UK UNIQUE (Room);

--Display tables
SELECT table_name FROM user_tables ;

DESC COURSE

DESC TERM

DESC LOCATION

DESC STUDENT

DESC ENROLLMENT

DESC COURSE_SECTION

SELECT constraint_name, constraint_type, table_name FROM user_constraints;


SPOOL OFF;