FROM node:alpine AS dependencies
WORKDIR /usr/src
COPY ./package.json ./
RUN npm install --only=production

FROM dependencies AS build
WORKDIR /usr/src/packages/website
COPY packages/website ./
RUN npm run build

FROM node:alpine AS production
WORKDIR /usr/src/website
COPY --from=build /usr/src/packages/website/dist ./
COPY --from=dependencies /usr/src/node_modules ./node_modules
ENV HOST=0.0.0.0
ENV PORT=80
EXPOSE 80
CMD ["node", "./server/entry.mjs"]