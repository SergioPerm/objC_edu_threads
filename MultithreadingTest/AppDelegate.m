//
//  AppDelegate.m
//  MultithreadingTest
//
//  Created by kluv on 03/06/2018.
//  Copyright © 2018 kluv. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray* array;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor lightGrayColor];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];

//    [self performSelectorInBackground:@selector(testThread) withObject:nil];
    
//    for (int i = 0; i < 3; i++) {
//
//        NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
//        myThread.name = [NSString stringWithFormat:@"Thread #%d",i + 1];
//
//        [myThread start];
//    }
    
//    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
//    [myThread start];
    
    /*
    self.array = [NSMutableArray array]; //also [[NSMutableArray alloc] init]
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"x"];
    myThread.name = [NSString stringWithFormat:@"Thread #%d",1];
    
    NSThread* myThread2 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"o"];
    myThread2.name = [NSString stringWithFormat:@"Thread #%d",2];
    
    [myThread start];
    [myThread2 start];
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:5];
    */
    
    self.array = [NSMutableArray array]; //also [[NSMutableArray alloc] init]
    
    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("kluv.thread1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [self addStringToArray:@"x"];
    });
    
    dispatch_async(queue, ^{
        [self addStringToArray:@"o"];
    });
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:5];
    
    return YES;
}

- (void) testThread {
    
    @autoreleasepool {
    
        NSString* threadName = [[NSThread currentThread] name];
        double startTime = CACurrentMediaTime();
        
        for (int i = 0; i < 20000; i++) {
            NSLog(@"Thread name: %@, %d", [[NSThread currentThread] name] ,i);
        }
        
        NSLog(@"%@ finished in %f", threadName, CACurrentMediaTime() - startTime);
    }
    
}

- (void) addStringToArray:(NSString*) string {
    
    @autoreleasepool {
        
        NSString* threadName = [[NSThread currentThread] name];
        double startTime = CACurrentMediaTime();
        
        for (int i = 0; i < 1000; i++) {
            //@synchronized(self) {
                [self.array addObject:string];
            //}
        }
        
        NSLog(@"%@ finished in %f", threadName, CACurrentMediaTime() - startTime);
        
    }
    
}

- (void) printArray{
    NSLog(@"%@", self.array);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
