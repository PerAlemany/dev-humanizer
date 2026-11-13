Subject: Billing API errors on Thursday evening, 18:00–18:40

Hi Laura,

Between about 18:00 and 18:40 yesterday (Thursday 12 November), roughly 60% of requests to our billing API failed with a 502 error. Northern Freight sent 214 requests that got a 502 in that window. Your integration retries three times, so some of them went through on a later attempt. The rest didn't and need to be resent.

Resending is safe. The API is idempotent by invoice number, so an invoice that already went through won't be created twice. If it's easier for your team, you can simply resend every invoice from that window.

Nothing was lost or half-written on our side. Every request that got a 200 is stored. The ones that got a 502 were stopped at our load balancer and never reached the billing application.

The cause was a change to the load balancer's health check, made just before 18:00. The new check pointed to an endpoint that two of our three servers don't have. The load balancer marked those two as unhealthy and stopped sending them traffic, although they were working normally. We reverted the change at 18:38, and by 18:40 the error rate was back to zero.

We've made two changes since. We now get an alert as soon as fewer than two servers are healthy, rather than only when the error rate goes up. And from today, every load balancer change needs a second reviewer before it goes out.

Sorry for the trouble this caused your team.

Best,
