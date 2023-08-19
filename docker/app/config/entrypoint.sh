if [ ! -f "vendor/autoload.php" ]; then
    echo "Installing composer."
    composer install --no-progress --no-interaction
    echo "Composer installed."
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env ${APP_ENV}"
    cp .env.example .env
    php artisan key:generate
    php artisan cache:clear
    php artisan config:clear
    php artisan cache:clear
    php artisan migrate
else
  echo "env file exists."
  if [ -z "${APP_KEY}" ]; then
      php artisan key:generate
  else
    echo "Application key already generated ${APP_KEY}"
  fi
  php artisan cache:clear
  php artisan config:clear
  php artisan optimize
fi

exec "$@"
