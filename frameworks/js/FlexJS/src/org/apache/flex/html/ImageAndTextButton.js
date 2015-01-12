/**
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org.apache.flex.html.ImageAndTextButton');

goog.require('org.apache.flex.html.Button');



/**
 * @constructor
 * @extends {org.apache.flex.html.Button}
 */
org.apache.flex.html.ImageAndTextButton = function() {
  org.apache.flex.html.ImageAndTextButton.base(this, 'constructor');

  this._text = '';
  this._src = '';
};
goog.inherits(org.apache.flex.html.ImageAndTextButton,
    org.apache.flex.html.Button);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.ImageAndTextButton.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'ImageAndTextButton',
                qName: 'org.apache.flex.html.ImageAndTextButton'}] };


/**
 * @override
 */
org.apache.flex.html.ImageAndTextButton.prototype.createElement =
    function() {
  this.element = document.createElement('button');
  this.element.setAttribute('type', 'button');

  this.positioner = this.element;
  this.element.flexjs_wrapper = this;

  if (org.apache.flex.core.ValuesManager.valuesImpl.getValue) {
    var impl = org.apache.flex.core.ValuesManager.valuesImpl.
        getValue(this, 'iStatesImpl');
  }

  return this.element;
};


/**
 * @expose
 * @return {string} The text getter.
 */
org.apache.flex.html.ImageAndTextButton.prototype.get_text = function() {
  return this._text;
};


/**
 * @expose
 * @param {string} value The text setter.
 */
org.apache.flex.html.ImageAndTextButton.prototype.set_text =
    function(value) {
  this._text = value;
  this.setInnerHTML();
};


/**
 * @expose
 * @return {string} The image url.
 */
org.apache.flex.html.ImageAndTextButton.prototype.get_image = function() {
  return this._src;
};


/**
 * @expose
 * @param {string} value The image url.
 */
org.apache.flex.html.ImageAndTextButton.prototype.set_image =
    function(value) {
  this._src = value;
  this.setInnerHTML();
};


/**
 */
org.apache.flex.html.ImageAndTextButton.prototype.setInnerHTML = function() {
  var inner = '';
  if (this._src != null)
    inner += '<img src=\'' + this._src + '\'/>';
  inner += '&nbsp;';
  inner += this._text;
  this.element.innerHTML = inner;
};
