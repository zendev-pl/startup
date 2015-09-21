server {
listen 80;

server_name *.z.pl;

proxy_buffer_size   256k;
proxy_buffers   8 256k;
proxy_busy_buffers_size   512k;

root {{ doc_root }};

index app_dev.php app.php index.php;

try_files $uri $uri/ @rewrite;

location @rewrite {
rewrite ^/(.*)$ /app_dev.php/$1;
autoindex on;
}

location ~ \.php {
fastcgi_index app_dev.php;
fastcgi_pass            unix:/var/run/php5-fpm.sock;
include fastcgi_params;
fastcgi_read_timeout 300;

fastcgi_buffer_size 128k;
fastcgi_buffers 4 256k;
fastcgi_busy_buffers_size 256k;
fastcgi_split_path_info ^(.+\.php)(/.+)$;
fastcgi_param PATH_INFO $fastcgi_path_info;
fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
}

location ~ /\.ht {
deny all;
}
}