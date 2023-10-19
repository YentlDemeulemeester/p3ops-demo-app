FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /src

# Kopieer de .csproj-bestanden naar de container
COPY *.csproj ./

RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /publish
 
FROM mcr.microsoft.com/dotnet/sdk:6.0 as final-env
WORKDIR /app
COPY --from=build-env /app/publish .

ENTRYPOINT ["dotnet", "SportStore.dll"]
