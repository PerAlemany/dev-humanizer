Subject: Billing API errors yesterday evening (18:00–18:40)

Hi Laura,

Yesterday (Thursday) between about 18:00 and 18:40, our billing API returned 502 errors for about 60% of requests. Our load balancer logs show 214 failed requests from Northern Freight in that window. Your integration retries three times, so some of them went through later, but not all of them.

The failed requests never reached our application, so nothing was half-written. Every invoice that got a 200 response in that window is in our system. The API is idempotent by invoice number, so your team can resend the ones that failed. Resending an invoice that already went through won't create a duplicate.

The cause was a change to our load balancer's health check at 17:55. The new check pointed to an endpoint that two of our servers don't have, so the load balancer marked them as unhealthy even though they were working. We reverted the change at 18:38 and the error rate was back to zero by 18:40.

Until now we only alerted on the error rate. We've added an alert that fires when fewer than two servers are healthy. From today, every load balancer change also needs a second reviewer.

Sorry for the trouble this caused your team.

Best,
