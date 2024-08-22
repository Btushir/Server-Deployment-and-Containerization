# Use the `python:3.9` as a source image from the Amazon ECR Public Gallery or base image for the docker image we are building
# We are not using `python:3.7.2-slim` from Dockerhub because it has put a  pull rate limit.
FROM public.ecr.aws/sam/build-python3.9:latest

# Set up an app directory for your code
# Copy all the files from the current on your local machine into a directory named /app inside the Docker image.
COPY . /app
 # sets the working directory to /app. Any subsequent commands in the Dockerfile will be executed in this directory.
WORKDIR /app

# Install `pip` and needed Python packages from `requirements.txt` in the docker image
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Define an entrypoint which will run the main app using the Gunicorn WSGI server.
ENTRYPOINT ["gunicorn", "-b", ":8080", "main:APP"]
