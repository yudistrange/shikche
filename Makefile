serve:
	echo "Building the frontend matter"
	rm -rf priv/static/*
	cd assets && yarn build && mv build/* ../priv/static
	echo "Starting the phoenix server"
	mix phx.server
