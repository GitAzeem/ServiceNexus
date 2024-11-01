

# ServiceNexus

**ServiceNexus** is a Python-based GUI tool designed to streamline the local installation of essential software services on Linux distributions such as Ubuntu, Fedora, and CentOS. With a user-friendly interface, users can select their Linux variant, choose a service to install, and securely enter the root password to complete installations directly on their system.

## Features

- **Multi-Distribution Support**: Compatible with Ubuntu, Fedora, and CentOS.
- **Service Selection**: Locally installs popular services, including Nginx, Apache, Git, Vim, Jenkins, and Docker.
- **Secure Password Entry**: Users can safely enter the root password for installation purposes.
- **User Feedback**: Clear success or failure messages are displayed after each installation.

## Project Structure

- **`ServiceNexus.py`**: Main Python script that builds the GUI, manages user inputs, and executes installation scripts.
- **`install_service.sh`**: Bash script that performs installations based on the selected Linux distribution and service.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/GitAzeem/ServiceNexus.git
   cd ServiceNexus
   ```

2. Install necessary Python dependencies:
   ```bash
   pip install tk
   ```

3. Ensure the shell scripts have executable permissions:
   ```bash
   chmod +x install_service.sh jenkins-installation.sh docker-installation.sh
   ```

## Usage

1. Run `ServiceNexus.py`:
   ```bash
   python ServiceNexus.py
   ```

2. In the GUI:
   - Select your Linux variant (Ubuntu, Fedora, CentOS).
   - Choose the software or service you want to install locally.
   - Enter the root password.
   - Click **Install**.

3. After the installation completes, the GUI will display a message indicating whether the installation was successful or failed.

## Script Details

### `install_service.sh`

The script takes two arguments from the GUI:
- **OS_VARIANT**: The selected Linux variant (e.g., `UBUNTU`, `FEDORA`, `CENTOS`).
- **ITEM**: The service to install (e.g., `nginx`, `apache`, `git`, `vim`).

The script then performs the installation locally using the appropriate package manager (`apt`, `dnf`, or `yum`).

### Example CLI Usage

You can also execute the installation script directly:
```bash
bash install_service.sh UBUNTU nginx
```
This command installs Nginx locally on an Ubuntu system.

## Customization

- **Add More Services**: To add more services, edit the `install_service.sh` script and include the necessary commands within each OS function (`install_ubuntu`, `install_fedora`, `install_centos`).
- **Expand GUI Options**: Update the service dropdown options in `ServiceNexus.py` to include additional services.



This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

This README now clarifies that **ServiceNexus** installs software locally, giving users a comprehensive guide to using and customizing the project.
