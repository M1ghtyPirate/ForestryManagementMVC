using ForestryWeb.Models.Database.Tables;
using ForestryWeb.Models.Database.Views;
using Microsoft.EntityFrameworkCore;

namespace ForestryWeb.Models.Database
{
    public class ApplicationContext : DbContext
    {
        public DbSet<Forestry> Forestries { get; set; } = null!;
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<ForestryAreas> view_ForestryAreas { get; set; } = null!;
        public DbSet<ForestryAreasPercentage> view_ForestryAreasPercentage { get; set; } = null!;

        public ApplicationContext(DbContextOptions<ApplicationContext> options) : base(options)
        {
            //Database.EnsureCreated();
        }

    }
}
