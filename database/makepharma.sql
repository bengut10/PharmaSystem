--
--Create a small pharmacy database
--

set termout on
set feedback on
prompt Building sample pharamacy database.  Please wait ...
--set termout off
set feedback off
set trimspool on

CREATE TABLE physician(
    drLicense VARCHAR(10),
    dName VARCHAR(15) NOT NULL,
    phone CHAR(15) NOT NULL UNIQUE, 
    PRIMARY KEY (drLicense)
);

INSERT INTO physician(drLicense, dName, phone) VALUES
    ('a1234', 'Roger Smith', '512-967-2324');
INSERT INTO physician(drLicense, dName, phone) VALUES
    ('b3267', 'Frank James', '512-983-5670');
INSERT INTO physician(drLicense, dName, phone) VALUES
    ('g1184', 'Ray Lopez', '512-9065-324');
INSERT INTO physician(drLicense, dName, phone) VALUES
    ('d2184', 'Nicole Laiz','512-555-9845');
INSERT INTO physician(drLicense, dName, phone) VALUES
    ('z8188', 'Sarah Marts','254-7653-224');

CREATE TABLE drug
(
    dName VARCHAR(15),
    price FLOAT NOT NULL,
    PRIMARY KEY(dName),
    CHECK (PRICE BETWEEN .01 AND 100)
);

INSERT INTO drug(dName, price) VALUES
    ('adderall', .99);
INSERT INTO drug(dName, price) VALUES
    ('ibuprofen', .29);
INSERT INTO drug(dName, price) VALUES
    ('codeine', 1.49);
INSERT INTO drug(dName, price) VALUES
    ('lipitor', 2.01);
INSERT INTO drug(dName, price) VALUES
    ('nexium', 1.77);
INSERT INTO drug(dName, price) VALUES
    ('plavix', 3.01);
INSERT INTO drug(dName, price) VALUES
    ('advair Diskus', 5.33);
INSERT INTO drug(dName, price) VALUES
    ('abilify', 1.11);
INSERT INTO drug(dName, price) VALUES
    ('seroquel', 2.87);
INSERT INTO drug(dName, price) VALUES
    ('singulair', 3.49);
INSERT INTO drug(dName, price) VALUES
    ('crestor', 1.06);
INSERT INTO drug(dName, price) VALUES
    ('actos', .88);
INSERT INTO drug(dName, price) VALUES
    ('epogen', 2.44);
INSERT INTO drug(dName, price) VALUES
    ('prozac', 4.32);
INSERT INTO drug(dName, price) VALUES
    ('xanax', 3.49);

CREATE TABLE diagnostic
(
    code NUMERIC(5,2),
    description VARCHAR(15) NOT NULL,
    PRIMARY KEY (code)
);

INSERT INTO diagnostic(code, description) VALUES
    (434.23, 'severe pain');
INSERT INTO diagnostic(code, description) VALUES
    (235.37, 'narcolepsy');
INSERT INTO diagnostic(code, description) VALUES
    (342.12, 'mild pain');
INSERT INTO diagnostic(code, description) VALUES
    (111.11, 'anxiety');
INSERT INTO diagnostic(code, description) VALUES
    (113.18, 'acid reflux');


CREATE TABLE insurance
(
    policy VARCHAR(7),
    name VARCHAR(15) NOT NULL,
    copay FLOAT NOT NULL,
    PRIMARY KEY (policy),
    CHECK (copay BETWEEN 0 and 500)
);

INSERT INTO insurance(policy, name, copay) VALUES
    ('dbro46', 'BronzePlus', 400.00);
INSERT INTO insurance(policy, name, copay) VALUES
    ('abc789', 'SilverPlus', 200.00);
INSERT INTO insurance(policy, name, copay) VALUES
    ('jjo386', 'Platinum', 10.00);

CREATE TABLE supports
(
  policy VARCHAR(7) NOT NULL,
  compound VARCHAR(15) NOT NULL,
  FOREIGN KEY (policy) REFERENCES insurance(policy),
  FOREIGN KEY (compound) REFERENCES drug(dName)
);

INSERT INTO supports(policy, compound) VALUES
    ('dbro46', 'ibuprofen');
INSERT INTO supports(policy, compound) VALUES
    ('abc789', 'ibuprofen');
INSERT INTO supports(policy, compound) VALUES
    ('jjo386', 'codeine');


CREATE TABLE inventory
(
   location INT NOT NULL, --Reffers to a isle number in the store.--
   quantity INT NOT NULL,
   compound VARCHAR(15) NOT NULL,
   FOREIGN KEY (compound) REFERENCES drug(dName),
   CHECK (location >= 0),
   CHECK (quantity >= 0)
);

INSERT INTO inventory(location, quantity, compound) VALUES
    (1, 17, 'adderall');  
INSERT INTO inventory(location, quantity, compound) VALUES
    (3,32, 'ibuprofen');  
INSERT INTO inventory(location, quantity, compound) VALUES
    (2, 58, 'codeine');  

CREATE TABLE payment
(
    authorization INT,
    cost FLOAT NOT NULL,
    policy VARCHAR(7) NOT NULL,
    compound VARCHAR(15) NOT NULL,
    PRIMARY KEY (authorization),
    FOREIGN KEY (policy) REFERENCES insurance(policy),
    FOREIGN KEY (compound) REFERENCES drug(dName),
    CHECK (cost >= 0)
);

INSERT INTO payment(authorization, cost, policy, compound) VALUES
    (1, 400.00, 'dbro46', 'ibuprofen');
INSERT INTO payment(authorization, cost, policy, compound) VALUES
    (2, 200.00, 'abc789', 'adderall');
INSERT INTO payment(authorization, cost, policy, compound) VALUES
    (3, 10.00, 'jjo386', 'codeine');

CREATE TABLE customer
(
    id INT,
    name VARCHAR(15) NOT NULL,
    dob DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(15) NOT NULL,
    policy VARCHAR(7) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (policy) REFERENCES insurance(policy)
);

INSERT INTO customer(id, name, dob, phone, address, policy) VALUES
    (1, 'Bilbo Baggins', TO_DATE('1979/07/08', 'yyyy/mm/dd'), '860-326-4643', '12 Main', 'dbro46');
INSERT INTO customer(id, name, dob, phone, address, policy) VALUES
    (2, 'Gandalf Grey', TO_DATE('1972/07/08', 'yyyy/mm/dd'), '478-346-4643', '1 Kempf', 'abc789');
INSERT INTO customer(id, name, dob, phone, address, policy) VALUES
    (3, 'George Bush', TO_DATE('1979/07/09', 'yyyy/mm/dd'), '840-333-3455', '12 twelve', 'jjo386');

CREATE TABLE prescription
(
    rx INT,
    expiration DATE NOT NULL,
    quantity INT NOT NULL,
    admin VARCHAR(15) NOT NULL,
    refill INT NOT NULL,
    code NUMERIC(5,2) NOT NULL,
    compound VARCHAR(15) NOT NULL,
    physician VARCHAR(10) NOT NULL,
    patient int NOT NULL,
    PRIMARY KEY (rx),
    FOREIGN KEY (physician) REFERENCES physician(drLicense),
    FOREIGN KEY (code) REFERENCES diagnostic(code),
    FOREIGN KEY (compound) REFERENCES drug(dName),
    FOREIGN KEY (patient) REFERENCES customer(id),
    CHECK (rx >=0)
);


INSERT INTO prescription(rx, expiration, quantity, admin,  refill, code, compound, physician, patient) VALUES
    (12, TO_DATE('2016-11-23', 'yyyy-mm-dd'), 40, 'pill', 2, 235.37, 'adderall', 'a1234', 1); 
INSERT INTO prescription(rx, expiration, quantity, admin, refill, code, compound, physician, patient) VALUES
    (73, TO_DATE('2016-11-17', 'yyyy-mm-dd'), 50, 'pill', 2, 342.12, 'ibuprofen', 'b3267', 2);
INSERT INTO prescription(rx, expiration, quantity, admin, refill, code, compound, physician, patient) VALUES
    (13, TO_DATE('2016-11-12', 'yyyy-mm-dd'), 50, 'fluid', 6, 434.23, 'codeine', 'a1234', 3); 
INSERT INTO prescription(rx, expiration, quantity, admin, refill, code, compound, physician, patient) VALUES
    (23, TO_DATE('2016-11-09', 'yyyy-mm-dd'), 30, 'pill', 3, 111.11, 'xanax', 'b3267', 1); 
INSERT INTO prescription(rx, expiration, quantity, admin, refill, code, compound, physician, patient) VALUES
    (15, TO_DATE('2016-11-12', 'yyyy-mm-dd'), 30, 'pill', 5, 113.18, 'nexium', 'z8188', 2); 


CREATE TABLE sale
(
    timestamp DATE NOT NULL,
    authorization INT NOT NULL,
    rx INT NOT NULL,
    FOREIGN KEY (rx) REFERENCES prescription(rx),
    FOREIGN KEY (authorization) REFERENCES payment(authorization)
);

INSERT INTO sale(timestamp, authorization, rx) VALUES
    (TO_DATE('2016-07-07 14:20', 'yyyy-mm-dd hh24:mi'), 1, 12);
INSERT INTO sale(timestamp, authorization, rx) VALUES
    (TO_DATE('2016-07-08 13:22', 'yyyy-mm-dd hh24:mi'), 2, 73);
INSERT INTO sale(timestamp, authorization, rx) VALUES
    (TO_DATE('2016-06-09 12:20', 'yyyy-mm-dd hh24:mi'), 3, 13);


CREATE TABLE treats
(
     compound VARCHAR(15) NOT NULL,
     code NUMERIC(5,2) NOT NULL,
     FOREIGN KEY (compound) REFERENCES drug(dName),
     FOREIGN KEY (code) REFERENCES diagnostic(code)
);

INSERT INTO treats (compound, code) VALUES
    ('adderall', 235.37);
INSERT INTO treats (compound, code) VALUES
    ('ibuprofen', 342.12);
INSERT INTO treats (compound, code) VALUES
    ('codeine', 434.23);
INSERT INTO treats (compound, code) VALUES
    ('xanax', 111.11);
INSERT INTO treats (compound, code) VALUES
    ('nexium', 113.18);    

CREATE TABLE allergy
(
    name INT NOT NULL,
    compound VARCHAR(15) NOT NULL,
    FOREIGN KEY (name) REFERENCES customer(id),
    FOREIGN KEY (compound) REFERENCES drug(dName)
);

INSERT INTO allergy(name, compound) VALUES
    (1, 'codeine');
INSERT INTO allergy(name, compound) VALUES
    (2, 'adderall');
INSERT INTO allergy(name, compound) VALUES
    (3, 'ibuprofen');

