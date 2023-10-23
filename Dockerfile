# Gebruik het officiële .NET runtime image als basisimage.
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS build-env

# werkdirectory van container instellen.
WORKDIR /app
COPY . ./
RUN dotnet publish src/Server/Server.csproj -c Release -o out

# Maak een copy van de container.
FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /App
COPY --from=build-env /App/out .

# Variabelen instellen (SQL moet nog ingesteld worden!)
# ENV DOTNET_ConnectionStrings__SqlDatabase=localhost,1433;Database=SportStore;Trusted_Connection=True; > verplaatst naar compose

ENTRYPOINT ["dotnet", "Server.dll"]

