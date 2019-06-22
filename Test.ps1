Clear-Host
docker build -t skvalpediem .
Clear-Host
docker kill skvalpediem
docker run `
    -d `
    --rm `
    -it `
    -u pi `
    -p 8080:8080 `
    -v /home/kevin/boatdata:/home/pi/boatdata `
    -v /home/kevin/code/skvalpediem:/home/pi/code/skvalpediem `
    --name skvalpediem `
    skvalpediem
docker exec skvalpediem pwsh /home/pi/code/skvalpediem/Start-Dashboard.ps1
Start-Process http://localhost:8080