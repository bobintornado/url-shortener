# Requirement

* Ruby version: 2.4.1
* Rails Version: 5.1.1

# Demo

## Front-end

https://fierce-savannah-38850.herokuapp.com/

## API

Post to `api/urls` for creation, Get from `api/urls` for full list

```
curl -X POST -H "Content-Type: application/json"  https://fierce-savannah-38850.herokuapp.com/api/urls --data '{"url": "https://www.google.com"}'
curl https://fierce-savannah-38850.herokuapp.com/api/urls
```

# Design

## Schema

1. Store long url in table `urls`, use base_62 version of id as shortened version of url; use unique constraint to prevent duplication for space saving purpose.
2. Store shortend url visit information in table `visits`.

## Routing

1. visit `/:base_62_id`
 for url redirection
2. visit `/` for front-end app
3. json content is served from from `/api/urls`

## Front-end

Dead simple vue.js app shamelessly copied from https://vuejs.org/v2/examples/grid-component.html

## Information Captured

### HTTP Related
`HTTP_VERSION`, `HTTP_USER_AGENT`, `HTTP_ACCEPT_LANGUAGE`, `REMOTE_ADDR`, `SERVER_NAME`

### Time related
Visit time as `created_at`

# Tests

Not yet.

# Deployment

Deployed to Heroku.
