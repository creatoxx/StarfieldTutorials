package UIHUD
{
   import flash.geom.ColorTransform;
   
   public class ColorTransformUI
   {
       
      
      public function ColorTransformUI()
      {
         super();
      }
      
      public static function GetTransformFromColor(customColor:uint) : ColorTransform
      {
         var customColorTransform:ColorTransform = new ColorTransform();
         customColorTransform.color = customColor;
         return customColorTransform;
      }
      
      public static function GetPayloadColorCondition(currentWeight:uint, maxWeight:uint) : int
      {
         if(currentWeight / maxWeight * 100 > uint(100))
         {
            return 3;
         }
         if(currentWeight / maxWeight * 100 > uint(90))
         {
            return 2;
         }
         if(currentWeight / maxWeight * 100 > uint(80))
         {
            return 1;
         }
         return 0;
      }
      
      public static function convertColor(sHexColor:String, opacity:Number = null) : uint
      {
         sHexColor = sHexColor.replace("#","");
         var iColor:uint = uint("0x" + sHexColor);
         if(opacity != null)
         {
            var iAlpha:uint = Math.round(opacity * 255);
            return uint(iAlpha << 24 | iColor & 16777215);
         }
         return iColor;
      }
   }
}
