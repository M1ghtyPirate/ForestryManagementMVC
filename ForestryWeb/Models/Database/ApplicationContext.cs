using ForestryWeb.Models.Database.Tables;
using ForestryWeb.Models.Database.Views;
using Microsoft.EntityFrameworkCore;

namespace ForestryWeb.Models.Database
{
    public class ApplicationContext : DbContext
    {
        #region Tables

        public DbSet<AgeClass> AgeClasses { get; set; } = null!;
        public DbSet<ForestAreas> ForestAreas { get; set; } = null!;
        public DbSet<Forestry> Forestries { get; set; } = null!;
        public DbSet<GrowthRate> GrowthRate { get; set; } = null!;
        public DbSet<NonForestAreas> NonForestAreas { get; set; } = null!;
        public DbSet<ProductOutput> ProductOutput { get; set; } = null!;
        public DbSet<QualityClass> QualityClasses { get; set; } = null!;
        public DbSet<Section> Sections { get; set; } = null!;
        public DbSet<TreeAgeGroup> TreeAgeGroups { get; set; } = null!;
        public DbSet<TreeQualityGroup> TreeQualityGroups { get; set; } = null!;
        public DbSet<TreeSpecies> TreeSpecies { get; set; } = null!;
        public DbSet<User> Users { get; set; } = null!;

        #endregion

        #region Views

        public DbSet<AvgSectionGrowthCalc> view_AvgSectionGrowthCalc { get; set; } = null!;
        public DbSet<ForestryAreas> view_ForestryAreas { get; set; } = null!;
        public DbSet<ForestryAreasPercentage> view_ForestryAreasPercentage { get; set; } = null!;
        public DbSet<ForestryFellingPeriod> view_ForestryFellingPeriods { get; set; } = null!;
        public DbSet<ForestryFellingType> view_ForestryFellingTypes { get; set; } = null!;
        public DbSet<ForestryTreeSpecies> view_ForestryTreeSpecies { get; set; } = null!;
        public DbSet<ForestryTreeSpeciesTotal> view_ForestryTreeSpeciesTotal { get; set; } = null!;
        public DbSet<SectionAgeGroup> view_SectionAgeGroups { get; set; } = null!;
        public DbSet<SectionFelling10YAGFellingArea> view_SectionFelling10YAGFellingAreas { get; set; } = null!;
        public DbSet<SectionFelling10YAGMovementArea> view_SectionFelling10YAGMovementAreas { get; set; } = null!;
        public DbSet<SectionFelling10YAGRemainingArea> view_SectionFelling10YAGRemainingAreas { get; set; } = null!;
        public DbSet<SectionFelling10YAGResultArea> view_SectionFelling10YAGResultAreas { get; set; } = null!;
        public DbSet<SectionFelling10YAGStartArea> view_SectionFelling10YAGStartAreas { get; set; } = null!;
        public DbSet<SectionFelling10YTotalArea> view_SectionFelling10YTotalAreas { get; set; } = null!;
        public DbSet<SectionFellingAgeGroup> view_SectionFellingAgeGroups { get; set; } = null!;
        public DbSet<SectionFellingPart> view_SectionFellingParts { get; set; } = null!;
        public DbSet<SectionFellingType> view_SectionFellingTypes { get; set; } = null!;
        public DbSet<SectionFellingPeriod> view_SectionsFellingPeriods { get; set; } = null!;
        public DbSet<SectionsFellingVariant> view_SectionsFellingVariants { get; set; } = null!;
        public DbSet<SectionMainFellingAgeCalc> view_SectionsMainFellingAgeCalc { get; set; } = null!;
        public DbSet<SectionTotal> view_SectionsTotal { get; set; } = null!;
        public DbSet<TreeGroup> view_TreeGroups { get; set; } = null!;
        public DbSet<TreeAgeGroupTotal> view_TreeAgeGroupsTotal { get; set; } = null!;
        public DbSet<TreeForestryAgeGroupTotal> view_TreeForestryAgeGroupsTotal { get; set; } = null!;
        public DbSet<TreeForestryGroupTotal> view_TreeForestryGroupsTotal { get; set; } = null!;
        public DbSet<TreeQualityGroupTotal> view_TreeQualityGroupsTotal { get; set; } = null!;
        public DbSet<TreeSpeciesGroupTotal> view_TreeSpeciesGroupsTotal { get; set; } = null!;

        #endregion

        public ApplicationContext(DbContextOptions<ApplicationContext> options) : base(options)
        {
            //Database.EnsureCreated();
        }

    }
}
