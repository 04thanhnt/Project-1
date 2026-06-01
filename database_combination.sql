with all_orders as(
select orderid,
	   customerid,
	   productid,
	   orderdate,
	   quantity,
	   revenue,
	   COGS
from orders_2023

union all
select orderid,
	   customerid,
	   productid,
	   orderdate,
	   quantity,
	   revenue,
	   COGS
from orders_2024

union all
select orderid,
	   customerid,
	   productid,
	   orderdate,
	   quantity,
	   revenue,
	   COGS
from orders_2025
)

select 
a.orderid,
a.customerid,
a.productid,
p.productname,
p.productcategory,
a.orderdate,
c.customerjoindate,
c.region,
a.quantity,
round(p.price,3) as price,
case when a.revenue is null then round(a.quantity * price,3)
	 else round(a.revenue,3) 
	 end as revenue,
round(p.base_cost,3) as base_cost,
round(a.COGS,3) as COGS,
round(coalesce(a.revenue, a.quantity*price) - a.COGS,3) as Gross_Profit
from all_orders a
left join customers c on a.customerid=c.customerid
left join products p on a.productid= p.productid
where a.customerid is not null
order by orderdate desc

