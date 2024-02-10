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
   menuPath: 'Plugins.Positions trombone'
   id: slidePositions

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
        slidePositions.title = "Positions Trombone";
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
         case 23: return "2\u00BD\n6"; break;//F
         case 24: return "2\n5"; break;//Gb
	case 25: return "1\u00BD\n4"; break;//G
	case 26: return "1\n3"; break;//Ab
	case 27: return "\u00BD\n2"; break;//A
	case 28: return "0\n1"; break;//Bb 2nd Line
	case 29: return "3\n7"; break;//B
	case 30: return "2\u00BD\n6"; break;//C
	case 31: return "2\n5"; break;//Db
	case 32: return "1\u00BD\n4"; break;//D
	case 33: return "1\n3"; break;//Eb            
	case 34: return "\u00BD\n2"; break;//E
            case 35: return "0\n1"; break;//F
            case 36: return "2\n5"; break;//Gb
            case 37: return "1\u00BD\n4"; break;//G
            case 38: return "1\n3"; break;//Ab
            case 39: return "\u00BD\n2"; break;//A
            case 40: return "0\n1"; break;//Bb Top Staff Bass
            case 41: return "1\u00BD\n4"; break;//B
            case 42: return "1\n3"; break;//C
            case 43: return "\u00BD\n2"; break;//C#
            case 44: return "0\n1"; break;//D
            case 45: return "1\n3"; break;
            case 46: return "\u00BD\n2"; break;
            case 47: return "0\n1"; break;
            case 48: return "1\n3"; break;
            case 49: return "\u00BD\n2"; break;
            case 50: return "1\n3"; break;
            case 51: return "0\n1"; break;//Bb Above Staff Bass
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
            var text  = newElement(Element.LYRICS)
            text.text = griff(cursor.element.notes[0].pitch) + CrLf
                     ;
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
