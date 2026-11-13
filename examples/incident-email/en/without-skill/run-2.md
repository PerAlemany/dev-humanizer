**To:** Laura Bennett, Northern Freight
**Subject:** Billing API errors on Thursday 12 November, 17:55 to 18:40: what happened and what to resend

Hi Laura,

Yesterday evening (Thursday 12 November) the billing API returned errors to part of your traffic for about 45 minutes. Your invoice data is intact, but some requests may need to be resent. Details below.

**What happened**

At 17:55 we made a configuration change to the load balancer in front of the billing API. Because of an error in that change, the load balancer wrongly treated two of our three servers as down, even though they were working normally. From then until 18:40, about 60% of requests to the billing API got an HTTP 502 error.

Our monitoring alerted us at 18:02. Once we had found the cause, we reverted the change, and the error rate was back to zero at 18:40. Service has been normal since then.

**Impact on Northern Freight**

- Our load balancer logs show 214 requests from Northern Freight that got a 502 between 17:55 and 18:40.
- Those requests never reached the billing application, so nothing was partly processed or half-written. We checked: every invoice that got a 200 response in that window is stored correctly.
- Your integration retries failed requests up to 3 times, so some of the 214 will have gone through on a later attempt. The rest were not processed.

**What we'd ask you to do**

Please resend any invoice from that window that your system shows as failed. Invoice creation is idempotent by invoice number, so it's safe to resend an invoice even if you're not sure whether it went through. It won't create a duplicate.

If it would help, we can send you the list of the 214 failed requests from our logs so you can match them against your records.

**What we're changing**

- We've added an alert that fires as soon as fewer than two servers are healthy, so a problem like this is caught right away and not only once errors start to rise. This went live last night.
- From today, every load balancer change needs a second reviewer before it goes out.
- We're also looking into why our servers weren't all running the same version, which is part of why the change affected only two of them.

I'm sorry for the disruption to your billing run. If you have any questions, or would like to go through this on a call, just let me know.

Best regards,
[Your name]
[Title, company]
