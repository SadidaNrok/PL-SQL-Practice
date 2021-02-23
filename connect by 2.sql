SET SERVEROUTPUT ON;
DECLARE
    CURSOR c IS (SELECT ID, IDPARENT, VALUE FROM TEST
                WHERE VALUE IS NOT NULL
                START WITH ID = 9
                CONNECT BY PRIOR IDPARENT = ID);
                
    t TEST%ROWTYPE;
    d TEST.VALUE%TYPE;
BEGIN
    OPEN c;
    FETCH c INTO t;
    --dbms_output.put_line(d);
    CLOSE c;
END;