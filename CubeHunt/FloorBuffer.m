//
//  FloorBuffer.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "FloorBuffer.h"

@implementation FloorBuffer

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        GLfloat data[] = {
            20, 0, 0,
            0, 0, 0,
            0, 0, 20,
            20, 0, 0,
            0, 0, 20,
            20, 0, 20,
            0, 0, 0,
            -20, 0, 0,
            -20, 0, 20,
            0, 0, 0,
            -20, 0, 20,
            0, 0, 20,
            20, 0, -20,
            0, 0, -20,
            0, 0, 0,
            20, 0, -20,
            0, 0, 0,
            20, 0, 0,
            0, 0, -20,
            -20, 0, -20,
            -20, 0, 0,
            0, 0, -20,
            -20, 0, 0,
            0, 0, 0
        };
        GLuint length = 72;
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
