using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionFelling10YTotalArea
    {
        public Guid? ForestryID { get; set; }
        public string? ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public int? MainFellingAgeClass { get; set; }
        public int? MainFellingAge { get; set; }
        public double? FellingOperationalArea { get; set; }
        public bool? IsDeciduous { get; set; }
        public double? StartArea { get; set; }
        public double? OperationalArea { get; set; }
        [Column("10YFellingPart")]
        public double? _10YFellingPart { get; set; }
        [Column("10YFellingArea")]
        public double? _10YFellingArea { get; set; }
        public double? ResultArea { get; set; }
        public double? StartAreaDelta { get; set; }
        public double? ResultAreaDelta { get; set; }
    }
}
