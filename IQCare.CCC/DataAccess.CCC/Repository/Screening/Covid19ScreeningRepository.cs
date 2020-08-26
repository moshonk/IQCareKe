using DataAccess.CCC.Context;
using DataAccess.CCC.Interface;
using DataAccess.Context;
using Entities.CCC;
using Entities.CCC.Screening;

namespace DataAccess.CCC.Repository.Screening
{
    public class Covid19ScreeningRepository:BaseRepository<Covid19Screening>,ICovid19ScreeningRepository
    {
        private GreencardContext _context;

        public Covid19ScreeningRepository():this(new GreencardContext())
        {

        }

        public Covid19ScreeningRepository(GreencardContext context) : base(context)
        {
            _context = context;
        }
    }
}
