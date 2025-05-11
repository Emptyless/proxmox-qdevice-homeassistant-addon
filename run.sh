#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

bashio::log.info "Stopping ssh server"
service ssh stop

bashio::log.info "Updating the sshd_config"
SSHD_CONFIG="$(bashio::config 'sshd_config')"
echo "${SSHD_CONFIG}" > /etc/ssh/sshd_config

bashio::log.info "Updating the authorized_keys"
echo "" > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
for idx in $(bashio::config 'public_keys|keys'); do
    PUBLIC_KEY=$(bashio::config "public_keys[${idx}].public_key")
    echo "${PUBLIC_KEY}" >> ~/.ssh/authorized_keys
    bashio::log.info "added: ${PUBLIC_KEY}"
done

bashio::log.info "Starting ssh server"
service ssh start

bashio::log.info "Run corosync-qnetd in foreground:"
bashio::log.info "  using -p $(bashio::config 'port')"
bashio::log.info "  using -s $(bashio::config 'server_tls')"
bashio::log.info "  using -c $(bashio::config 'client_tls')"
DEBUG=$(bashio::config 'debug')
bashio::log.info "  using -d ${DEBUG}"
service corosync-qnetd stop
corosync-qnetd -f "$([ "${DEBUG}" = "true" ] && echo "-d")" -p "$(bashio::config 'port')" -s "$(bashio::config 'server_tls')" -c "$(bashio::config 'client_tls')"

