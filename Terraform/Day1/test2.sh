#!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "Hello from Web Server 2" > /var/www/html/index.html
