--У нас есть таблица операций, в ней 4 столбца: 
--id операции, id клиента, дата операции, сумма операции. 
--Нужно вывести последние операции по каждому клиенту
--с максимальной суммой за определенный период».

select * from
(
    select c.*
        , dense_rank() over (partition by c.client_id order by c.oper_id desc) as m_o/*max_operation*/
    from
        (
        select t.*
        , dense_rank() over (partition by t.client_id order by t.amount desc) as m_a/*max_amount*/
        from habr_test_table_220414 t
        ) c 
    where c.m_a = 1
) where m_o = 1;