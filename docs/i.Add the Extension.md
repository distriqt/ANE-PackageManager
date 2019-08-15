
## Add the Extension

First step is always to add the extension to your development environment. 
To do this use the tutorial located [here](http://airnativeextensions.com/knowledgebase/tutorial/1).



## Required ANEs

### Core ANE

The Core ANE is required by this ANE. You must include and package this extension in your application.

The Core ANE doesn't provide any functionality in itself but provides support libraries and frameworks used by our extensions.
It also includes some centralised code for some common actions that can cause issues if they are implemented in each individual extension.

You can access this extension here: [https://github.com/distriqt/ANE-Core](https://github.com/distriqt/ANE-Core).



### Android Support ANE

Due to several of our ANE's using the Android Support library the library has been separated 
into a separate ANE allowing you to avoid conflicts and duplicate definitions.
This means that you need to include the some of the android support native extensions in 
your application along with this extension. 

You will add these extensions as you do with any other ANE, and you need to ensure it is 
packaged with your application. There is no problems including this on all platforms, 
they are just **required** on Android.

This ANE requires the following Android Support extensions:

- [com.distriqt.androidsupport.V4.ane](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/com.distriqt.androidsupport.V4.ane)

You can access these extensions here: [https://github.com/distriqt/ANE-AndroidSupport](https://github.com/distriqt/ANE-AndroidSupport).

>
> **Note**: if you have been using the older `com.distriqt.AndroidSupport.ane` you should remove that
> ANE and replace it with the equivalent `com.distriqt.androidsupport.V4.ane`. This is the new 
> version of this ANE and has been renamed to better identify the ANE with regards to its contents.
>



## Extension IDs

The following should be added to your `extensions` node in your application descriptor to identify all the required ANEs in your application:

```xml
<extensions>
    <extensionID>com.distriqt.PackageManager</extensionID>
    <extensionID>com.distriqt.Core</extensionID>
    <extensionID>com.distriqt.androidsupport.V4</extensionID>
</extensions>
```





# Android 

## Manifest Additions

In order for certain features of the extension to operate correctly you must add the following to your manifest additions node of your application descriptor.

```xml
<android>
    <manifestAdditions><![CDATA[
        <manifest android:installLocation="auto" >
            <uses-permission android:name="android.permission.INTERNET"/>
            
            <application>

                <receiver android:name="com.distriqt.extension.packagemanager.receivers.PackageManagerReceiver" android:enabled="true" android:exported="true" >
                    <intent-filter>
                        <action android:name="android.intent.action.PACKAGE_REMOVED" />
                        <data android:scheme="package" />
                    </intent-filter>
                </receiver>

            </application>
        </manifest>
    )></manifestAdditions>
</android>
```



## Supported

You should always check whether the extension is supported before making calls. 
This allows you to react to whether the functionality is available on the device.

```as3
if (PackageManager.isSupported)
{
	//	Functionality here
}
```




