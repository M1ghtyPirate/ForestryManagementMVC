using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionTotal
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public string? TreeQualityGroups { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
        public double? AvgQuality { get; set; }
        public bool? IsHigh { get; set; }
        public bool? IsDeciduous { get; set; }
        public double? AvgAge { get; set; }
        public Guid? TreeSpeciesID { get; set; }
        public string? TreeSpeciesName { get; set; }
        public int? RipeAge { get; set; }
        public double? TechnicalAge { get; set; }
    }
}
