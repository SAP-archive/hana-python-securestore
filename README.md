[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/hana-python-securestore)](https://api.reuse.software/info/github.com/SAP-samples/hana-python-securestore)

# Python example of SAP HANA Secure Store API

## Description

This repo contains a complete example of interfacing with the SAP HANA Secure Store API.  It take the form of multi-target application(MTA) with the interfacing module written in the python programming language.  

If you are just interested in the python specifics of calling the API, you can find all the details in the [python/server.py](python/server.py) file.

This example is referred to in the official SAP help documentation at the following link: [Access the SAP HANA Secure Store with Python](https://help.sap.com/viewer/DRAFT/4505d0bdaf4948449b7f7379d24d0f0d/2.0.04/en-US/0d07ee1462c141beb8a86a92bc9cb92e.html)

## Requirements

- The user is expected to be familiar with XS Advanced(XSA) application development in general and the Python programming language  and it's packaging utilities(pip) specifically.  Also a working knowledge of XSA organization, spaces, roles, and space mappings is assumed.

- The Secure Store functions are implmented in a SAP HANA Database instance and the sample application must be deployed into a space where a HANA instance is available.  

- The target deploy environment must have Python runtime 3.6.5 installed(or adjust python/runtime.txt).  Verify with the following using the XSA command-line-interface tool.

    ```
    xs runtimes
    ```

   If the required Python runtime is not available, request it be installed by your HANA system administrator.  
   
   >  Here are instructons for the system administrator: [The SAP HANA XS Advanced Python Run Time](https://help.sap.com/viewer/DRAFT/4505d0bdaf4948449b7f7379d24d0f0d/2.0.03/en-US/8d786ec8ab964145a7453c1f53f452db.html)

- Python, with pip utility for assembling the python dependencies.  See [python.org](https://www.python.org/)

- Either the XSA command-line-interface tools(xs) or the Cloud Foundry(CF) command-line-interface tool(cf) with MTA plugin to facilitate the deploy.  This example will use the XSA CLI. 

    See the [Client package available from the HANA Express Downloader](https://www.sap.com/cmp/ft/crm-xu16-dat-hddedft/index.html) or the [Cloud Foundry CLI + MTA Plugin](https://github.com/cloudfoundry-incubator/multiapps-cli-plugin)

- A functional java runtime (for the MTA builder tool).  See [java.com](https://www.java.com/en/download/)

- The MTA builder tool jar file.  See [Multitarget Application Archive Builder](https://help.sap.com/viewer/58746c584026430a890170ac4d87d03b/Cloud/en-US/ba7dd5a47b7a4858a652d15f9673c28d.html) 

- A  NodeJS implementation for assembling the nodejs dependencies. See [NodeJS.org](https://nodejs.org/en/)

- The [git command line client](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

- This example project also requires python libraries provided by SAP. Follow the help instructions at the following link in order to download the XS_PYTHON.ZIP file:  [Download and Consume Python Libraries](https://help.sap.com/viewer/4505d0bdaf4948449b7f7379d24d0f0d/2.0.03/en-US/842824f04d654ceeaf5168da663a65ce.html)



## Download and Installation

>  **Note:**  These instructions assume you are using a Linux or MacOS system.  If you are on Windows, substitute "/" for "\\" in the commands below, and use `/` instead of `-` for options.  Some options may not be required on Windows, you can safely remove them.

> **Caution:** The following instructions should be performed on a Linux based system.  The python pip utility has a tendency to pick up versions of the libraries of the current system's architecture and this will cause the deployed application to crash.  If you are running on a Windows system you can either use a Secure Shell client(SSH) such as Putty to shell into your HANA instance or install a small Linux based system using a virtual machine or Docker container.  Details are beyond the scope of this document. 

- Create a folder (using sap_dependencies here to mimik the help documentation) and unzip the file contents into it.
The file name was XS_PYTHON00_1-70003433.ZIP as of the date this repo was last updated.  You may need to adjust the filename accordingly.

    ```
    mkdir -p sap_dependencies
    unzip XS_PYTHON00_1-70003433.ZIP -d sap_dependencies
    ```

- Clone this repo at the same directory level as the sap_dependencies folder.  For details on cloning a repo see [Cloning a repository](https://help.github.com/articles/cloning-a-repository/)
    ```
    git clone https://github.com/SAP/hana-python-securestore.git
    ```

- Change into the project folder.
    ```
    cd hana-python-securestore
    ```



- Pull all the python dependencies into a "vendor" folder that will be bundled into the project.
    ```
    cd python
    mkdir -p vendor
    pip download -d vendor -r requirements.txt --find-links ../../sap_dependencies
    cd ..
    ```
    
    > **Note:** If pip doesn't support the download sub-command you may need to update it.
    ```
    pip install --upgrade pip  
    ```

- Pull all the NodeJS dependencies into a "node_modules" folder that will be bundled into the project.
    ```
    tools/set_nodejs_env
    cd app
    npm install
    cd ..
    ```

- Build the MTAR and deploy the application to a space where an SAP HANA instance is available.
    ```
    mkdir -p target
    java -jar ../mta_archive_builder-1.1.7.jar --build-target XSA --mtar target/python-securestore_xsa.mtar build
    xs deploy target/python-securestore_xsa.mtar --use-namespaces
    ```

- Discover the deployed application's URL and open it in a browser.
    ```
    xs app hana-python-securestore.app --urls
    ```

## Limitations

This example is intended to illustrate the use of the Secure Storage API in a HANA system.  It does not contain extensive error handling or enforce a certain order of operations.  As such, certain assumptions apply and key values are hard coded.  For instance, you can not retrieve or delete a value before it's been created.

## Known Issues

This example contains no known issues.

## How to obtain support

This project is provided "as-is" with no expectation for major changes or support.

## To-Do (upcoming changes)

The required python libraries may become publically available on PyPi at some point in the future.  If this becomes the case, the requirements will be simplified to remove the downloading of the SAP Python Libraries.

## License
 Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 This project is licensed under the SAP SAMPLE CODE LICENSE AGREEMENT except as noted otherwise in the [LICENSE file](LICENSES/Apache-2.0.txt).
