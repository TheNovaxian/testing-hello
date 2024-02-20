 sys/sys as sysdba

 connect sys/sys as sysdba

 DROP USER c##shaquille_Neil_L5Q4 CASCADE;

 CREATE USER c##shaquille_Neil_L5Q4 IDENTIFIED BY 130;

GRANT CONNECT, resource TO c##shaquille_Neil_L5Q4;

ALTER USER c##shaquille_Neil_L5Q4 QUOTA 100M on users;

connect c##shaquille_Neil_L5Q4/130;

SPOOL C:\Users\Shaquille\Projectpt5\Shaquille_neil_L5Q4.txt

SELECT to_char(sysdate,'DD MM YYYY Year Month Day HH:MI:SS Am') 
FROM DUAL;

-- CREATING TABLES --

CREATE TABLE COURSE(CourseID NUMBER CONSTRAINT course_cid_PK PRIMARY KEY,
 CourseName varchar2(50) CONSTRAINT course_CourseName_NN NOT NULL,
 Credits NUMBER);

CREATE TABLE TERM(TermID NUMBER CONSTRAINT term_tid_PK PRIMARY KEY,
STATUS VARCHAR2(10) CONSTRAINT term_status_CK CHECK (STATUS IN ('OPEN','CLOSED')),
 Description varchar2(50) CONSTRAINT term_Description_NN NOT NULL);

CREATE TABLE LOCATION(LocID NUMBER CONSTRAINT location_lid_PK PRIMARY KEY,
 Building VARCHAR2(50) CONSTRAINT location_Building_NN NOT NULL, 
 Room NUMBER CONSTRAINT location_Room_UK UNIQUE);

CREATE TABLE STUDENT(StudID NUMBER CONSTRAINT student_sid_PK PRIMARY KEY,
 SName varchar2(50) CONSTRAINT student_SName_NN NOT NULL,
 Birthdate DATE);


CREATE TABLE COURSE_SECTION(CSectionID NUMBER CONSTRAINT course_section_csid_PK PRIMARY KEY,
 MaxCapacity NUMBER CONSTRAINT course_section_MaxCapacity_NN NOT NULL,CourseID NUMBER, TermID NUMBER, LOCID NUMBER,
 CONSTRAINT course_section_cid_FK FOREIGN KEY (CourseID)
REFERENCES COURSE(CourseID),
CONSTRAINT course_section_tid_FK FOREIGN KEY (TermID)
REFERENCES TERM(TermID),
CONSTRAINT course_section_lid_FK FOREIGN KEY (LocID)
REFERENCES LOCATION(LocID));

CREATE TABLE ENROLLMENT(StudID NUMBER, CSectionID NUMBER,GRADE VARCHAR2(2),
CONSTRAINT ENROLLMENT_sid_csid_PK PRIMARY KEY(StudID,CSectionID),
CONSTRAINT enrollment_sid_FK FOREIGN KEY (StudID)
REFERENCES STUDENT(StudID),
CONSTRAINT enrollment_csid_FK FOREIGN KEY (CSectionID)
REFERENCES COURSE_SECTION(CSectionID));

----Autogenerating values of FK and PK -----
CREATE SEQUENCE course_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE term_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE location_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE student_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE csection_sequence START WITH 1 INCREMENT BY 14;

INSERT INTO STUDENT(StudID, SName)
VALUES (student_sequence.NEXTVAL, 'Shaquille');

INSERT INTO TERM(TermID, Description)
VALUES(term_sequence.NEXTVAL, 'Winter');

INSERT INTO LOCATION(LocID, Building)
VALUES(location_sequence.NEXTVAL, 'Laval Campus');



-- End of solution --

INSERT INTO COURSE(CourseName,Credits,CourseID)
VALUES ('Database', 3, course_sequence.NEXTVAL);

INSERT INTO COURSE_SECTION(CourseID,CSectionID,TermID,LocID,MaxCapacity)
VALUES (course_sequence.CURRVAL, csection_sequence.NEXTVAL, term_sequence.CURRVAL, location_sequence.CURRVAL, 10);

INSERT INTO ENROLLMENT(StudID,CSectionID,GRADE)
VALUES(student_sequence.CURRVAL, csection_sequence.CURRVAL, NULL);

INSERT INTO COURSE_SECTION(CourseID,CSectionID,TermID,LocID,MaxCapacity)
VALUES (course_sequence.CURRVAL, csection_sequence.NEXTVAL, term_sequence.CURRVAL, location_sequence.CURRVAL, 10);

INSERT INTO ENROLLMENT(StudID,CSectionID,GRADE)
VALUES(student_sequence.CURRVAL, csection_sequence.CURRVAL, NULL);



UPDATE COURSE_SECTION
SET MaxCapacity = 25
WHERE CSectionID = 15;




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