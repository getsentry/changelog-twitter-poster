import os
import logging
from requests_oauthlib import OAuth1Session

sentrychangelog_twitter_consumer_key = os.environ.get(
    "sentrychangelog_twitter_consumer_key"
)
sentrychangelog_twitter_consumer_secret = os.environ.get(
    "sentrychangelog_twitter_consumer_secret"
)
sentrychangelog_twitter_access_token = os.environ.get(
    "sentrychangelog_twitter_access_token"
)
sentrychangelog_twitter_access_token_secret = os.environ.get(
    "sentrychangelog_twitter_access_token_secret"
)
sentrychangelog_webhook_auth_header = os.environ.get(
    "sentrychangelog_webhook_auth_header"
)


# make sure the request has all the required fields, and draft the twitter post content
def validate_component(request_json):
    if not (
        "title" in request_json
        and "description" in request_json
        and "link" in request_json
    ):
        logging.error("Component Validation: incorrect formatted webhook json")
        return False
    else:
        message = "{} \n \n {} {}".format(
            request_json["title"],
            request_json["description"],
            request_json["link"],
        )
        return message


def post_to_twitter(payload):
    oauth = OAuth1Session(
        sentrychangelog_twitter_consumer_key,
        client_secret=sentrychangelog_twitter_consumer_secret,
        resource_owner_key=sentrychangelog_twitter_access_token,
        resource_owner_secret=sentrychangelog_twitter_access_token_secret,
    )

    response = oauth.post(
        "https://api.twitter.com/2/tweets",
        json=payload,
    )

    if response.status_code != 201:
        logging.exception(
            "Request returned an error: {} {}".format(
                response.status_code, response.text
            )
        )
    return "Success", 200


def main(request):

    # make sure the request is coming from Zapier
    if request.headers.get("User-Agent") != "Zapier":
        return "Unauthorized", 401
    # verifiy the authorization header
    elif request.headers.get("Authorization") != sentrychangelog_webhook_auth_header:
        return "Unauthorized", 401

    # validate the request and craft the message
    message = validate_component(request.get_json(silent=True))

    if message:
        return post_to_twitter({"text": message})
    else:
        return "Bad Request", 400


if __name__ == "__main__":
    main()
