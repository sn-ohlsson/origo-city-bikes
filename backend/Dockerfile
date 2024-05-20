# Use a base image with Java and Maven
# FROM maven:3.8.4-openjdk-17-slim
FROM maven:3.8.6-openjdk-11
# Set the working directory
WORKDIR /app/backend

# Copy the project files
COPY . .

# Build the application
RUN mvn clean package

# Expose the port your application runs on
EXPOSE 8080

# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "target/backend-0.0.1-jar-with-dependencies.jar"]
#CMD ["origo_city_bikes.ApplicationKt"]