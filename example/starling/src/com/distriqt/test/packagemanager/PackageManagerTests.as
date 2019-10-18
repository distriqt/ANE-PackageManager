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
	import com.distriqt.extension.packagemanager.PackageManager;
	import com.distriqt.extension.packagemanager.events.PackageManagerEvent;
	
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
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
