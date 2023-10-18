FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

COPY src/Server/*.csproj src/Server/
RUN dotnet restore src/Server/Server.csproj

COPY . .

RUN dotnet publish src/Server/Server.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app
COPY --from=build /app/publish .

ENV DOTNET_ENVIRONMENT=Production
ENV DOTNET_ConnectionStrings__SqlDatabase=Server=localhost,1433;Database=SportStore;Trusted_Connection=True;

ENTRYPOINT ["dotnet", "Server.dll"]