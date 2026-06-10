select 
	claimstatus, 
	count(claimid) as total_claims, 
	CAST(sum(claimamount) as DECIMAL(10,2)) as total_claimamount, 
	CAST(avg(claimamount) AS DECIMAL(10,2)) as avg_claimamount
from claims
group by claimstatus
order by total_claimamount DESC