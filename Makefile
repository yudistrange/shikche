serve:
	echo "Building the frontend matter"
	rm -rf priv/static/*
	cd assets && yarn build && mv build/* ../priv/static
	echo "Starting the phoenix server"
	mix phx.server

tests:
	echo "Running tests"
	cd assets && yarn ci
	echo "Running backend tests"
	mix test

ci:
	echo "Running tests on CI"
	cd assets && yarn install && yarn ci && cd ../ && MIX_ENV=ci mix test

