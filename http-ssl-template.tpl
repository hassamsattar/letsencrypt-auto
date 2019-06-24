server {
        listen       443;
        server_name  VHNAME www.VHNAME;

        ssl on;
        ssl_certificate VHSSLDIR/fullchain.pem;
        ssl_certificate_key VHSSLDIR/privkey.pem;

        error_log  /var/log/nginx/error.log;

        root   VHDOCROOT;
        index  index.php index.html;
    
    location / {
                try_files $uri $uri/ /index.php?q=$request_uri;
        }
        
        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            include        fastcgi_params;
            fastcgi_param  SERVER_ROOT VHDOCROOT;
        fastcgi_param  DOCUMENT_ROOT VHDOCROOT;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
