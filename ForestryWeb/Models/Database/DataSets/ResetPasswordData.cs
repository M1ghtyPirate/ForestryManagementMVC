using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.DataSets
{
    public class ResetPasswordData
    {
        public Guid UserID { get; set; }
        public string ResetPassword { get; set; }
        public string NewPassword { get; set; }
    }
}
