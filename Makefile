serve:
	echo "Starting the phoenix server"
	mix phx.server

tests:
	echo "Running backend tests"
	mix test

ci-tests:
	echo "Running tests on CI"
	MIX_ENV=ci mix test


