using DEMO2025_Shed.ModelDB;
using DEMO2025_Shed.Tools;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace DEMO2025_Shed.RepositoriesDB
{
    public class User_Repositry
    {
        public static string Block_Repository(string login)
        {
            if (string.IsNullOrEmpty(login))
            {
                return SystemMessages.FalseAuth;
            }
            BD.Inst().Users.FirstOrDefault(s => s.Login == login).IsBlocked = true;
            BD.Save();
            return SystemMessages.BlockAuth;
        }

        public static bool CheckAuthorisateForMounthAfterCreate(User user)
        {
            
            var daysInMonth = DateTime.DaysInMonth(user.DateCreate.Year, user.DateCreate.Month);
            var controlAuthorizateDate = user.DateCreate.AddDays(daysInMonth);
            if (user.IsBlocked == false & DateOnly.FromDateTime(DateTime.Now.Date) >= controlAuthorizateDate)
            {
                user.IsBlocked = true;
                BD.Save();
                return true;
            }
            else
                return false;
        }
        public static (string, bool) Authorizate(string login, PasswordBox password)
        {
            var data = BD.Inst().Users.FirstOrDefault(s => s.Login == login && s.Password == password.Password);
            if (data == null)
            {
                return (SystemMessages.FalseAuth, false);
            }
            if (User_Repositry.CheckAuthorisateForMounthAfterCreate(data))
            {
                return (SystemMessages.BlockAuth, false);
            }
            if (data.DateUpdate == null)
            {
                return (SystemMessages.SucessAuth, true);
            }
            return (SystemMessages.SucessAuth, false);
        }

        public static string ChangePassword(string login, PasswordBox newPassword)
        {
            BD.Inst().Users.First(s => s.Login == login).Password = newPassword.Password;
            BD.Save();
            return SystemMessages.SucessAuth;
        }
    }
}
