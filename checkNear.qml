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
//  il ne faut opérer que sur des segment qui décrive des notes et des silences
//==============================================

import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
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


       function lmt(durationElement, numTicks) {
		this.elem = durationElement ;
                this.numTicks = numTicks ;
               //durationElement.globalDuration.ticks ;
       }

      onRun: {
            console.log("start")
            if (typeof curScore == 'undefined' || curScore == null) {
                  console.log("no score found");
                  Qt.quit();
            }
	    //============================

            curScore.startCmd();

            // find selection
            var startStaff;
            var endStaff;
            var endTick;
            var processAll ;

            var cursor = curScore.newCursor();
            //cursor.rewind(RewindMode.SELECTION_START);
            cursor.rewind(1);
            if (!cursor.segment) {
                  // no selection
                  console.log("no selection: processing whole score");
                  processAll = true;
                  startStaff = 0;
                  endStaff = curScore.nstaves;
            } else {
                  console.log(" selection: ");
                  processAll = false;
                  startStaff = cursor.staffIdx;
                  cursor.rewind(2);
                  //cursor.rewind(RewindMode.SELECTION_END);
                  endStaff = cursor.staffIdx ;
		  endTick = cursor.tick;
                  if(endTick == 0) {
                        // selection includes end of score
                        // calculate tick from last score segment
                        endTick = curScore.lastSegment.tick + 1;
                  }
	    }

            // initialize data structure
            var foundNear = 0;

            var track;

            var startTrack = startStaff ;
            var endTrack = endStaff * 4;



            if(processAll) {
                  cursor.track = 0;
                  cursor.rewind(0);
                  //cursor.rewind(RewindMode.SCORE_START);
            } else {
                  cursor.track = 0;
                  cursor.rewind(1);
                  //cursor.rewind(RewindMode.SELECTION_START);
	    }

            var segment = cursor.segment;

	  var tempSingleNotesOnSameSegment = [] ;
	   var tempChordsOnSameSegment = [] ;
            //while (segment ) {
	     while (segment && (processAll || segment.tick < endTick)) {
                  var foundOne = 0 ;
		  var numSeg = 0 ;
                  var currentTick = segment.tick ;
	    	var singleNotesOnSameSegment = tempSingleNotesOnSameSegment.slice()  ; // slice()
	   	 var chordsOnSameSegment = tempChordsOnSameSegment.slice() ;
                  //console.log("segment " + numSeg);

                  // Pass 1: read notes
                  for (track = startTrack; track < endTrack; track++) {

                        if (segment.elementAt(track)) {
                              if (segment.elementAt(track).type == Element.CHORD) {
                                    // we ignore grace notes for now
                                    var chord = segment.elementAt(track);
                                    var notes = chord.notes;
				    var tickz = chord.globalDuration.ticks 
console.log ("tickz " + currentTick  + " " + tickz) ;
        

                                    if (notes.length > 1) {
					// add chord to chordsArray
                                        chordsOnSameSegment.push(new lmt(notes, tickz)) ;
				        //console.log("chord " + notes + " " + notes.length ) ;
                                         
                                    } else {
					// add note ot singleNotes
                                    	var note = notes[notes.length-1];
			                singleNotesOnSameSegment.push(new lmt(note, tickz)) ;
				        //console.log("found " + note ) ;
				    }

// CHANGER CODE POUR CHERCHER LES NOTES D'UN ACCORD

                              } else if (segment.elementAt(track).type == Element.REST) {
					console.log("rest") ;
                               
                              } else if (segment.elementAt(track).type == Element.TUPLET) {
					console.log("tuple") ;

			      } else {
                                    //console.log ("something " + segment.elementAt(track)) ;
                              }
                        } else {
				//	console.log ("nothing") ;
                        }
                  }
                 // NOW compare
                  var singleNotesNumber = singleNotesOnSameSegment.length ;
		 for(var ix= 0 ; ix < singleNotesNumber ; ix++ ) {
                      var curNote = singleNotesOnSameSegment[ix].elem ;
                      for (var iy = ix+1 ; iy < singleNotesNumber ; iy++) {
			if (compareNotes(curNote, singleNotesOnSameSegment[iy].elem )) {
                           if(foundOne == 0 ) {
				foundNear ++ ;
                           }
			   foundOne ++ ;
                        }
                       }// single notes comparison
                      // compare notes in chors
                       for (var iz = 0 ; iz < chordsOnSameSegment.length ; iz ++) {
                          var chord = chordsOnSameSegment[iz].elem ;
			  console.log(" chord " + chord + " length " + chord.length) ;
                           for (var idx = 0 ; idx < chord.length ;idx++) {
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
	         tempSingleNotesOnSameSegment = [] ;
	         tempChordsOnSameSegment = [] ;
                 var nexts = segment.next ;
                // test if null
                 if(nexts == null ) break ;
                 var diffs = nexts.tick - segment.tick ;
                 console.log (" diff " + diffs ) ;
		for (var nx = 0 ; nx < singleNotesOnSameSegment.length ; nx++) {
			var elemz = singleNotesOnSameSegment[nx].elem ;
                        var ln = singleNotesOnSameSegment[nx].numTicks ;
                        if (ln > diffs) {
				console.log ("long note") ;
	         		tempSingleNotesOnSameSegment.push(new lmt(elemz, ln-diffs)) ;
                        }		
                 }
                 for (var nx = 0 ; nx < chordsOnSameSegment.length ; nx++) {
			var elemz = chordsOnSameSegment[nx].elem ;
                        var ln = chordsOnSameSegment[nx].numTicks ;
                        if (ln > diffs) {
				console.log ("long note") ;
	         		tempChordsOnSameSegment.push(new lmt(elemz, ln-diffs)) ;
                        }		
                 }
                 
		// now modify
                  segment = nexts;
            }

            // set result dialog

            if (foundNear == 0) {
                  msgResult.text = "No neighboring  found!\n";
            } else {
                  msgResult.text = foundNear + " neighborings found!\n";
            }


            curScore.endCmd();

            console.log("finished");
            msgResult.visible = true;
            //quit() // dialog will call quit()
      }
}
