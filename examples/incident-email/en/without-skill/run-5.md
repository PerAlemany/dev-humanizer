**To:** Laura Bennett
**Subject:** Billing API errors yesterday evening, 18:00 to 18:40

Hi Laura,

Yesterday evening, from about 18:00 to 18:40, the billing API returned 502 errors on roughly 60% of requests. Our load balancer logs show 214 requests from Northern Freight got one of those errors. I'm sorry for the trouble this caused your team.

**Your data**

- None of the requests that got a 502 reached the billing service. The load balancer rejected them before they got there, so nothing was half-written.
- Every invoice that got a 200 in that window was created. We checked each one against the database.
- Your integration retries up to 3 times, so some of the 214 went through on a later attempt. The rest were never created.

**What you need to do**

Resend the invoices that failed in that window. You can resend all of them without first checking which ones made it: the API matches on invoice number, so an invoice that already exists won't be created a second time. If it helps, we can send you the timestamps of the 214 failed requests from our logs.

**What happened**

At 17:55 we changed the health check on the load balancer in front of the billing API. The new check looked for an endpoint that two of our three servers don't have. The load balancer marked those two servers as down even though they were working fine, and requests sent their way failed.

We were alerted at 18:02 and found the cause at 18:15. Undoing the change took until 18:38, longer than it should have, because a stuck automated job had locked our infrastructure configuration and we had to clear the lock by hand first. The error rate was back to zero at 18:40.

**What we've changed**

- We now get an alert as soon as fewer than two servers are healthy. Until last night we only alerted on the error rate, so we'd only hear about a problem like this once requests were already failing.
- From today, every load balancer change needs a second engineer to review it before it goes out.

If anything looks off on your side, or you'd like the list of failed requests, just reply here.

Best,
[your name]
