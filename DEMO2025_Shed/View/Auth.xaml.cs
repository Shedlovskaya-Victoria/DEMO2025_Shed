using DEMO2025_Shed.RepositoriesDB;
using DEMO2025_Shed.Tools;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace DEMO2025_Shed.View
{
    /// <summary>
    /// Логика взаимодействия для Auth.xaml
    /// </summary>
    public partial class Auth : Page, INotifyPropertyChanged
    {
        public string Login { get; set; }
        private int countTries;
        private Visibility visibilStep1_Auth;
        private Visibility visible_BlockPanel;
        private Visibility visibilStep2_ChangePassword;

        public event PropertyChangedEventHandler? PropertyChanged;
        public void Signal([CallerMemberName] string prop = null) => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        public Visibility VisibilStep1_Auth
        {
            get => visibilStep1_Auth;
            set { visibilStep1_Auth = value; Signal(); }
        }
        public Visibility VisibilStep2_ChangePassword
        {
            get => visibilStep2_ChangePassword;
            set { visibilStep2_ChangePassword = value; Signal(); }
        }
        public Visibility Visible_BlockPanel
        {
            get => visible_BlockPanel;
            set { visible_BlockPanel = value; Signal(); }
        }
        public Auth()
        {
            InitializeComponent();
            DataContext = this;
            Login = "";
            countTries = 0;
            Visible_BlockPanel = Visibility.Hidden;
            VisibilStep2_ChangePassword = Visibility.Hidden;
            VisibilStep1_Auth = Visibility.Visible;
        }

        private void AuthInter(object sender, RoutedEventArgs e)
        {
            if (BlockAccount())
            {
                if (string.IsNullOrEmpty(Login))
                {
                    countTries++;
                    MessageBox.Show(SystemMessages.FalseAuth);
                    return;
                }
                //сущеcтвует ли логин
                else if (User_Repositry.IsExistsUser(Login))
                {
                    MessageBox.Show(SystemMessages.UserNotExists);
                    countTries++;
                }
                else if (string.IsNullOrEmpty(password.Password))
                {
                    countTries++;
                    MessageBox.Show(SystemMessages.FalseAuth);
                    return;
                }
                //не прошел ли месяц спустя создания логина
                if (User_Repositry.CheckAuthorisateForMounthAfterCreate(Login))
                {
                    MessageBox.Show(SystemMessages.BlockAuth);
                    return;
                }
                //авторизация
                var result = User_Repositry.Authorizate(Login, password);
                //не меняли ли мы уже пароль
                var needChangePassword = User_Repositry.IsNeedChangePassword(Login);

                if (result == SystemMessages.SucessAuth)
                {
                    if (needChangePassword)
                    {
                        VisibilStep1_Auth = Visibility.Hidden;
                        VisibilStep2_ChangePassword = Visibility.Visible;
                    }
                    else
                    {
                        goToMainPage();
                    }
                }
                else
                {
                    MessageBox.Show(result);
                    countTries++;
                    BlockAccount();
                }
            }
            else
            {

                MessageBox.Show(SystemMessages.BlockAuth);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ChangePassword(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(oldPassword.Password))
            {
                MessageBox.Show(SystemMessages.FalseAuth);
                return;
            }
            else if (string.IsNullOrEmpty(newPassword.Password))
            {
                MessageBox.Show(SystemMessages.FalseAuth);
                return;
            }
            else if (string.IsNullOrEmpty(isTruePassword.Password))
            {
                MessageBox.Show(SystemMessages.FalseAuth);
                return;
            }

            if (newPassword.Password == isTruePassword.Password)
            {
                var result = User_Repositry.ChangePassword(Login, newPassword);
                MessageBox.Show(result);
                if (result == SystemMessages.SucessAuth)
                {
                    goToMainPage();
                }
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private bool BlockAccount()
        {
            if (countTries == 3)
            {
                MessageBox.Show(SystemMessages.BlockAuth);
                VisibilStep1_Auth = Visibility.Hidden;
                Visible_BlockPanel = Visibility.Visible;
                BlockLabel.Content = User_Repositry.Block_Repository(Login);

                return false;
            }
            else
                return true;
        }
        private void goToMainPage()
        {
            Nav.Inst().CurrentPage = new Main();
        }
    }
}
