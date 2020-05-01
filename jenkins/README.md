### Jenkins

- <https://jenkins.io/doc/book/installing/>
- <https://devopscube.com/jenkins-master-build-slaves-docker-container/>
- GitLab
    - <https://github.com/jenkinsci/gitlab-plugin>
    - <https://github.com/jenkinsci/gitlab-plugin/wiki/Setup-Example>

- <https://stackoverflow.com/questions/53201656/extracting-an-entire-jenkins-stage-to-a-shared-library>

#### Retrieve password
- Open & Inspect and copy `"{...}"`
- Open Script Console by <https://jenkins/script>:
    ```groovy
    println(hudson.util.Secret.fromString("{...}").getPlainText())
    ``` 
- `echo "..." | base64 --decode`

#### CSP
- <https://wiki.jenkins.io/display/JENKINS/Configuring+Content+Security+Policy>
