#!/bin/bash

OS_VARIANT=$1
ITEM=$2

# Function to install services for Ubuntu
install_ubuntu() {
    sudo apt-get update
    case $ITEM in
        "nginx")
            sudo apt-get install -y nginx
            ;;
        "apache")
            sudo apt-get install -y apache2
            ;;
        "git")
            sudo apt-get install -y git
            ;;
        "vim")
            sudo apt-get install -y vim
            ;;
        *)
            echo "Service not recognized."
            ;;
    esac
}

# Function to install services for Fedora
install_fedora() {
    sudo dnf check-update
    case $ITEM in
        "nginx")
            sudo dnf install -y nginx
            ;;
        "apache")
            sudo dnf install -y httpd
            ;;
        "git")
            sudo dnf install -y git
            ;;
        "vim")
            sudo dnf install -y vim
            ;;
        *)
            echo "Service not recognized."
            ;;
    esac
}

# Function to install services for CentOS
install_centos() {
    sudo yum check-update
    case $ITEM in
        "nginx")
            sudo yum install -y nginx
            ;;
        "apache")
            sudo yum install -y httpd
            ;;
        "git")
            sudo yum install -y git
            ;;
        "vim")
            sudo yum install -y vim
            ;;
        *)
            echo "Service not recognized."
            ;;
    esac
}

# Main logic to determine which installation function to call
case $OS_VARIANT in
    "UBUNTU")
        install_ubuntu
        ;;
    "FEDORA")
        install_fedora
        ;;
    "CENTOS")
        install_centos
        ;;
    *)
        echo "OS variant not recognized."
        ;;
esac

