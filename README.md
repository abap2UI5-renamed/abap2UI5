# abap2UI5 with Renamed Namespace

This repository demonstrates the automagic namespace renaming functionality. Fork this repository and automatically rename the namespace of abap2UI5.

### Features
* create a version for your customer namespace, e.g., /YYY/u5 or /YYY/2ui5.
* create versions for different departments, e.g., z2ui5_mm, z2ui5_pp, etc.
* create release-specific versions, e.g., z2ui5_124, z2ui5_125, etc.

After renaming, you can install abap2UI5 multiple times in the same system.

### Usage
1. Fork this repository
2. Set your new namespace [here](https://github.com/abap2UI5/abap2UI5-mirror-renamed/blob/main/abaplint_rename.json#L16-L17)
3. Run `npm run init` and `npm run main` to mirror [abap2UI5](https://github.com/abap2UI5/abap2UI5) and rename for example `z2ui5` to `/2U5/TEST`
4. Pull the repository with abapGit
5. (Optional) setup a [github action](https://github.com/abap2UI5/abap2UI5-mirror-renamed/blob/main/.github/workflows/cron.yml) to automate this process

### Credits
Thank you to [larshp](https://github.com/larshp) and the tool abaplint processing the renaming and [christianguenter2](https://github.com/christianguenter2) for abap2UI5 adjustments.

### Blogs
* Automagic standalone renaming of ABAP objects [(SCN - 20.02.2021)](https://community.sap.com/t5/application-development-blog-posts/automagic-standalone-renaming-of-abap-objects/ba-p/13499851)
* Multiple installations of abap2xlsx in the same system [(SCN - 09.12.2023)](https://community.sap.com/t5/application-development-blog-posts/multiple-installations-of-abap2xlsx-in-the-same-system/ba-p/13578241)
