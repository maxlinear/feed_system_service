#!/bin/sh /etc/rc.common
START=87
USE_PROCD=1

start_service() {
	procd_open_instance
	procd_set_param respawn
	procd_set_param stdout 1
	procd_set_param stderr 1
	procd_set_param command /usr/bin/ss_server
	procd_close_instance
}
