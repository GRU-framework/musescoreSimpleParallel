//==============================================
//  show notes constituing a 7, 7dim, or 9 chord
//
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
//
//  ALGO: à chaque moment on compare les notes qui sont alignées sur le même temps
//  on classe les notes isolées et les notes d'accord (deux groupes distincts)
//  en remontant le tableau des notes isolées on compare chaque note isolée avec les autres (celles qui n'ont pas servide pivot de comparaisons)
//  la comparaison se fait aussi avec les notes des accords (qui ne seront pas des pivots : des notes proches dans un accord ne comptent pas)
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

	function compareNotes(note1, note2) {
              var cint = note1.pitch - note2.pitch;
             var diff = Math.abs(cint) %12  ;
             if (diff == 1 || diff == 2 || diff== 11 || diff == 10 ) {
                      markColor(note1,note2,colorNear);
                      return true ;
             } else {
                    return false ;
             }
        }


      onRun: {
            console.log("start")
            if (typeof curScore == 'undefined' || curScore == null) {
                  console.log("no score found");
                  Qt.quit();
            }

            curScore.startCmd();

            // find selection
            var startStaff;
            var endStaff;
            var endTick;
            var processAll ;

            var cursor = curScore.newCursor();
            cursor.rewind(1);
            if (!cursor.segment) {
                  // no selection
                  console.log("no selection: processing whole score");
                  processAll = true;
                  startStaff = 0;
                  endStaff = curScore.nstaves;
            } 

            // initialize data structure
            var foundNear = 0;

            var track;

            var startTrack = startStaff ;
            var endTrack = endStaff * 4;


            // go through all staves/voices simultaneously

            if(processAll) {
                  cursor.track = 0;
                  cursor.rewind(0);
            }

            var segment = cursor.segment;

            while (segment ) {
                  var foundOne = 0 ;
		  var numSeg = 0 ;
                  //console.log("segment " + numSeg);
	    	var singleNotesOnSameSegment = [] ;
	   	 var chordsOnSameSegment = [] ;

                  // Pass 1: read notes
                  for (track = startTrack; track < endTrack; track++) {

                        if (segment.elementAt(track)) {
                              if (segment.elementAt(track).type == Element.CHORD) {
                                    // we ignore grace notes for now
                                    var notes = segment.elementAt(track).notes;

                                    if (notes.length > 1) {
					// add chord to chordsArray
                                        chordsOnSameSegment.push(notes) ;
                                         
                                    } else {
					// add note ot singleNotes
                                    	var note = notes[notes.length-1];
			                singleNotesOnSameSegment.push(note) ;
				    }

// CHANGER CODE POUR CHERCHER LES NOTES D'UN ACCORD

                              } else if (segment.elementAt(track).type == Element.REST) {
					console.log("rest") ;
                              } else {
                                    console.log ("something " + segment.elementAt(track)) ;
                              }
                        } else {
					console.log ("nothing") ;
                        }
                  }
                 // NOW compare
                  var singleNotesNumber = singleNotesOnSameSegment.length ;
		 for(var ix= 0 ; ix < singleNotesNumber ; ix++ ) {
                      var curNote = singleNotesOnSameSegment[ix] ;
                      for (var iy = ix+1 ; iy < singleNotesNumber ; iy++) {
			if (compareNotes(curNote, singleNotesOnSameSegment[iy] )) {
                           if(foundOne == 0 ) {
				foundNear ++ ;
                           }
			   foundOne ++ ;
                        }
                       }// single notes comparison
                      // compare notes in chors
                       for (var iz = 0 ; iz < chordsOnSameSegment[iz] ; iz ++) {
                          var chord = chordOnSameSegment[iz] ;
                           for (var idx = 0 ; ix < chord.length ;idx++) {
				if (compareNotes(curNote, chord[idx] )) {
                           		if(foundOne == 0 ) {
						foundNear ++ ;
                           		}
			   		foundOne ++ ;
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
            } else {
                  msgResult.text = foundNear + " neighboring notes found!\n";
            }


            curScore.endCmd();

            console.log("finished");
            msgResult.visible = true;
            //quit() // dialog will call quit()
      }
}
