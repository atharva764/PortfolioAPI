# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY PortfolioAPI.slnx ./
COPY PortfolioAPI/*.csproj ./PortfolioAPI/

# Restore dependencies
RUN dotnet restore "PortfolioAPI/PortfolioAPI.csproj"

# Copy the rest of the project
COPY PortfolioAPI/. ./PortfolioAPI/

# Publish app
WORKDIR /src/PortfolioAPI
RUN dotnet publish -c Release -o /app

# Stage 2: Run
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy published files
COPY --from=build /app ./

# Copy SQLite DB
COPY portfolio.db ./

# Expose port
EXPOSE 5000

# Start app
ENTRYPOINT ["dotnet", "PortfolioAPI.dll"]