# Gebruik het officiële .NET runtime image als basisimage.
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

# werkdirectory van container instellen.
WORKDIR /app

# Poort kiezen
EXPOSE 80

# Maak eeb copy van de container.
COPY ./src/Server/publish /app

# Variabelen instellen (SQL moet nog ingesteld worden!)
ENV DOTNET_ENVIRONMENT=Production
ENV DOTNET_ConnectionStrings__SqlDatabase=localhost,1433;Database=SportStore;Trusted_Connection=True;

# 
CMD ["dotnet", "Server.dll"]