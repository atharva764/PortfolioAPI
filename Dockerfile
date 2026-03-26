# Use .NET 8 SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY *.sln ./
COPY PortfolioAPI/*.csproj ./PortfolioAPI/

# Restore dependencies
RUN dotnet restore

# Copy the rest of the project
COPY PortfolioAPI/. ./PortfolioAPI/

# Set working directory to project
WORKDIR /src/PortfolioAPI

# Publish the app to /app folder
RUN dotnet publish -c Release -o /app

# Use smaller runtime image for production
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy published files from build stage
COPY --from=build /app ./

# Copy SQLite database
COPY portfolio.db ./

# Expose port Render will map
EXPOSE 5000

# Environment variables for .NET in container
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV DOTNET_HOSTBUILDER__RELOADCONFIGONCHANGE=false

# Start the app
ENTRYPOINT ["dotnet", "PortfolioAPI.dll"]