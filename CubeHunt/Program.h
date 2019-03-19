//
//  Program.h
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Program : NSObject

@property (assign, nonatomic) GLuint program;

-(GLuint)loadShader:(GLenum)type withSource:(const char*)source;

-(GLuint)linkVertexShader:(GLuint)vertexShader andFragmentShader:(GLuint)fragmentShader;

@end
