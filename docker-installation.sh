#!/bin/bash

# Function to install Docker on Debian/Ubuntu
install_docker_debian() {
    echo "Installing Docker on Debian/Ubuntu..."

    # Update the package list and install dependencies
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg lsb-release

    # Add Docker’s official GPG key and set up the stable repository
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Docker installed successfully on Debian/Ubuntu."
}

# Function to install Docker on RHEL/Fedora/CentOS
install_docker_rhel() {
    echo "Installing Docker on RHEL/Fedora/CentOS..."

    # Uninstall any old versions and install required packages
    sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    sudo yum install -y yum-utils

    # Set up the Docker repository and install Docker
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Docker installed successfully on RHEL/Fedora/CentOS."
}

# Function to install Docker on macOS
install_docker_mac() {
    echo "Installing Docker on macOS..."

    # Install Docker using Homebrew
    brew install --cask docker

    echo "Docker installed successfully on macOS."
}

# Function to start Docker service
start_docker() {
    echo "Starting Docker service..."

    if [[ "$os" == "debian" || "$os" == "rhel" || "$os" == "fedora" ]]; then
        sudo systemctl start docker
        sudo systemctl enable docker
    elif [[ "$os" == "mac" ]]; then
        open /Applications/Docker.app
    fi

    echo "Docker service started."
}

# Function to check Docker status
check_docker_status() {
    echo "Checking Docker status..."

    if ! systemctl is-active --quiet docker; then
        echo "Docker is not running. Starting Docker..."
        sudo systemctl start docker
    fi

    echo "Docker is running."
}

# Function to display Docker version and test installation
verify_docker_installation() {
    echo "Verifying Docker installation..."

    docker --version
    docker compose version

    echo "Running test Docker container..."
    sudo docker run hello-world
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &> /dev/null; then
            os="debian"
        elif command -v yum &> /dev/null; then
            os="rhel"
        elif command -v dnf &> /dev/null; then
            os="fedora"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        os="mac"
    else
        echo "Unsupported OS."
        exit 1
    fi
}

# Main script logic
main() {
    detect_os

    case "$os" in
        "debian")
            install_docker_debian
            ;;
        "rhel"|"fedora")
            install_docker_rhel
            ;;
        "mac")
            install_docker_mac
            ;;
        *)
            echo "Unsupported OS."
            exit 1
            ;;
    esac

    start_docker
    check_docker_status
    verify_docker_installation
    echo "Docker setup completed!"
}

# Run the main function
main

