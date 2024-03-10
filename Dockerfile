# Use the latest Node.js image
FROM node:latest AS builder

# Set the working directory in the container
WORKDIR ./

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the React app
RUN npm run build

# Use a smaller Nginx image for serving the built React app
FROM nginx:alpine

# Copy the built app from the previous stage to Nginx server
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

