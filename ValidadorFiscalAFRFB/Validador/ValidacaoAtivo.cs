using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ValidadorFiscalAFRFB.Modelos;

namespace ValidadorFiscalAFRFB.Validador
{
    public class ValidacaoAtivo
    {
        private Stream Arquivo { get; set; }
        private string file;

        public List<Ativo> Ativos { get; set; }

        public ValidacaoAtivo(string f)
        {
            this.file = f;
        }


        public async Task LerDados()
        {
            using (Arquivo = File.Open(this.file, FileMode.Open))
            {
                using (StreamReader leitor = new StreamReader(Arquivo))
                {
                    string linha = await Task.Run(() => leitor.ReadLineAsync());

                    this.Ativos = new List<Ativo>();

                    while (linha != null)
                    {
                        this.Ativos.Add(new Ativo()
                        {   
                            Id = GetNextId(),
                            NumeroDoBem = linha.Substring(0,19),
                            NaturezaBem = linha.Substring(20,1),
                            NumeroCadastroBem = linha.Substring(21,20),
                            IdentificacaoBem = linha.Substring(41,45),
                            CodigoConta = linha.Substring(86,28),
                            CodigoContaDepreciacao = linha.Substring(114,28),
                            DataAquisicao = linha.Substring(142,8),
                            TipoDocumeto = linha.Substring(150,3),
                            SerieDocumeto = linha.Substring(153,5),
                            NotaDocumento = linha.Substring(158,12),
                            ValorAquisicao = linha.Substring(170,17),
                            ValorReais = linha.Substring(187,17),
                            NumeroArquivamento = linha.Substring(204,12),
                            DataInicioDepreciacao = linha.Substring(216,8),
                            TaxaDepreciacao = linha.Substring(224,5),
                            DepreciacaoAcumulada = linha.Substring(229,17),
                            DepreciacaoLancada = linha.Substring(246,17),
                            DataDaBaixa = linha.Substring(263,8)
                        });

                        linha = await Task.Run(() => leitor.ReadLineAsync());
                    }
                }
            }
        }

        private int GetNextId()
        {
            if (Ativos == null)
            {
                return 0;
            }
            return Ativos.Count();
        }

    }
}
