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
//=============================================================================

import QtQuick 2.9
import MuseScore 3.0

MuseScore {
   version: "3.0"
   description: "Basses pistons style Fanfare "
   menuPath: 'Plugins.pistons basse'
   id: euphoniumFingerings

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
        euphoniumFingerings.title = "pistons Basse";
	//euphoniumFingerings.thumbnailName = "euph.png";
        euphoniumFingerings.categoryCode = "Brass Fingerings/Slide";
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
            case 22: return "⨪⨪⨪\u00A0"; break;
            case 23: return "⨪Ī⨪\u00A0"; break;
            case 24: return "Ī⨪⨪\u00A0"; break;
            case 26: return "⨪⨪Ī\u00A0"; break;
            case 26: return "⨪ĪĪ\u00A0"; break;
            case 27: return "Ī⨪Ī\u00A0"; break;
            case 28: return "ĪĪĪ\u00A0"; break; //Bb 2nd Line
            case 29 : return "⨪⨪⨪\u00A0"; break; //B
            case 30: return "⨪Ī⨪\u00A0"; break; //C
            case 31: return "Ī⨪⨪\u00A0"; break; //C#
            case 32: return "⨪⨪Ī\u00A0"; break; //D
            case 33: return "⨪ĪĪ\u00A0"; break; //Eb
            case 34: return "Ī⨪Ī\u00A0"; break; //E
            case 35: return "ĪĪĪ\u00A0"; break; //F
            case 36: return "Ī⨪⨪\u00A0"; break; //F#
            case 37: return "⨪⨪Ī\u00A0"; break; //G
            case 38: return "⨪ĪĪ\u00A0"; break; //G#
            case 39: return "Ī⨪Ī\u00A0"; break; //A
            case 40: return "ĪĪĪ\u00A0"; break; //Bb
            case 41: return "⨪⨪Ī\u00A0"; break;
            case 42: return "⨪ĪĪ\u00A0"; break;
            case 43: return "Ī⨪Ī\u00A0"; break;
            case 44: return "ĪĪĪ\u00A0"; break;
            case 45: return "⨪ĪĪ\u00A0"; break;
            case 46: return "Ī⨪Ī\u00A0"; break;
            case 47: return "ĪĪĪ\u00A0"; break;
            case 48: return "Ī⨪⨪\u00A0"; break;
            case 49: return "⨪⨪Ī\u00A0"; break;
            case 50: return "⨪ĪĪ\u00A0"; break;
            case 51: return "Ī⨪Ī\u00A0"; break;
            case 52: return "ĪĪĪ\u00A0"; break;
            case 53: return "#2 or b12"; break;
            case 54: return "⨪ĪĪ\u00A0"; break;
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
