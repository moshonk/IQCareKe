using DataAccess.CCC.Context;
using DataAccess.CCC.Interface.Triage;
using DataAccess.Context;
using Entities.CCC.Triage;

namespace DataAccess.CCC.Repository.Triage
{
    public class PatientPregnancyIntentionAssessmentRepository : BaseRepository<PatientPregnancyIntentionAssessment>, IPatientPregnancyIntentionAssessmentRepository
    {
        private GreencardContext _context;

        public PatientPregnancyIntentionAssessmentRepository() : this(new GreencardContext())
        {

        }

        public PatientPregnancyIntentionAssessmentRepository(GreencardContext context) : base(context)
        {
            _context = context;
        }
    }
}
