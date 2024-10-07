FROM ubuntu:latest

# Install Java and Maven
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk maven && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy only the pom.xml first for caching
COPY pom.xml /app/

# Download dependencies
RUN mvn dependency:go-offline

# Copy the rest of the application code
COPY . /app

# Build the application
RUN mvn clean package -Dmaven.test.skip=true

# Expose the port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/spring-backend-v1.jar"]
