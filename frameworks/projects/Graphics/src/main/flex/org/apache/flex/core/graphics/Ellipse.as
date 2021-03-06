////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.core.graphics
{
    COMPILE::SWF
    {
        import flash.geom.Point;
        import flash.geom.Rectangle;            
    }
    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;
    }

	public class Ellipse extends GraphicShape
	{
		
		COMPILE::JS
		private var _ellipse:WrappedHTMLElement;
		
		/**
		 *  Draw the ellipse.
		 *  @param xp The x position of the top-left corner of the bounding box of the ellipse.
		 *  @param yp The y position of the top-left corner of the bounding box of the ellipse.
		 *  @param width The width of the ellipse.
		 *  @param height The height of the ellipse.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         *  @flexjsignorecoercion SVGEllipseElement
		 */
		public function drawEllipse(xp:Number, yp:Number, width:Number, height:Number):void
		{
            COMPILE::SWF
            {
                graphics.clear();
                applyStroke();
                beginFill(new Rectangle(xp, yp, width, height), new Point(xp,yp));
                graphics.drawEllipse(xp,yp,width,height);
                endFill();                    
            }
            COMPILE::JS
            {
                var style:String = getStyleStr();
				if (_ellipse == null) {
					_ellipse = document.createElementNS('http://www.w3.org/2000/svg', 'ellipse') as WrappedHTMLElement;
					_ellipse.flexjs_wrapper = this;
					element.appendChild(_ellipse);
				}
				_ellipse.setAttribute('style', style);
                if (stroke)
                {
					_ellipse.setAttribute('cx', String(width / 2 + stroke.weight));
					_ellipse.setAttribute('cy', String(height / 2 + stroke.weight));
                }
                else
                {
					_ellipse.setAttribute('cx', String(width / 2));
					_ellipse.setAttribute('cy', String(height / 2));
                }
				_ellipse.setAttribute('rx', String(width / 2));
				_ellipse.setAttribute('ry', String(height / 2));
                
                resize(x, y, (_ellipse as SVGEllipseElement).getBBox());

            }
		}
		
		override protected function draw():void
		{
			drawEllipse(0, 0, width, height);	
		}
		
	}
}
