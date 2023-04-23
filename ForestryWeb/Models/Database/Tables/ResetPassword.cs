using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class ResetPassword
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? ResetPasswordID { get; set; }
        public Guid UserID { get; set; }
        public byte[] ResetPasswordHashed { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime? GenerationDate { get; set; }
    }
}
