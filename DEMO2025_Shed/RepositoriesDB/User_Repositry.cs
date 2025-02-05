using DEMO2025_Shed.Tools;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DEMO2025_Shed.RepositoriesDB
{
    public class User_Repositry
    {
        public static string Block_Repository(string login)
        {
            BD.Inst().Users.Find(s=>s.Login == login).IsBlocked = true;
            BD.Save();
            return SystemMessages.BlockAuth;
        }
    }
}
