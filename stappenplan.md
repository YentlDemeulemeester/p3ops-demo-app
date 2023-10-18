# VM Opstellen
Clone repository op fysieke machine
```
git clone git@github.com:HOGENTDevOpsPrj/devops-23-24-operations-g05.git
```
Ga naar de folder waar je die clone hebt gemaakt
```
vagrant up devops

vagrant ssh devops
```
Clone repository op VM
```
git clone https://github.com/HoGentTIN/p3ops-demo-app.git
```
Installeer Docker
```
sudo apt update

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce

sudo systemctl start docker
sudo systemctl enable docker
```
Installeer de MS SQL Container
```
docker pull mcr.microsoft.com/mssql/server

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Devopsg05!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest
```
Verander de Connection String
```
sudo apt install nano

cd p3ops-demo-app/src/Server

nano appsettings.Development.json

"SqlDatabase": "Server=localhost,1433;Database=SportStore;Trusted_Connection=True;"
```
Installeer .NET 6.0
```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0

sudo apt-get install -y dotnet-runtime-6.0
```
# Run in development
Restore package & start server
```
cd p3ops-demo-app/

dotnet restore src/Server/Server.csproj

dotnet run watch --project src/Server/Server.csproj
```
# Run in production
Build de server
```
cd p3ops-demo-app/

dotnet build src/Server/Server.csproj
```
Publish the server
```
dotnet publish src/Server/Server.csproj -c Release -o publish

DOTNET_ENVIRONMENT=Production
DOTNET_ConnectionStrings__SqlDatabase="Server=localhost,1433;Database=SportStore;Trusted_Connection=True;"
```
Start the server
```
dotnet publish/Server.dll
```
# Testen
Voer de test uit
```
cd p3ops-demo-app/

dotnet restore src/Server/Server.csproj
dotnet restore src/Domain/Domain.csproj

dotnet test tests/Domain.Tests/Domain.Tests.csproj
```
