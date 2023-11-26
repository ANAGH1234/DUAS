# Use the official .NET Core SDK image for the build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy all project files and restore dependencies
COPY . ./
RUN dotnet publish -c Release -o out

# Build the runtime image
FROM mcr.microsoft.com/dotnet/runtime:7.0

# Set the working directory for the runtime image
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build-env /app/out .

# Expose the port your app will run on
EXPOSE 80

# Define the command to run your application
ENTRYPOINT ["dotnet", "API.dll"]
