# Use a base image with Java and Maven installed
FROM maven:3.6.3-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files (pom.xml and src directory) to the container
COPY pom.xml .
COPY src ./src

# Build the application using Maven
RUN mvn clean package

# Create a new container with only the JRE
FROM openjdk:17

# Set the working directory in the container
WORKDIR /app

# Copy the compiled JAR file from the 'build' container to this container
COPY --from=build /home/runner/work/spring-petclinic/spring-petclinic/target

# Expose the port the application will run on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "app.jar"]
