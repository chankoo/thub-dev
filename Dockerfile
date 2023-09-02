# Use the official Python image as the base image
FROM python:3.11

# Set the working directory inside the container
WORKDIR /thub-dev

# rustup shell setup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# Set the initial PATH value (can be adjusted based on your requirements)
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# Run the logic from the script to modify PATH
RUN export PATH="$HOME/.cargo/bin:$PATH"

# Copy the pyproject.toml and poetry.lock files
COPY pyproject.toml /thub-dev/

# Install Poetry and project dependencies
RUN pip install poetry && poetry config virtualenvs.create false

RUN poetry new thub-dev

RUN poetry install

# Copy the rest of the application code
COPY . /thub-dev/
