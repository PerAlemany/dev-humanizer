Subject: Billing API errors yesterday between 18:00 and 18:40

Hi Laura,

Yesterday between 18:00 and 18:40 our billing API returned 502 errors for part of its traffic, and 214 of Northern Freight's requests were affected. Your integration retries three times, so some of them went through later. The rest need to be resent. It's safe to resend all 214: the API is idempotent by invoice number, so an invoice that already went through won't be created twice.

Nothing was lost or half-written. Every invoice that got a 200 in that window is in our system, and the requests that got a 502 never reached the application.

The cause was a change to our load balancer's health check at 17:55. The new check looked for a health endpoint that two of our three servers don't have, so the load balancer marked them as unhealthy even though they were working, and about 60% of requests failed. We were paged at 18:02, reverted the change at 18:38, and errors were back to zero by 18:40.

We've added an alert that fires as soon as fewer than two servers are healthy. Until now we only alerted on the error rate. And from today, every load balancer change needs a second reviewer.

Sorry for the disruption.

Best,
