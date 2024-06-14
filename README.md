# config-apply-action
Upload and commit config to qbee.io within GitHub runners.

# Usage

# Usage
To use this action make sure to use our [authentication action](https://github.com/qbee-io/authenticate-action) before the file upload.

A sample GitHub action file in your repository would look like this

```yaml
name: qbee.io upload
on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
  
  steps:
    - uses: actions/checkout@v4

    - name: config apply and commmit for a node id
      uses: qbee-io/config-apply-action@main
      with:
        file_path: test/docker-containers.json
        form_type: docker_containers
        node_id: my-device-or-group-id
        commit_message: This is my commit message
    
    - name: config apply and commit for a tag name
      uses: qbee-io/config-apply-action@main
      with:
        file_path: test/docker-containers-template.json
        form_type: docker_containers
        tag_name: my-tag-name
        commit_message: ${{ github.event.head_commit.message}}
        template_params: docker_image=alpine:latest,user=my-user,password=my-password
```
# Input variables
* `file_path`: Path to the config json file. Valid json can be exported from the UI for the relevant form_type/bundle
* `form_type`: The form_type (bundle) that the config data is for (eg. docker_containers, software_management etc.)
* `node_id`: The device or group id the configuration will be applied to
* `tag_name`: The tag name the configuration will be applied to. Will take precedence if both `node_id` and `tag_name` are defined.
* `commit_message`: The qbee commit message. If no commit message is given, then a commit is not done (ie. config will not be made active)
* `template_params`: Comma separated list of key=value that will be used to expand any template vars in the config (see https://pkg.go.dev/text/template for templating syntax)