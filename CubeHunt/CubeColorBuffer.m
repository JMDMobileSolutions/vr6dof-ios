//
//  CubeColorBuffer.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "CubeColorBuffer.h"

@implementation CubeColorBuffer

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        GLfloat data[] = {
            1, 0, 0, 1,
            1, 0, 0, 1,
            1, 0, 0, 1,
            1, 0, 0, 1,
            1, 0, 0, 1,
            1, 0, 0, 1,
            0, 1, 0, 1,
            0, 1, 0, 1,
            0, 1, 0, 1,
            0, 1, 0, 1,
            0, 1, 0, 1,
            0, 1, 0, 1,
            0, 0, 1, 1,
            0, 0, 1, 1,
            0, 0, 1, 1,
            0, 0, 1, 1,
            0, 0, 1, 1,
            0, 0, 1, 1,
            1, 1, 0, 1,
            1, 1, 0, 1,
            1, 1, 0, 1,
            1, 1, 0, 1,
            1, 1, 0, 1,
            1, 1, 0, 1,
            1, 0, 1, 1,
            1, 0, 1, 1,
            1, 0, 1, 1,
            1, 0, 1, 1,
            1, 0, 1, 1,
            1, 0, 1, 1,
            0, 1, 1, 1,
            0, 1, 1, 1,
            0, 1, 1, 1,
            0, 1, 1, 1,
            0, 1, 1, 1,
            0, 1, 1, 1
        };
        GLuint length = 144;
        self.buffer = [self createWithData:data andLength:length];
        if (self.buffer == 0)
        {
            return self;
        }
        self.length = length;
    }
    return self;
}
@end
