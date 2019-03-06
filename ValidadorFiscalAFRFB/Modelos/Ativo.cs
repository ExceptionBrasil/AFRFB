using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ValidadorFiscalAFRFB.Factorys;

namespace ValidadorFiscalAFRFB.Modelos
{
    public class Ativo
    {
        public int Id { get; set; }
        public string NumeroDoBem { get; set; }
        public string NaturezaBem { get; set; }
        public string NumeroCadastroBem { get; set; }
        public string IdentificacaoBem { get; set; }
        public string CodigoConta { get; set; }
        public string CodigoContaDepreciacao { get; set; }
        public string DataAquisicao { get; set; }
        public DateTime DataAquisicaoFormatada
        {
            get
            {
                return this.DataAquisicao.GetDate();                
            }
        }
        public string TipoDocumeto { get; set; }
        public string SerieDocumeto { get; set; }
        public string NotaDocumento { get; set; }
        public string ValorAquisicao { get; set; }
        public decimal ValorAquisicaoFormatado
        {
            get
            {
                return this.ValorAquisicao.GetValue(2);                
            }
        }

        public string ValorReais { get; set; }
        public decimal ValorReaisFormatado
        {
            get
            {
                return this.ValorReais.GetValue(2);
            }
        }
        public string NumeroArquivamento { get; set; }

        public string DataInicioDepreciacao { get; set; }
        public DateTime DataInicioDepreciacaoFormatada
        {
            get
            {
                return this.DataInicioDepreciacao.GetDate();
            }
        }

        public string TaxaDepreciacao { get; set; }
        public decimal TaxaDepreciacaoFormatado
        {
            get
            {
                return this.TaxaDepreciacao.GetValue(2);
            }
        }


        public string DepreciacaoAcumulada { get; set; }
        public decimal DepreciacaoAcumuladaFormatado
        {
            get
            {
                return this.DepreciacaoAcumulada.GetValue(2);
            }
        }

        public string DepreciacaoLancada { get; set; }
        public decimal DepreciacaoLancadaFormatado
        {
            get
            {
                return this.DepreciacaoLancada.GetValue(2);
            }
        }

        public string DataDaBaixa { get; set; }
        public DateTime DataDaBaixaFormatada
        {
            get
            {
                return this.DataDaBaixa.GetDate();
            }
        }

    }
}
