
/*
Задача 1. Посчитать % изменение количества клиентов, совершивших покупку, месяц-к-месяцу
*/

begin try
drop table #client_order
end try

begin catch
end catch

select * into #client_order from (

select 1 as client_id, 1 as order_id, '01/01/2021' as order_date union all
select 1 as client_id, 2 as order_id, '02/01/2021' as order_date union all
select 2 as client_id, 3 as order_id, '30/01/2021' as order_date union all
select 3 as client_id, 4 as order_id, '30/01/2021' as order_date union all
select 1 as client_id, 5 as order_id, '31/01/2021' as order_date union all

select 1 as client_id, 6 as order_id, '01/02/2021' as order_date union all
select 1 as client_id, 7 as order_id, '02/02/2021' as order_date union all
select 2 as client_id, 8 as order_id, '27/02/2021' as order_date union all
select 1 as client_id, 9 as order_id, '27/02/2021' as order_date union all
select 1 as client_id, 10 as order_id, '28/02/2021' as order_date union all

select 1 as client_id, 11 as order_id, '01/03/2021' as order_date union all
select 2 as client_id, 12 as order_id, '02/03/2021' as order_date union all
select 3 as client_id, 13 as order_id, '30/03/2021' as order_date union all
select 1 as client_id, 14 as order_id, '30/03/2021' as order_date union all
select 1 as client_id, 15 as order_id, '31/03/2021' as order_date

) as q

select month, client_cnt, lag(client_cnt) over(order by month) as client_cnt_prev_month, 100.0*client_cnt/(lag(client_cnt) over(order by month)) as relation
from (
	select
		dateadd(dd, -day(order_date)+1, order_date) as month,
		count(distinct client_id) as client_cnt
	from #client_order
	group by dateadd(dd, -day(order_date)+1, order_date)
) as q

/*
Comments

Вывод: первое число месяца, количество клиентов в этом месяце, количество клиентов в прошлом месяце, отношение количества клиентов в рассматриваемом месяце к прошлому.
Запрос выводит результаты по фактическим месяцам из таблицы,
то есть, если в какой-то месяц не было ни одного заказа, он пропускается.
*/

/*
Задача 2. Вывести сумму GMV (Gross Merchandise Value) с нарастающим итогом по дням.
*/

begin try
drop table #gross_merchandaise_value
end try

begin catch
end catch

select * into  #gross_merchandaise_value from (

select '01/01/2021' as fact_date, 4372888 as gmv union all
select '29/12/2020' as fact_date, 9556268 as gmv union all
select '12/01/2021' as fact_date, 2752858 as gmv union all
select '08/12/2020' as fact_date, 8701993 as gmv union all
select '04/01/2021' as fact_date, 7779666 as gmv

) as q

select fact_date, gmv, sum(gmv) over(order by fact_date) as cumulative_sum
from #gross_merchandaise_value
order by fact_date

/*
Comments ...
*/

/*
Задача 3. Получить время отклика на каждое письмо (письмо идентифицируется по полю mail_id), отправленное пользователем mr_employee@ozon.ru.
Дана таблица с логом электронных писем пользователя mr_employee@ozon.ru (т.е. письма, отправленные с
этой электронной почты и полученные на нее).
У всех цепочек сообщений уникальная тема. В одной цепочке может быть несколько писем.
*/

begin try
drop table #mails;
end try

begin catch
end catch

select * into  #mails from (

select 1 as mail_id, 'mr_employee@ozon.ru' as mail_from, 'ms_intern@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-08T12:00:03' as datetime) as timestamp union all
select 2 as mail_id, 'mr_employee@ozon.ru' as mail_from, 'ms_intern@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-08T12:01:10' as datetime) as timestamp union all
select 3 as mail_id, 'mr_employee@ozon.ru' as mail_from, 'ms_intern@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-08T12:02:03' as datetime) as timestamp union all
select 4 as mail_id, 'ms_intern@ozon.ru' as mail_from, 'mr_employee@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-10T13:41:34' as datetime) as timestamp union all
select 5 as mail_id, 'ms_intern@ozon.ru' as mail_from, 'mr_employee@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-10T13:44:34' as datetime) as timestamp union all
select 6 as mail_id, 'ms_intern@ozon.ru' as mail_from, 'mr_employee@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-10T13:45:34' as datetime) as timestamp union all
select 7 as mail_id, 'mr_employee@ozon.ru' as mail_from, 'mr_boss@ozon.ru' as mail_to, 'Отчет по продажам 2021-01-10' as mail_subject, cast('2021-01-11T15:02:57' as datetime) as timestamp union all
select 8 as mail_id, 'mr_boss@ozon.ru' as mail_from, 'mr_employee@ozon.ru' as mail_to, 'Отчет по продажам 2021-01-10' as mail_subject, cast('2021-01-18T11:03:08' as datetime) as timestamp union all
select 9 as mail_id, 'stranger@ozon.ru' as mail_from, 'mr_employee@ozon.ru' as mail_to, 'Хотите заработать денег?' as mail_subject, cast('2021-01-18T12:16:44' as datetime) as timestamp union all
select 10 as mail_id, 'mr_employee@ozon.ru' as mail_from, 'ms_intern@ozon.ru' as mail_to, 'Задание для практики' as mail_subject, cast('2021-01-20T19:48:54' as datetime) as timestamp


) as q
;

with mails as (select mail_id, mail_from, mail_to, mail_subject, timestamp, ROW_NUMBER() over(partition by mail_from, mail_to, mail_subject order by timestamp) as mail_block_number
from #mails)

select

	m.mail_id, m.mail_from, m.mail_to, m.mail_subject, m.timestamp

	,datediff(MINUTE,  m.timestamp,
			(select top 1 m1.timestamp
			 from mails m1
			 where m1.mail_subject = m.mail_subject
					and m1.mail_to = m.mail_from
					and m1.timestamp >= m.timestamp
					and m.mail_block_number = 1
			order by m1.timestamp asc
			)
			) as response_minutes

	,(select top 1 m1.mail_id
	  from mails m1
	  where m1.mail_subject = m.mail_subject
			and m1.mail_to = m.mail_from
			and m1.timestamp >= m.timestamp
			and m.mail_block_number = 1
	  order by m1.timestamp asc
	  ) as response_mail_id

	,(select top 1 m1.timestamp
	  from mails m1
	  where m1.mail_subject = m.mail_subject
			and m1.mail_to = m.mail_from
			and m1.timestamp >= m.timestamp
			and m.mail_block_number = 1
	  order by m1.timestamp asc
	  ) as response_timestamp

from mails m
where m.mail_from = 'mr_employee@ozon.ru'
order by m.timestamp

/*
Comments

Время отклика вычисляется в минутах.
Время отклика считается относительно первого ответного письма.
В случае ситуации, когда было отправлено несколько писем подряд по одной теме одному адресату,
время отклика посчитается только для первого отправленного письма, остальным проставится NULL. Для этого используется mail_block_number в представлении.

*/

/*
Задача 4. Вывести id сотрудников с разницей в заработной плате в пределах 5000 рублей.
*/

begin try
drop table #employee_salary;
end try

begin catch
end catch

select * into  #employee_salary from (

select 2 as  employee_id, 100000 as salary_rub union all
select 1 as  employee_id, 105000 as salary_rub union all
select 3 as  employee_id, 68000 as salary_rub union all
select 4 as  employee_id, 112000 as salary_rub union all
select 6 as  employee_id, 118000 as salary_rub union all
select 5 as  employee_id, 123000 as salary_rub

) as q
;

select distinct es1.employee_id, es1.salary_rub
from #employee_salary es1
	join #employee_salary es2 on abs(es1.salary_rub-es2.salary_rub) <= 5000 and es1.employee_id<>es2.employee_id
order by es1.salary_rub, es1.employee_id

/*
Comments ...
*/
