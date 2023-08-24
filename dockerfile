FROM centos:7
RUN yum install epel-release -y
RUN yum install java-openjdk -y
RUN yum install mariadb -y
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.92/bin/apache-tomcat-8.5.92.tar.gz /opt/
WORKDIR /opt
RUN tar -xzf apache-tomcat-8.5.92.tar.gz
WORKDIR /opt/apache-tomcat-8.5.92
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar lib/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war webapps/
COPY context.xml conf/context.xml
RUN mysql -h database-12.cc5qxedpq2vh.us-east-1.rds.amazonaws.com -u admin -padmin123
RUN create database studentapp;
RUN use studentapp;
RUN CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT,
	student_name VARCHAR(100) NOT NULL,
    student_addr VARCHAR(100) NOT NULL,
	student_age VARCHAR(3) NOT NULL,
	student_qual VARCHAR(20) NOT NULL,
	student_percent VARCHAR(10) NOT NULL,
	student_year_passed VARCHAR(10) NOT NULL,
	PRIMARY KEY (student_id) );
RUN exit;
EXPOSE 8080
CMD ./bin/catalina.sh run