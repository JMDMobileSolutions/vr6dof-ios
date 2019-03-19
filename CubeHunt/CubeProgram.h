//
//  CubeProgram.h
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "Program.h"

@interface CubeProgram : Program

@property (assign, nonatomic) GLint transform;

@property (assign, nonatomic) GLint position;

@property (assign, nonatomic) GLboolean focused;

@property (assign, nonatomic) GLint vertex;

@property (assign, nonatomic) GLint color;

@end
