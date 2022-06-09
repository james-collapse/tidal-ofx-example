#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	ofSetFrameRate(60);
	ofSetVerticalSync(true);
	fbo.allocate(ofGetWidth(), ofGetHeight());
	c = ofColor::red;
	receiver.setup(PORT);
	ofLog() << "Listening for OSC messages on port " << PORT;
}

//--------------------------------------------------------------
void ofApp::update(){
	while (receiver.hasWaitingMessages())
	{
		ofxOscMessage m;
		receiver.getNextMessage(m);
		handleOscMessage(m);

		string mode = getTidalParameter("mode");
		float v = ofMap(stof(mode), 0.0, 1.0, 128, 255);
		c.setHue(v);
	}

}

//--------------------------------------------------------------
void ofApp::handleOscMessage(ofxOscMessage m) {
	if (m.getAddress() == "/oscplay")
	{
		for (int i = 0; i < m.getNumArgs(); i++)
		{
			if (i % 2 == 1)
			{
				string key = m.getArgAsString(i - 1);
				string value = "";

				if (m.getArgType(i) == OFXOSC_TYPE_INT32) {
					value = ofToString(m.getArgAsInt(i));
				}
				else if (m.getArgType(i) == OFXOSC_TYPE_FLOAT) {
					value = ofToString(m.getArgAsFloat(i));
				}
				else if (m.getArgType(i) == OFXOSC_TYPE_STRING) {
					value = m.getArgAsString(i);
				}
				else {
					ofLog() << "Unhandled argument type: " + m.getArgTypeName(i);
					throw;
				}

				// Add to map
				tidalParameters.insert_or_assign(key, value);
			}
		}
	}
	else
	{
		ofLog() << "Unrecognised source address: " + m.getAddress();
		throw;
	}
}

//--------------------------------------------------------------
void ofApp::draw(){
	fbo.begin();

	ofSetColor(255);
	ofBackgroundGradient(ofColor(255), ofColor(128));	
	float tx = ofGetWidth() / 2;
	float ty = ofGetHeight() / 2;
	float r = ofGetWidth() / 4;

	ofPushMatrix();
	
	ofTranslate(tx, ty);
	ofSetColor(c);
	ofFill();
	ofDrawCircle(0, 0, r);
	
	ofPopMatrix();

	fbo.end();

	fbo.draw(0, 0);
}

string ofApp::getTidalParameter(string key) {
	map<string, string>::iterator it = tidalParameters.find(key);

	if (it != tidalParameters.end())
	{
		return it->second;
	}
	else
	{
		ofLog() << "Unable to find parameter with key: " + key;
		throw;
	}
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
