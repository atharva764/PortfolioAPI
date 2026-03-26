# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY *.sln ./
COPY PortfolioAPI.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy all project files
COPY . .

# Publish
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy published files
COPY --from=build /app ./

# Copy SQLite DB files
COPY portfolio.db ./
COPY portfolio.db-shm ./
COPY portfolio.db-wal ./

EXPOSE 7035
ENTRYPOINT ["dotnet", "PortfolioAPI.dll"]