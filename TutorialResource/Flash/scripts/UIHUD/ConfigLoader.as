package UIHUD
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ConfigLoader
   {
       
      
      private var _data:Object;
      
      private var _urlLoader:URLLoader;
      
      private var _completeCallback:Function;
      
      private var _fileNames:Array;
      
      private var _callbackValue;
      
      public function ConfigLoader()
      {
         super();
         _data = {};
         this._urlLoader = new URLLoader();
         this._urlLoader.addEventListener(Event.COMPLETE,OnFileRead);
         this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,OnErrorIO);
         this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,OnErrorSec);
      }
      
      public function prepareFile(fileName:String, completeCallback:Function, callbackValue:* = null) : void
      {
         _completeCallback = completeCallback;
         _callbackValue = callbackValue;
         _fileNames = [fileName];
         readFile();
      }
      
      public function readConfigs(fileNames:Array, completeCallback:Function, callbackValue:* = null) : void
      {
         _completeCallback = completeCallback;
         _callbackValue = callbackValue;
         _fileNames = fileNames;
         readFile();
      }
      
      private function readFile() : void
      {
         if(_fileNames.length > 0)
         {
            var fileName:String = _fileNames.shift();
            fileName = fileName.replace(/^\s+|\s+$/g,"");
            var request:URLRequest = new URLRequest(fileName);
            _urlLoader.load(request);
         }
         else if(_completeCallback != null)
         {
            _completeCallback(_data,_callbackValue);
         }
      }
      
      private function OnFileRead(event:Event) : void
      {
         var rawData:String = this._urlLoader.data;
         parseIniData(rawData);
         readFile();
      }
      
      private function parseIniData(rawData:String) : void
      {
         var lines:Array = rawData.split(/\r\n|\r|\n/);
         var currentSection:String = "";
         var currentSectionData:Object = {};
         for each(var line in lines)
         {
            line = line.replace(/^\s+|\s+$/g,"");
            if(line.length > 0)
            {
               if(line.charAt(0) == "[")
               {
                  var sectionMatch:Array = line.match(/^\[(.*?)\]$/);
                  if(sectionMatch && sectionMatch.length == 2)
                  {
                     currentSection = String(sectionMatch[1]);
                     if(!_data[currentSection])
                     {
                        _data[currentSection] = {};
                     }
                  }
               }
               else if(currentSection.length > 0 && line.indexOf("#") != 0 && line.indexOf(";") != 0)
               {
                  var parts:Array = line.split("=");
                  if(parts.length == 2)
                  {
                     var key:String = String(parts[0].replace(/^\s+|\s+$/g,""));
                     var value:String = String(parts[1].replace(/^\s+|\s+$/g,""));
                     var dataType:String = "s";
                     if(key.length > 0)
                     {
                        var prefix:String = key.charAt(0);
                        if(prefix == "b")
                        {
                           dataType = "b";
                        }
                        else if(prefix == "f")
                        {
                           dataType = "f";
                        }
                        else if(prefix == "i")
                        {
                           dataType = "i";
                        }
                     }
                     var typedValue:* = "";
                     switch(dataType)
                     {
                        case "b":
                           typedValue = value.toLowerCase() != "false" && value != "0" && value != "";
                           break;
                        case "f":
                           typedValue = parseFloat(value);
                           break;
                        case "i":
                           typedValue = int(value);
                           break;
                        default:
                           typedValue = value;
                     }
                     _data[currentSection][key] = typedValue;
                  }
               }
            }
         }
      }
      
      private function OnErrorIO(event:IOErrorEvent) : void
      {
         readFile();
      }
      
      private function OnErrorSec(event:SecurityErrorEvent) : void
      {
         readFile();
      }
   }
}
