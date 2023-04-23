using System.ComponentModel.DataAnnotations.Schema;

namespace ForestryWeb.Models.Database.Tables
{
    public class User
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? UserID { get; set; }
        public string Login { get; set; }
        [NotMapped]
        public string Password { get; set; }
        public string? Email { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime? RegDate { get; set; }
        public DateTime? LoginDate { get; set; }
        public bool IsAdmin { get; set; }
        public byte[] PasswordHashed { get; set; }
    }
}
