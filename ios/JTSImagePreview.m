//
//  JTSImagePreview.m
//  RNImagePreview2
//
//  Created by lin on 2019/2/2.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "JTSImagePreview.h"
#import <React/RCTLog.h>
#import <JTSImageViewController.h>
#import "AppDelegate.h"

@implementation JTSImagePreview

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showImage:(NSString *)url)
{
  // method code
  RCTLogInfo(@"showImage with url %@", url);
  // init imageInfo
  JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
  // set url
  imageInfo.imageURL = [NSURL URLWithString:url];
  
  JTSImageViewController *imageViewer = [[JTSImageViewController alloc] initWithImageInfo:imageInfo mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_None];
  
  // Get root to show from
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  // Determine what controller is in the front based on if the app has a navigation controller or a tab bar controller
  UIViewController* showingController;
  if([delegate.window.rootViewController isKindOfClass:[UINavigationController class]]){
    
    showingController = ((UINavigationController*)delegate.window.rootViewController).visibleViewController;
  } else if ([delegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
    
    showingController = ((UITabBarController*)delegate.window.rootViewController).selectedViewController;
  } else {
    
    showingController = (UIViewController*)delegate.window.rootViewController;
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [imageViewer showFromViewController:showingController
                             transition:JTSImageViewControllerTransition_FromOffscreen];
  });
}

@end
