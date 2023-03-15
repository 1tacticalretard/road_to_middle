import json
import requests

# put your Telegram bot token ID & chat ID here or set up env. variables instead
TELEGRAM_TOKEN = ''
TELEGRAM_CHAT_ID = ''
TELEGRAM_URL = "https://api.telegram.org/bot{}/sendMessage".format(TELEGRAM_TOKEN)

def process_message(input):
    try:
        # Loading JSON into a string
        raw_json = json.loads(input)
        # Outputing as JSON with indents
        output = json.dumps(raw_json, indent=4)
    except:
        output = input
    return output

def lambda_handler(event, context):
    message = process_message(event['Records'][0]['Sns']['Message'])
    payload = {
            "text": message.encode("utf8"),
            "chat_id": TELEGRAM_CHAT_ID
        }
    requests.post(TELEGRAM_URL, payload)
