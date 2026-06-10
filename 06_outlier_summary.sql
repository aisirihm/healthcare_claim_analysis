select providerspecialty,
		count(claimid) as total_claims,
		sum(case when is_outlier = 1 then 1 else 0 end) as total_outlier_claims,
		cast(cast(sum(case when is_outlier = 1 then 1 else 0 end) as float)/count(claimid) * 100 as decimal(10,2)) as outlier_pct,
		cast(avg(case when is_outlier = 1 then claimamount else null end) as decimal(10,2)) as avg_outlier_claimamount,
		cast(avg(case when is_outlier = 0 then claimamount else null end) as decimal(10,2)) as avg_normal_claimamount
from claims
group by providerspecialty
order by outlier_pct desc