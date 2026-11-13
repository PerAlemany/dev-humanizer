import random
import time

import requests


def fetch_with_retry(url, attempts=5, base_delay=0.5):
    for attempt in range(attempts):
        try:
            resp = requests.get(url, timeout=10)
            resp.raise_for_status()
            return resp
        except requests.RequestException:
            if attempt == attempts - 1:
                raise
            delay = base_delay * (2 ** attempt)
            time.sleep(delay + random.uniform(0, delay))
