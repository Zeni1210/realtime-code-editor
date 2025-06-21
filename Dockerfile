FROM node:alpine

LABEL version="1.0"
LABEL description="Real-time Collaborative Code Editor"
LABEL maintainer="kiruthika"

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]

RUN npm install --production

COPY . .

# Set environment variables
ENV VITE_BACKEND_URL=http://localhost:5050
ENV PORT=5050

# Expose the necessary ports
EXPOSE 5050
EXPOSE 3000

# Run the application
CMD ["npm", "run", "start:docker"]
