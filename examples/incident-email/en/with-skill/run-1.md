Subject: Billing API errors on Thursday 12 November, 18:00–18:40

Hi Laura,

On Thursday between 18:00 and 18:40, about 60% of requests to our billing API failed with a 502 error. Northern Freight sent 214 requests that got a 502 in that window. Your integration retries three times, so some of them went through on a later attempt.

The ones that didn't can be resent as they are. The API is idempotent by invoice number, so resending an invoice that did get through won't create a duplicate. Nothing was lost or half-written: every request that got a 200 created its invoice, and the requests that got a 502 never reached the application.

The cause was a change we made to the load balancer's health check at 17:55. The new check pointed to an endpoint that two of our servers don't have, so the load balancer took them out of service even though they were working normally. We reverted the change at 18:38, and errors had stopped by 18:40.

We've since added an alert for when fewer than two servers are healthy, because until now we only alerted on the error rate. From today, any change to the load balancer also needs a second reviewer.

Sorry for the disruption to your team.

Best,
