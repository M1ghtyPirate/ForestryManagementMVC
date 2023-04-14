using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionFellingAgeGroup
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public Guid AgeClassID { get; set; }
        public int AgeClass { get; set; }
        public bool? IsDeciduous { get; set; }
        public int Age { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
        public double? AvgGrowth { get; set; }
    }
}
