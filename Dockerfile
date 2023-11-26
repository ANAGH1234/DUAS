# Use the official .NET Core runtime as a base image
FROM mcr.microsoft.com/dotnet/runtime:7.0

# Set the working directory for the runtime image
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build-env /var/lib/jenkins/workspace/DUAS-SOCIAL/Application/bin/Release/net7.0 .

# Expose the port your app will run on
EXPOSE 80

# Define the command to run your application
ENTRYPOINT ["dotnet", "Application.dll"]



