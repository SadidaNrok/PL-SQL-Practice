SET SERVEROUTPUT ON
DECLARE
    CURSOR c IS SELECT * 
    FROM HABR_TEST_TABLE_220414;
BEGIN
    FOR i IN c LOOP
        dbms_output.put_line('Date: '||i.input_date);
        EXIT WHEN i.input_date = to_date('30.12.2021','DD.MM.YYYY');
    END LOOP;
END;

DECLARE
    d habr_test_table_220414.input_date%TYPE;
    CURSOR c IS SELECT input_date 
    FROM HABR_TEST_TABLE_220414;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO d;
        EXIT WHEN c%NOTFOUND;
        dbms_output.put_line('Date: '||d);
    END LOOP;
    CLOSE c;
END;

DECLARE
    d habr_test_table_220414.input_date%TYPE;
    CURSOR c IS SELECT input_date 
    FROM HABR_TEST_TABLE_220414;
BEGIN
    OPEN c;
    WHILE c%ISOPEN LOOP
        FETCH c INTO d;
        IF c%NOTFOUND THEN
            CLOSE c;
        END IF;
        dbms_output.put_line('Date: '||d);
    END LOOP;
END;