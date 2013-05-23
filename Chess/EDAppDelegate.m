//
//  EDAppDelegate.m
//  Chess
//
//  Created by Dontje, Evan on 5/8/13.
//  Copyright (c) 2013 Evan Dontje. All rights reserved.
//

#import "EDAppDelegate.h"

#import "EDViewController.h"

#import "EDChessService.h"

@implementation EDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[EDViewController alloc] initWithNibName:@"EDViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[EDViewController alloc] initWithNibName:@"EDViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"chessboard_iPhone.jpeg"];
    
    UIGraphicsBeginImageContextWithOptions(self.window.frame.size, NO, 0.f);
    [backgroundImage drawInRect:CGRectMake(0.f, 0.f, self.window.frame.size.width, self.window.frame.size.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.window.backgroundColor = [UIColor colorWithPatternImage:resultImage];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:
(NSData *)deviceToken {
    
    
    // Register the APNS deviceToken with the Mobile Service Devices table.
    NSCharacterSet *angleBrackets = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:angleBrackets];
    
    
    EDChessService* instance = [EDChessService defaultService];
    [instance registerDeviceToken:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

@end
