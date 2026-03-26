# 1. Build stage using .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy everything and publish
COPY . ./
RUN dotnet publish -c Release -o out

# 2. Runtime stage using ASP.NET
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out ./

# Set the port from Render environment variable
ENV ASPNETCORE_URLS=http://+:$PORT

# Run the application
ENTRYPOINT ["dotnet", "PortfolioAPI.dll"]