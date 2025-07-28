FROM python:3.10-slim

# Set work directory
WORKDIR /code

# Install system dependencies
RUN apt-get update \
    && apt-get install -y build-essential libpq-dev gcc \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt /code/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Debug: Print installed packages
RUN pip list

# Copy project files
COPY . /code/

# Run collectstatic only if needed
RUN if python -c "import django" ; then python manage.py collectstatic --noinput ; fi

# Expose port
EXPOSE 8000

# Run the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

