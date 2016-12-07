# Deploying a Gitlab CI Runner on Poky/ZC706

## Install the Gitlab CI runner binary for ARM

The binary for ARM architecture is downloaded and installed on the ZC706 machine via:

```
$ wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-arm
$ chmod +x /usr/local/bin/gitlab-ci-multi-runner
$ useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
```

The Gitlab CI runner is configured by running the following command. Enter the URL and token to be found on the project's Gitlab settings pages (Settings -> Runners)

```
$ gitlab-ci-multi-runner register
```
This will register the CI runner with the Gitlab service. In order to run the service, place the `gitlab-ci-runner` file in `/etc/init.d` and run

```
$ chmod 755 /etc/init.d/gitlab-ci-runner
$ chown root:root /etc/init.d/gitlab-ci-runner
$ update-rc.d gitlab-ci-runner defaults
```

This is necessary since the automated install script of the Gitlab CI Multi Runner does not know how to treat the Poky Linux distribution correctly.


## Checking the status

The status of the service can be checked either via the Gitlab service web interface or on the runner machine using:

```
$ /etc/init.d/gitlab-ci-runner status
```

The service is started and stopped via

```
$ /etc/init.d/gitlab-ci-runner start
$ /etc/init.d/gitlab-ci-runner stop
```
