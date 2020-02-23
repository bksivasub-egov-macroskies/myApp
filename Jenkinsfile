podTemplate(yaml: """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  serviceAccountName: cd-jenkins
  containers:
  - name: app
    image: buvan/git
    command: ["/bin/sh","-c","cd /data && git clone https://github.com/bksivasub-egov-macroskies/myApp.git && cat"]
    tty: true
    volumeMounts:
      - name: shared-volume
        mountPath: /data

  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug-539ddefcae3fd6b411a95982a830d987f4214251
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
  
    volumeMounts:
      - name: kaniko-secret
        mountPath: /kaniko/.docker
      - name: shared-volume
        mountPath: /data
  restartPolicy: Never
  volumes:
    - name: shared-volume
      emptyDir: {}
    - name: kaniko-secret
      secret:
        secretName: regcred
        items:
          - key: .dockerconfigjson
            path: config.json
        """
        )
{
    node(POD_LABEL) {
    stage('Build with Kaniko') {
      git 'https://github.com/jenkinsci/docker-jnlp-slave.git'
      container('kaniko') {
          sh '/kaniko/executor -f /data/myApp/Dockerfile -c /data/myApp --destination=buvan/hiya'
            }
        }
    }
}
