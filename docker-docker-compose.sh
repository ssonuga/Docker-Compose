#!/bin/bash

# This script will install Docker and Docker Compose on Ubuntu 22.04 (Jammy).
# It will guide you through the process, check for errors, and stop if it encounters any issues.
# You need to run this script as root or with sudo.

# Function to handle errors and exit if something goes wrong
handle_error() {
  echo "Error encountered. Exiting."
  exit 1
}

# Trap any error and call the handle_error function
trap 'handle_error' ERR

# Function to print a separator line
separator() {
  echo "=============================================================="
}

# Function to check if the user is running the script as root
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or with sudo."
    exit 1
  fi
}

# Function to update the system packages
#update_system() {
 # echo "Updating the system packages..."
 # apt update && apt upgrade -y
#}

# Function to install required dependencies for Docker installation
install_dependencies() {
  echo "Installing required packages..."
  apt install apt-transport-https ca-certificates curl software-properties-common -y
}

# Function to add Docker's GPG key and repository
add_docker_repo() {
  echo "Adding Docker's official GPG key and setting up the repository..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
}

# Function to install Docker
install_docker() {
  echo "Installing Docker..."
  apt update
  apt install docker-ce docker-ce-cli containerd.io -y
  echo "Docker installed successfully!"
}

# Function to verify Docker installation
verify_docker() {
  echo "Verifying Docker installation..."
  if ! command -v docker &> /dev/null; then
    echo "Docker installation failed."
    exit 1
  fi
  docker --version
}

# Function to install Docker Compose
install_docker_compose() {
  echo "Installing Docker Compose..."
  curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  echo "Docker Compose installed successfully!"
}

# Function to verify Docker Compose installation
verify_docker_compose() {
  echo "Verifying Docker Compose installation..."
  if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose installation failed."
    exit 1
  fi
  docker-compose --version
}

# Function to enable Docker to start on boot
enable_docker_on_boot() {
  echo "Enabling Docker to start on boot..."
  systemctl enable docker
  echo "Docker is enabled to start on boot."
}

# Function to test Docker and Docker Compose installation with a sample container
# test_docker_setup() {
 # echo "Running a test to check Docker and Docker Compose setup..."
 # mkdir -p ~/docker_test && cd ~/docker_test
 # cat > docker-compose.yml << EOF
# version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "8080:80"
EOF
  docker-compose up -d
  sleep 5 # Give it a few seconds to start
  echo "Test complete. You can visit http://<server-ip>:8080 in your browser."
}

# Function to clean up the test container
#cleanup_test() {
 # echo "Cleaning up the test container..."
 # cd ~/docker_test
 # docker-compose down
 # rm -rf ~/docker_test
 # echo "Test environment cleaned up."
#}

# Function to interactively confirm the installation steps
confirm_continue() {
  read -p "Do you want to proceed with the $1? [Y/n]: " response
  case $response in
    [nN]* ) echo "Skipping $1."; return 1;;
    * ) return 0;;
  esac
}

# Main installation logic
main() {
  separator
  echo "Welcome to the Docker and Docker Compose setup script!"
  echo "This script will guide you through installing Docker and Docker Compose on Ubuntu 22.04 (Jammy)."
  separator

  check_root

  # Confirm and run each step interactively
  if confirm_continue "system update"; then update_system; fi
  separator

  if confirm_continue "install required dependencies"; then install_dependencies; fi
  separator

  if confirm_continue "add Docker repository"; then add_docker_repo; fi
  separator

  if confirm_continue "install Docker"; then install_docker; verify_docker; fi
  separator

  if confirm_continue "install Docker Compose"; then install_docker_compose; verify_docker_compose; fi
  separator

  if confirm_continue "enable Docker on boot"; then enable_docker_on_boot; fi
  separator

  if confirm_continue "run a Docker test"; then test_docker_setup; fi
  separator

  if confirm_continue "clean up test environment"; then cleanup_test; fi
  separator

  echo "Installation complete! Docker and Docker Compose are installed and working."
}

# Run the main function
main
