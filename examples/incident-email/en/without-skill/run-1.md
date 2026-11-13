**To:** Laura Bennett
**Subject:** Billing API errors yesterday evening, 12 Nov, 18:00 to 18:40

Hi Laura,

Yesterday evening, from about 18:00 to 18:40, the billing API returned 502 errors for a large share of requests (around 60% at the worst point). In that window Northern Freight sent 214 requests that got a 502.

The cause was on our side. At 17:55 we changed the health check on our load balancer. Two of the three servers behind it didn't support the new check, so the load balancer marked them as down and stopped sending them traffic, even though they were working normally. We were paged at 18:02 and found the cause soon after. Rolling the change back took longer than it should have, because a stuck job in our deployment pipeline was blocking changes. The rollback went out at 18:38, and by 18:40 the error rate was back to zero.

Your data is fine. The requests that got a 502 were stopped at the load balancer and never reached the application, so nothing was half-written. Every invoice created in that window that got a 200 is stored correctly.

Your integration retries each request 3 times, so some of the 214 will have gone through on a later attempt. Any that still failed can be sent again as they are. The API is idempotent on invoice number, so resending an invoice that already went through won't create a duplicate. If it would help your team, we can send you the list of the 214 failed requests from our logs to check against your records.

We've made two changes since:

- We now get an alert as soon as fewer than two servers are healthy. Until now we only alerted on the error rate.
- Any change to the load balancer now needs a second person to review it before it goes out.

Sorry for the disruption. If anything on your side still looks off, let me know and we'll look at it straight away.

Best,
[Your name]
