using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace DEMO2025_Shed.Tools
{
    public class Nav
    {
       public Page CurrentPage { get; set; }
       static Nav nav;
        public static Nav Inst()
        {
            if(nav == null) nav = new Nav();
            return nav;
        }
    }
}
