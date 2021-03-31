#!/bin/bash


# Install OpenJDK (required for Jenkins)
yum install -y java-1.8.0-openjdk

# Add Jenkins stable repository
/usr/local/bin/wget -O "/etc/yum.repos.d/jenkins.repo" "http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo"
rpm --import "https://jenkins-ci.org/redhat/jenkins-ci.org.key"

# Install Jenkins
yum install -y jenkins

# Set Jenkins arguments for skipping install wizard
sed -i 's/^JENKINS_JAVA_OPTIONS=.*$/JENKINS_JAVA_OPTIONS="-Djenkins.install.runSetupWizard=false"/g' "/etc/sysconfig/jenkins"

# Enable and start Jenkins
systemctl enable jenkins && systemctl start jenkins

# Get Jenkins Cli client JAR file
/usr/local/bin/wget --tries=60 --waitretry=1 --retry-connrefused --retry-on-http-error=503 "http://localhost:8080/jnlpJars/jenkins-cli.jar" -P "/home/vagrant"

# Install Ansible plugin on Jenkins
java -jar "/home/vagrant/jenkins-cli.jar" -s "http://localhost:8080/" install-plugin "ansible"

# Restart Jenkins
systemctl restart jenkins
