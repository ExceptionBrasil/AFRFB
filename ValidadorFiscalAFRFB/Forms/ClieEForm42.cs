using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ValidadorFiscalAFRFB.Modelos;
using ValidadorFiscalAFRFB.Validador;

namespace ValidadorFiscalAFRFB.Forms
{
    public partial class ClieEForm42 : Form
    {
        public ClieEForm42()
        {
            InitializeComponent();
        }

        private void btnOpenDialogFile_Click(object sender, EventArgs e)
        {

           
            openFileDialog.ShowDialog(tFileBox);
            tFileBox.Text = openFileDialog.FileName;
        }

        private async void btnValidarCliFor_Click(object sender, EventArgs e)
        {
            ValidacaoClieFor validador = new ValidacaoClieFor(tFileBox.Text);

            if (!validador.Exists())
            {
                MessageBox.Show("O arquivo selecionado não existe mais");
                return;
            }

            await validador.LerDados();
            await validador.Intercalar(progressBar);


            dgHeader.DataSource = validador.Titulos;
        }

        private void dgHeader_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var itemGrid=  (DataGridView)sender;
            List<LayoutClieFor> titulos = (List<LayoutClieFor>)itemGrid.DataSource;

            dgDetail.DataSource = titulos[e.RowIndex].Movimentacao;
        }
    }
}
