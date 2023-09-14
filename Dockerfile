FROM node:16-slim
LABEL description="Triple Pattern Fragment Server."
# Install location
ENV dir /var/www/@ldf/server

# Copy the server files
WORKDIR ${dir}
#COPY components ${dir}/components/
#COPY config ${dir}/config/
#COPY bin ${dir}/bin/
#COPY package.json ${dir}

# Set the npm registry
ARG NPM_REGISTRY=https://registry.npmjs.org/
RUN npm config set @ldf:registry $NPM_REGISTRY

# Install the node module
RUN apt-get update && \
    apt-get install -y g++ make python python3
    #cd ${dir} 

#RUN npm install hdt
COPY . .
RUN yarn install
RUN apt-get remove -y g++ make python && apt-get autoremove -y && \
    rm -rf /var/cache/apt/archives

# Expose the default port
EXPOSE 3000

# Run base binary
ENTRYPOINT ["node", "./node_modules/.bin/ldf-server"]

# Default command
CMD ["--help"]
