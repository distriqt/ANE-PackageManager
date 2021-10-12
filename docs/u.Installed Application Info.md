
There are two methods to retrieve the installed application information, asynchronous and synchronous. We suggest the async method as it shouldn't affect the ui as much as the synchronous method may do, depending on the device and the number of applications installed.

Which ever method you use, the end result is an `Array` of `PackageInfo` objects. These objects contain:

- `packageName`: The java package name of the application
- `label`: The name of the application
- `versionName`: The version name of this package, as specified by the manifest tag's `versionName` attribute
- `versionCode`: The version code for the application

along with other information detailed in the asdocs.



## Asynchronous retrieval

In order to retrieve a list of applications that are installed on the device call the `getInstalledApplicationsAsync()` function.

You can use either a callback passed to the function or listen for the `PackageManagerEvent.GET_INSTALLED_APPLICATIONS` event (or both)


Listening for the event involves adding a listener for `PackageManagerEvent.GET_INSTALLED_APPLICATIONS` and then processing the result in the handler:

```as3
PackageManager.service.addEventListener( 
    PackageManagerEvent.GET_INSTALLED_APPLICATIONS, 
    getInstalledApplicationsHandler 
);

PackageManager.service.getInstalledApplicationsAsync();


function getInstalledApplicationsHandler( event:PackageManagerEvent ):void
{
    var installedPackages:Array = event.data;
    if (installedPackages != null)
    {
        for each (var packageInfo:PackageInfo in installedPackages)
        {
            trace( packageInfo.packageName );
        }
    }
}
```	 


Alternatively you can do the similar thing with a callback:

```as3
PackageManager.service.getInstalledApplicationsAsync(
        function( installedPackages:Array ):void
        {
            if (installedPackages != null)
            {
                for each (var packageInfo:PackageInfo in installedPackages)
                {
                    trace( packageInfo.packageName );
                }
            }
        }
);
```


## Synchronous retrieval

You can also call `getInstalledApplications()` to directly retrieve an array of the application package information however be aware that this call may take some time.


```as3
var installedPackages:Array = PackageManager.service.getInstalledApplications();
if (installedPackages != null)
{
    for each (var packageInfo:PackageInfo in installedPackages)
    {
        trace( packageInfo.packageName );
    }
}
```