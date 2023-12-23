#!/bin/sh

echo "Starting SSH tunnel setup..."

setup_tunnel() {
    echo "Setting up tunnel with the following parameters:"
    echo "Source SSH User: $1"
    echo "Source Host: $2"
    echo "Source SSH Port: $3"
    echo "Source Port: $4"
    echo "Target SSH User: $5"
    echo "Target Host: $6"
    echo "Target SSH Port: $7"
    echo "Target Port: $8"

    [ -z "$1" ] && echo "Error: Source SSH User is missing" && return
    [ -z "$2" ] && echo "Error: Source Host is missing" && return
    [ -z "$5" ] && echo "Error: Target SSH User is missing" && return
    [ -z "$6" ] && echo "Error: Target Host is missing" && return

    autossh -NT -M 0 -o "ServerAliveInterval=60" -o "ServerAliveCountMax=2" -o "StrictHostKeyChecking=no" \
            -L "*:${8}:localhost:${4}" \
            -p "${3}" "${1}@${2}" &
    autossh -NT -M 0 -o "ServerAliveInterval=60" -o "ServerAliveCountMax=2" -o "StrictHostKeyChecking=no" \
            -R "*:${8}:localhost:${8}" \
            -p "${7}" "${5}@${6}" &

    echo "Tunnel setup complete."
}

# Loop through a predefined number of tunnels
for i in $(seq 1 10); do
    source_ssh_user=""
    source_host=""
    source_ssh_port=""
    source_port=""
    target_ssh_user=""
    target_host=""
    target_ssh_port=""
    target_port=""

    while IFS=': ' read -r key value; do
        value=$(echo $value | xargs) # Trim leading and trailing whitespaces

        case $key in
            "tunnel${i}_source_ssh_user")
                source_ssh_user=$value
                ;;
            "tunnel${i}_source_host")
                source_host=$value
                ;;
            "tunnel${i}_source_host_ssh_port")
                source_ssh_port=$value
                ;;
            "tunnel${i}_source_port")
                source_port=$value
                ;;
            "tunnel${i}_target_ssh_user")
                target_ssh_user=$value
                ;;
            "tunnel${i}_target_host")
                target_host=$value
                ;;
            "tunnel${i}_target_host_ssh_port")
                target_ssh_port=$value
                ;;
            "tunnel${i}_target_port")
                target_port=$value
                ;;
        esac
    done < /config.yaml

    if [ ! -z "$source_ssh_user" ]; then
        setup_tunnel "$source_ssh_user" "$source_host" "$source_ssh_port" "$source_port" \
                     "$target_ssh_user" "$target_host" "$target_ssh_port" "$target_port"
    fi
done

wait
