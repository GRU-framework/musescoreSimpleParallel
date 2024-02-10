//=============================================================================
//  MuseScore
//
// Fingerings for Tuba
// 
//
//  Contribution Tony Babecka, Artur Vilà Canal, Joachim Schmitz, BurkardS
//  Copyright (c) 2011 Karl Gerhards, (C)2008 Werner Schweer and others
// modified by stiiting bugle for french "fanfares"
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
   description: "Pistons Souba"
   menuPath: 'Plugins.Pistons Souba'
   id: tubaFingerings

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
        tubaFingerings.title = "pistons Souba";
	//tubaFingerings.thumbnailName = "tuba.png";
        categoryCode = "Brass Fingerings & Slide";
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
            case 10: return "⨪⨪⨪\u00A0"; break;
            case 11: return "⨪Ī⨪\u00A0"; break;
            case 12: return "Ī⨪⨪\u00A0"; break;
            case 13: return "⨪⨪Ī\u00A0"; break;
            case 14: return "⨪ĪĪ\u00A0"; break;
            case 15: return "Ī⨪Ī\u00A0"; break;
            case 16: return "ĪĪĪ\u00A0"; break; //Bb 2nd Line
            case 17: return "⨪⨪⨪\u00A0"; break; //B
            case 18: return "⨪Ī⨪\u00A0"; break; //C
            case 19: return "Ī⨪⨪\u00A0"; break; //C#
            case 20: return "⨪⨪Ī\u00A0"; break; //D
            case 21: return "⨪ĪĪ\u00A0"; break; //Eb
            case 22: return "Ī⨪Ī\u00A0"; break; //E
            case 23: return "ĪĪĪ\u00A0"; break; //F
            case 24: return "Ī⨪⨪\u00A0"; break; //F#
            case 25: return "⨪⨪Ī\u00A0"; break; //G
            case 26: return "⨪ĪĪ\u00A0"; break; //G#
            case 27: return "Ī⨪Ī\u00A0"; break; //A
            case 28: return "ĪĪĪ\u00A0"; break; //Bb
            case 29: return "⨪⨪Ī\u00A0"; break;
            case 30: return "⨪ĪĪ\u00A0"; break;
            case 31: return "Ī⨪Ī\u00A0"; break;
            case 32: return "ĪĪĪ\u00A0"; break;
            case 33: return "⨪ĪĪ\u00A0"; break;
            case 34: return "Ī⨪Ī\u00A0"; break;
            case 35: return "ĪĪĪ\u00A0"; break;
            case 36: return "Ī⨪⨪\u00A0"; break;
            case 37: return "⨪⨪Ī\u00A0"; break;
            case 38: return "⨪ĪĪ\u00A0"; break;
            case 39: return "Ī⨪Ī\u00A0"; break;
            case 40: return "ĪĪĪ\u00A0"; break;
            case 41: return "#2 or b12"; break;
            case 42: return "⨪ĪĪ\u00A0"; break;



            //case 10: return "1\n2\n3"; break;
            //case 11: return "1\n3"; break;
            //case 12: return "2\n3"; break;
            //case 13: return "1\n2"; break;
            //case 14: return "1"; break;
            //case 15: return "2"; break;
            //case 16: return "0"; break; //Bb below staff
            //case 17: return "1\n2\n3"; break; //B
            //case 18: return "1\n3"; break; //C
            //case 19: return "2\n3"; break; //C#
            //case 20: return "1\n2"; break; //D
            //case 21: return "1"; break; //Eb
            //case 22: return "2"; break; //E
            //case 23: return "0"; break; //F
            //case 24: return "2\n3"; break; //F#
            //case 25: return "1\n2"; break; //G
            //case 26: return "1"; break; //G#
            //case 27: return "2"; break; //A
            //case 28: return "0"; break; //Bb 2nd line
            //case 29: return "1\n2"; break;
            //case 30: return "1"; break;
            //case 31: return "2"; break;
            //case 32: return "0"; break;
            //case 33: return "1"; break;
            //case 34: return "2"; break;
            //case 35: return "0"; break;
            //case 36: return "2\n3"; break;
            //case 37: return "1\n2"; break;
            //case 38: return "1"; break;
            //case 39: return "2"; break;
            //case 40: return "0"; break;
            //case 41: return "#2 or b12"; break;
            //case 42: return "1"; break;
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
