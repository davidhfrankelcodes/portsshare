# portSSHare

## Overview

This project provides a Dockerized solution for setting up multiple SSH tunnels using AutoSSH. It's designed to forward ports from a source machine on a private network to a target machine, potentially on a different network. The setup is controlled through a simple configuration file and is executed within a Docker container for ease of use and portability.

## Prerequisites

- Docker and Docker Compose installed on your system.
- SSH access set up between the source and target servers. Run `ssh-copy-id` command from the portSSHare host both source and target hosts.
- SSH keys configured for passwordless login.

## Configuration

### Config File Format

The configuration is defined in a YAML file (`config.yaml`). Each tunnel is specified with the following parameters:

- `source_ssh_user`: SSH username for the source server.
- `source_host`: Hostname or IP address of the source server.
- `source_host_ssh_port`: SSH port of the source server.
- `source_port`: The port on the source server to be forwarded.
- `target_ssh_user`: SSH username for the target server.
- `target_host`: Hostname or IP address of the target server.
- `target_host_ssh_port`: SSH port of the target server.
- `target_port`: The port on the target server where the source port will be forwarded to.

### Example Configuration

```yaml
tunnel1_source_ssh_user: username
tunnel1_source_host: source-server.example.com
tunnel1_source_host_ssh_port: 22
tunnel1_source_port: 8080
tunnel1_target_ssh_user: username
tunnel1_target_host: target-server.example.com
tunnel1_target_host_ssh_port: 22
tunnel1_target_port: 9000

tunnel2_source_ssh_user: username
tunnel2_source_host: another-source-server.example.com
tunnel2_source_host_ssh_port: 22
tunnel2_source_port: 8000
tunnel2_target_ssh_user: username
tunnel2_target_host: target-server.example.com
tunnel2_target_host_ssh_port: 22
tunnel2_target_port: 9001
```

## Usage

1. **Prepare Configuration**: Edit the `config.yaml` file to define your SSH tunneling setup.

2. **Build the Docker Container**:

    ```bash
    docker-compose build
    ```

3. **Run the Docker Container**:

    ```bash
    docker-compose up -d
    ```

4. **Check Tunnels**: Verify that the tunnels are established.

5. **Stopping the Container**:

    ```bash
    docker-compose down
    ```

## Additional Information

- The setup script (`start-tunnels.sh`) is designed to parse the `config.yaml` file and set up the SSH tunnels as specified.
- The Docker container uses Alpine Linux for a minimal footprint.
- The AutoSSH tool is used for establishing persistent SSH tunnels.

## Troubleshooting

- Ensure SSH keys are correctly set up for passwordless authentication.
- Check that the specified ports are open and not blocked by firewalls.
- For any connection issues, review the logs of the Docker container.
