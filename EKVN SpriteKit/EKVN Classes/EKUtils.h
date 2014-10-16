//
//  ekutils.h
//  EKVN SpriteKit
//
//  Created by James on 9/17/14.
//  Copyright (c) 2014 James Briones. All rights reserved.
//

/*
 
 NOTES:
 
 The "normal" edition of EKVN is meant for use with cocos2d, while EKVN SpriteKit runs on -- obviously -- SpriteKit. 
 However, cocos2d has certain functions/capabilities/quirks that aren't present in SpriteKit. The EKUtils files then, 
 are a group of functions that are meant to bridge the gap between the two frameworks, and make the transition from
 cocos2d to SpriteKit a little easier.
 
 */

#include <SpriteKit/SpriteKit.h>

// Set (or find) the screen size in points (as opposed to the screen size in pixels).
void EKSetScreenSizeInPoints( CGFloat width, CGFloat height );
CGSize EKScreenSizeInPoints();

// Retrieves view/screen size data from an SKView object. 
void EKSetScreenDataFromView( SKView* view );

// Sets position using normalized coordinates; used mostly to set SKNode positions to normalized coordinates (0.0 to 1.0)
CGPoint EKPositionWithNormalizedCoordinates( CGFloat normalizedX, CGFloat normalizedY );

// Adds two positions (CGPoints) together; returns result.
CGPoint EKPositionAddTwoPositions( CGPoint first, CGPoint second );

// Used when adding one node to another; this function finds where the bottom-left corner of the node would be.
// In cocos2d, adding one node to another with a position of (0,0) results in the child node being positioned
// at the lower-left corner of the parent, which isn't the case with SpriteKit.
CGPoint EKPositionOfBottomLeftCornerOfParentNode( SKNode* parentNode );

// Calculates distance between two points. This works more-or-less like cocos2d's ccpDistance function
CGFloat EKMathDistanceBetweenPoints( CGPoint first, CGPoint second );

// Checks for collision between two sprite "circles," or rather, it checks the distance between two sprites and sees
// if they're close enough to "collide."
BOOL EKCollisionBetweenSpriteCircles( SKSpriteNode* first, SKSpriteNode* second );

// Checks for collision between two boundinx boxes.
BOOL EKCollisionBetweenSpriteBoundingBoxes( SKSpriteNode* first, SKSpriteNode* second );

// Used to convert color from cocos2d's ccColor3B format to the UIColor format.
UIColor* EKColorFromUnsignedCharRGB( unsigned char r, unsigned char g, unsigned char b );
UIColor* EKColorFromUnsignedCharRGBA( unsigned char r, unsigned char g, unsigned char b, unsigned char a );

// Retrieves bounding box of sprite. However, cocos2d's "bounding box" and SpriteKit's "frame" are similar; so this might not be necessary.
CGRect EKBoundingBoxOfSprite( SKSpriteNode* sprite );
