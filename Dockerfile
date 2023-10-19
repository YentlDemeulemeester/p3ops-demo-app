# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src
COPY *.csproj ./
RUN dotnet restore "*.csproj"

COPY . .
RUN dotnet publish "*.csproj" -c Release -o /publish
 
# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal as final
WORKDIR /app
COPY --from=build /publish .

ENTRYPOINT ["dotnet", "SportStore.sln"]
