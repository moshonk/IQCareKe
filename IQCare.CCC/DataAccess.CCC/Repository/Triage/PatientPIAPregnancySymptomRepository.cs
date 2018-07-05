using DataAccess.CCC.Context;
using DataAccess.CCC.Interface.Triage;
using DataAccess.Context;
using Entities.CCC.Triage;

namespace DataAccess.CCC.Repository.Triage
{

    public class PatientPIAPregnancySymptomRepository : BaseRepository<PatientPIAPregnancySymptom>, IPatientPIAPregnancySymptomRepository
    {
        private readonly GreencardContext _context;

        public PatientPIAPregnancySymptomRepository() : this(new GreencardContext())
        {

        }

        public PatientPIAPregnancySymptomRepository(GreencardContext context) : base(context)
        {
            _context = context;
        }
    }
}
