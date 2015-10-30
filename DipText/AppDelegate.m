//
//  AppDelegate.m
//  DipText
//
//  Created by Samuelhuang on 30/10/2015.
//  Copyright © 2015年 Samuelhuang. All rights reserved.
//

#import "AppDelegate.h"
#import "Product.h"
#import "ProductSpec.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

// go

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


+ (instancetype)spec:(ProductSpec *)spec, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start( args, spec );
    NSMutableArray *mArray = [@[spec] mutableCopy];
    for ( ;; )
    {
        id tempSpec = va_arg( args, id );
        if (tempSpec == nil)
            break;
        [mArray addObject:tempSpec];
    }
    va_end( args );
    AndSpec *andSpec = [[AndSpec alloc] init];
    andSpec.specs = [mArray copy];
    return andSpec;
}
- (BOOL)satisfy:(Product *)product
{
    for (ProductSpec *spec in _specs) {
        if (![spec satisfy:product]) {
            return NO;
        }
    }
    return YES;
}


-(NSArray *)findProducts:(NSArray *)products bySpec:(ProductSpec *)spec
{
    NSMutableArray *list = [@[] mutableCopy];
    for (Product *product in products) {
        if ([spec satisfy:product]) {
            [list addObject:product];
        }
    }
    return list;
}


-(NSArray *) findAllRedProducts:(NSArray*)products{

    NSMutableArray *list = [@[] mutableCopy];
    for (Product *product in products ){
        if ([product.color  isEqual: @"RED"]) {
            [list addObject:product];
        }
    }
    return list;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
