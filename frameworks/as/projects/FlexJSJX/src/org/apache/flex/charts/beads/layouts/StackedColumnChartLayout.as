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
package org.apache.flex.charts.beads.layouts
{
	import org.apache.flex.charts.core.ICartesianChartLayout;
	import org.apache.flex.charts.core.IChart;
	import org.apache.flex.charts.core.IChartItemRenderer;
	import org.apache.flex.charts.core.IChartSeries;
	import org.apache.flex.charts.core.IHorizontalAxisBead;
	import org.apache.flex.charts.core.IVerticalAxisBead;
	import org.apache.flex.charts.supportClasses.ColumnSeries;
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.IContentView;
	import org.apache.flex.core.ILayoutParent;
	import org.apache.flex.core.ISelectionModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	
	/**
	 *  The StackedColumnChartLayout class calculates the size and position of all of the itemRenderers for
	 *  all of the series in a StackedColumnChart. 
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class StackedColumnChartLayout implements IBeadLayout, ICartesianChartLayout
	{
		/**
		 *  constructor
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function StackedColumnChartLayout()
		{
		}
		
		private var _strand:IStrand;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
			IEventDispatcher(value).addEventListener("widthChanged", changeHandler);
			IEventDispatcher(value).addEventListener("childrenAdded", changeHandler);
			IEventDispatcher(value).addEventListener("itemsCreated", changeHandler);
			IEventDispatcher(value).addEventListener("layoutNeeded", changeHandler);
		}
		
		private var _gap:Number = 20;
		
		/**
		 *  The amount of space to leave between series. If a chart has several series,
		 *  the bars for an X value are side by side with a gap between the groups of
		 *  bars.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get gap():Number
		{
			return _gap;
		}
		public function set gap(value:Number):void
		{
			_gap = value;
		}
		
		/**
		 * @private
		 */
		private function changeHandler(event:Event):void
		{
			var layoutParent:ILayoutParent = _strand.getBeadByType(ILayoutParent) as ILayoutParent;
			var contentView:IContentView = layoutParent.contentView as IContentView;
			
			var selectionModel:ISelectionModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			var dp:Array = selectionModel.dataProvider as Array;
			if (!dp)
				return;
			
			var series:Array = IChart(_strand).series;
			var n:int = dp.length;
			trace("There are "+series.length+" series in this chart");
			
			var xAxis:IHorizontalAxisBead;
			if (_strand.getBeadByType(IHorizontalAxisBead)) xAxis = _strand.getBeadByType(IHorizontalAxisBead) as IHorizontalAxisBead;
			var xAxisOffset:Number = xAxis == null ? 0 : xAxis.axisHeight;
			var yAxis:IVerticalAxisBead;
			if (_strand.getBeadByType(IVerticalAxisBead)) yAxis = _strand.getBeadByType(IVerticalAxisBead) as IVerticalAxisBead;
			var yAxisOffset:Number = yAxis == null ? 0 : yAxis.axisWidth;
			
			var xpos:Number = yAxisOffset;
			var ypos:Number = 0;
			var useWidth:Number = UIBase(_strand).width-yAxisOffset;
			var useHeight:Number = UIBase(_strand).height - xAxisOffset;
			var itemWidth:Number = (useWidth - gap*(dp.length-1))/dp.length;
			
			var maxYValue:Number = 0;
			
			var barValues:Array = [];
			var maxValue:Number = 0;
			var scaleFactor:Number = 1;
			
			for (var i:int=0; i < n; i++)
			{
				barValues.push({totalValue:0, scaleFactor:0});
				var data:Object = dp[i];
				
				for (var s:int = 0; s < series.length; s++)
				{
					var bcs:ColumnSeries = series[s] as ColumnSeries;
					var field:String = bcs.yField;
					
					var yValue:Number = Number(data[field]);
					barValues[i].totalValue += yValue;
				}
				
				maxValue = Math.max(maxValue, barValues[i].totalValue);
			}
			
			scaleFactor = useHeight/maxValue;
			
			for (i=0; i < n; i++)
			{
				data = dp[i];
				ypos = useHeight;
				
				for (s=0; s < series.length; s++)
				{
					bcs = series[s] as ColumnSeries;

					var child:IChartItemRenderer = bcs.itemRenderer.newInstance() as IChartItemRenderer;
					child.itemRendererParent = contentView;
					child.data = data;
					child.fillColor = bcs.fillColor;
					yValue = Number(data[bcs.yField]);
					
					child.x = xpos;
					child.width = itemWidth;
					child.y = ypos - yValue*scaleFactor;
					child.height = yValue*scaleFactor;
					
					ypos = child.y;
					
					contentView.addElement(child);
				}
				
				xpos += gap + itemWidth;
			}
			
			IEventDispatcher(_strand).dispatchEvent(new Event("layoutComplete"));
		}
	}
}