**Subject:** Billing API errors yesterday evening, 18:00–18:40

Hi Laura,

From about 18:00 to 18:40 yesterday (Thursday 12 November), the billing API returned 502 errors on roughly 60% of requests. Your integration got 214 of them. It's fixed and no data was corrupted, but some of your invoices from that window may not have been created and will need to be resent.

**What happened**

At 17:55 we changed the health check on the load balancer in front of the billing API. Two of our three servers run an older version that doesn't answer on the new check, so the load balancer marked them as down even though they were working. We were paged at 18:02, found the cause, reverted the change at 18:38, and errors stopped by 18:40. The revert took longer than it should have because a stuck job in our deployment tooling was blocking it, and we had to clear that by hand.

**What it means for you**

The requests that got a 502 never reached the application, so nothing was half-written. Every request that got a 200 created its invoice as normal.

Your integration retries three times, so some of the 214 went through on a later attempt. The rest were not processed. Resending is safe: the API is idempotent on invoice number, so an invoice we already have won't be created twice. The simplest fix is to resend every invoice from 18:00–18:40 that didn't get a 200. If you'd rather check first, send us the invoice numbers from that window and we'll tell you which ones we have.

**What we've changed**

- We now get an alert as soon as fewer than two servers are healthy. Until yesterday we only alerted on the error rate. This went in last night.
- From today, any change to the load balancer needs a second reviewer before it goes out.
- We're also looking into why our servers were on different versions, since that's what made the new check fail on two of them.

Sorry for the disruption. Happy to go through any of this on a call if that's useful.

Best,
[Your name]
