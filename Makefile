build:
	echo "Building frontend matter"
	rm -rf priv/static/*
	mkdir -p priv/static
	cd assets && yarn install && yarn build && mv build/* ../priv/static/

serve:
	make serve
	echo "Starting the phoenix server"
	mix phx.server

tests:
	echo "Running tests"
	cd assets && yarn test
	echo "Running backend tests"
	mix test

ci-tests:
	echo "Running tests on CI"
	make build
	cd assets && yarn install && yarn ci && cd ../ && MIX_ENV=ci mix test

