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

# setup for opencv
RUN apt-get update
RUN apt-get -y install libgl1-mesa-glx ghostscript python3-tk
RUN pip install camelot-py[cv]

RUN apt-get -y install gcc-11 g++-11
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 --slave /usr/bin/g++ g++ /usr/bin/g++-11
RUN pip install llama-cpp-python

# Copy the pyproject.toml and poetry.lock files
COPY pyproject.toml /thub-dev/

# Install Poetry and project dependencies
RUN pip install poetry && poetry config virtualenvs.create false

RUN poetry new thub-dev

RUN poetry install

# Copy the rest of the application code
COPY . /thub-dev/
