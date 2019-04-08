
## Package Removed

The package removed event is dispatched every time another application package is removed from the device. The event will contain the package name (i.e. application id) of the application that was removed.

Using this functionality is as simple as adding a listener for the `PackageManagerEvent.PACKAGE_REMOVED` event and processing the event in a handler function, for example:

```as3
PackageManager.service.addEventListener( PackageManagerEvent.PACKAGE_REMOVED, packageRemovedHandler );
		
function packageRemovedHandler( event:PackageManagerEvent ):void
{
	trace( "Package Removed::"+ event.packageName );
}
```

The extension can also dispatch events for any package that was removed while your application was not running. These events will get dispatched straight after you add a listener for the package removed event.

In order for your application to receive events while your application is not running, you must add the following to your Android applications manifest additions. You should have done this as part of the ![](Add the Extension|i.Add the Extension) section but we will list the important receiver again here.

```xml
<receiver android:name="com.distriqt.extension.packagemanager.receivers.PackageManagerReceiver" android:enabled="true" android:exported="true" >
    <intent-filter>
        <action android:name="android.intent.action.PACKAGE_REMOVED" />
        <data android:scheme="package" />
    </intent-filter>
</receiver>
``` 


>
> **Note**: This event is **not** dispatched when your application is removed. You cannot detect your own application's removal using this process only other applications.
>

