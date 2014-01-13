# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Cockroach::Application.config.secret_key_base = 'ed9eb0e3906ce589abaab017f589174135c4aafbb72ddac6b08465faeb0d3e0954e690eed8d1b560011255a1f6396e10ed207c970fd7f954b8b4b511059ea263'
