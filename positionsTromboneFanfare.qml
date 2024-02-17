//=============================================================================
//  MuseScore
//
// Slide Positions
// 
//
//  Contribution Tony Babecka, Artur Vilà Canal, Joachim Schmitz, BurkardS
//  Copyright (c) 2011 Karl Gerhards, (C)2008 Werner Schweer and others
//  Modified by sitting bugle for french "fanfares"
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
//=============================================================================

import QtQuick 2.9
import MuseScore 3.0

MuseScore {
   version: "3.0"
   description: "Positions deTrombone pour fanfares "
   menuPath: 'Plugins.Positions trombone fanfare'
   id: slidePositions

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
        slidePositions.title = "Positions Trombone Fanfare" ;
	//slidePositions.thumbnailName = "BoneSlide.png";
        slidePositions.categoryCode = "Brass Fingerings/Slide";
      }
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
         case 22: return "3" ; break ; //Fa#
         case 23: return "2\u00BD"; break;//Sol
         case 24: return "2"; break;//Lab
	case 25: return "1\u00BD≿"; break;//La
	case 26: return "1"; break;//Sib
	case 27: return "\u00BD"; break;//Si
	case 28: return "0"; break;//DO
	case 29: return "3≿"; break;//Do#
	case 30: return "2\u00BD≿"; break;//Ré
	case 31: return "2"; break;//Mib
	case 32: return "1\u00BD≿"; break;//Mi
	case 33: return "1"; break;//Fa
	case 34: return "\u00BD"; break;//Fa#
            case 35: return "0"; break;//Sol
            case 36: return "2"; break;//Lab
            case 37: return "1\u00BD≿"; break;//La
            case 38: return "1"; break;//Sib
            case 39: return "\u00BD"; break;//Si
            case 40: return "0"; break;//Do
            case 41: return "1\u00BD"; break;//D0#
            case 42: return "1"; break;//Ré
            case 43: return "\u00BD"; break;//Mib
            case 44: return "0"; break;//Mi
            case 45: return "1≿"; break; //Fa
            case 46: return "\u00BD"; break;//Fa#
            case 47: return "0"; break;//SOL
            case 48: return "2"; break;// Lab
            case 49: return "1\u00BD≿"; break;// La
            case 50: return "1"; break; //Sib 
            case 51: return "\u00BD"; break;//Si
            case 52: return "0"; break;//Do
            case 53: return "\u00BD"; break;//Do #
            case 54: return "0"; break; //Ré
            case 53: return "\u00BD"; break;//Mib
            case 56: return "0"; break;//Mi
            case 57: return "1"; break;//Fa
            case 58: return "\u00BD"; break;//Fa #
            default: return "";			
         }
      }

      //var names = ["D","D#","E","F","F#","G","G#","A","A#","B","C","C#"];
      // comment this block for american note names
      var names = ["re","re#","mi","fa","fa#","sol","sol#","la","la#","si", "do","do#"];
      // comment the above block for american note names
      var cursor   = curScore.newCursor();
      cursor.staffIdx = 0;
      cursor.voice = 0;
      cursor.rewind(0);  // set cursor to first chord/rest
      var CrLf = '\n';
      var textold = "xxx";
      while (cursor.segment) {
         if (cursor.element && cursor.element.type == Element.CHORD) {
            var text  = newElement(Element.LYRICS) ;
//text.setProperty(Sid.lyricsEvenFontStyle,FontStyle.UnderLine) ;
            //text.setProperty(StyledProperty.lyricsOddFontStyle,FontStyle.UnderLine) ;
            var notes = cursor.element.notes ;
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
      
      curScore.endCmd()
      quit();
   }
}
