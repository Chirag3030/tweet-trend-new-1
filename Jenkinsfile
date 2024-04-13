def registry ='https://losteroid.jfrog.io'
def imageName = 'losteroid.jfrog.io/losteroid-docker-local/ttrend'
def version   = '2.1.2'
pipeline {
    agent {
        node {
            label 'maven-slave'
        }
    }
    environment {
        PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
    }
    stages {
        stage("Build") {
            steps {
                echo "-----------build started----------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "-----------build completed--------"
            }
        }
        stage("Test") {
            steps {
                echo "-------unit test started-----------"
                sh 'mvn surefire-report:report'
                echo "-------unit test completed---------"
            }
        }
        stage("Jar Publish") {
            steps {
                script {
                    echo '<--------------- Jar Publish Started ---------------->'
                    def server = Artifactory.newServer url: registry + "/artifactory", credentialsId: "artifact-cred"
                    def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}"
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "jarstaging/(*)",
                                "target": "losteroid-maven-libs-release-local/{1}",
                                "flat": "false",
                                "props": "${properties}",
                                "exclusions": ["*.sha1", "*.md5"]
                            }
                        ]
                    }"""
                    def buildInfo = server.upload(uploadSpec)
                    buildInfo.env.collect()
                    server.publishBuildInfo(buildInfo)
                    echo '<--------------- Jar Publish Ended --------------------->'
                }
            }
        }

        stage(" Docker Build ") {
          steps {
            script {
               echo '<--------------- Docker Build Started --------------->'
               app = docker.build(imageName+":"+version)
               echo '<--------------- Docker Build Ends --------------->'
            }
          }
        }

                stage (" Docker Publish "){
            steps {
                script {
                   echo '<--------------- Docker Publish Started ---------------->'  
                    docker.withRegistry(registry, 'artifact-cred'){
                        app.push()
                    }    
                   echo '<--------------- Docker Publish Ended --------------->'  
                }
            }
        }
    }
}
