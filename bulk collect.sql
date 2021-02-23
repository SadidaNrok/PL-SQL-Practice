SET SERVEROUTPUT ON;
DECLARE
    TYPE id_collection IS TABLE OF NUMBER;
    TYPE parent_collection IS TABLE OF NUMBER;
    id_coll ID_COLLECTION;
    par_coll PARENT_COLLECTION;
BEGIN
    SELECT id, idparent
    BULK COLLECT INTO id_coll, par_coll
    FROM test;
    
    FOR i IN 1..id_coll.COUNT LOOP
        dbms_output.put_line(id_coll(i)||' '||par_coll(i));
    END LOOP;
END;

DECLARE
    -- ќпредел€ем скал€рные типы данных.
    TYPE id_collection IS TABLE OF NUMBER;
    TYPE parent_collection IS TABLE OF NUMBER;
    -- ќпредел€ем локальные переменные,
    id_coll ID_COLLECTION;
    parent_coll PARENT_COLLECTION;
    -- ќпредел€ем статический курсор.
    CURSOR c IS
        SELECT id, idparent
        FROM test;
BEGIN
    OPEN c;
    LOOP
        FETCH c BULK COLLECT INTO id_coll, parent_coll LIMIT 3;
        EXIT WHEN id_coll.COUNT = 0;
        FOR i IN 1..id_coll.COUNT LOOP
            dbms_output.put('ID [' || id_coll(i) || ']');
            dbms_output.put(' IDPARENT [' || parent_coll(i) || ']');
            dbms_output.new_line();
        END LOOP;
    END LOOP;
END;