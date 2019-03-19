//
//  Renderer.h
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import <GVRKit/GVRKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Renderer : GVRRenderer

-(void)updateTransform:(simd_float4x4)transform isTracking:(BOOL)isTracking;

@end

NS_ASSUME_NONNULL_END
