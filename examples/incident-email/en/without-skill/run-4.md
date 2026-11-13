**Subject:** Billing API errors yesterday, 17:55–18:40: what happened and what to resend

Hi Laura,

Yesterday evening (Thursday 12 November), from about 17:55 to 18:40, part of the requests to our billing API failed with a 502 error. Northern Freight sent 214 requests that got a 502 in that window.

**What you need to do**

Your integration retries each request 3 times, so some of those 214 went through on a later attempt. Any that still failed after the last retry need to be sent again. Resending is safe: the API matches invoices by invoice number, so a request that already went through won't create a duplicate. If it's easier to resend all 214, that's fine too.

No data was lost or left half-written. The failed requests were rejected by our load balancer and never reached the billing system. Every invoice that got a 200 response was saved correctly. We've checked that against the invoices table.

If you'd like, we can send you the list of the 214 failed requests from our logs so you can check them against yours.

**What happened**

At 17:55 we changed a setting on the load balancer that decides which servers can take traffic. The new setting checked an address that two of our three servers don't have, so the load balancer took those two out of service even though they were working normally. That left one server, and about 60% of requests failed.

Our monitoring alerted us at 18:02. Undoing the change took longer than it should have because a problem in our deployment tooling blocked it at first. We reverted it at 18:38 and errors stopped at 18:40.

**What we've changed**

- We now get an alert as soon as fewer than two servers are taking traffic. Before, we only alerted on the error rate.
- From today, every load balancer change needs a second person to review it before it goes live.

Sorry for the disruption. If anything still looks wrong on your side, or you want to go through the details, just reply to this email.

Best regards,
[Your name]
