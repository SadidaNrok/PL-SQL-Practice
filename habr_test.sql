/*������� ��������*/
create table habr_test_table_220414
(
  oper_id    number,
  client_id  number,
  input_date date,
  amount     number,
  constraint habr_test_table_220414_pk primary key (oper_id)
);
grant all on habr_test_table_220414 to public;

/*��� ����, ����� ���� oper_id ���� ���������� - �������� ������������������*/
create sequence habr_test_sequence_220414 increment by 1;
grant all on habr_test_sequence_220414 to public;
/*� �������, ������� ��� ������� � �������, ����� ��������� �������� oper_id �� ��������� ������� ������������������*/
create trigger habr_test_trigger_220414
before insert
   on habr_test_table_220414
   for each row
begin
   :new.oper_id := habr_test_sequence_220414.nextval;
end;

/*��������� �������� ������� � �� ������� ��� ������ ��������� �� �������������� ����������*/
/*��� ����� ������ ������ � ���, ����� ���������� �������� � 10-��� ���������*/
/*��� ����, ����� ��� �� ��������� cost = 3, �������� �������� 20000 �����, ���� ���� �� �������*/
/*������ ��� ������ - ��������� �������� ���������� ������� � ��������� ��� �������� ���������� counter */
declare
  counter number := 10000;
  i       number := 0;
begin
   loop
   insert into habr_test_table_220414 
      (
         client_id
       , input_date
       , amount
      ) 
   values
      (
         trunc (dbms_random.value (1, 11))
       , to_date(trunc(dbms_random.value(to_char(date '2013-01-01','j'),to_char(date '2013-12-31','j'))),'j')
       , trunc (dbms_random.value (1, 100000))
      );
   exit when (i = counter);
    i := i + 1;
   end loop;
   commit;
/*���� ���������� ������������� ��������, ����� �� ����� ���������� ����� �� ��������� ������ �������*/
/*�������� ����� �������:*/
  insert into habr_test_table_220414 select * from habr_test_table_220414;
  commit;
/*� � ������������ id �������� ����������� �������*/
end;