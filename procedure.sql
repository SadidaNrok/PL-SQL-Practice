CREATE OR REPLACE PROCEDURE format_string
(str IN OUT VARCHAR2)
IS
BEGIN
    str := '[' || str || ']';
END;

SET SERVEROUTPUT ON;
DECLARE
    str VARCHAR2(10):='GROUP';
BEGIN
    format_string(str);
    dbms_output.put_line(str);
END;


VARIABLE session_var VARCHAR2(30)
CALL join_strings('Hello', 'World') INTO :session_var;
EXECUTE format_string(:session_var);