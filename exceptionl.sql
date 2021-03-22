set serveroutput on

declare
    a varchar2(1);
    e EXCEPTION;
begin
    declare
        b varchar2(2) := 'rt';
    begin
        raise e; --генерация исключения 1
    exception
        when others then -- обрабатывается исключение 1
        a:=b; --генерация исключения 2
        DBMS_OUTPUT.PUT_LINE('Не дошли до этой строки');
    end;
exception
    when others then -- обрабатывается исключение 2
    DBMS_OUTPUT.PUT_LINE('Перехвачено во внешнем блоке [' || SQLERRM || ']');
end;

begin
    declare
        a varchar2(1) := '&1'; -- генерация исключения при вводе нескольких символов
    begin
        DBMS_OUTPUT.PUT_LINE('Значение переменной подстановки [' || a || ']');
    exception
        when others then -- здесь исключение не обрабатывается
        DBMS_OUTPUT.PUT_LINE('Перехвачено локальное исключение');
    end;
exception
    when others then -- обрабатывается исключение
    DBMS_OUTPUT.PUT_LINE('Перехвачено внешнее исключение');
end;