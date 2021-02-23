--� ��� ���� ������� ��������, � ��� 4 �������: 
--id ��������, id �������, ���� ��������, ����� ��������. 
--����� ������� ��������� �������� �� ������� �������
--� ������������ ������ �� ������������ ������.

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