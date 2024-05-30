# Use a base image with Maven installed
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY . .

# Build the Maven project
RUN mvn clean package

# Use a lightweight base image for the final container
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/hello-world-1.0-SNAPSHOT.jar .

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "hello-world-1.0-SNAPSHOT.jar"]
