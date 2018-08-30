useradd --create-home --password                                            \
    "$(echo ${NETCONF_PASSWORD} | openssl passwd -1 -stdin)"                \
    "${NETCONF_USER}"

unset NETCONF_PASSWORD

NETCONF_USER_HOME="$(eval echo "~${NETCONF_USER}")"

if ! grep -P "^Subsystem netconf " /etc/ssh/sshd_config > /dev/null
then cat << EOF >> /etc/ssh/sshd_config
Port ${NETCONF_PORT}
Subsystem netconf "/usr/sbin/netconf-subsystem \
    --ncxserver-sockname=${NETCONF_PORT}@/tmp/ncxserver.sock"
EOF
    if service ssh status ; then
        service ssh restart
    fi
fi
if ! service ssh status ; then
    service ssh start
fi

cd "${NETCONF_USER_HOME}"

NETCONF_STARTUP_CFG_FILE="$(realpath "${NETCONF_STARTUP_CFG_FILE}")"

if [ ! -f "${NETCONF_STARTUP_CFG_FILE}" ]
then cat << EOF > "${NETCONF_STARTUP_CFG_FILE}"
<config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
${NETCONF_STARTUP_CFG}
</config>
EOF
elif [ -n "${NETCONF_STARTUP_CFG}" ]
then cat << EOF >&2
[WARN] \
NETCONF_STARTUP_CFG is not empty, \
but NETCONF_STARTUP_CFG_FILE already exists. \
Using existing ${NETCONF_STARTUP_CFG_FILE}
EOF
fi
rm -fr /tmp/ncxserver.sock

netconfd_module_options=
for module in ${NETCONF_MODULES} ; do
    netconfd_module_options="${netconfd_module_options} --module=${module}"
done
netconfd                                                                    \
    --port="${NETCONF_PORT}"                                                \
    --superuser="${NETCONF_USER}"                                           \
    --startup="${NETCONF_STARTUP_CFG_FILE}"                                 \
    --log-level="${NETCONF_LOG_LEVEL}"                                      \
                                                                            \
    ${netconfd_module_options}                                              \
    "$@"
