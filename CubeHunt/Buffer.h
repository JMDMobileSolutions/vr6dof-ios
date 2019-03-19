//
//  Buffer.h
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Buffer : NSObject

@property (assign, nonatomic) GLuint buffer;

@property (assign, nonatomic) GLuint length;

-(GLuint)createWithData:(GLfloat*)data andLength:(GLsizeiptr)length;

@end
