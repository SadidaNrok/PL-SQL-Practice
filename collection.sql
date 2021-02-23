DECLARE
    --Запись
    TYPE demo_record IS RECORD
    (id NUMBER, value VARCHAR2(10));
    demo DEMO_RECORD;
    --Массив
    TYPE number_varray IS VARRAY(10) OF NUMBER;
    arr NUMBER_VARRAY;
    --Вложенная таблица
    TYPE number_table IS TABLE OF NUMBER;
    tbl NUMBER_TABLE;
    --Ассоциативный массив с числовым индексом
    TYPE number_list IS TABLE OF NUMBER
    INDEX BY PLS_INTEGER NOT NULL;
    n_lst NUMBER_LIST;
    --Ассоциативный массив со строковым индексом
    TYPE char_list IS TABLE OF NUMBER
    INDEX BY VARCHAR2(10) NOT NULL;
    c_list CHAR_LIST;
BEGIN
    demo:=DEMO_RECORD(1,'10');
    arr:=NUMBER_VARRAY(1,4,5,3,8,9,6,5,0,2);
    dbms_output.PUT_LINE('['||demo.id||']['||demo.value||']');
    ----------------------------------------------------
    FOR i IN 1..arr.LIMIT LOOP
        dbms_output.PUT('['||arr(i)||']');
    END LOOP;
    dbms_output.new_line;
    ----------------------------------------------------
    tbl:=NUMBER_TABLE(1,2,3,4,5,6,7);
    tbl.DELETE(2);
    FOR i IN 1..tbl.COUNT LOOP
        IF tbl.EXISTS(i) THEN
            dbms_output.PUT('['||tbl(i)||']');
        END IF;
    END LOOP;
    dbms_output.new_line;
    ----------------------------------------------------
    FOR i IN 1..6 LOOP
        n_lst(i):=i*2;
    END LOOP;
    n_lst.DELETE(2);
    FOR i IN 1..n_lst.COUNT LOOP
        IF n_lst.EXISTS(i) THEN
            dbms_output.PUT('['||n_lst(i)||']');
        END IF;
    END LOOP;
    dbms_output.new_line;
    ----------------------------------------------------
    c_list('a'):=1;
    c_list('b'):=2;
    c_list('c'):=3;
    
END;