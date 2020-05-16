# RUN ALL CONTAINERS FROM ROOT (folder with .sln file):
# docker-compose build
# docker-compose up
#
# RUN JUST THIS CONTAINER FROM ROOT (folder with .sln file):
# docker build --pull -t ServerGameMD -f src/ServerGameMD/Dockerfile .
#
# RUN COMMAND
#  docker run --name eshopServerGameMD --rm -it -p 5106:5106 ServerGameMD
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["ServerGameMD/ServerGameMD.csproj", "ServerGameMD/"]
RUN dotnet restore "ServerGameMD/ServerGameMD.csproj"
COPY . .
WORKDIR "/src/ServerGameMD"
RUN dotnet build "ServerGameMD.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ServerGameMD.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ServerGameMD.dll"]
