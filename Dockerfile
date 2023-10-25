# Base image voor .NET 6.0
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
# Map aanmaken
WORKDIR /app

# Kopieren van alle code van de root map naar de container
COPY *.csproj ./

# Restore van de packages
RUN dotnet restore *.csproj

# Kopieren van de rest van de applicatie naar de container
COPY . ./
# Builden van de applicatie
RUN dotnet publish -c Release -o publish

# Maken van een final build image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS final-env
# Map aanmaken
WORKDIR /app
# Kopieren van de vorige container naar de nieuwe container
COPY --from=build-env /app/publish .

# App starten
ENTRYPOINT ["dotnet", "Server.dll"]