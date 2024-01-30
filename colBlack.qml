import QtQuick 2.0
import MuseScore 3.0
 
MuseScore {
      version:  "2"
      description: "This demo plugin erase colors from parallels"
      menuPath: "Plugins.Proof Reading.colorBackToBlack"
 
      property variant colors : [
               "#e21c48", "#f26622", "#f99d1c",
               "#ffcc33", "#fff32b", "#bcd85f",
               "#62bc47", "#009c95", "#0071bb",
               "#5e50a1", "#8d5ba6", "#cf3e96"
               ]
      property var colorFifth: "#ff6500";
      property var colorOctave: "#ff0050";
      property var colorHidden: "#a03500";
 
      property var colorBlack: "#000000" ;
      // Apply the given function to all notes in selection
      // or, if nothing is selected, in the entire score
      function applyToNotesInSelection(func) {
            if (typeof curScore === 'undefined')
                  return;
       
            var cursor     = curScore.newCursor();
            cursor.rewind(1);
            var startStaff  = cursor.staffIdx;
            cursor.rewind(2);
            var endStaff   = cursor.staffIdx;
            var endTick    = cursor.tick // if no selection, end of score
            var fullScore = false;
            if (!cursor.segment) { // no selection
                  fullScore = true;
                  startStaff = 0; // start with 1st staff
                  endStaff = curScore.nstaves; // and end with last
            }
       console.log(startStaff + " - " + endStaff + " - " + endTick)
            for (var staff = startStaff; staff <= endStaff; staff++) {
                  for (var voice = 0; voice < 4; voice++) {          
                        cursor.rewind(1); // sets voice to 0
                        cursor.voice = voice; //voice has to be set after goTo
                        cursor.staffIdx = staff;

                        if (!cursor.segment)
                              cursor.rewind(0) // if no selection, beginning of score

                        while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                              if (cursor.element && cursor.element.type == Element.CHORD) {
                                    var notes = cursor.element.notes;
                                    for (var i = 0; i < notes.length; i++) {
                                          var note = notes[i];
                                          func(note);
                                    }
                              }
                              cursor.next();
                        }
                  }
            }
      }
 
      function colorNote(note) {
            //note.color = colors[note.pitch % 12];
            var curcol = note.color ;
            if(( curcol ==  colorFifth ) || (curcol ==  colorOctave ) || (curcol == colorHidden ) ) {
           	 note.color = colorBlack ;
            }
      }
 
      onRun: {
            console.log("hello colornotes");
 
            if (typeof curScore === 'undefined')
                  Qt.quit();
 
            applyToNotesInSelection(colorNote)
 
            Qt.quit();
         }
}
