//
//  FloorColorBuffer.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "FloorColorBuffer.h"

@implementation FloorColorBuffer

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        GLfloat data[] = {
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
            0, 0.5, 0, 1,
        };
        GLuint length = 96;
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
