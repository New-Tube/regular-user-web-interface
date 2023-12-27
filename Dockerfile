FROM --platform=linux/amd64 node:21.5.0 as builder

WORKDIR /app

COPY ./app . 

RUN npm install
RUN npm run build


FROM --platform=linux/amd64 node:21.5.0

WORKDIR /app

COPY --from=builder /app/build /app/build
COPY --from=builder /app/package* /app/

ENV HOST=0.0.0.0
ENV PORT=8080

ENTRYPOINT [ "node", "build" ]
