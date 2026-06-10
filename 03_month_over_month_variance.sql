with monthly_totals as (
	   select format(cast(claimdate as date), 'yyyy-MM') as year_mo,
	   sum(claimamount) as total_amt
from claims
group by format(cast(claimdate as date), 'yyyy-MM')
)

select year_mo,
	   total_amt,
	   LAG(total_amt, 1) OVER (ORDER BY year_mo) AS prev_month_amount,
	   (total_amt - LAG(total_amt, 1) OVER (ORDER BY year_mo) ) as variance_amt,
	   cast((total_amt - LAG(total_amt, 1) OVER (ORDER BY year_mo))/LAG(total_amt, 1) OVER (ORDER BY year_mo) * 100 as decimal(10,2)) as variance_pct
from monthly_totals
order by year_mo