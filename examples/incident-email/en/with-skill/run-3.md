Subject: Billing API errors yesterday, 18:00–18:40

Hi Laura,

Between 18:00 and 18:40 yesterday (Thursday 12 Nov), our billing API returned 502 errors for about 60% of requests. 214 of Northern Freight's requests got a 502 in that window. Your integration retries three times, so some of them went through later, but others may still be missing on our side and will need to be resent.

Resending is safe. The API is idempotent by invoice number, so an invoice that already went through won't be created twice. Nothing was half-written either. The requests that got a 502 never reached the application, and every invoice from that window that got a 200 is stored.

The cause was a change to our load balancer's health check at 17:55. The new check pointed to an endpoint that two of our nodes don't have, so the load balancer marked them as unhealthy even though they were working. We reverted the change at 18:38, and the error rate was back to zero at 18:40.

Until now we only alerted on the error rate. We've added an alert for when fewer than two nodes are healthy, and from today any load balancer change needs a second reviewer.

Sorry for the disruption.

Best,
