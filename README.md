# Url Shortener

## Design

1. Store long url in table `urls`. Use base_62 of incremental id as shortened url.
2. Tracking url visits in table `visits`.
3. Tracking approximate unique visitors by cookie in unique_visits

## Routing

1. visit `/:base_62_id` for url redirection
2. visit `/` for simple front-end app
3. json content is served from from `/api/urls`

## Information Tracked

### HTTP Related
`HTTP_VERSION`, `HTTP_USER_AGENT`, `HTTP_ACCEPT_LANGUAGE`, `REMOTE_ADDR`, `SERVER_NAME`

### Time related
Visit time as `created_at`

## Demo

### Front-end

https://fierce-savannah-38850.herokuapp.com/

### API

Post to `api/urls` for creation, Get from `api/urls` for full list

```
curl -X POST -H "Content-Type: application/json"  https://fierce-savannah-38850.herokuapp.com/api/urls --data '{"url": "https://www.google.com"}'
curl https://fierce-savannah-38850.herokuapp.com/api/urls
curl https://fierce-savannah-38850.herokuapp.com/api/urls/unique_visitors_stat?url=https://www.google.com&from=2017-07-08&to=2017-07-11&interval=1%20day
```
