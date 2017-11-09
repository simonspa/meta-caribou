# Configuraion file
The foler contains a configuration file of the gitlab-runner server running the meta-caribou docker image.

The defualt path for the file is:
```
/etc/gitlab-runner/config.toml
```
The TOKEN keyword should be replaced with an actual value from the gitlab GUI.

Once uploaded on the gitlab-runner server, the service should be restarted with
```
service gitlab-runner restart
```
