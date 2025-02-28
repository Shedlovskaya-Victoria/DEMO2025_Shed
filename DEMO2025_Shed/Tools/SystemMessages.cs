using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DEMO2025_Shed.Tools
{
    public static class SystemMessages
    {
        public const string FalseAuth = 
            "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные.";
        public const string SucessAuth = "Вы успешно авторизовались";
        public const string BlockAuth = "Вы заблокированы. Обратитесь к администратору";
        public const string PasswordIsAlreadyExists = "Подобный пароль уже существует. Введите другой пароль";
        public const string UserNotExists = "Такого логина не существует. Попробуйте еще раз.";
    }
}
