select providerid,
	   providerspecialty,
	   cast(sum(claimamount) as decimal(10,2)) as total_claimamount,
	   dense_rank() over (partition by providerspecialty order by sum(claimamount) desc) as specialty_rank
from claims
group by providerid,providerspecialty 
order by providerspecialty, specialty_rank