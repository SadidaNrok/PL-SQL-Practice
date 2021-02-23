SET SERVEROUTPUT ON;
DECLARE
    CURSOR c IS (SELECT VALUE FROM TEST
                WHERE VALUE IS NOT NULL
                START WITH ID = 9
                CONNECT BY PRIOR IDPARENT = ID);
    d TEST.VALUE%TYPE;
BEGIN
    OPEN c;
    FETCH c INTO d;
    dbms_output.put_line(d);
    CLOSE c;
END;