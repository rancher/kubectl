# kubectl

And. That. Is. It.

## Adding new versions

1. `Add new versions` workflow will create a PR,
2. A `CODEOWNER` will need to review and approve the PR,
3. Upon review, the `Validate PR` workflow will run to meet merge requirements,
4. The PR can be merged after all checks pass,
5. Once merged, the `Publish Images` workflow will run:
    - Validates versions file,
    - Prebuild information collection,
    - Image's built with docker `buildx` action,
    - CPU arch specific tags published

### Merging PRs & Image Releases
Before a PR can be merged it must be:
- Reviewed and Approved by at least 1 user assigned in `CODEOWNERS`, 
- passing the `Check kubectl release versions` action.

## Digging Deeper

The source for the versions to create the images is in `versions.txt`.
This file is maintained by the scheduled [`add-new-veresions.yml`](./.github/workflows/check-new-versions.yml) workflow which automatically looks up new versions and creates a pull request.
Additionally, you can manually add entries to it or manually run the [GitHub Actions workflow](./.github/workflows/check-new-versions.yml) to create an automatic PR on-demand.

Scripts live in the `./scripts` directory:

- `add-new-versions.sh`: Checks GitHub releases for `kubernetes/kubernetes` with a version regex, checks if the image already exists, and if not, adds it to `versions.txt`.
- `check-versions.sh`: Checks if the binaries exists for all architectures for versions in `versions.txt`.
- `new-versions.sh`: Compares versions in `versions.txt` to filter out new versions into `new-versions.txt` temp file. (Based on existing image versions defined by `$EXISTING_VERSIONS` env variable.)

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
