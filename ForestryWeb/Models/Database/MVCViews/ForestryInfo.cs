using System.ComponentModel.DataAnnotations.Schema;
using ForestryWeb.Models.Database.Tables;

namespace ForestryWeb.Models.Database.MVCViews
{
    public class ForestryInfo
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid? ForestryID { get; set; }
        public string Name { get; set; }
        public Guid AuthorID { get; set; }
        public string AuthorLogin { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime? CreationDate { get; set; }
        public DateTime? EditDate { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public bool? IsShared { get; set; }

        public ForestryInfo(Forestry forestry, User user)
        {
            ForestryID = forestry.ForestryID;
            Name = forestry.Name;
            AuthorID = forestry.AuthorID;
            AuthorLogin = user.Login;
            CreationDate = forestry.CreationDate;
            EditDate = forestry.EditDate;
            IsShared = forestry.IsShared;
        }
    }
}
