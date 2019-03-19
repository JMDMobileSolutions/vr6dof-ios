//
//  Buffer.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "Buffer.h"

@implementation Buffer

-(GLuint)createWithData:(GLfloat*)data andLength:(GLsizeiptr)length
{
    GLuint buffer = 0;
    glGenBuffers(1, &buffer);
    if (buffer == 0)
    {
        return buffer;
    }
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, length * sizeof(GLfloat), data, GL_STATIC_DRAW);
    return buffer;
}
@end
