ARG REPO=mcr.microsoft.com/dotnet/runtime-deps
FROM $REPO:7.0.14-alpine3.18-amd64

# .NET globalization APIs will use invariant mode by default because DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true is set
# by the base runtime-deps image. See https://aka.ms/dotnet-globalization-alpine-containers for more information.

# .NET Runtime version
ENV DOTNET_VERSION=7.0.14

# Install .NET Runtime
RUN wget -O dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-musl-x64.tar.gz \
    && dotnet_sha512='954cb4d80a7da484c5f73a4dd26b35866fe320260af6c7c7dd79e7b82bfc4d972c6c854c705514983f78ee2f44b572f30ed622dd69e94c737e6c5663279f68be' \
    && echo "$dotnet_sha512  dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -oxzf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
# Set the working directory inside the container
WORKDIR /app

# Copy all project files and restore dependencies
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Build the runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:7.0.14-alpine3.18-amd64
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the port your app will run on
EXPOSE 80

# Define the command to run your application
ENTRYPOINT ["dotnet", "YourMainApi.dll"]
