using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ValidadorFiscalAFRFB.Factorys;

namespace ValidadorFiscalAFRFB.Modelos
{
    public class LayoutClieFor
    {

        public List<LayoutClieForMovimentacao> Movimentacao { get; set; }

        public int Id { get; set; }
        public string CodigoContaAnalitica { get; set; }
        public string CodigoParticipante { get; set; }
        public string DataOperacao { get; set; }

        public DateTime? DataOperacaoFormatada
        { get
            {
                return this.DataOperacao.GetDate();
            }
        }


        public string Historico { get; set; }
        public string ValorDaOpercao { get; set; }
        public decimal ValorDaOpercaoFormatado
        {
            get
            {
                return ValorDaOpercao.GetValue(2);
            }
        }

        public string TipoOperacao { get; set; }
        public string TipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public string ValorOriginal { get; set; }

        public decimal ValorOriginaFormatado
        {
            get
            {
                return this.ValorOriginal.GetValue(2);
            }
        }

        public string DataEmissao { get; set; }
        public DateTime DataEmissaoFormatada
        {
            get
            {


                return this.DataEmissao.GetDate();
            }
        }

        public string DataVencimento { get; set; }
        public DateTime DataVencimentoFormatada
        {
            get
            {
                return this.DataVencimento.GetDate();
            }
        }

        public string NumeroArquivamento { get; set; }




        

    }
}
