using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class EmailCreditentials
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? EmailCreditentialsID { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string SMTPHost { get; set; }
        public int SMTPPort { get; set; }
        public bool EnableSSL { get; set; }
        public int EmailType { get; set; }
    }
}
