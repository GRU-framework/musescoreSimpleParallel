//==============================================
//  show notes constituing a 7, 7aug, 9, or 9dim chord
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
// marks voice number 4 with rest that show the cadence like a silent metronome
// while (cursor.measure) {
//==============================================

import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import MuseScore 3.0


MuseScore {
      menuPath: "Plugins.Adds a silent metronome to a staff"
      description: "writes rests at regular interval on 4th voice"
      version: "0.2"
      requiresScore: true

      property var colorRests: "#b07550";


      id: cadence

      Component.onCompleted :{ 
            if (mscoreMajorVersion >= 4) {
                  cadence.title = "create a pseudo notes for a metronom ";
                  cadence.categoryCode = "composing-arranging-tools"
            }
      }



       function lmt(durationElement, numTicks) {
		this.elem = durationElement ;
                this.numTicks = numTicks ;
               //durationElement.globalDuration.ticks ;
       }
      property var durations:
     {
    1: [1, 16], 
    2: [1, 8],
    3: [3, 16], 
    4: [1, 4],
    5: [5, 16], 
    6: [3, 8], 
    7: [7, 16], 
    8: [1, 2]
    }

  //function setDurationAndRests(cursor, numberOf16ths, numRests)
  function setDurationAndRests(cursorA, tsN, tsD)
  {
   console.log( "Ts N " + tsN ) ;
    if (tsN == 0) return;
    cursorA.track = 3;
    for(var num = 0 ; num < tsN; num++) {
      var tickA = cursorA.tick ;
      console.log("TIck A " + tickA + "tsN " + tsN + " TsD " + tsD + " Num " + num) ;
      cursorA.setDuration(1, tsD);
      cursorA.addRest() ;
      cursorA.rewindToTick(tickA) ;
      var elem = cursorA.element ;
      elem.color = colorRests ;
      elem.small= true ;
       cursorA.next() ;
    }
  }


      onRun: {
            console.log("start")
            if (typeof curScore == 'undefined' || curScore == null) {
                  console.log("no score found");
                  Qt.quit();
            }
	    //============================

            curScore.startCmd();
// tryng to find parts that have no pitched notes (drums)

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
           var no = 1;
           while (cursor.measure) {
			var m = cursor.measure;
                        var segment = m.firstSegment;
			if(segment == undefined ) continue ;
			var tick = segment.tick;
			var tsD = m.timesigActual.denominator;
			var tsN = m.timesigActual.numerator;
			var ticksB = division * 4.0 / tsD;
			var ticksM = ticksB * tsN ;
                        console.log(tsN + "/" + tsD + " measure " + no +
			    " at tick " + tick + " length " + ticksM);
                        cursor.track = 3;
                        setDurationAndRests(cursor, tsN, tsD) ;
                         // boucle selon denominator
                         // créer un element de type Chord ElementType_CHORD
                         //  mettre la durée
                         //  mettre le silence
                         //  ajouter au curseur

                        no++ ;
                        cursor.track = 0;
                        cursor.rewindToTick(tick) ;
                        cursor.nextMeasure();
	}

            curScore.endCmd();

            console.log("finished");
      }
}
