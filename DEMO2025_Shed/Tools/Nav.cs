using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace DEMO2025_Shed.Tools
{
    public class Nav : INotifyPropertyChanged
    {
        public Page CurrentPage { 
            get => currentPage;
            set { currentPage = value; Signal(); } 
        }
        static Nav nav;
        private Page currentPage;

        public event PropertyChangedEventHandler? PropertyChanged;
        public void Signal([CallerMemberName] string prop = null)
            => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        public static Nav Inst()
        {
            if(nav == null) nav = new Nav();
            return nav;
        }
    }
}
