--
--  Clean up the pharmacy database
--

set termout on
prompt Removing sample pharmacy database.  Please wait ...
set termout off
set feedback off

DROP TABLE allergy cascade constraint;
DROP TABLE treats cascade constraint;
DROP TABLE sale cascade constraint;
DROP TABLE prescription cascade constraint;
DROP TABLE customer cascade constraint;
DROP TABLE payment cascade constraint;
DROP TABLE inventory cascade constraint;
DROP TABLE supports cascade constraint;
DROP TABLE drug cascade constraint;
DROP TABLE diagnostic cascade constraint;
DROP TABLE insurance cascade constraint;
DROP TABLE physician cascade constraint;

purge recyclebin;

