using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ValidadorFiscalAFRFB.Factorys
{
    public static class FormatFactory
    {
        /// <summary>
        /// converte a string em um valor do tipo decimal
        /// </summary>
        /// <param name="t">The t.</param>
        /// <returns></returns>
        public static decimal GetValue(this string t, int casas)
        {
            var valorDecimal = t.Substring(t.Length - casas, casas);
            var valorInteiro = t.Substring(0, t.Length - casas);
            var valorFormatado = valorInteiro + "," + valorDecimal;
            return (Convert.ToDecimal(valorFormatado));


        }

        public static DateTime GetDate(this string d)
        {
            var dia = d.Substring(0, 2);
            var mes = d.Substring(2, 2);
            var ano = d.Substring(4, 4);
            var dataTexto = dia + "-" + mes + "-" + ano;
            if (String.IsNullOrWhiteSpace(dia + mes + ano))
            {
                dataTexto = "01-01-1990";
            }

            return Convert.ToDateTime(dataTexto);
        }
    }
}
