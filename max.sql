--У нас есть таблица операций, в ней 4 столбца: 
--id операции, id клиента, дата операции, сумма операции. 
--Нужно вывести последние операции по каждому клиенту
--с максимальной суммой за определенный период».

select * from
(
    select c.*
        , max(c.oper_id) over (partition by c.client_id) as m_o/*max_operation*/
    from
        (
        select t.*
        , max(t.amount) over (partition by t.client_id) as m_a/*max_amount*/
        from habr_test_table_220414 t
        ) c 
    where c.m_a = c.amount
) where m_o = oper_id;