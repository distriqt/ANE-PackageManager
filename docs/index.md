
![](images/hero.png)

# PackageManager

The [PackageManager](https://airnativeextensions.com/extension/com.distriqt.PackageManager) extension gives access to certain features of the Android package manager.


### Features:

- Receive package added and removed events when other applications are installed or removed from the device
- Single API interface - your code works across supported platforms with no modifications
- Sample project code and ASDocs reference



## Documentation


The [wiki](https://github.com/distriqt/ANE-PackageManager/) forms the best source of detailed documentation for the extension along with the [asdocs](https://distriqt.github.io/ANE-PackageManager/asdocs). 


Quick Example: 

```as3
PackageManager.service.addEventListener( PackageManagerEvent.PACKAGE_REMOVED, packageRemovedHandler );
		
function packageRemovedHandler( event:PackageManagerEvent ):void
{
	trace( "Package Removed::"+ event.packageName );
}
```

More information here: 

[com.distriqt.PackageManager](https://airnativeextensions.com/extension/com.distriqt.PackageManager)


## License

You can purchase a license for using this extension:

[airnativeextensions.com](https://airnativeextensions.com/)

distriqt retains all copyright.


![](images/promo.png)
