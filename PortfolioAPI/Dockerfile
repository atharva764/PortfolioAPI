# Base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["PortfolioAPI/PortfolioAPI.csproj", "PortfolioAPI/"]
RUN dotnet restore "PortfolioAPI/PortfolioAPI.csproj"
COPY . .
WORKDIR "/src/PortfolioAPI"
RUN dotnet build "PortfolioAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PortfolioAPI.csproj" -c Release -o /app/publish

# Runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY PortfolioAPI/portfolio.db ./portfolio.db
ENTRYPOINT ["dotnet", "PortfolioAPI.dll"]