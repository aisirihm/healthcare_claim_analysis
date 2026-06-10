with denied_claims as (
select providerspecialty, count(claimid) as denied_count
from claims
where claimstatus = 'Denied'
group by providerspecialty
)
select top 5 a.providerspecialty, a.denied_count, count(b.claimid) as total_claims, cast(cast(a.denied_count as float)/count(b.claimid) * 100 as decimal(10,2)) as rejection_rate
from denied_claims a
join claims b
on a.providerspecialty = b.providerspecialty
group by a.providerspecialty, a.denied_count
order by rejection_rate DESC