Stand
=====
We use this for our morning stands.

The Setup
---------

* config/config.yaml
* config/users.yaml

```ruby
- {first: Dan, last: Aykroyd, email: d.aykroyd@email.com}
- {first: Bill, last: Murray , email: b.murray@email.com}
- {first: Harold, last: Ramis, email: h.ramis@email.com}

This app will be looking for 2 files in the config foler.

config.yaml holds the email settings and redis settings.

users.yaml holds the user data.

I've included example files.

Boot
----
* ruby web.rb