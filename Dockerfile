# =========================
# BUILD STAGE
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy code
COPY . ./

# Build project
RUN dotnet publish Test-trino/Test-trino.csproj -c Release -o /app/publish

# =========================
# RUNTIME STAGE
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy published output
COPY --from=build /app/publish .

# ✅ Copy file cấu hình từ Jenkins configs nếu có
COPY configs/ci-docker-demo/. ./  # copy chồng appsettings.json, key, v.v.

EXPOSE 8999
ENTRYPOINT ["dotnet", "Test-trino.dll"]
