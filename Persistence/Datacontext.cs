using Domain;
using Microsoft.EntityFrameworkCore;

namespace Persistence
{
    public class Datacontext : DbContext
    {
        public Datacontext(DbContextOptions options) : base(options)
        {

        }

        public DbSet<Activity> Activities { get; set; }
    }
}
