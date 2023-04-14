using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionFellingPeriod
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public double? OperationalArea { get; set; }
        public double? OperationalVolume { get; set; }
        public double? FellingOperationalArea { get; set; }
        public double? FellingOperationalVolume { get; set; }
        public double? FellingOperationalPeriod { get; set; }
    }
}
