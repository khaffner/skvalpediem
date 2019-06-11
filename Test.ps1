Clear-Host
docker build --no-cache --quiet -t skvalpediem .
docker run --rm -d -p 8080:8080 skvalpediem
Start-Process http://localhost:8080