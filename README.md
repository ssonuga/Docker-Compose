
# Docker and Docker Compose Setup

This project contains a **bash script** for setting up Docker and Docker Compose on an **Ubuntu Jammy 22.04** server, as well as a `docker-compose.yml` file to test the Docker environment after installation.

## Directory Structure

```plaintext
.
├── docker-docker-compose.sh  # Bash script to install Docker and Docker Compose
└── docker-compose.yml        # Docker Compose file for testing the installation
```

### Prerequisites

- You should have root access on your **Ubuntu 22.04** system.
- Ensure that your system is up-to-date and ready for installation.

### Important Notes Before You Begin

1. **Review the Bash Script**: It's always good practice to review any scripts before running them, especially those that require root privileges. You can review the script by opening it in a text editor:

   ```bash
   nano docker-docker-compose.sh
   ```

2. **Allow Execution of the Script**: Before you can run the script, make sure it's executable:

   ```bash
   chmod +x docker-docker-compose.sh
   ```

3. **Interactive and Fault-Resistant**: The bash script is designed to guide you through the installation interactively, meaning it will ask for your confirmation before each major step. It also handles errors gracefully, quitting if any errors are encountered during the process.

### How to Use the Setup Script

1. **Run the Bash Script**: To install Docker and Docker Compose, simply run the bash script:

   ```bash
   ./docker-docker-compose.sh
   ```

   The script will:
   - Update your system.
   - Install required dependencies.
   - Add Docker's official GPG key and repository.
   - Install Docker and Docker Compose.
   - Enable Docker to start on boot.
   - Test the installation with a simple Wordpress Application.

2. **Test Docker and Docker Compose**: After the installation, you can test if Docker and Docker Compose are working properly by running the provided `docker-compose.yml` file.

   The `docker-compose.yml` file launches an Nginx web server, which will be accessible on port **8080**.

   To start the test environment:
   
   ```bash
   docker-compose up -d
   ```

   Once the containers are running, you can open a browser and visit:

   ```plaintext
   http://<server-ip>:8080
   ```

   You should see the default **Wordpress** welcome page.

### Stopping the Test Environment

Once you’re done testing, you can bring down the Docker containers by running:

```bash
docker-compose down
```

This will stop and remove the containers, leaving your system clean.

### Cleanup (Optional)

If you want to completely remove all Docker resources (containers, images, volumes) after testing, you can run the following command:

```bash
docker system prune -a
```

### Troubleshooting

- **Permission Denied Errors**: If you encounter any "permission denied" errors while running the bash script or Docker commands, ensure you are running the script as `root` or with proper privileges.
- **Docker Not Starting**: If Docker does not start after installation, try rebooting your server or manually starting Docker with:

  ```bash
  systemctl start docker
  ```

### Future Improvements

- Feel free to modify the `docker-compose.yml` file to deploy other services or applications.
- Add any additional services to the `docker-docker-compose.sh` script as needed for your specific project requirements.

---

That's it! You’re now ready to install and run Docker and Docker Compose on your Ubuntu server. If you have any issues or questions, feel free to reach out.
