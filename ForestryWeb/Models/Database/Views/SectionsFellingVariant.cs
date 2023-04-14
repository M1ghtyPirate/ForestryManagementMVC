using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionsFellingVariant
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
        public double? AvgGrowth { get; set; }
        public int? MainFellingAge { get; set; }
        public int? MainFellingAgeClass { get; set; }
        public double? AvgOperationalVolumePerHectare { get; set; }
        public double? OverdueVolume { get; set; }
        public double? OverdueArea { get; set; }
        public double? FellingRipeArea { get; set; }
        public double? FellingRipeVolume { get; set; }
        public double? FellingAgeFirstArea { get; set; }
        public double? FellingAgeFirstVolume { get; set; }
        public double? FellingAgeSecondArea { get; set; }
        public double? FellingAgeSecondVolume { get; set; }
        public double? FellingAvgGrowthArea { get; set; }
        public double? FellingAvgGrowthVolume { get; set; }
        public double? FellingStateArea { get; set; }
        public double? FellingStateVolume { get; set; }
        public double? FellingCycleArea { get; set; }
        public double? FellingCycleVolume { get; set; }
        public double? FellingOperationalArea { get; set; }
        public double? FellingOperationalVolume { get; set; }
    }
}
