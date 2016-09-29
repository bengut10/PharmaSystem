CREATE TABLE diagnostic
(
   code number(5,2),
   description varchar(255),
   
   CONSTRAINT checkPriCode PRIMARY KEY(code)
)
/

CREATE TABLE drug
(
   id number(10) NOT NULL,
   compound varchar(255),
   targetCode number(10) NOT NULL,
   price float NOT NULL,
   
   CONSTRAINT checkPriComp PRIMARY KEY(compound),
   CONSTRAINT checkDiagCode FOREIGN KEY(targetCode) REFERENCES diagnostic(code) 
)
/

CREATE TABLE insurance
(
   planId varchar(255),
   name varchar(255),
   copay float,
   support number(10),
   
   CONSTRAINT checkPlanID PRIMARY KEY(planId),
   CONSTRAINT checkSupport FOREIGN KEY(support) 
   REFERENCES drug(id)
)
/

CREATE TABLE physician
(
   name varchar(255) NOT NULL,
   license varchar(255) NOT NULL,
   phone number(255) NOT NULL,

   CONSTRAINT checkLicense PRIMARY KEY(license)
)
/

CREATE TABLE prescription
(
   expdate date NOT NULL,
   compound varchar(255) NOT NULL,
   admin varchar(255) NOT NULL, /*This needs to be fixed*/
   refils number NOT NULL,
   quantity number NOT NULL,
   diagnostic number(5,2)  NOT NULL,
   rx number,
   
   CONSTRAINT checkRX PRIMARY KEY(rx),
   CONSTRAINT checkCompound FOREIGN KEY(compound) 
   REFERENCES drug(compound),
   CONSTRAINT checkDiagnostic FOREIGN KEY(diagnostic) 
   REFERENCES diagnostic(code)
 
)
/

CREATE TABLE customer
(
   name varchar(255) NOT NULL,
   address varchar(255) NOT NULL,
   ssn number,
   phone number NOT NULL,
   prescription number NOT NULL,
   
   CONSTRAINT checkPrescription FOREIGN KEY(prescription)
   REFERENCES prescription(rx)

)
/

CREATE TABLE transaction
(
   timeStamp date,
   trnumber number, /*  this should be fixed */
   totalCost float, /*this should be derived */
   compound number NOT NULL,
   quantity number NOT NULL,
)
/
;
  
