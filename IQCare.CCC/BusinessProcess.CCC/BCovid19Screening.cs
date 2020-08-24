using DataAccess.Base;
using DataAccess.CCC.Context;
using DataAccess.CCC.Repository;
using Entities.CCC;
using Interface.CCC;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessProcess.CCC
{
    public class BCovid19Screening : ProcessBase, ICovid19Screening
    {
        public Covid19Screening getScreeningByDocumentId(string documentId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var covid19Screening = unitOfWork.Covid19ScreeningRepository.FindBy(
                    x => x.document_id == documentId).FirstOrDefault();
                unitOfWork.Dispose();
                return covid19Screening;
            }
        }

        public Covid19Screening SaveCovid19Screening(Covid19Screening covid19Screening)
        {
            try
            {
                using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
                {
                    unitOfWork.Covid19ScreeningRepository.Add(covid19Screening);
                    unitOfWork.Complete();
                    unitOfWork.Dispose();

                    return covid19Screening;
                }

            }
            catch (DbUpdateException)
            {
                throw;
            }        
        }

        public void UpdateCovid19Screening(Covid19Screening covid19Screening)
        {
            try
            {
                using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
                {
                    unitOfWork.Covid19ScreeningRepository.Update(covid19Screening);
                    unitOfWork.Complete();
                    unitOfWork.Dispose();
                }
            }
            catch (DbUpdateException)
            {

                throw;
            }
        }
    }
}
