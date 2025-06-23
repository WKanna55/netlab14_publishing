# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar el archivo .csproj y restaurar dependencias
COPY Lab14_wkana/Lab14_wkana.csproj Lab14_wkana/
WORKDIR /src/Lab14_wkana
RUN dotnet restore

# Copiar el resto del proyecto y compilar
COPY Lab14_wkana/. ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80

ENTRYPOINT ["dotnet", "Lab14_wkana.dll"]