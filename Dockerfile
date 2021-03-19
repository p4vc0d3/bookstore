# Pull base image
FROM python:3.8

# Update the package listing
RUN apt-get update

# Install pygraphviz dependencies
RUN apt-get -y install --no-install-recommends \
    graphviz \
    libgraphviz-dev \
    pkg-config

# Delete cached files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
COPY Pipfile Pipfile.lock /code/
RUN pip install pipenv && pipenv install --system --dev

# Copy project
COPY . /code/