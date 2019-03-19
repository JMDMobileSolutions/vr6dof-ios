//
//  CubeBuffer.h
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "Buffer.h"

NS_ASSUME_NONNULL_BEGIN

@interface CubeBuffer : Buffer

-(BOOL)isFocusedInDirection:(GLKVector4)direction atPosition:(GLKVector4)position andCubePosition:(GLKVector3)cubePosition;

@end

NS_ASSUME_NONNULL_END
