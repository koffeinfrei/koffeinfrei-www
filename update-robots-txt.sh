#!/bin/bash

source .env

curl -X POST https://api.darkvisitors.com/robots-txts \
-H "Authorization: Bearer $DARK_VISITORS_TOKEN" \
-H "Content-Type: application/json" \
-d '{
    "agent_types": [
        "AI Data Scraper",
        "Undocumented AI Agent"
    ],
    "disallow": "/"
}' > build/robots.txt

./deploy.sh
