FROM microsoft/dotnet:2.1-sdk as source

RUN  apt-get update \
  && apt-get install -y jq \
  && rm -rf /var/lib/apt/lists/* && \
  wget https://raw.githubusercontent.com/vishnubob/wait-for-it/8ed92e8cab83cfed76ff012ed4a36cef74b28096/wait-for-it.sh && \
   chmod +x wait-for-it.sh

COPY dotnet-hang.csproj .
RUN ls -la && dotnet restore ./dotnet-hang.csproj -v diag
COPY . .
RUN dotnet build dotnet-hang.csproj -c Release

ENTRYPOINT ["./run_test.sh"]