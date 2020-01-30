# Example: docker run -ti --rm -p 5000:5000 -v $PWD:/foo puncover puncover --elf_file /foo/zephyr.elf --gcc_tools_base /usr/bin
FROM alpine
RUN apk update && apk add gcc py2-pip git
WORKDIR /opt
RUN git clone https://github.com/HBehrens/puncover.git --branch=master
WORKDIR /opt/puncover
RUN git checkout bba9fb7
RUN sed -i s/port=args.port/host=\'0.0.0.0\',port=args.port/g puncover/puncover.py
RUN pip install .
WORKDIR /tmp
RUN rm -rf /opt/puncover
EXPOSE 5000
CMD ["/usr/bin/puncover"]
