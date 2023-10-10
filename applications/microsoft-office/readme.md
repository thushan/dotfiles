# Office Custom Installations

Who'd have thought that installing Office can be a royal PIA? What's more, it's install-all only and no uninstaller.

So here's a customised Office configuration to use with the [Office Deployment Tool](https://learn.microsoft.com/en-us/deployoffice/overview-office-deployment-tool) for the two variations of Windows installations.

## All

All configurations install the 64bit edition of Office and remove the following:

* Access
* Lync
* Outlook
* Publisher

via:

```xml
<ExcludeApp ID="Access" />
<ExcludeApp ID="Lync" />
<ExcludeApp ID="Outlook" />
<ExcludeApp ID="Publisher" />
```

Also ensures updates are installed.

## Work

Installs the `O365ProPlusRetail` version downloading it to `C:\OfficeSetup\`.

## Home

Installs the `ProPlus2021Retail` version downloading it to `C:\OfficeSetup\`.

Additionally removes:

* Teams
* OneDrive
* OneNote

via:

```xml
<ExcludeApp ID="OneDrive" />
<ExcludeApp ID="Teams" />
<ExcludeApp ID="OneNote" />
```

# Installing

With the [ODT Tool](https://go.microsoft.com/fwlink/p/?LinkID=626065) extracted, run the profile first to download components:

```powershell
PS> setup.exe /download office2021pro-config-home.xml
```

Then install with:

```powershell 
PS> setup.exe /configure office2021pro-config-home.xml
```