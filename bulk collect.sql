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
    -- ���������� ��������� ���� ������.
    TYPE id_collection IS TABLE OF NUMBER;
    TYPE parent_collection IS TABLE OF NUMBER;
    -- ���������� ��������� ����������,
    id_coll ID_COLLECTION;
    parent_coll PARENT_COLLECTION;
    -- ���������� ����������� ������.
    CURSOR c IS
        SELECT id, idparent
        FROM test;
BEGIN
    OPEN c;
    LOOP
        -- ������ �� ��� ������ �� ���
        FETCH c BULK COLLECT INTO id_coll, parent_coll LIMIT 3;
        EXIT WHEN id_coll.COUNT = 0;
        FOR i IN 1..id_coll.COUNT LOOP
            dbms_output.put('ID [' || id_coll(i) || ']');
            dbms_output.put(' IDPARENT [' || parent_coll(i) || ']');
            dbms_output.new_line();
        END LOOP;
    END LOOP;
END;

DECLARE
    TYPE record_type IS RECORD
    (id NUMBER, idparent NUMBER, value NUMBER);
    TYPE collection IS TABLE OF RECORD_TYPE;
    dataset COLLECTION;
    CURSOR c IS SELECT * FROM test;
BEGIN
    OPEN c;
    LOOP
        FETCH c BULK COLLECT INTO dataset LIMIT 3;
        EXIT WHEN dataset.count = 0;
        FOR i IN 1..dataset.count LOOP
            dbms_output.put('ID [' || dataset(i).id || ']');
            dbms_output.put(' IDPARENT [' || dataset(i).idparent || ']');
            dbms_output.put(' VALUE [' || dataset(i).value || ']');
            dbms_output.new_line();
        END LOOP;
    END LOOP;
    CLOSE c;
END;
