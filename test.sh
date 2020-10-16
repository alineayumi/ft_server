docker build -t ft_server .
docker run --name ft_server -it -p80:80 -p443:443 ft_server