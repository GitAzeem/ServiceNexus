import tkinter as tk
from tkinter import ttk
import subprocess

def install():
    os_variant = os_var.get()
    item = item_var.get()
    root_password = password_var.get()

    # Check if Jenkins or Docker is selected
    if item == "jenkins":
        command = ["bash", "jenkins-installation.sh"]
    elif item == "docker":
        command = ["bash", "docker-installation.sh"]
    else:
        command = ["bash", "install_service.sh", os_variant, item]

    # Use echo to pass the password to sudo
    full_command = f'echo {root_password} | sudo -S ' + ' '.join(command)

    # Execute the command
    try:
        subprocess.run(full_command, shell=True, check=True, text=True)
        result_label.config(text=f"{item.capitalize()} installation successful!")
    except subprocess.CalledProcessError:
        result_label.config(text=f"{item.capitalize()} installation failed!")

# Create main window
root = tk.Tk()
root.title("Service Installer")

# Dropdown for OS Variant
os_label = tk.Label(root, text="Linux Variant")
os_label.grid(column=0, row=0)
os_var = tk.StringVar()
os_dropdown = ttk.Combobox(root, textvariable=os_var)
os_dropdown['values'] = ("UBUNTU", "FEDORA", "CENTOS")
os_dropdown.grid(column=0, row=1)

# Dropdown for Service Item
item_label = tk.Label(root, text="Service Name")
item_label.grid(column=1, row=0)
item_var = tk.StringVar()
item_dropdown = ttk.Combobox(root, textvariable=item_var)
item_dropdown['values'] = ("nginx", "apache", "git", "vim", "jenkins", "docker")  # Added Docker
item_dropdown.grid(column=1, row=1)

# Password Entry
password_label = tk.Label(root, text="Root Password")
password_label.grid(column=2, row=0)
password_var = tk.StringVar()
password_entry = tk.Entry(root, textvariable=password_var, show="*")  # Hide input
password_entry.grid(column=2, row=1)

# Install button
install_button = tk.Button(root, text="Install", command=install)
install_button.grid(column=3, row=1)

# Result label
result_label = tk.Label(root, text="")
result_label.grid(column=0, row=2, columnspan=4)

# Start the GUI
root.mainloop()
