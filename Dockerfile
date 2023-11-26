# Use the official .NET Core SDK image for the build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Set the working directory
WORKDIR /app

# Copy the project file and restore dependencies
COPY DUAS-SOCIAL/*.csproj ./
RUN dotnet restore

# Copy the remaining files and build the application
COPY DUAS-SOCIAL/. ./
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image as the final image
FROM mcr.microsoft.com/dotnet/runtime:7.0

# Set the working directory for the runtime image
WORKDIR /app

# Copy the published application from the build image
COPY --from=build-env /app/out .

# Expose the port your application listens on
EXPOSE 80

# Specify the command to run your application
ENTRYPOINT ["dotnet", "Application.dll"]

