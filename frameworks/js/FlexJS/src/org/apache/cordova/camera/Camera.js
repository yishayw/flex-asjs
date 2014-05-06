/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 FalconJX will inject html into the index.html file.  Surround with
 "inject_html" tag as follows:

 <inject_html>
    <script type="text/javascript" src="cordova.js"></script>
 </inject_html>
 */

/**
 * org.apache.cordova.camera.Camera
 *
 * @fileoverview
 *
 * @suppress {checkTypes}
 */

goog.provide('org.apache.cordova.camera.Camera');



/**
 * @constructor
 */
org.apache.cordova.camera.Camera = function() {
  this.pictureSourceType = org.apache.cordova.camera.Camera.PictureSourceType.PHOTOLIBRARY;
  this.destinationType = org.apache.cordova.camera.Camera.DestinationType.DATA_URL;
  this.mediaType = org.apache.cordova.camera.Camera.MediaType.PICTURE;
  this.encodingType = org.apache.cordova.camera.Camera.EncodingType.JPEG;
  this.direction = org.apache.cordova.camera.Camera.Direction.BACK;
};


/**
 * @type {Object}
 */
org.apache.cordova.camera.Camera.DestinationType = {DATA_URL: 0, FILE_URI: 1, NATIVE_URI: 2};


/**
 * @type {Object}
 */
org.apache.cordova.camera.Camera.PictureSourceType = {PHOTOLIBRARY: 0, CAMERA: 1, SAVEDPHOTOALBUM: 2};


/**
 * @type {Object}
 */
org.apache.cordova.camera.Camera.EncodingType = {JPEG: 0, PNG: 1};


/**
 * @type {Object}
 */
org.apache.cordova.camera.Camera.MediaType = {PICTURE: 0, VIDEO: 1, ALLMEDIA: 2};


/**
 * @type {Object}
 */
org.apache.cordova.camera.Camera.Direction = {BACK: 0, FRONT: 1};


/**
 * @type {number}
 */
//org.apache.cordova.camera.Camera.prototype.pictureSourceType;


/**
 * @type {number}
 */
//org.apache.cordova.camera.Camera.prototype.destinationType;


/**
 * @type {number}
 */
//org.apache.cordova.camera.Camera.prototype.mediaType;


/**
 * @type {number}
 */
//org.apache.cordova.camera.Camera.prototype.encodingType;


/**
 * @type {number}
 */
//org.apache.cordova.camera.Camera.prototype.direction;


/**
 * @expose
 * @param {Function} cameraSuccess
 * @param {Function} cameraError
 * @param {Object} cameraOptions
 */
org.apache.cordova.camera.Camera.prototype.getPicture = function(cameraSuccess, cameraError, cameraOptions) {
  navigator.camera.getPicture(cameraSuccess, cameraError, cameraOptions);
};


/**
 * @expose
 * @param {Function} cameraSuccess
 * @param {Function} cameraError
 */
org.apache.cordova.camera.Camera.prototype.cleanup = function(cameraSuccess, cameraError) {
  navigator.camera.cleanup();
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.cordova.camera.Camera.prototype.FLEXJS_CLASS_INFO = {
  names: [{ name: 'Camera', qName: 'org.apache.cordova.camera.Camera'}]
};