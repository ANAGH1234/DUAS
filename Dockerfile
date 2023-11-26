# Use the official .NET Core runtime as a base image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
# Set the working directory inside the container
WORKDIR /app

# Copy all project files and restore dependencies
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Build the runtime image
FROM  mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the port your app will run on
EXPOSE 80

# Define the command to run your application
ENTRYPOINT ["dotnet", "DUAS"]
