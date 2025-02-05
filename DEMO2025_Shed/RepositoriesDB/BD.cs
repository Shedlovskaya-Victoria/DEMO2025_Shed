using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DEMO2025_Shed.RepositoriesDB
{
    public class BD
    {
        private static User22Context _user22Context;

        public static User22Context Inst()
        {
            if (_user22Context == null)
                _user22Context = new User22Context();

            return _user22Context;
        }
        public static void Save()
        {
            BD.Inst().SaveChanges();
        }
    }
}
