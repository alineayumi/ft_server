docker rm -f  ft_server
docker rm $(docker ps -qa)
docker system prune