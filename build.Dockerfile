FROM alexryall/swoolegento

WORKDIR /var/www/html

ARG MAGENTO_REPO_USERNAME
ARG MAGENTO_REPO_PASSWORD

COPY --chown=docker /src /var/www/html

USER docker

RUN composer config -a -g http-basic.repo.magento.com \
 ${MAGENTO_REPO_USERNAME} ${MAGENTO_REPO_PASSWORD}

RUN composer install

USER root
