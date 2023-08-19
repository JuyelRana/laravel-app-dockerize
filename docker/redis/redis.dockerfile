FROM redis:latest
#COPY custom redis configuration (optional)
COPY redis/config/redis.conf /usr/local/etc/redis/redis.conf
EXPOSE 6379
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

