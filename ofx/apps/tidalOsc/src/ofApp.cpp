#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	osc.setup(PORT);
}

//--------------------------------------------------------------
void ofApp::update() {
	while (osc.hasWaitingMessages()) {
		ofxOscMessage msg;

		// Get the next waiting message and copy to msg
		osc.getNextMessage(&msg);

		// Find the index of the 's' argument
		for (size_t i = 0; i < msg.getNumArgs(); i++)
		{
			string name = msg.getArgAsString(i);

			if (name == "s")
			{
				// Get the value of the argument at the following index
				string x = msg.getArgAsString(i + 1);

				// Log the output 
				ofLogNotice() << name << ": " << x;

				break;
			}

		}
	}
}

//--------------------------------------------------------------
void ofApp::draw() {

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key) {

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y) {

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y) {

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg) {

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo) {

}
