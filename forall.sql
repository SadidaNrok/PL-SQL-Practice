CREATE TABLE ITEM_TEMP
(item_id NUMBER,
item_title VARCHAR2(62),
item_subtitle VARCHAR2(60));

SET SERVEROUTPUT ON;

DECLARE
    TYPE id_collection IS TABLE OF NUMBER;
    TYPE title_collection IS TABLE OF VARCHAR2(60);
    TYPE subtitle_collection IS TABLE OF VARCHAR2(60);
    id ID_COLLECTION;
    title TITLE_COLLECTION;
    subtitle SUBTITLE_COLLECTION;
    CURSOR c IS SELECT item_id, item_title, item_subtitle
                FROM item_temp;
BEGIN
    OPEN c;
    LOOP
        FETCH c BULK COLLECT INTO id, title, subtitle LIMIT 10;
        EXIT WHEN title.COUNT = 0;
        FORALL i IN id.FIRST..id.LAST
        INSERT INTO item_temp VALUES(id(i), title(i), subtitle(i));
    END LOOP;
    FOR i IN 1..id.COUNT LOOP
        dbms_output.put('Вставлено [' || id(i) || ']');
        dbms_output.put_line('[' || SQL%BULK_ROWCOUNT(i) || ']');
    END LOOP;
    CLOSE c;
    COMMIT;
END;