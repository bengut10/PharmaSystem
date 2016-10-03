
CREATE TABLE physician
(
  drlicense CHAR(255) NOT NULL,
  name CHAR(255) NOT NULL,
  phone NUMERIC(12,0) NOT NULL,
  PRIMARY KEY (drlicense)
)
/

CREATE TABLE drug
(
  compound CHAR(255) NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (compound)
)
/

CREATE TABLE diagnostic
(
  code NUMERIC(5,2) NOT NULL,
  description CHAR(255) NOT NULL,
  PRIMARY KEY (code)
)
/

CREATE TABLE insurance
(
  policy CHAR(255) NOT NULL,
  name CHAR(255) NOT NULL,
  copay FLOAT NOT NULL,
  PRIMARY KEY (policy)
)
/

CREATE TABLE supports
(
  policy CHAR(255) NOT NULL,
  compound CHAR(255) NOT NULL,
  FOREIGN KEY (policy) REFERENCES insurance(policy),
  FOREIGN KEY (compound) REFERENCES drug(compound)
)
/

CREATE TABLE inventory
(
  location INT NOT NULL,
  quantity INT NOT NULL,
  compound CHAR(255) NOT NULL,
  FOREIGN KEY (compound) REFERENCES drug(compound)
)
/

CREATE TABLE medPrescription
(
  expiration DATE NOT NULL,
  rx INT NOT NULL,
  quantity INT NOT NULL,
  admin CHAR(255) NOT NULL,
  indication CHAR(255),
  refill INT NOT NULL,
  code NUMERIC(5,2) NOT NULL,
  compound CHAR(255) NOT NULL,
  PRIMARY KEY (rx),
  FOREIGN KEY (code) REFERENCES diagnostic(code),
  FOREIGN KEY (compound) REFERENCES drug(compound),
  UNIQUE ()
)
/

CREATE TABLE payment
(
  authorizarion INT NOT NULL,
  cost FLOAT NOT NULL,
  policy CHAR(255) NOT NULL,
  compound CHAR(255) NOT NULL,
  PRIMARY KEY (authorizarion),
  FOREIGN KEY (policy) REFERENCES insurance(policy),
  FOREIGN KEY (compound) REFERENCES drug(compound)
)
/

CREATE TABLE transaction
(
  timestamp DATE NOT NULL,
  authorizarion INT NOT NULL,
  FOREIGN KEY (authorizarion) REFERENCES payment(authorizarion)
)
/

CREATE TABLE customer
(
  name CHAR(255) NOT NULL,
  dob DATE NOT NULL,
  phone INT NOT NULL,
  ssn INT NOT NULL,
  address CHAR(255) NOT NULL,
  policy CHAR(255) NOT NULL,
  PRIMARY KEY (ssn),
  FOREIGN KEY (policy) REFERENCES insurance(policy)
)
/

CREATE TABLE treats
(
  compound CHAR(255) NOT NULL,
  code NUMERIC(5,2) NOT NULL,
  FOREIGN KEY (compound) REFERENCES drug(compound),
  FOREIGN KEY (code) REFERENCES diagnostic(code)
)
/

CREATE TABLE consults
(
  ssn INT NOT NULL,
  drlicense CHAR(255) NOT NULL,
  FOREIGN KEY (ssn) REFERENCES customer(ssn),
  FOREIGN KEY (drlicense) REFERENCES physician(drlicense)
)
/

CREATE TABLE cPrescription
(
  ssn INT NOT NULL,
  rx INT NOT NULL,
  FOREIGN KEY (ssn) REFERENCES customer(ssn),
  FOREIGN KEY (rx) REFERENCES medPrescription(rx)
)
/

CREATE TABLE allergy
(
  ssn INT NOT NULL,
  compound CHAR(255) NOT NULL,
  FOREIGN KEY (ssn) REFERENCES customer(ssn),
  FOREIGN KEY (compound) REFERENCES drug(compound)
);

  
