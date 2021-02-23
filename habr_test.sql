/*создаем табличку*/
create table habr_test_table_220414
(
  oper_id    number,
  client_id  number,
  input_date date,
  amount     number,
  constraint habr_test_table_220414_pk primary key (oper_id)
);
grant all on habr_test_table_220414 to public;

/*ƒл€ того, чтобы поле oper_id было уникальным - создадим последовательность*/
create sequence habr_test_sequence_220414 increment by 1;
grant all on habr_test_sequence_220414 to public;
/*и триггер, который при вставке в таблицу, будет подмен€ть значение oper_id на следующий элемент последовательности*/
create trigger habr_test_trigger_220414
before insert
   on habr_test_table_220414
   for each row
begin
   :new.oper_id := habr_test_sequence_220414.nextval;
end;

/*Ќаполн€ем табличку данными и да поможет нам рандом заполнить ее разнообразными значени€ми*/
/*ƒл€ теста примем период в год, также рассмотрим ситуацию с 10-тью клиентами*/
/*ƒл€ того, чтобы нам не выдавалс€ cost = 3, наполним табличку 20000 строк, если кому то хочетс€*/
/*больше или меньше - разделите желаемое количество пополам и присвойте это значение переменной counter */
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
/*ƒабы обеспечить возникновение ситуации, когда мы имеем одинаковые суммы по операци€м одного клиента*/
/*выполним такую команду:*/
  insert into habr_test_table_220414 select * from habr_test_table_220414;
  commit;
/*а о уникальности id операции позаботитс€ триггер*/
end;