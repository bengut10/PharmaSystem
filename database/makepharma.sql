

CREATE TABLE physician
(
    drLicense CHAR(255),
    dName CHAR(255) NOT NULL,
    phone NUMERIC(10,0) NOT NULL UNIQUE,
    PRIMARY KEY (drLicense)
);

INSERT INTO physician(drLicense, dName, phone) VALUES
    ('a1234', 'Roger Smith', 5129672324);
INSERT INTO physician(drLicense, dName, phone) VALUES
    ('b3267', 'Frank James', 5129835670);
INSERT INTO physician(drLicense, dName, phone) VALUES
    ('g1184', 'Ray Lopez', 5129065324);


CREATE TABLE drug
(
    dName CHAR(255),
    price FLOAT NOT NULL,
    PRIMARY KEY(dName)
);

INSERT INTO drug(dName, price) VALUES
    ('adderall', .99);
INSERT INTO drug(dName, price) VALUES
    ('ibuprofen', .29);
INSERT INTO drug(dName, price) VALUES
    ('codeine', 1.49);

CREATE TABLE diagnostic
(
  code NUMERIC(5,2),
  description CHAR(255) NOT NULL,
  PRIMARY KEY (code)
);

INSERT INTO diagnostic(code, description) VALUES
    (434.23, 'severe pain');
INSERT INTO diagnostic(code, description) VALUES
    (235.37, 'narcolepsy');
INSERT INTO diagnostic(code, description) VALUES
    (342.12, 'mild pain');

CREATE TABLE insurance
(
  policy CHAR(255),
  name CHAR(255) NOT NULL,
  copay FLOAT NOT NULL,
  PRIMARY KEY (policy)
);

CREATE TABLE supports
(
  policy CHAR(255) NOT NULL,
  compound CHAR(255) NOT NULL,
  FOREIGN KEY (policy) REFERENCES insurance(policy),
  FOREIGN KEY (compound) REFERENCES drug(dName)
);


CREATE TABLE inventory
(
  location INT NOT NULL, --Reffers to a isle number in the store.--
  quantity INT NOT NULL,
  compound CHAR(255) NOT NULL,
  FOREIGN KEY (compound) REFERENCES drug(dName)
);

CREATE TABLE payment
(
  authorizarion INT,
  cost FLOAT NOT NULL,
  policy CHAR(255) NOT NULL,
  compound CHAR(255) NOT NULL,
  PRIMARY KEY (authorizarion),
  FOREIGN KEY (policy) REFERENCES insurance(policy),
  FOREIGN KEY (compound) REFERENCES drug(dName)
);

CREATE TABLE customer
(
  id INT,
  name CHAR(255) NOT NULL,
  dob DATE NOT NULL,
  phone INT NOT NULL,
  address CHAR(255) NOT NULL,
  policy CHAR(255) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (policy) REFERENCES insurance(policy)
);

CREATE TABLE prescription
(
  rx INT,
  expiration DATE NOT NULL,
  quantity INT NOT NULL,
  admin CHAR(255) NOT NULL,
  indication CHAR(255), --may be null
  refill INT NOT NULL,
  code NUMERIC(5,2) NOT NULL,
  compound CHAR(255) NOT NULL,
  physician CHAR(255) NOT NULL,
  patient int NOT NULL,
  PRIMARY KEY (rx),
  FOREIGN KEY (physician) REFERENCES physician(drLicense),
  FOREIGN KEY (code) REFERENCES diagnostic(code),
  FOREIGN KEY (compound) REFERENCES drug(dName),
  FOREIGN KEY (patient) REFERENCES customer(id)
);

CREATE TABLE sale
(
  timestamp DATE NOT NULL,
  authorizarion INT NOT NULL,
  rx INT NOT NULL,
  FOREIGN KEY (rx) REFERENCES prescription(rx),
  FOREIGN KEY (authorizarion) REFERENCES payment(authorizarion)
);

CREATE TABLE treats
(
  compound CHAR(255) NOT NULL,
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
    

CREATE TABLE allergy
(
  name INT NOT NULL,
  compound CHAR(255) NOT NULL,
  FOREIGN KEY (name) REFERENCES customer(id),
  FOREIGN KEY (compound) REFERENCES drug(dName)
);

