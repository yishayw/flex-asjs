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
package org.apache.flex.html.beads
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.apache.flex.core.BeadViewBase;
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.ILayoutParent;
	import org.apache.flex.core.IStrand;
    import org.apache.flex.core.IParent;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.html.Container;
	import org.apache.flex.html.supportClasses.Border;
	import org.apache.flex.html.supportClasses.ContainerContentArea;
	import org.apache.flex.html.supportClasses.ScrollBar;
    import org.apache.flex.html.beads.models.ScrollBarModel;
	
    /**
     *  The ContainerView class is the default view for
     *  the org.apache.flex.html.Container class.
     *  It lets you use some CSS styles to manage the border, background
     *  and padding around the content area.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
	public class ScrollingContainerView extends BeadViewBase implements IBeadView, ILayoutParent
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function ScrollingContainerView()
		{
		}
		
        /**
         *  The actual parent that parents the children.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */        
		protected var actualParent:DisplayObjectContainer;
				
        /**
         *  @copy org.apache.flex.core.IBead#strand
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			
			var padding:Object = determinePadding();
			
			if (contentAreaNeeded())
			{
				actualParent = new ContainerContentArea();
				DisplayObjectContainer(value).addChild(actualParent);
				Container(value).setActualParent(actualParent);
				actualParent.x = padding.paddingLeft;
				actualParent.y = padding.paddingTop;
			}
			else
			{
				actualParent = value as UIBase;
			}
			
			var backgroundColor:Object = ValuesManager.valuesImpl.getValue(value, "background-color");
			var backgroundImage:Object = ValuesManager.valuesImpl.getValue(value, "background-image");
			if (backgroundColor != null || backgroundImage != null)
			{
				if (value.getBeadByType(IBackgroundBead) == null)
					value.addBead(new (ValuesManager.valuesImpl.getValue(value, "iBackgroundBead")) as IBead);					
			}
			
			var borderStyle:String;
			var borderStyles:Object = ValuesManager.valuesImpl.getValue(value, "border");
			if (borderStyles is Array)
			{
				borderStyle = borderStyles[1];
			}
			if (borderStyle == null)
			{
				borderStyle = ValuesManager.valuesImpl.getValue(value, "border-style") as String;
			}
			if (borderStyle != null && borderStyle != "none")
			{
				if (value.getBeadByType(IBorderBead) == null)
					value.addBead(new (ValuesManager.valuesImpl.getValue(value, "iBorderBead")) as IBead);	
			}
		}
		
		/**
		 *  Determines the top and left padding values, if any, as set by
		 *  padding style values. This includes "padding" for all padding values
		 *  as well as "padding-left" and "padding-top".
		 * 
		 *  Returns an object with paddingLeft and paddingTop properties.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		protected function determinePadding():Object
		{
			var paddingLeft:Object;
			var paddingTop:Object;
			var padding:Object = ValuesManager.valuesImpl.getValue(_strand, "padding");
			if (padding is Array)
			{
				if (padding.length == 1)
					paddingLeft = paddingTop = padding[0];
				else if (padding.length <= 3)
				{
					paddingLeft = padding[1];
					paddingTop = padding[0];
				}
				else if (padding.length == 4)
				{
					paddingLeft = padding[3];
					paddingTop = padding[0];					
				}
			}
			else if (padding == null)
			{
				paddingLeft = ValuesManager.valuesImpl.getValue(_strand, "padding-left");
				paddingTop = ValuesManager.valuesImpl.getValue(_strand, "padding-top");
			}
			else
			{
				paddingLeft = paddingTop = padding;
			}
			var pl:Number = Number(paddingLeft);
			var pt:Number = Number(paddingTop);
			
			return {paddingLeft:pl, paddingTop:pt};
		}
		
		/**
		 *  Returns true if container to create a separate ContainerContentArea.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		protected function contentAreaNeeded():Boolean
		{
			var padding:Object = determinePadding();
			
			return (!isNaN(padding.paddingLeft) && padding.paddingLeft > 0 ||
				    !isNaN(padding.paddingTop) && padding.paddingTop > 0);
		}
		
        /**
         *  The parent of the children.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get contentView():DisplayObjectContainer
		{
			return actualParent;
		}
		
        /**
         *  The border.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get border():Border
		{
			return null;
		}
		
        /**
         *  The host component, which can resize to different slots.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get resizableView():DisplayObject
		{
			return _strand as DisplayObject;
		}
		
        private var _vScrollBar:ScrollBar;
        
        /**
         *  The vertical ScrollBar, if it exists.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get vScrollBar():ScrollBar
		{
            if (!_vScrollBar)
                _vScrollBar = createScrollBar();
            return _vScrollBar;
		}
		
        /**
         *  The horizontal ScrollBar, if it exists.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get hScrollBar():ScrollBar
		{
			return null;
		}

        /**
         * @private
         */
        private function createScrollBar():ScrollBar
        {
            var vsb:ScrollBar;
            vsb = new ScrollBar();
            var vsbm:ScrollBarModel = new ScrollBarModel();
            vsbm.maximum = 100;
            vsbm.minimum = 0;
            vsbm.pageSize = 10;
            vsbm.pageStepSize = 10;
            vsbm.snapInterval = 1;
            vsbm.stepSize = 1;
            vsbm.value = 0;
            vsb.model = vsbm;
            vsb.width = 16;
            IParent(_strand).addElement(vsb);
            return vsb;
        }

        /**
         *  The position of the vertical scrollbar
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get verticalScrollPosition():Number
        {
            return ScrollBarModel(vScrollBar.model).value;
        }
        
        /**
         *  @private
         */
        public function set verticalScrollPosition(value:Number):void
        {
            ScrollBarModel(vScrollBar.model).value = value;
        }

        /**
         *  The maximum position of the vertical scrollbar
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get maxVerticalScrollPosition():Number
        {
            return ScrollBarModel(vScrollBar.model).maximum - 
                ScrollBarModel(vScrollBar.model).pageSize;
        }
        
    
    }
}