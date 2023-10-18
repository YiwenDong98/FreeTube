FROM node:18

RUN apt-get update -y && apt install -y \
  libnss3 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdrm2 \
  libgtk-3-dev \
  libasound2 \
  && apt-get clean

COPY . /freetube
WORKDIR /freetube
RUN sed -i 's/const server = new WebpackDevServer({/const server = new WebpackDevServer({...webConfig.devServer,allowedHosts:"all",/' _scripts/dev-runner.js
RUN yarn install
RUN yarn run rebuild:electron

EXPOSE 9080
CMD ["yarn", "run", "dev:web"]
