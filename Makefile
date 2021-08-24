.PHONY: config-syntax-check
config-syntax-check:
	@# remember to override any quiet mode with verbose
	docker-compose run --rm haproxy haproxy -c -V -f /usr/local/etc/haproxy/haproxy.cfg

.PHONY: print-version
print-version:
	docker-compose run --rm haproxy -v

.PHONY: build
build:
	docker build . -t radixdlt-haproxy

.PHONY: run
run:
	docker-compose up -d --build

.PHONY: stop
stop:
	docker-compose stop

# dynamically reload config without restarting the container
.PHONY: reload-config
reload-config:
	docker-compose kill -s HUP haproxy

.PHONY: print-config
print-config:
	docker-compose exec haproxy bash -c 'cat /usr/local/etc/haproxy/haproxy.cfg'

.PHONY: test-parallel
test-parallel:
	parallel --delay 0.1 'echo {}; nc -v -w 10 127.0.0.1 30000' ::: {1..1000}

.PHONY: test-nping
test-nping:
	nping --tcp-connect -p 30000 --ttl 30 --delay 0.5 --rate 100 --count 1000 127.0.0.1