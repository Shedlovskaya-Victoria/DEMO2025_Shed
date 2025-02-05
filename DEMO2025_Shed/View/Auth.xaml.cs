using DEMO2025_Shed.RepositoriesDB;
using DEMO2025_Shed.Tools;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
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
    public partial class Auth : Page
    {
        public string Login { get; set; } 
        private int countTries;
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
            BlockAccount();
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

            var result = Auth_Registr_Repository.Registrate(Login, password);
            MessageBox.Show(result);
            if (result == SystemMessages.SucessAuth)
            {
                VisibilStep1_Auth = Visibility.Hidden;
                VisibilStep2_ChangePassword = Visibility.Visible;
            }
        }

        private void ChangePassword(object sender, RoutedEventArgs e)
        {
            BlockAccount();
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
                var result = Auth_Registr_Repository.ChangePassword(Login, newPassword);
                MessageBox.Show(result);
                if(result == SystemMessages.SucessAuth)
                {
                    Nav.Inst().CurrentPage = new Main();
                }
            }
            
        }

        private void BlockAccount()
        {
            if (countTries == 3)
            {
                Visible_BlockPanel = Visibility.Visible;
                BlockLabel.Content = User_Repositry.Block_Repository(Login);
                countTries = 0;
                
            }
        }
    }
}
