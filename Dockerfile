# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy toàn bộ mã nguồn và build
COPY . ./
RUN dotnet publish /app/GolfService.Api/ -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
# ⚠️ Quan trọng: để ASP.NET lắng nghe đúng cổng container
# ENV ASPNETCORE_URLS=http://+:80
# ENV ASPNETCORE_ENVIRONMENT=Development

# Mở cổng và chạy ứng dụng
EXPOSE 80

COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Test-trino.dll"]