using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Views
{
    [Keyless]
    public class SectionMainFellingAgeCalc
    {
        public Guid ForestryID { get; set; }
        public string ForestryName { get; set; }
        public Guid SectionID { get; set; }
        public string SectionName { get; set; }
        public double? Area { get; set; }
        public double? Volume { get; set; }
        public double? TechnicalAge { get; set; }
        public int? OptimalFellingAge { get; set; }
        public double? TargetAge { get; set; }
        public int? TargetClass { get; set; }
        public int? RipeAge { get; set; }
        public double? LowerClassTargetArea { get; set; }
        public double? LowerClassAreaDiff { get; set; }
        public int? LowerClassMainFellingAge { get; set; }
        public double? TargetClassTargetArea { get; set; }
        public double? TargetClassAreaDiff { get; set; }
        public int? TargetClassMainFellingAge { get; set; }
        public double? HigherClassTargetArea { get; set; }
        public double? HigherClassAreaDiff { get; set; }
        public int? HigherClassMainFellingAge { get; set; }
        public int? MainFellingAge { get; set; }
        public int? MainFellingAgeClass { get; set; }
    }
}
