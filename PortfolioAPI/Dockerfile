# Use .NET 8 ASP.NET runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5000

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["PortfolioAPI.csproj", "./"]
RUN dotnet restore "./PortfolioAPI.csproj"

COPY . .
WORKDIR "/src/."
RUN dotnet publish "PortfolioAPI.csproj" -c Release -o /app/publish

# Final stage
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
# ✅ Copy SQLite DB (if you have an existing DB file)
COPY portfolio.db ./

ENTRYPOINT ["dotnet", "PortfolioAPI.dll"]