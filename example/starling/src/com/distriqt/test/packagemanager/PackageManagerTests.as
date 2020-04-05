/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Dec 4, 2017
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.packagemanager
{
	import com.distriqt.extension.packagemanager.PackageInfo;
	import com.distriqt.extension.packagemanager.PackageManager;
	import com.distriqt.extension.packagemanager.events.PackageManagerEvent;
	
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**	
	 */
	public class PackageManagerTests extends Sprite
	{
		public static const TAG : String = "";
		
		private var _l : ILogger;
		
		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}
		
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function PackageManagerTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				log( "PackageManager Supported: " + PackageManager.isSupported );
				if (PackageManager.isSupported)
				{
					log( "PackageManager Version:   " + PackageManager.service.version );
				}
			}
			catch (e:Error)
			{
				trace( e );
			}
		}
		
		
		////////////////////////////////////////////////////////
		//  
		//
		
		public function listen():void
		{
			log( "listen()" );
			PackageManager.service.addEventListener( PackageManagerEvent.PACKAGE_REMOVED, packageRemovedHandler );
		}
		
		
		private function packageRemovedHandler( event:PackageManagerEvent ):void
		{
			log( event.type + "::"+ event.packageName );
		}
		
		
		
		//
		//	INSTALLER
		//
		
		public function getInstaller():void
		{
			log( "getInstaller() = " + PackageManager.service.getInstallerPackageName() );
		}
		
		
		
		//
		//	INSTALLED APPLICATIONS
		//
		
		public function getInstalledApplications():void
		{
			log( "getInstalledApplications()" );
			var startTime:int = getTimer();
			var installedPackages:Array = PackageManager.service.getInstalledApplications();
			log( "getInstalledApplications(): native complete: " + String(getTimer() - startTime)  );
			if (installedPackages != null)
			{
				printPackages( installedPackages );
			}
			else
			{
				log( "not supported" );
			}
			log( "getInstalledApplications(): print complete: " + String(getTimer() - startTime)  );
		}
		
		
		public function getInstalledApplicationsAsync():void
		{
			log( "getInstalledApplicationsAsync()" );
			var startTime:int = getTimer();
			
			//
			//	You can use either a callback function or the event (or both)
			//
			
			PackageManager.service.addEventListener( PackageManagerEvent.GET_INSTALLED_APPLICATIONS, getInstalledApplicationsHandler );
			
			PackageManager.service.getInstalledApplicationsAsync(
					function( installedPackages:Array ):void
					{
						log( "getInstalledApplicationsAsync(): callback: " + String(getTimer() - startTime)  );
						printPackages( installedPackages );
					}
			);
			log( "getInstalledApplicationsAsync(): complete: " + String(getTimer() - startTime)  );
		}
		
		private function getInstalledApplicationsHandler( event:PackageManagerEvent ):void
		{
			printPackages( event.data );
		}
		
		
		private function printPackages( installedPackages:Array ):void
		{
			if (installedPackages != null)
			{
				for each (var packageInfo:PackageInfo in installedPackages)
				{
					log( "package: " + packageInfo.toString() );
				}
			}
		}
		
		
		//
		//	APP INSTALL
		//
		
		public function appInstall():void
		{
			log( "appInstall()" );
			if (PackageManager.service.canRequestApplicationInstalls)
			{
				var apkFile:File = File.applicationStorageDirectory.resolvePath("Main.apk");
				if (!apkFile.exists)
				{
					log( "copying apk" );
					File.applicationDirectory.resolvePath("assets/Main.apk").copyTo( apkFile );
					log( "copying apk complete" );
				}
				
				log( "installApplication( " + apkFile.nativePath + " )" );
				PackageManager.service.installApplication( apkFile.nativePath );
			}
			else
			{
				log( "canRequestApplicationInstalls() = false" );
			}
		}

		
		public function showManageUnknownAppSourcesSettings():void
		{
			log( "showManageUnknownAppSourcesSettings()" );
			PackageManager.service.showManageUnknownAppSourcesSettings();
		}
		
		
	}
}
