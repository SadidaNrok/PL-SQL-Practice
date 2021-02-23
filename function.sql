CREATE OR REPLACE FUNCTION join_strings
(str1 VARCHAR2, str2 VARCHAR2)
RETURN VARCHAR2
IS
BEGIN
    RETURN str1 || ' ' || str2;
END;

SET SERVEROUTPUT ON
DECLARE
    str1 VARCHAR2(20):='Hello';
    str2 VARCHAR2(20):='world';
    str3 VARCHAR2(30);
BEGIN
    dbms_output.put_line(join_strings(str1,str2));
    str3:=join_strings(str1,str2);
    dbms_output.put_line(str3);
END;


SELECT join_strings('Hello','world') FROM dual;


VARIABLE session_var VARCHAR2(30)
CALL join_strings('Hello','World') INTO :session_var;
SELECT :session_var FROM dual;

VARIABLE my_string VARCHAR2(30);
BEGIN
    :my_string:='Строковая константа.';
END;

