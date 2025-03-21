cat /dev/urandom | LC_CTYPE=C sed -l8 -r "s/[^0-9a-z%^&*()_]//ig" | head -n 8
