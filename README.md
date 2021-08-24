A minimal [HAProxy](https://www.haproxy.org/) configuration to act as a frontend for a Radix DLT Node, specifically for the TCP gossip port. Pull requests are welcome.

# Why HAProxy?

The official [Radix Node installation](https://docs.radixdlt.com/main/node/introduction.html) uses Nginx in front of the core Radix process to add various features such as password protection for admin endpoints. The default configuration provided for Nginx does add some basic rate limiting for HTTP endpoints but not much for the [TCP gossip port](https://github.com/radixdlt/radixdlt-nginx/blob/fa1012b2611eba7fe6e22904ab00827bad207c9f/conf.d/nginx.conf.envsubst#L11-L18). HAProxy has numerous options to deal with TCP connections and sessions so it can add flexibility and an additional layer of protection to the TCP gossip port. The configuration here is not intended as a fully fledged DDoS solution, it can however help with some service abuse scenarios.

# Usage

## Main Configuration
The main configuration is [here](config/haproxy.cfg). The default figures will continue to be tweaked over time driven by feedback from other node runners.

The [config](config) directory also contains allow and deny IP lists, the former of which contains the [official Radix seeds nodes](https://docs.radixdlt.com/main/node/cli-install-node-docker.html#_install_the_node). Add/remove from these lists depending on which nodes / systems you wish to trust.

## Environment Variables
The configuration loads some environment variables which you will need to specify in your setup. The [docker-compose.yml](docker-compose.yml) file is a godo reference of the full list of variables used.

## Using in Production
If you want to run this in production, please be advised that you should protect the stats port in your firewall setup. Although the configuration here does not enable admin mode on the stats dashboard and also password protects it, defense in depth should be your priority.

## Changing Rules
If you wish to add or update some of the rules in the configuration, check out the `tcp-request` sections of the documentation such as [`tcp-request connection`](https://cbonte.github.io/haproxy-dconv/2.4/configuration.html#4-tcp-request%20connection) plus the readme section below on local development.

## Docker Image
At the moment there is no public published Docker image, let us know if that might be helpful.

# Local Development

You will need `docker` and `docker-compose` installed for local development. You may also wish to install `parallel` and `nping` for testing purposes.

Check out the [Makefile](Makefile) for common commands including basic testing.

# More on HAProxy

* [The Four Essential Sections of an HAProxy Configuration](https://www.haproxy.com/blog/the-four-essential-sections-of-an-haproxy-configuration/)
* [Use a Load Balancer as a First Row of Defense Against DDOS](https://www.haproxy.com/blog/use-a-load-balancer-as-a-first-row-of-defense-against-ddos/)
* [How to Run HAProxy with Docker](https://www.haproxy.com/blog/how-to-run-haproxy-with-docker/)
* [Introduction to HAProxy Stick Tables](https://www.haproxy.com/blog/introduction-to-haproxy-stick-tables/)
* [Exploring the HAProxy Stats Page](https://www.haproxy.com/blog/exploring-the-haproxy-stats-page/)