using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ValidadorFiscalAFRFB.Modelos;

namespace ValidadorFiscalAFRFB.Validador
{
    public class ValidacaoClieFor
    {        
        private Stream Arquivo { get; set; }
        private string file;
        public List<LayoutClieFor> Titulos { get; set; }
        public List<LayoutClieForMovimentacao> Movimentacao { get; set; }


        public ValidacaoClieFor(string fileName)
        {
            this.file = fileName;
        }

        public bool Exists()=>File.Exists(this.file);


        /// <summary>
        /// Intercala os Arquivos 
        /// </summary>
        public async Task Intercalar(ProgressBar tbar)
        {
            tbar.Maximum = Titulos.Count;
            foreach (var titulo  in Titulos)
            {
                titulo.Movimentacao = Movimentacao
                                        .Where(m => m.CodigoParticipante == titulo.CodigoParticipante &&
                                        m.NumeroDocumento == titulo.NumeroDocumento).ToList();

                foreach (var item in titulo.Movimentacao)
                {
                    item.Id = titulo.Id;
                }

                tbar.Value++;
                                                  
            }
            tbar.Value = 0;
            
        }




        /// <summary>
        /// Faz a leitura do Arquivo
        /// </summary>
        /// <returns></returns>
        public async Task LerDados()
        {
            

            using (this.Arquivo = File.Open(this.file, FileMode.Open))
            {
                using (StreamReader leitor = new StreamReader(Arquivo))
                {
                    
                    string linha = await Task.Run(() => leitor.ReadLineAsync()); //Primeira Linha                     

                    this.Titulos = new List<LayoutClieFor>();
                    this.Movimentacao = new List<LayoutClieForMovimentacao>();

                    while (linha != null)
                    {
                      
                        if (linha.Substring(117, 1) == "C")
                        {
                            this.Titulos.Add(new LayoutClieFor()
                            {
                                Id = GetNextId(),
                                CodigoContaAnalitica = linha.Substring(0, 27),
                                CodigoParticipante = linha.Substring(28, 14),
                                DataOperacao = linha.Substring(42, 8),
                                Historico = linha.Substring(50, 50),
                                ValorDaOpercao = linha.Substring(100, 17),
                                TipoOperacao = linha.Substring(117, 1),
                                TipoDocumento = linha.Substring(118, 3),
                                NumeroDocumento = linha.Substring(121, 12),
                                ValorOriginal = linha.Substring(133, 17),
                                DataEmissao = linha.Substring(150, 8),
                                DataVencimento = linha.Substring(158, 8),
                                NumeroArquivamento = linha.Substring(166, 12)

                            });
                        }
                        else
                        {
                           
                            Movimentacao.Add(new LayoutClieForMovimentacao()
                            {                                
                                CodigoContaAnalitica = linha.Substring(0, 27),
                                CodigoParticipante = linha.Substring(28, 14),
                                DataOperacao = linha.Substring(42, 8),
                                Historico = linha.Substring(50, 50),
                                ValorDaOpercao = linha.Substring(100, 17),
                                TipoOperacao = linha.Substring(117, 1),
                                TipoDocumento = linha.Substring(118, 3),
                                NumeroDocumento = linha.Substring(121, 12),
                                ValorOriginal = linha.Substring(133, 17),
                                DataEmissao = linha.Substring(150, 8),
                                DataVencimento = linha.Substring(158, 8),
                                NumeroArquivamento = linha.Substring(166, 12)
                            });
                        }


                        linha = await Task.Run(() => leitor.ReadLineAsync());
                    }
                }
            }
        }

        private int GetNextId()
        {
            if (Titulos==null)
            {
                return 0;
            }
            return Titulos.Count();
        }
    }
}
