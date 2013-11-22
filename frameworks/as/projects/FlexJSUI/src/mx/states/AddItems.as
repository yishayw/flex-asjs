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

// shim the mx classes for states.  Be careful about updates to the main SDK's
// version as that will move the timestamp ahead of this one and then it will
// take precedence over this one at link time.
package mx.states
{
    import org.apache.flex.core.IDocument;
    
	public class AddItems implements IDocument
	{
		public function AddItems()
		{
			super();
		}
		
        public var items:Array;
        
		public var itemsDescriptor:Array;     

        public var destination:String;
        
        public var propertyName:String;
        
        public var position:String;
        
        public var relativeTo:String;
        
        public var document:Object;
        
        public function setDocument(document:Object, id:String = null):void
        {
            this.document = document;
        }
        
        /**
         * @private 
         * Initialize this object from a descriptor.
         */
        public function initializeFromObject(properties:Object):Object
        {
            for (var p:String in properties)
            {
                this[p] = properties[p];
            }
            
            return Object(this);
        }
	}
}