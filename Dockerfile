# Use the official Python image as the base image
FROM python:3.11

# Set the working directory inside the container
WORKDIR /thub-dev

# Copy the pyproject.toml and poetry.lock files
COPY pyproject.toml /thub-dev/

# Install Poetry and project dependencies
RUN pip install poetry
#&& poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

RUN poetry new thub-dev


# Copy the rest of the application code
COPY . /thub-dev/
