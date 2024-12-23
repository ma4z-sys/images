FROM node:lts

WORKDIR /app/data

CMD ["sh", "-c", "$START"]
CMD ["sh", "-c", "$START2"]
