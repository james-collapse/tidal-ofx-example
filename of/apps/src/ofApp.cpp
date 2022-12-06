#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	ofSetFrameRate(60);
	ofSetVerticalSync(true);
	fbo.allocate(ofGetWidth(), ofGetHeight());
	c = ofColor::red;
	receiver.setup(PORT);
	ofLog() << "Listening for OSC messages on port " << PORT;
	// Initialise counter
	frame = 0;
	// Initialise Tidal variable
	tidal = 0;
}

//--------------------------------------------------------------
void ofApp::update(){
	while (receiver.hasWaitingMessages())
	{
		ofxOscMessage m;
		receiver.getNextMessage(m);

		// Get first message argument
		float v = m.getArgAsFloat(0);

		ofLog() << "Value received from Tidal: " << v;

		// Set Tidal variable
		tidal = v;

		// Reset counter
		frame = 0;
	}
}

//--------------------------------------------------------------
void ofApp::draw(){
	// Create a buffer to draw into
	fbo.begin();
	// Clear background
	ofSetColor(255);
	// Set gradient background
	ofBackgroundGradient(ofColor(255), ofColor(128));

	// Change fill colour
	float f = expImpulse(frame, 0.1);
	c.setBrightness(200 * f * tidal);

	// Draw circle
	float tx = ofGetWidth() / 2;
	float ty = ofGetHeight() / 2;
	float r = ofGetWidth() / 4;

	ofPushMatrix();
	
	ofTranslate(tx, ty);

	ofSetColor(c);
	ofFill();
	ofSetCircleResolution(100);
	ofDrawCircle(0, 0, r);

	ofPopMatrix();

	fbo.end();

	// Draw buffer contents to screen
	fbo.draw(0, 0);

	// Increment counter
	frame += 1;
}

//--------------------------------------------------------------
float ofApp::expImpulse(float x, float k) {
	// Impulse function (maximum at x = 1/k)
	float h = k * x;
	return h * exp(1.0 - h);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
