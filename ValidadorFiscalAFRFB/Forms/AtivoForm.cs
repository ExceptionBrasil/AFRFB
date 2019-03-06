using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ValidadorFiscalAFRFB.Validador;

namespace ValidadorFiscalAFRFB.Forms
{
    public partial class AtivoForm : Form
    {
        public AtivoForm()
        {
            InitializeComponent();
        }

        private void btnOpenFile_Click(object sender, EventArgs e)
        {
            openFileDialog.ShowDialog();
            tFileBox.Text = openFileDialog.FileName;
        }

        private async void btnValidar_Click(object sender, EventArgs e)
        {
            ValidacaoAtivo validador = new ValidacaoAtivo(tFileBox.Text);
            await validador.LerDados();
            dgAtivo.DataSource = validador.Ativos;

        }
    }
}
