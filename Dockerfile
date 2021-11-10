FROM 40ants/base-lisp-image:latest-sbcl-bin

# Install caveman and make a dummy project
RUN ros -e '(ql:quickload :caveman2) (caveman2:make-project #P"/root/.roswell/local-projects/dummy" :author "Dockerfile")'

# Install the dependences of the dummy project, then remove it
RUN ros -e '(ql:quickload :deps)'
RUN rm -rf /root/.roswell/local-projects/deps

# Get clackup
RUN ros install clack

# Improve ergonomics
RUN apt-get update && apt-get install -y rlwrap
RUN echo 'alias ros="rlwrap ros"' >> ~/.bashrc
