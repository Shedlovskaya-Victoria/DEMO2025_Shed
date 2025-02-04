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
        public string Login { get; set; } = "";

        public Visibility VisibilStep1_Auth { get; set; } = Visibility.Visible;
        public Visibility VisibilStep2_ChangePassword { get; set; } = Visibility.Hidden;
        public Auth()
        {
            InitializeComponent();
            DataContext = this;
        }

        private void AuthInter(object sender, RoutedEventArgs e)
        {
            if (Login == null)
            {
                MessageBox.Show("Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные");
                return;
            }
            if (password.Password == null)
            {
                MessageBox.Show("Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные");
                return;
            }



            MessageBox.Show("Вы успешно авторизовались");
            VisibilStep1_Auth = Visibility.Hidden;
            VisibilStep2_ChangePassword = Visibility.Visible;
        }

        private void ChangePassword(object sender, RoutedEventArgs e)
        {

        }
    }
}
