set serveroutput on

declare
    a varchar2(1);
    e EXCEPTION;
begin
    declare
        b varchar2(2) := 'rt';
    begin
        raise e; --��������� ���������� 1
    exception
        when others then -- �������������� ���������� 1
        a:=b; --��������� ���������� 2
        DBMS_OUTPUT.PUT_LINE('�� ����� �� ���� ������');
    end;
exception
    when others then -- �������������� ���������� 2
    DBMS_OUTPUT.PUT_LINE('����������� �� ������� ����� [' || SQLERRM || ']');
end;

begin
    declare
        a varchar2(1) := '&1'; -- ��������� ���������� ��� ����� ���������� ��������
    begin
        DBMS_OUTPUT.PUT_LINE('�������� ���������� ����������� [' || a || ']');
    exception
        when others then -- ����� ���������� �� ��������������
        DBMS_OUTPUT.PUT_LINE('����������� ��������� ����������');
    end;
exception
    when others then -- �������������� ����������
    DBMS_OUTPUT.PUT_LINE('����������� ������� ����������');
end;