//
//  ekutils.c
//  EKVN SpriteKit
//
//  Created by James on 9/17/14.
//  Copyright (c) 2014 James Briones. All rights reserved.
//

#include "ekutils.h"

// Set screen/view dimensions; use default sizes for iPhone 4S
CGFloat EKScreenWidthInPoints   = 480.0;
CGFloat EKScreenHeightInPoints  = 320.0;

#pragma mark - Screen dimensions

void EKSetScreenSizeInPoints( CGFloat width, CGFloat height )
{
    EKScreenWidthInPoints = fabs( width );
    EKScreenHeightInPoints = fabs( height );
    
    //NSLog(@"Screen size in points has been set to: %f, %f", EKScreenWidthInPoints, EKScreenHeightInPoints);
}

CGSize EKScreenSizeInPoints()
{
    return CGSizeMake( EKScreenWidthInPoints, EKScreenHeightInPoints );
}

void EKSetScreenDataFromView( SKView* view )
{
    CGSize viewSizeInPoints = view.frame.size;
    
    EKSetScreenSizeInPoints( viewSizeInPoints.width, viewSizeInPoints.height );
}

#pragma mark - Positions

CGPoint EKPositionWithNormalizedCoordinates( CGFloat normalizedX, CGFloat normalizedY )
{
    return CGPointMake( EKScreenWidthInPoints * normalizedX, EKScreenHeightInPoints * normalizedY );
}

CGPoint EKPositionAddTwoPositions( CGPoint first, CGPoint second )
{
    CGFloat x = first.x + second.x;
    CGFloat y = first.y + second.y;
    
    return CGPointMake( x, y );
}

CGPoint EKPositionOfBottomLeftCornerOfParentNode( SKNode* parentNode )
{
    if( !parentNode )
        return CGPointZero;
    
    CGFloat widthOfParent = parentNode.frame.size.width;
    CGFloat heightOfParent = parentNode.frame.size.height;
    
    CGFloat xPos = (widthOfParent * (-0.5));
    CGFloat yPos = (heightOfParent * (-0.5));
    
    return CGPointMake(xPos, yPos);
}

#pragma mark - Math

CGFloat EKMathDistanceBetweenPoints( CGPoint first, CGPoint second )
{
    CGPoint subtractedValue     = CGPointMake( first.x - second.x, first.y - second.y );
    CGPoint p1                  = subtractedValue;
    CGPoint p2                  = subtractedValue;
    CGFloat lengthSquared       = ( p1.x * p2.x + p1.y * p2.y );
    CGFloat length              = sqrt( lengthSquared );
    
    return length;
}

#pragma mark - Collision

CGRect EKBoundingBoxOfSprite( SKSpriteNode* sprite )
{
    if( !sprite )
        return CGRectZero;
    
    CGFloat rectX = sprite.position.x - (sprite.size.width * sprite.anchorPoint.x);
    CGFloat rectY = sprite.position.y - (sprite.size.height * sprite.anchorPoint.y);
    CGFloat width = sprite.size.width;
    CGFloat height = sprite.size.height;
    
    return CGRectMake(rectX, rectY, width, height);
}

BOOL EKCollisionBetweenSpriteCircles( SKSpriteNode* first, SKSpriteNode* second )
{
    if( first && second ) {
        
        // Returns "averaged out" values for distance: (width + height) / 2
        CGFloat radiusOfFirst   = ((first.size.width*0.5) + (first.size.height*0.5)) * 0.5;
        CGFloat radiusOfSecond  = ((second.size.width*0.5) + (second.size.height*0.5)) * 0.5;
        
        CGFloat distanceBetweenTwo = EKMathDistanceBetweenPoints( first.position, second.position );
        
        if( distanceBetweenTwo <= (radiusOfFirst + radiusOfSecond) )
            return YES;
    }
    
    return NO;
}

BOOL EKCollisionBetweenSpriteBoundingBoxes( SKSpriteNode* first, SKSpriteNode* second )
{
    if( first && second ) {
        
        CGPoint firstPos    = first.position;
        CGFloat firstWidth  = first.size.width;
        CGFloat firstHeight = first.size.height;
        CGFloat firstX      = firstPos.x - (firstWidth * first.anchorPoint.x);
        CGFloat firstY      = firstPos.y - (firstHeight * first.anchorPoint.y);
        CGRect firstBox     = CGRectMake(firstX , firstY, firstWidth, firstHeight);
        
        CGPoint secondPos       = second.position;
        CGFloat secondWidth     = second.size.width;
        CGFloat secondHeight    = second.size.height;
        CGFloat secondX         = secondPos.x - (secondWidth * second.anchorPoint.x);
        CGFloat secondY         = secondPos.y - (secondHeight * second.anchorPoint.y);
        CGRect secondBox        = CGRectMake(secondX, secondY, secondWidth, secondHeight);
        
        return CGRectIntersectsRect( firstBox, secondBox );
    }
    
    return NO;
}

#pragma mark - Color

UIColor* EKColorFromUnsignedCharRGB( unsigned char r, unsigned char g, unsigned char b )
{
    return EKColorFromUnsignedCharRGBA(r, g, b, 255);
}

UIColor* EKColorFromUnsignedCharRGBA( unsigned char r, unsigned char g, unsigned char b, unsigned char a )
{
    float fR = (float) r;
    float fG = (float) g;
    float fB = (float) b;
    float fA = (float) a;
    
    // Convert to normalized values (0.0 to 1.0)
    fR = fR / 255.0;
    fG = fG / 255.0;
    fB = fB / 255.0;
    fA = fA / 255.0;
    
    return [UIColor colorWithRed:fR green:fG blue:fB alpha:fA];
}


