using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.DataSets
{
    public class UserInfoUpdate
    {
        public string CurrentPassword { get; set; }
        public string NewPassword { get; set; }
        public string Email { get; set; }
    }
}
