FROM node:14-alpine3.12
WORKDIR /usr/src/app

# javaのインストール
RUN apk update && \
    apk add --no-cache openjdk11 python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install awscli && \
    rm -rf /var/cache/apk/*

ENV AWS_ACCESS_KEY_ID="dummy" AWS_DEFAULT_REGION="ap-northeast-1" AWS_SECRET_ACCESS_KEY="dummy"
COPY package*.json ./
RUN npm install

# アプリケーションのソースをバンドルする
COPY . .

# local dynamodbのインストール
RUN npm run setup

EXPOSE 8000
CMD [ "npm", "run", "dynamodb"]