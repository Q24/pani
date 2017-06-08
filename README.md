# pani
This repository contains a Vagrant image that acts as a caching proxy for apt, i.e. the update system for Debian and derivatives.

Once the proxy is configured, all requests are routed through the proxy, which will return the cached file if it's available, 
ond only download the file externally if it isn't, thereby drastically speeding up upgrades.

A few tweaks enable this proxy to download Java files from Oracle.

Other Vagrant images that we uses may automatically configure if one is detected on port 3142.

To configure the proxy manually, create a file in `/etc/apt/apt.conf.d/`, e.g. `01proxy`, with the following content:

    Acquire::http::proxy "http://10.0.2.2:3142";

In this example, the ip address is the default gateway in a Virtualbox machine, i.e. suitable for use inside a Vagrant image as well.
In other use cases, adjust accordingly.
