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

        public event PropertyChangedEventHandler? PropertyChanged;
        public void Signal([CallerMemberName] string prop = null) => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        public Visibility VisibilStep1_Auth { get; set; } 
        public Visibility VisibilStep2_ChangePassword { get; set; } 
        public Visibility Visible_BlockPanel { get; set; } 
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
                else if (string.IsNullOrEmpty(password.Password))
                {
                    countTries++;
                    MessageBox.Show(SystemMessages.FalseAuth);
                    return;
                }

                var result = User_Repositry.Authorizate(Login, password);
                if (result.Item1 == SystemMessages.SucessAuth)
                {
                    if (result.Item2)  //проверка была ли уже первая авторизация и смена пароля пользователем
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
                    MessageBox.Show(result.Item1);
                    countTries++;
                    BlockAccount();
                }
            }
            else
            {

                MessageBox.Show(SystemMessages.BlockAuth);
            }
        }

        private void ChangePassword(object sender, RoutedEventArgs e)
        {
            if (BlockAccount())
            {
                if (string.IsNullOrEmpty(oldPassword.Password))
                {
                    countTries++;
                    MessageBox.Show(SystemMessages.FalseAuth);
                    return;
                }
                else if (string.IsNullOrEmpty(newPassword.Password))
                {
                    countTries++;
                    MessageBox.Show(SystemMessages.FalseAuth);
                    return;
                }
                else if (string.IsNullOrEmpty(isTruePassword.Password))
                {
                    countTries++;
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
            else
            {
                //
            }
        }

        private bool BlockAccount()
        {
            if (countTries == 3)
            {
                MessageBox.Show(SystemMessages.BlockAuth);
                VisibilStep1_Auth = Visibility.Hidden;
                Visible_BlockPanel = Visibility.Visible;
                BlockLabel.Content = User_Repositry.Block_Repository(Login);
                Signal(nameof(VisibilStep1_Auth));
                Signal(nameof(Visible_BlockPanel));
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
