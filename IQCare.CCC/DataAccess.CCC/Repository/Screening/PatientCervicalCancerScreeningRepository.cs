using DataAccess.CCC.Context;
using DataAccess.CCC.Interface;
using DataAccess.Context;
using Entities.CCC.Screening;

namespace DataAccess.CCC.Repository.Screening
{
    public class PatientCervicalCancerScreeningRepository:BaseRepository<PatientCervicalCancerScreening>,IPatientCervicalCancerScreeningRepository
    {
        private GreencardContext _context;

        public PatientCervicalCancerScreeningRepository():this(new GreencardContext())
        {

        }

        public PatientCervicalCancerScreeningRepository(GreencardContext context) : base(context)
        {
            _context = context;
        }
    }
}
