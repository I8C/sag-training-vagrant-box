
# Introduction
This project describes how you can quickly build a Vagrant box, containing a Software AG (SAG) webMethods development/training/sandbox environment.  
  
# Pre-requisites
## Vagrant
[Vagrant](https://www.vagrantup.com/downloads.html) enables you to quickly create a Virtual Machine (VM), based on so called 'boxes', offering a wide variety of available Operating Systems, with optional additional features such as databases, middleware, etc... These boxes run on top of one or more types of hypervisors (VirtualBox, Hyper-V,...). We use the [VirtualBox](#virtualbox) hypervisor.  
  
Vagrant and the public boxes on the [Vagrant Cloud](https://app.vagrantup.com/boxes/search) can be used for free. The instructions in this manual were tested on Vagrant version 2.2.9., on Windows 10 Pro 1909.  
  
## VirtualBox
We use [VirtualBox](https://www.virtualbox.org/wiki/Downloads) because it's supported on Windows, Mac OS and Linux, allowing all members of our team to use the same demo VM on their laptop O.S. of choice. VirtualBox is also free and backed by an active community!!!  
  
The instructions in this manual were tested on VirtualBox v6.1.6.  
  
## Software AG Empower Account
To download the Software AG webMethods software, you need an account for https://empower.softwareag.com/ with access to Software Downloads.  
  
# Build
## Select Software AG webMethods version
First decision to make is which version and components of webMethods you wish to use. We use version 10.5, because it's the most recent version available with LTS at the time of writing.  
  
## Check webMethods System Requirements
Whenever installing webMethods software, first thing to check are the system requirements! SAG supports multiple O.S., RDBMS, JDK's, etc... but avoid installing the software on platforms or versions that are not supported, because this can cause issues and SAG support may refuse to help.  
  
So make sure you check the system requirements matrices in the [SAG System Requirements document](https://documentation.softwareag.com/system_platform_requirements/10-5_System_Requirements_for_Software_AG_Products.pdf) (version WEBM-SYS-10.5-20200515).  
  
For this project, we decided to use a Microsoft Windows Server and SQL Server environment, because this is also the type of environment SAG uses for it's training exercises. Based on the SAG System Requirements we can use:
- Windows Server 2012, 2016, 2019 (Windows 8 or 10 are also supported)
- SQL Server 2016, 2019
  
## Find matching Vagrant Box
Once you know your system requirements, you can search for a box on the Vagrant Cloud that matches those requirements. For this manual, we select https://app.vagrantup.com/gusztavvargadr/boxes/sql-server/versions/2019.0.2003, a box containing Windows Server 2019 2003.0.0 + SQL Server 2019, available for our hypervisor of choice, VirtualBox.  
  
We further customize this box, using the provisioning sections in our [Vagrantfile](./Vagrantfile). These will:
- install tools such as Notepad++, Git, Chrome, 7-zip,...
- set the locale and keyboard for the Belgian region
- rename the machine to _sagbase_
- enable the TCP/IP protocol for SQL Server, which the webMethods components will use to connect
  
  
To create and start the VM,  _git clone_ this project to your laptop and execute the following command from the CLI in this folder where this README.md and [Vagrantfile](./Vagrantfile) are located:  
  
```
vagrant up
```
  
Wait until the above command has completely finished before login in to the created VM. The VM will be restarted automatically to apply changes that require a restart.  
  
The used base box comes pre-installed with SQL Server Developer Edition and SQL Server Management Studio. You can access it with the following accounts:  
  
| Type | Username | Password |
| --- | --- | --- |
| Windows | vagrant | vagrant |
| SQL Server | sa | Vagrant42 |
  
  
## Evaluation License
The version of Windows Server on the selected box is an Evaluation version that is valid for 180 days. Luckily Microsoft allows you to extended the trial period by rearming the license, using the following command:  
  
```powershell
slmgr /rearm
```
  
You can rearm up to 5 times, resulting in a total duration of the Evaluation license up to 3 years. Use the following command to check the remaining rearm attempts:  
  
```powershell
slmgr /dlv
```
  
## Provisioning SAG webMethods
Vagrant comes with powerful provisioning features. Unfortunately, the SAG installer can't really be used from the command line, unless you've configured it using the UI first to generate the proprietary scripts it requires. The configration also changes with each release, so we don't invest any effort into trying to automate the installation and just perform it manually as explained in the sections below.  
  
The installation was performed with the SAG Installer version _SoftwareAGInstaller20191216-w64.exe_. Store the installer .exe file in the _C:\vagrant_ folder of the VM to keep the resulting Vagrant box small.  
  
### Create a software image
It's a best practice to create a software image first, using the _Advanced Options..._ button on the Welcome screen of the SAG Installer. Just add all available components to the image. We will select a subset of components to install, in a second run of the SAG installer, when we create the script in the next section using the components from this image.  
  
Save the image in the _C:\vagrant_ folder of the VM. This minimizes the size of the resulting Vagrant box we will create later on (a full image can be up to 10GB large), which makes distribution easier as it can be up- and downloaded faster. You can share the image file, together with the SAG installer used to create it as optional separate files.  
  
### Create an installation script  
Using the _Advanced Options..._ button on the Welcome screen of the SAG Installer, create a SAG Installer installation script for your installation procedure. The procedure for this box is shown in the screenshots below. As you can see, most of the default values are accepted in the installation below. The password used for the database user _webmuser_, is identical to the username.  
  
Note that you need to have your license key files available before you can perform the instation procedure.  
  
The script created for the installation below has been added to this project: [saginstallscript.txt](./saginstallscript.txt). The master password for this script = _vagrant_. This script installs the Common C/C++ libraries for CentraSite, requiring you to restart the VM and run the installer again to complete the installation. Creating an installation script saves you the annoyance of having to enter all the parameters again when you have to execute SAG installer a second time. Note that you can only use the script in this project if your Empower account has access to the same Software AG components.   
You can try to edit this script using the SAG Installer. If this doesn't work, just perform the installation based on the screen shots below and use those to create a new script.  
  
The full list of installed components can be found [here](./evidence/saginstaller.md). Use this list as a reference when you want to create a similar new box, using another version of the webMethods software.    
  

![1](./img/saginstaller/1.png)  
  
![2](./img/saginstaller/2.png)  
  
![3](./img/saginstaller/3.png)  
  
![4](./img/saginstaller/4.png)  
  
![5](./img/saginstaller/5.png)  
  
![6](./img/saginstaller/6.png)  
  
![7](./img/saginstaller/7.png)  
  
![8](./img/saginstaller/8.png)  
  
![9](./img/saginstaller/9.png)  
  
![10](./img/saginstaller/10.png)  
  
![11](./img/saginstaller/11.png)  
  
![12](./img/saginstaller/12.png)  
  
![13](./img/saginstaller/13.png)  
  
![14](./img/saginstaller/14.png)  
  
![15](./img/saginstaller/15.png)  
  
![16](./img/saginstaller/16.png)  
  
![17](./img/saginstaller/17.png)  
  
![18](./img/saginstaller/18.png)  
  
![19](./img/saginstaller/19.png)  
  
![20](./img/saginstaller/20.png)  
  
![21](./img/saginstaller/21.png)
  
![22](./img/saginstaller/22.png)  
  
![23](./img/saginstaller/23.png)
  
  
### Install the SAG software
Using the image and script from the previous sections, perform the actual installation. Specify them upon startup of the SAG Installer using the _Advanced Options..._ button on the Welcome screen. As explained in the previous section, you may have to run the script multiple times, as some components may require a restart of the O.S.   
  
It's a good practice to enable logging when performing the installation, using the _Advanced Options..._ button on the Welcome screen of the SAG Installer. The installer window closes without a notification when the installation is finished or interrupted. Then it's handy you can check the log to know the result of the installation.  
  
### Configure the database
Once the SAG installer has finished installing all components, you can run the database configurator from C:\SoftwareAG\common\db\bin\dbConfiguratorUI.bat to create the database, database user (set the password to the same value as the username) and its objects.  Install all available components into:  
  
```
jdbc:wm:sqlserver://localhost:1433;databaseName=webmdb
```  
  
The SQL Server database has already been installed and configured using the [Vagrantfile](./Vagrantfile).  
  
The result should look similar to [this](./evidence/dbconfigurator.log). Make sure there are no errors reported.  
  
![1](./img/dbconfigurator/1.png)  
  
  
  
### Test
Start the webMethods components you have installed, using the Windows Services created by the SAG Installer. Check that they startup correctly, by login in using the corresponding UI. Check the corresponding log files that their are no errors. The table below shows a couple of components that are typically always installed.  
  
  
| Component | Startup Type | URL | log file |
| --- | --- | --- | --- |
| My webMethods Server | Automatic | http://localhost:8585 | C:\SoftwareAG\MWS\server\default\logs\_full_.log |
| Integration Server | Automatic | http://localhost:5555 | C:\SoftwareAG\IntegrationServer\instances\default\logs\server.log |
  
# Package as a Vagrant box 
## Create
Once the installation of all SAG webMethods software is complete, you can create a Vagrant box from your existing VM, using:  
  
```
vagrant package --output webMethods10.5-1.0.0.box --vagrantfile VagrantfileForBoxing
```
  
The [VagrantfileForBoxing](./VagrantfileForBoxing) that is added to the package is based on the Vagrantfile packaged in the originating box. It indicates the type of O.S. of the box, which is required for the VirtualBox Guest Additions plugin. It's also used to set the initial CPU and memory specs in case these would not be explicitely set.  
  
## Distribute
The Vagrant box created by this project isn't (and should never be made!) publically available as it contains Software AG licensed software and your license keys that can't be publically shared.  
  
You can distribute the box file created in the previous section using a secured DropBox, OneDrive, etc...  
  
# Create VM from Vagrant box
To create a new VM instance from the Vagrant box created in the previous section on another laptop, you need to:
1) Install the [pre-requisites](#pre-requisites)
2) Create an empty folder in which:
   1) you download the Vagrant box created in the previous section
   2) you download the [metadata.json](./metadata.json) and [VagrantfileForVMInstance](./VagrantfileForVMInstance) files in this project
3) Rename the downloaded _VagrantfileForVMInstance_ to _Vagrantfile_
  
  
Then open a CLI and navigate to the folder created in bullet point 2. To install the box, just type:  
    
```
vagrant box add metadata.json
# Check if the box has been correctly installed
vagrant box list
```
  
Once the box has been installed (this can take a couple of minutes), you can simply create and start the VM by executing following command in the same CLI session.  
  
```
vagrant up
```
  
# Known issues
## SSL error during box download
Downloading the _gusztavvargadr/sql-server_ box might generate an OpenSSL timeout error. This seems to be some network issue, probably caused by the large size of the box. Just retry until the download succeeds.  
  