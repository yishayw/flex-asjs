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
package org.apache.flex.html.staticControls.supportClasses
{
    import flash.text.TextFieldType;
    
    import org.apache.flex.core.CSSTextField;
    import org.apache.flex.core.IBead;
    import org.apache.flex.core.IBeadController;
    import org.apache.flex.core.IStrand;
    import org.apache.flex.core.IUIBase;
    import org.apache.flex.core.UIBase;
    import org.apache.flex.core.ValuesManager;
    import org.apache.flex.events.Event;
    import org.apache.flex.html.staticControls.beads.ITextItemRenderer;
	
	public class TextFieldItemRenderer extends CSSTextField implements ITextItemRenderer, IStrand, IUIBase
	{
		public function TextFieldItemRenderer()
		{
			super();
            type = TextFieldType.DYNAMIC;
            selectable = false;
		}
        
        public var highlightColor:uint = 0xCEDBEF;
        public var selectedColor:uint = 0xA8C6EE;
        public var downColor:uint = 0x808080;

        private var _width:Number;
        override public function get width():Number
        {
            if (isNaN(_width))
            {
                var value:* = ValuesManager.valuesImpl.getValue(this, "width");
                if (value === undefined)
                    return $width;
                _width = Number(value);
                super.width = value;
            }
            return _width;
        }
        override public function set width(value:Number):void
        {
            if (_width != value)
            {
                _width = value;
                super.width = value;
                dispatchEvent(new Event("widthChanged"));
            }
        }
        protected function get $width():Number
        {
            return super.width;
        }
        
        private var _height:Number;
        override public function get height():Number
        {
            if (isNaN(_height))
            {
                var value:* = ValuesManager.valuesImpl.getValue(this, "height");
                if (value === undefined)
                    return $height;
                _height = Number(value);
                super.height = value;
            }
            return _height;
        }
        override public function set height(value:Number):void
        {
            if (_height != value)
            {
                _height = value;
                super.height = value;
                dispatchEvent(new Event("heightChanged"));
            }
        }
        protected function get $height():Number
        {
            return super.height;
        }

        public function get data():Object
        {
            return text;
        }
        public function set data(value:Object):void
        {
            text = String(value);
        }
        
        private var _index:int;
        
        public function get index():int
        {
            return _index;
        }
        public function set index(value:int):void
        {
            _index = value;
        }
        
        private var _hovered:Boolean;
        
        public function get hovered():Boolean
        {
            return _hovered;
        }
        public function set hovered(value:Boolean):void
        {
            _hovered = value;
            updateRenderer();
        }
        
        private var _selected:Boolean;
        
        public function get selected():Boolean
        {
            return _selected;
        }
        public function set selected(value:Boolean):void
        {
            _selected = value;
            updateRenderer();
        }

        private var _down:Boolean;
        
        public function get down():Boolean
        {
            return _down;
        }
        public function set down(value:Boolean):void
        {
            _down = value;
            updateRenderer();
        }
        
        public function updateRenderer():void
        {
            background = (down || selected || hovered);
            if (down)
                backgroundColor = downColor;
            else if (hovered)
                backgroundColor = highlightColor;
            else if (selected)
                backgroundColor = selectedColor;
        }
        
        public function get element():Object
        {
            return this;
        }

        // beads declared in MXML are added to the strand.
        // from AS, just call addBead()
        public var beads:Array;
        
        private var _beads:Vector.<IBead>;
        public function addBead(bead:IBead):void
        {
            if (!_beads)
                _beads = new Vector.<IBead>;
            _beads.push(bead);
            bead.strand = this;
        }
        
        public function getBeadByType(classOrInterface:Class):IBead
        {
            for each (var bead:IBead in _beads)
            {
                if (bead is classOrInterface)
                    return bead;
            }
            return null;
        }
        
        public function removeBead(value:IBead):IBead	
        {
            var n:int = _beads.length;
            for (var i:int = 0; i < n; i++)
            {
                var bead:IBead = _beads[i];
                if (bead == value)
                {
                    _beads.splice(i, 1);
                    return bead;
                }
            }
            return null;
        }
        
        public function addedToParent():void
        {
            var c:Class;

            // renderer has a default model (the 'data' property)
            // and it is essentially a view of that model, so it
            // only needs an assignable controller
            
            if (getBeadByType(IBeadController) == null) 
            {
                c = ValuesManager.valuesImpl.getValue(this, "iBeadController") as Class;
                if (c)
                {
                    var controller:IBeadController = new c as IBeadController;
                    if (controller)
                        addBead(controller);
                }
            }
        }
    }
}