# abap2UI5 Mirror

Fork this repository to automatically rename the namespace of abap2UI5.

### Features
* create a version for your customer namespace, e.g., /YYY/u5 or /YYY/2ui5.
* create versions for different departments, e.g., z2ui5_mm, z2ui5_pp, etc.
* create release-specific versions, e.g., z2ui5_124, z2ui5_125, etc.

After renaming, you can also install abap2UI5 multiple times in the same system.

### Usage
1. Fork this repository
2. Set your new namespace here: https://github.com/oblomov-dev/dev-abap2UI5_mirror/blob/047d9fe9e39a7e8b28e058e8775fa923d74c7d42/abaplint_rename.json#L17
3. Run `npm run mirror` to mirror [abap2UI5](https://github.com/abap2UI5/abap2UI5) and rename `z2ui5` to `z5ui5`
4. Pull the repository with abapGit
5. (Optional) setup a github action to automate this process

### Credits
Thank you to [larshp](https://github.com/larshp) and the tool abaplint processing the renaming and [christianguenter2](https://github.com/christianguenter2) for adjusting abap2UI5 and setting this up.

### More
* Automagic standalone renaming of ABAP objects [(SCN - 20.02.2021)](https://community.sap.com/t5/application-development-blog-posts/automagic-standalone-renaming-of-abap-objects/ba-p/13499851)
