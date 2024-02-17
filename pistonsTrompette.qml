//=============================================================================
//  MuseScore
//
// Fingerings for Bb Trumpet
// 
//
//  Contribution Tony Babecka, Artur Vilà Canal, Joachim Schmitz, BurkardS
//  Copyright (c) 2011 Karl Gerhards, (C)2008 Werner Schweer and others
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
   description: "pistons trompette style fanfare"
   menuPath: 'Plugins.Pistons trompette'
   id: pistonsTrompette

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
        pistonsTrompette.title = "Pistons trompette";
	//trumpetFingerings.thumbnailName = "TrumpetFingerings.png";
        pistonsTrompette.categoryCode = "Brass Fingerings/Slide";
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
            case 34: return "iii\u00A0"; break; //FA #
            case 35: return "iĪi\u00A0"; break; //SOL
            case 36: return "Īii\u00A0"; break; //Lab
            case 37: return "≾iiĪ\u00A0"; break; //LA
            case 38: return "iĪĪ\u00A0"; break;  //Sib
            case 39: return "ĪiĪ\u00A0"; break;  //si
            case 40: return "ĪĪĪ\u00A0"; break; //DO
            case 41: return "iii≽\u00A0"; break; //DO#
            case 42: return "iĪi≿\u00A0"; break; //Ré
            case 43: return "Īii\u00A0"; break; //Mib
            case 44: return "≾iiĪ\u00A0"; break; //MI
            case 45: return "iĪĪ\u00A0"; break; //FA
            case 46: return "ĪiĪ\u00A0"; break; //FA#
            case 47: return "ĪĪĪ\u00A0"; break; //SOL
            case 48: return "Īii\u00A0"; break; //Lab
            case 49: return "≾iiĪ\u00A0"; break; //La
            case 50: return "iĪĪ\u00A0"; break; //Sib
            case 51: return "ĪiĪ\u00A0"; break; //Si
            case 52: return "ĪĪĪ\u00A0"; break; //DO
            case 53: return "iiĪ\u00A0"; break; // Do#
            case 54: return "iĪĪ\u00A0"; break; // Ré
            case 55: return "ĪiĪ\u00A0"; break; // Mib
            case 56: return "ĪĪĪ\u00A0"; break; // Mi
            case 57: return "≾iĪĪ\u00A0"; break; // Fa
            case 58: return "ĪiĪ\u00A0"; break; // Fa#
            case 59: return "ĪĪĪ\u00A0"; break; // Sol
            case 60: return "Īii\u00A0"; break; // Lab
            case 61: return "≾iiĪ\u00A0"; break; // La
            case 62: return "iĪĪ\u00A0"; break; // Sib
            case 63: return "ĪiĪ\u00A0"; break; // Si
            case 64: return "ĪĪĪ\u00A0"; break; // Do
            case 65: return "ĪiĪ\u00A0"; break; // Do#
            case 66: return "ĪĪĪ\u00A0"; break; // Ré

            //case 61: return "⨪⨪Ī\u00A0"; break;
            //case 61: return "⨪⨪Ī\u00A0"; break;
            //case 34: return "1\n2\n3"; break;
            //case 35: return "1\n3"; break;
            //case 36: return "2\n3"; break;
            //case 37: return "1\n2"; break;
            //case 38: return "1"; break;
            //case 39: return "2"; break;
            //case 40: return "0"; break; //Bb Below Staff Treble
            //case 41: return "1\n2\n3"; break; //B
            //case 42: return "1\n3"; break; //C
            //case 43: return "2\n3"; break; //C#
            //case 44: return "1\n2"; break; //D
            //case 45: return "1"; break; //Eb
            //case 46: return "2"; break; //E
            //case 47: return "0"; break; //F
            //case 48: return "2\n3"; break; //F#
            //case 49: return "1\n2"; break; //G
            //case 50: return "1"; break; //G#
            //case 51: return "2"; break; //A
            //case 52: return "0"; break; //Bb
            //case 53: return "1\n2"; break;
            //case 54: return "1"; break;
            //case 55: return "2"; break;
            //case 56: return "0"; break;
            //case 57: return "1"; break;
            //case 58: return "2"; break;
            //case 59: return "0"; break;
            //case 60: return "2\n3"; break;
            //case 61: return "1\n2"; break;
            //case 62: return "1"; break;
            //case 63: return "2"; break;
            //case 64: return "0"; break;
            //case 65: return "#2 or b12"; break;
            //case 66: return "1"; break;
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
      
      curScore.endCmd() ;
      Qt.quit();
   }
}
