with providers_avg_amt as (
		select providerid,
			   providerspecialty,
			   avg(claimamount) as avg_claim_amt
			   
		from
		claims
		group by providerid,
			   providerspecialty
		),
	specialty_avg as (
		select providerspecialty,
			   avg(claimamount) as avg_specialty_claim_amt
		from 
				claims
		group by providerspecialty)

select a.providerid, a.providerspecialty, a.avg_claim_amt, b.avg_specialty_claim_amt,
		(case when a.avg_claim_amt > b.avg_specialty_claim_amt * 2 then 'Unusual' 
		else 'Normal' end) as flag
		from providers_avg_amt a
		join specialty_avg b
		on a.providerspecialty = b.providerspecialty
		order by providerspecialty