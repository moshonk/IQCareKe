using Interface.CCC.Screening;
using System;
using System.Collections.Generic;
using Entities.CCC.Screening;
using Application.Presentation;
using Interface.CCC;
using Entities.CCC;
using log4net.Repository.Hierarchy;
using log4net.Core;

namespace IQCare.CCC.UILogic.Screening
{
    public class Covid19ScreeningManager
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        private ICovid19Screening _Covid19Screening = (ICovid19Screening)ObjectFactory.CreateInstance("BusinessProcess.CCC.BCovid19Screening, BusinessProcess.CCC");

        public Covid19Screening AddUpdateCovid19Screening(Covid19Screening covid19Screening)
        {
            try
            {
                Covid19Screening covid19Screening1 = _Covid19Screening.getScreeningByDocumentId(covid19Screening.document_id);
                if (covid19Screening1 == null)
                {
                    return _Covid19Screening.SaveCovid19Screening(covid19Screening);
                }
                else
                {
                    covid19Screening.id = covid19Screening1.id;
                    _Covid19Screening.UpdateCovid19Screening(covid19Screening);
                    return covid19Screening;
                }

            }
            catch (Exception ex)
            {
                log.Error(ex.Message, ex);
                throw;
            }
        }
    }
}
