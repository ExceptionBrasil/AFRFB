using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ValidadorFiscalAFRFB.Forms;

namespace ValidadorFiscalAFRFB
{
    public partial class frmHome : Form
    {
        public frmHome()
        {
            InitializeComponent();
        }

        private void btnClieForLayout_Click(object sender, EventArgs e)
        {
            ClieEForm42 clieEForm42 = new ClieEForm42();
            clieEForm42.Show();
        }

        private void ativoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AtivoForm ativo = new AtivoForm();
            ativo.Show();
        }
    }
}
