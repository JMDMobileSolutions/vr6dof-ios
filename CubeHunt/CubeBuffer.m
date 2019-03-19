//
//  CubeBuffer.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "CubeBuffer.h"

@implementation CubeBuffer

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        GLfloat data[] = {
            -1, 1, 1,
            -1, -1, 1,
            1, 1, 1,
            -1, -1, 1,
            1, -1, 1,
            1, 1, 1,
            1, 1, 1,
            1, -1, 1,
            1, 1, -1,
            1, -1, 1,
            1, -1, -1,
            1, 1, -1,
            1, 1, -1,
            1, -1, -1,
            -1, 1, -1,
            1, -1, -1,
            -1, -1, -1,
            -1, 1, -1,
            -1, 1, -1,
            -1, -1, -1,
            -1, 1, 1,
            -1, -1, -1,
            -1, -1, 1,
            -1, 1, 1,
            -1, 1, -1,
            -1, 1, 1,
            1, 1, -1,
            -1, 1, 1,
            1, 1, 1,
            1, 1, -1,
            1, -1, -1,
            1, -1, 1,
            -1, -1, -1,
            1, -1, 1,
            -1, -1, 1,
            -1, -1, -1
        };
        GLuint length = 108;
        self.buffer = [self createWithData:data andLength:length];
        if (self.buffer == 0)
        {
            return self;
        }
        self.length = length;
    }
    return self;
}

#define EPSILON 1E-6

-(BOOL)isFocusedInDirection:(GLKVector4)direction atPosition:(GLKVector4)position andCubePosition:(GLKVector3)cubePosition
{
    if (fabs(direction.x) > EPSILON)
    {
        float factor = (cubePosition.x - 1 - position.x) / direction.x;
        if (factor > EPSILON)
        {
            GLKVector4 hit = GLKVector4Add(position, GLKVector4MultiplyScalar(direction, factor));
            if (hit.y >= cubePosition.y - 1 && hit.y <= cubePosition.y + 1 && hit.z >= cubePosition.z - 1 && hit.z <= cubePosition.z + 1)
            {
                return YES;
            }
        }
        factor = (cubePosition.x + 1 - position.x) / direction.x;
        if (factor > EPSILON)
        {
            GLKVector4 hit = GLKVector4Add(position, GLKVector4MultiplyScalar(direction, factor));
            if (hit.y >= cubePosition.y - 1 && hit.y <= cubePosition.y + 1 && hit.z >= cubePosition.z - 1 && hit.z <= cubePosition.z + 1)
            {
                return YES;
            }
        }
    }
    if (fabs(direction.y) > EPSILON)
    {
        float factor = (cubePosition.y - 1 - position.y) / direction.y;
        if (factor > EPSILON)
        {
            GLKVector4 hit = GLKVector4Add(position, GLKVector4MultiplyScalar(direction, factor));
            if (hit.x >= cubePosition.x - 1 && hit.x <= cubePosition.x + 1 && hit.z >= cubePosition.z - 1 && hit.z <= cubePosition.z + 1)
            {
                return YES;
            }
        }
        factor = (cubePosition.y + 1 - position.y) / direction.y;
        if (factor > EPSILON)
        {
            GLKVector4 hit = GLKVector4Add(position, GLKVector4MultiplyScalar(direction, factor));
            if (hit.x >= cubePosition.x - 1 && hit.x <= cubePosition.x + 1 && hit.z >= cubePosition.z - 1 && hit.z <= cubePosition.z + 1)
            {
                return YES;
            }
        }
    }
    if (fabs(direction.z) > EPSILON)
    {
        float factor = (cubePosition.z - 1 - position.z) / direction.z;
        if (factor > EPSILON)
        {
            GLKVector4 hit = GLKVector4Add(position, GLKVector4MultiplyScalar(direction, factor));
            if (hit.x >= cubePosition.x - 1 && hit.x <= cubePosition.x + 1 && hit.y >= cubePosition.y - 1 && hit.y <= cubePosition.y + 1)
            {
                return YES;
            }
        }
        factor = (cubePosition.z + 1 - position.z) / direction.z;
        if (factor > EPSILON)
        {
            GLKVector4 hit = GLKVector4Add(position, GLKVector4MultiplyScalar(direction, factor));
            if (hit.x >= cubePosition.x - 1 && hit.x <= cubePosition.x + 1 && hit.y >= cubePosition.y - 1 && hit.y <= cubePosition.y + 1)
            {
                return YES;
            }
        }
    }
    return NO;
}
@end
