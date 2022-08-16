FROM alexryall/swoolegento

WORKDIR /var/www/html

COPY --chown=docker /src /var/www/html
