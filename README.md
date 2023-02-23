# kubectl

And. That. Is. It.

## Adding new versions

The source for the versions to create the images is in `versions.txt`. You can manually add entries to it or use the [GitHub Actions workflow](./.github/workflows/add-new-versions.yml) to automatically lookup new versions and create a pull request.

Scripts live in the `./scripts` directory:

- `add-new-versions.sh`: Checks GitHub releases for `kubernetes/kubernetes` with a version regex, checks if the image already exists, and if not, adds it to `versions.txt`.
- `check-versions.sh`: Checks if the binaries exists for all architectures for versions in `versions.txt`.
- `image-build-and-push.sh`: Checks if image already exists, if not, build and push it.
- `manifest-create-and-push.sh`: After all images for all architectures are created, create a manifest for all architectures and push.

## License

Copyright © 2020 - 2023 SUSE LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
