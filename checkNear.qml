//==============================================
//  show notes constituing a 7, 7dim, or 9 chord
//
//  Copyright (C)2015 Jörn Eichler (heuchi)
//  modified by sitting bugle
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.0
import QtQuick.Dialogs 1.1
import MuseScore 3.0

MuseScore {
      menuPath: "Plugins.Proof Reading.Show neighboring notes played together"
      description: "Check for 7, 7dim, 9 chords"
      version: "0.2"
      requiresScore: true

      property var colorNear: "#a06500";
      //property var colorOctave: "#ff0050";
      property var colorHidden: "#a03500";

      property bool processAll: false;
      property bool errorChords: false;

      id: checkNear

      Component.onCompleted : {
            if (mscoreMajorVersion >= 4) {
                  checkNear.title = "showing neighboring notes played together  ";
                  checkNear.categoryCode = "composing-arranging-tools"
            }
      }

      MessageDialog {
            id: msgResult
            title: "Result"
            text: "Not yet set"
            
            onAccepted: {
                  quit();
            }

            visible: false;
      }


      function markColor(note1, note2, color) {
            note1.color = color;
            note2.color = color;
      }


      onRun: {
            console.log("start")
            if (typeof curScore == 'undefined' || curScore == null) {
                  console.log("no score found");
                  quit();
            }

            curScore.startCmd();

            // find selection
            var startStaff;
            var endStaff;
            var endTick;

            var cursor = curScore.newCursor();
            cursor.rewind(1);
            if (!cursor.segment) {
                  // no selection
                  console.log("no selection: processing whole score");
                  processAll = true;
                  startStaff = 0;
                  endStaff = curScore.nstaves;
            } else {
                  startStaff = cursor.staffIdx;
                  cursor.rewind(2);
                  endStaff = cursor.staffIdx+1;
                  endTick = cursor.tick;
                  if(endTick == 0) {
                        // selection includes end of score
                        // calculate tick from last score segment
                        endTick = curScore.lastSegment.tick + 1;
                  }
                  cursor.rewind(1);
                  console.log("Selection is: Staves("+startStaff+"-"+endStaff+") Ticks("+cursor.tick+"-"+endTick+")");
            }

            // initialize data structure

            var changed = [];
            var curNote = [];
            var prevNote = [];
            var curRest = [];
            var prevRest = [];
            var curTick = [];
            var prevTick = [];

            var foundNear = 0;

            var track;

            var startTrack = startStaff * 4;
            var endTrack = endStaff * 4;

            for (track = startTrack; track < endTrack; track++) {
                  curRest[track] = true;
                  prevRest[track] = true;
                  changed[track] = false;
                  curNote[track] = 0;
                  prevNote[track] = 0;
                  curTick[track] = 0;
                  prevTick[track] = 0;
            }

            // go through all staves/voices simultaneously

            if(processAll) {
                  cursor.track = 0;
                  cursor.rewind(0);
            } else {
                  cursor.rewind(1);
            }

            var segment = cursor.segment;

            while (segment && (processAll || segment.tick < endTick)) {
                  var foundOne = 0 ;
		  var numSeg = 0 ;
                  //console.log("segment " + numSeg);

                  // Pass 1: read notes
                  for (track = startTrack; track < endTrack; track++) {
                                    curRest[track]=false;

                        if (segment.elementAt(track)) {
                              if (segment.elementAt(track).type == Element.CHORD) {
                                    // we ignore grace notes for now
                                    var notes = segment.elementAt(track).notes;

                                    if (notes.length > 1) {
                                          console.log("found chord with more than one note!");
                                          errorChords = true;
                                    }

// CHANGER CODE POUR CHERCHER LES NOTES D'UN ACCORD
                                    var note = notes[notes.length-1];

                                    prevTick[track]=curTick[track];
                                    prevRest[track]=curRest[track];
                                    prevNote[track]=curNote[track];
                                    curRest[track]=false;
                                    curNote[track]=note;
                                    curTick[track]=segment.tick;
                                    changed[track]=true;
                              } else if (segment.elementAt(track).type == Element.REST) {
                                    if (!curRest[track]) {
                                          // was note
                                          prevRest[track]=curRest[track];
                                          prevNote[track]=curNote[track];
                                          curRest[track]=true;
                                          changed[track]=false; // no need to check against a rest
                                    }
                              } else {
                                    changed[track] = false;
                              }
                        } else {
                              changed[track] = false;
                        }
                  }
                  // Pass 2: find paralleles
                  for (track=startTrack; track < endTrack; track++) {
                        var i;
                        // compare to other tracks
 console.log("real track " + track);
                        if (changed[track] && (!prevRest[track])) {
                              for (i=track; i < endTrack; i++) {
 console.log("track " + i);
                                    if (changed[i] && (!prevRest[i])) {
                                                var cint = curNote[track].pitch - curNote[i].pitch;
                                                var pint = prevNote[track].pitch-prevNote[i].pitch;
                                                var diff = Math.abs(cint) %12  ;
 console.log("curnote " + (curNote[track].pitch-18) + " " + (curNote[i].pitch-18) + "diff: " + diff);

            
                                                if (diff == 1 || diff == 2 || diff== 11 || diff == 10 ) {
                                                       markColor(curNote[track],curNote[i],colorNear);
                                                             foundNear++;
                                                             foundOne++ ;
                                                }

                                    }
                              }
                        }
                  }
                  numSeg++ ;
                  segment = segment.next;
            }

            // set result dialog

            if (foundNear == 0) {
                  msgResult.text = "No neighboring note found!\n";
            } else if (foundNear == 1) {
                  msgResult.text = "One neghbboring note found!\n";
            } else {
                  msgResult.text = foundNear + " neighboring notes found!\n";
            }

            if (errorChords) {
                  msgResult.text = msgResult.text +
                  "\nError: Found Chords!\nOnly the top note of each voice is used in this plugin!\n";
            }

            curScore.endCmd();

            console.log("finished");
            msgResult.visible = true;
            //quit() // dialog will call quit()
      }
}
