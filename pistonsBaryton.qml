//=============================================================================
//  MuseScore
//
// Fingerings for Bass Clef Euphonium
// 
//
//  Contribution Tony Babecka, Artur Vilà Canal, Joachim Schmitz, BurkardS
//  Copyright (c) 2011 Karl Gerhards, (C)2008 Werner Schweer and others
//  modified by Sitting Bugle for french "fanfares"
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//  répétition \u1D10
//=============================================================================

import QtQuick 2.9
import MuseScore 3.0

MuseScore {
   version: "3.0"
   description: "Baryton pistons style Fanfare "
   menuPath: 'Plugins.Pistons.Pistons baryton'
   id: barytoneFingerings

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
        euphoniumFingerings.title = "pistons Baryton";
	//euphoniumFingerings.thumbnailName = "euph.png";
        euphoniumFingerings.categoryCode = "Brass Fingerings/Slide";
      }
   }

	function compareChords(array1, array2) {
                if(array1 == undefined || array2 == undefined ) return false ;
                var length = array1.length ;
                 console.log( " length " + length + " " + array2.length ) ;
		if(length != array2.length) return false ;
                for(var idx = 0 ; idx < length ; idx ++ ){
                  if(array1[idx].pitch != array2[idx].pitch ) return false ;
                 }
                 console.log(" arrays equal") ;
                 return true ;
        }

   onRun: {
   
      curScore.startCmd()
    
      // gibt den Griff zur midi-Nummer
      function griff(midi) { 
         // change for other Brass
         midi = midi-18;
         // edit and uncomment for other Brass
         //midi = midi-20;
         // for 4 valves, usually 1+3 = 4
         switch (midi){
            case 22: return "iii\u00A0"; break; //Fa#
            case 23: return "iĪi\u00A0"; break; //Sol
            case 24: return "Īii\u00A0"; break; //LAb
            case 26: return "iiĪ\u00A0"; break; //La
            case 26: return "iĪĪ\u00A0"; break; //Sib
            case 27: return "ĪiĪ\u00A0"; break; //SI
            case 28: return "ĪĪĪ\u00A0"; break; //DO
            case 29 : return "iii\u00A0"; break; //Do#
            case 30: return "iĪi\u00A0"; break; //Ré
            case 31: return "Īii\u00A0"; break; //Mib
            case 32: return "iiĪ\u00A0"; break; //MI
            case 33: return "iĪĪ\u00A0"; break; //Fa
            case 34: return "ĪiĪ\u00A0"; break; //Fa#
            case 35: return "ĪĪĪ\u00A0"; break; //Sol
            case 36: return "Īii\u00A0"; break; //Lab
            case 37: return "iiĪ\u00A0"; break; //La
            case 38: return "iĪĪ\u00A0"; break; //Sib
            case 39: return "ĪiĪ\u00A0"; break; //SI
            case 40: return "ĪĪĪ\u00A0"; break; //DO
            case 41: return "iiĪ\u00A0"; break; //DO#
            case 42: return "iĪĪ\u00A0"; break; // Ré
            case 43: return "ĪiĪ\u00A0"; break; // Mib
            case 44: return "ĪĪĪ\u00A0"; break; //Mi
            case 45: return "iĪĪ\u00A0"; break; // Fa
            case 46: return "ĪiĪ\u00A0"; break; // Fa#
            case 47: return "ĪĪĪ\u00A0"; break; // SOl
            case 48: return "Īii\u00A0"; break; // Lab
            case 49: return "iiĪ\u00A0"; break; // La
            case 50: return "iĪĪ\u00A0"; break; //Sib (limite)
            case 51: return "ĪiĪ\u00A0"; break; //si
            case 52: return "ĪĪĪ\u00A0"; break; //do
            case 53: return "ĪiĪ\u00A0"; break; // do#
            case 54: return "iĪĪ/ĪĪĪ"; break; //ré
            case 55: return "ĪiĪ\u00A0"; break; // Mib
            case 56: return "ĪĪĪ\u00A0"; break; //MI
//===================================
//            //case 22: return "iii"; break;
//            case 23: return "iTi"; break;
//            case 24: return "Tii"; break;
//            case 25: return "iiT"; break;
//            case 26: return "iTT"; break;
//            case 27: return "TiT"; break;
//            case 28: return "TTT"; break; //Bb 2nd Line
//            case 29: return "iii"; break; //B
//            case 30: return "iTi"; break; //C
//            case 31: return "Tii"; break; //C#
//            case 32: return "iiT"; break; //D
//            case 33: return "iTT"; break; //Eb
//            case 34: return "TiT"; break; //E
//            case 35: return "TTT"; break; //F
//            case 36: return "Tii"; break; //F#
//            case 37: return "iiT"; break; //G
//            case 38: return "iTT"; break; //G#
//            case 39: return "TiT"; break; //A
//            case 40: return "TTT"; break; //Bb
//            case 41: return "iiT"; break;
//            case 42: return "iTT"; break;
//            case 43: return "TiT"; break;
//            case 44: return "TTT"; break;
//            case 45: return "iTT"; break;
//            case 46: return "TiT"; break;
//            case 47: return "TTT"; break;
//            case 48: return "Tii"; break;
//            case 49: return "iiT"; break;
//            case 50: return "iTT"; break;
//            case 51: return "TiT"; break;
//            case 52: return "TTT"; break;
//            case 53: return "#2 or b12"; break;
//            case 54: return "iTT"; break;

//=============================================================================
            default: return "";			
         }
      }

      var names = ["D","D#","E","F","F#","G","G#","A","A#","B","C","C#"];
      // comment this block for american note names
      //var names = ["re","re#","mi","fa","fa#","sol","sol#","la","la#","si", "do","do#"];
      // comment the above block for american note names
      var cursor   = curScore.newCursor();
      cursor.staffIdx = 0;
      cursor.voice = 0;
      cursor.rewind(0);  // set cursor to first chord/rest
      var CrLf = '\n';
      var textold = "xxx";
      var lastNotes = undefined ;
      while (cursor.segment) {
         if (cursor.element && cursor.element.type == Element.CHORD) { 
            var text  = newElement(Element.LYRICS) //text.text = "": //text.text = griff(notes[0].pitch) + CrLf ; //text.setProperty(Sid.lyricsEvenFontStyle,FontStyle.UnderLine) ;
            //text.setProperty(StyledProperty.lyricsOddFontStyle,FontStyle.UnderLine) ;
            var notes = cursor.element.notes ;
            if (compareChords(notes, lastNotes)) {
               text.text = "//\u00A0" ;
               cursor.add(text) ;
               cursor.next() ;
               continue ;
            } 
            lastNotes = notes ;
             //text.text = "":
            //text.text = griff(notes[0].pitch) + CrLf ;
            for( var ix =  notes.length ; ix > 0 ; ix--) {
                var curnote = notes[ix-1] ;
	     //  si la note est une prolongation ne rien marquer
	        if( curnote.tieBack == undefined ) {
                   if (ix == notes.length ) {
			   text.text += griff(curnote.pitch)  ;
                   } else {
		       text.text += "\n" + griff(curnote.pitch)  ;
                   }
                } else {
                 text.text += "—"  ;
                } 
            }

            //text.offsetY = 9;
            if (text.text != textold) cursor.add(text);
            textold = text.text;
            if (text.text = textold) cursor.add(text);
            textold = text.text;
         }
         cursor.next();
      }
      
      curScore.endCmd();
      quit();
   }
}
