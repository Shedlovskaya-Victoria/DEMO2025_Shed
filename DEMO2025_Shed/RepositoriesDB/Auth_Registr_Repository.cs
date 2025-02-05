using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using DEMO2025_Shed.Tools;

namespace DEMO2025_Shed.RepositoriesDB
{
    public class Auth_Registr_Repository
    {
        public static string Registrate(string login, PasswordBox password)
        {
            var data = BD.Inst().Users.FirstOrDefault(s => s.Login == login && s.Password == password.Password);
            if (data == null)
            {
                return SystemMessages.FalseAuth;
            }
            return SystemMessages.SucessAuth;
        }

        internal static string ChangePassword(string login, PasswordBox newPassword)
        {
            BD.Inst().Users.First(s=>s.Login == login).Password = newPassword.Password;
            BD.Save();
            return SystemMessages.SucessAuth;
        }
    }
}
