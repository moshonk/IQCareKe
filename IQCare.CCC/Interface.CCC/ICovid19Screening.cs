using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.CCC;

namespace Interface.CCC
{
    public interface ICovid19Screening
    {
        Covid19Screening SaveCovid19Screening(Covid19Screening covid19Screening);
        void UpdateCovid19Screening(Covid19Screening covid19Screening);
        Covid19Screening getScreeningByDocumentId(String documentId);

    }
}
