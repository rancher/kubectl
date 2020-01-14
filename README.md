# kubectl

And that's it.

## Building

```shell script
# On amd64 ...
docker build --build-arg ARCH=amd64 --build-arg ALPINE=amd64/alpine:3.11 --tag rancher/kubectl .
```

```shell script
# On arm64 ...
docker build --build-arg ARCH=arm64 --build-arg ALPINE=arm64v8/alpine:3.11 --tag rancher/kubectl .
```

```shell script
# On arm32 ...
docker build --build-arg ARCH=arm --build-arg ALPINE=arm32v7/alpine:3.11 --tag rancher/kubectl .
```

## License
Copyright (c) 2020 [Rancher Labs, Inc.](http://rancher.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
