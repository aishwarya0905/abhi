FROM centos:7
RUN yum install httpd -y
RUN echo "<h1> hello cloud </h1>" > /var/www/html/index.html
CMD httpd -DEFOREGROUND
RUN echo "demo" > /file2
