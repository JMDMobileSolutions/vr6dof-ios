//
//  Program.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "Program.h"

@implementation Program

-(GLuint)loadShader:(GLenum)type withSource:(const char*)source
{
    GLuint shader = glCreateShader(type);
    if (shader == 0)
    {
        return shader;
    }
    glShaderSource(shader, 1, &source, NULL);
    glCompileShader(shader);
    GLint result = GL_FALSE;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &result);
    if (result == GL_TRUE)
    {
        return shader;
    }
    GLint length = 0;
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &length);
    if (length > 1)
    {
        char* log = malloc(length);
        glGetShaderInfoLog(shader, length, NULL, log);
        NSLog(@"%s", log);
        free(log);
    }
    glDeleteShader(shader);
    return 0;
}

-(GLuint)linkVertexShader:(GLuint)vertexShader andFragmentShader:(GLuint)fragmentShader
{
    GLuint program = glCreateProgram();
    if (program == 0)
    {
        return program;
    }
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    GLint result = GL_FALSE;
    glGetProgramiv(program, GL_LINK_STATUS, &result);
    if (result == GL_TRUE)
    {
        return program;
    }
    GLint length = 0;
    glGetProgramiv(program, GL_INFO_LOG_LENGTH, &length);
    if (length > 1)
    {
        char* log = malloc(length);
        glGetProgramInfoLog(program, length, NULL, log);
        NSLog(@"%s", log);
        free(log);
    }
    glDeleteProgram(program);
    return 0;
}
@end
