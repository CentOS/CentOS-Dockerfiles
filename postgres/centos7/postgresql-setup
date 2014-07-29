#!/bin/sh
#
# postgresql-setup - Initialization and upgrade operations for PostgreSQL

# PGVERSION is the full package version, e.g., 9.0.2
# Note: the specfile inserts the correct value during package build
PGVERSION=9.2.7

# PGENGINE is the directory containing the postmaster executable
# Note: the specfile inserts the correct value during package build
PGENGINE=/usr/bin

# PREVMAJORVERSION is the previous major version, e.g., 8.4, for upgrades
# Note: the specfile inserts the correct value during package build
PREVMAJORVERSION=9.2

# PREVPGENGINE is the directory containing the previous postmaster executable
# Note: the specfile inserts the correct value during package build
PREVPGENGINE=/usr/lib64/pgsql/postgresql-9.2/bin

# Absorb configuration settings from the specified systemd service file,
# or the default "postgresql" service if not specified
SERVICE_NAME="$2"
if [ x"$SERVICE_NAME" = x ]; then
    SERVICE_NAME=postgresql
fi

# this parsing technique fails for PGDATA pathnames containing spaces,
# but there's not much I can do about it given systemctl's output format...
PGDATA="/var/lib/pgsql/data"
# PGDATA=`systemctl show -p Environment "${SERVICE_NAME}.service" |
#                 sed 's/^Environment=//' | tr ' ' '\n' |
#                 sed -n 's/^PGDATA=//p' | tail -n 1`
# if [ x"$PGDATA" = x ]; then
#     echo "failed to find PGDATA setting in ${SERVICE_NAME}.service"
#     exit 1
# fi
PGPORT="5432"
# PGPORT=`systemctl show -p Environment "${SERVICE_NAME}.service" |
#                 sed 's/^Environment=//' | tr ' ' '\n' |
#                 sed -n 's/^PGPORT=//p' | tail -n 1`
# if [ x"$PGPORT" = x ]; then
#     echo "failed to find PGPORT setting in ${SERVICE_NAME}.service"
#     exit 1
# fi

# Log file for initdb
PGLOG=/var/lib/pgsql/initdb.log

# Log file for pg_upgrade
PGUPLOG=/var/lib/pgsql/pgupgrade.log

export PGDATA
export PGPORT

# For SELinux we need to use 'runuser' not 'su'
if [ -x /sbin/runuser ]; then
    SU=runuser
else
    SU=su
fi

script_result=0

# code shared between initdb and upgrade actions
perform_initdb(){
    if [ ! -e "$PGDATA" ]; then
        mkdir "$PGDATA" || return 1
        chown postgres:postgres "$PGDATA"
        chmod go-rwx "$PGDATA"
    fi
    # Clean up SELinux tagging for PGDATA
    [ -x /sbin/restorecon ] && /sbin/restorecon "$PGDATA"

    # Create the initdb log file if needed
    if [ ! -e "$PGLOG" -a ! -h "$PGLOG" ]; then
        touch "$PGLOG" || return 1
        chown postgres:postgres "$PGLOG"
        chmod go-rwx "$PGLOG"
        [ -x /sbin/restorecon ] && /sbin/restorecon "$PGLOG"
    fi

    # Initialize the database
    $SU -l postgres -c "$PGENGINE/initdb --pgdata='$PGDATA' --auth='ident'" \
                    >> "$PGLOG" 2>&1 < /dev/null

    # Create directory for postmaster log files
    mkdir "$PGDATA/pg_log"
    chown postgres:postgres "$PGDATA/pg_log"
    chmod go-rwx "$PGDATA/pg_log"
    [ -x /sbin/restorecon ] && /sbin/restorecon "$PGDATA/pg_log"

    if [ -f "$PGDATA/PG_VERSION" ]; then
        return 0
    fi
    return 1
}

initdb(){
    if [ -f "$PGDATA/PG_VERSION" ]; then
        echo $"Data directory is not empty!"
        echo
        script_result=1
    else
        echo -n $"Initializing database ... "
        if perform_initdb; then
            echo $"OK"
        else
            echo $"failed, see $PGLOG"
            script_result=1
        fi
        echo
    fi
}

upgrade(){
    # must see previous version in PG_VERSION
    if [ ! -f "$PGDATA/PG_VERSION" -o \
         x`cat "$PGDATA/PG_VERSION"` != x"$PREVMAJORVERSION" ]
    then
        echo
        echo $"Cannot upgrade because the database in $PGDATA is not of"
        echo $"compatible previous version $PREVMAJORVERSION."
        echo
        exit 1
    fi
    if [ ! -x "$PGENGINE/pg_upgrade" ]; then
        echo
        echo $"Please install the postgresql-upgrade RPM."
        echo
        exit 5
    fi

    # Make sure service is stopped
    # Using service here makes it work both with systemd and other init systems
    service "$SERVICE_NAME" stop

    # Set up log file for pg_upgrade
    rm -f "$PGUPLOG"
    touch "$PGUPLOG" || exit 1
    chown postgres:postgres "$PGUPLOG"
    chmod go-rwx "$PGUPLOG"
    [ -x /sbin/restorecon ] && /sbin/restorecon "$PGUPLOG"

    # Move old DB to PGDATAOLD
    PGDATAOLD="${PGDATA}-old"
    rm -rf "$PGDATAOLD"
    mv "$PGDATA" "$PGDATAOLD" || exit 1

    # Create configuration file for upgrade process
    HBA_CONF_BACKUP="$PGDATAOLD/pg_hba.conf.postgresql-setup.`date +%s`"
    HBA_CONF_BACKUP_EXISTS=0

    if [ ! -f $HBA_CONF_BACKUP ]; then
        mv "$PGDATAOLD/pg_hba.conf" "$HBA_CONF_BACKUP"
        HBA_CONF_BACKUP_EXISTS=1

        # For fluent upgrade 'postgres' user should be able to connect
        # to any database without password.  Temporarily, no other type
        # of connection is needed.
        echo "local all postgres ident" > "$PGDATAOLD/pg_hba.conf"
    fi

    echo -n $"Upgrading database: "

    # Create empty new-format database
    if perform_initdb; then
        # Do the upgrade
        $SU -l postgres -c "$PGENGINE/pg_upgrade \
                        '--old-bindir=$PREVPGENGINE' \
                        '--new-bindir=$PGENGINE' \
                        '--old-datadir=$PGDATAOLD' \
                        '--new-datadir=$PGDATA' \
                        --link \
                        '--old-port=$PGPORT' '--new-port=$PGPORT' \
                        --user=postgres" >> "$PGUPLOG" 2>&1 < /dev/null
        if [ $? -ne 0 ]; then
            # pg_upgrade failed
            script_result=1
        fi
    else
        # initdb failed
        script_result=1
    fi

    # Move back the backed-up pg_hba.conf regardless of the script_result.
    if [ x$HBA_CONF_BACKUP_EXISTS = x1 ]; then
        mv -f "$HBA_CONF_BACKUP" "$PGDATAOLD/pg_hba.conf"
    fi

    if [ $script_result -eq 0 ]; then
        echo $"OK"
        echo
        echo $"The configuration files was replaced by default configuration."
        echo $"The previous configuration and data are stored in folder"
        echo $PGDATAOLD.
    else
        # Clean up after failure
        rm -rf "$PGDATA"
        mv "$PGDATAOLD" "$PGDATA"
        echo $"failed"
    fi
    echo
    echo $"See $PGUPLOG for details."
}

# See how we were called.
case "$1" in
    initdb)
        initdb
        ;;
    upgrade)
        upgrade
        ;;
    *)
        echo $"Usage: $0 {initdb|upgrade} [ service_name ]"
        exit 2
esac

exit $script_result
