FROM alexryall/swoolegento

WORKDIR /var/www/html

ARG MAGENTO_REPO_USERNAME
ARG MAGENTO_REPO_PASSWORD

COPY --chown=docker /src /var/www/html

USER docker

RUN composer config -a -g http-basic.repo.magento.com \
 ${MAGENTO_REPO_USERNAME} ${MAGENTO_REPO_PASSWORD}

RUN mv app/etc/env.php app/etc/_env.php

RUN composer install --no-dev
RUN php bin/magento setup:di:compile
RUN composer dump-autoload -o --apcu
RUN php bin/magento setup:static-content:deploy en_GB --theme Magento/luma -f
RUN php bin/magento setup:static-content:deploy en_GB --area adminhtml -f

RUN mv app/etc/_env.php app/etc/env.php

USER root
