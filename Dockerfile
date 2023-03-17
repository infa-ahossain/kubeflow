
# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM ubuntu:20.04


# avoid stuck build due to user prompt
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y curl wget sudo python3.8 python3.8-dev python3.8-venv python3-pip python3-wheel build-essential && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# create and activate virtual environment
# using final folder name to avoid path issues with packages
RUN python3.8 -m venv /home/myuser/venv
ENV PATH="/home/myuser/venv/bin:$PATH"

# install requirements
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir wheel
RUN pip3 install --no-cache-dir \
kfp

COPY . .
RUN chmod +x main.py
RUN pip install -r requirements.txt
CMD [ "python", "main.py", "run_test" ,"pipdecss", "exp3" ,"exp4" ,"exp456","kubeflow-user-example-com", "test_kfp.yaml"]
