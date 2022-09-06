FROM ubuntu
RUN pip install -r requirements.txt
RUN apt get install python3 && apt get install vim && apt get install pip && mkdir /workspace
ARG username
ARG password
RUN git clone https://${username}:${password}@github.com/username/repository.git
