using System.Globalization;
using System.Net.NetworkInformation;
using System.Security.Principal;

using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using Microsoft.Identity.Client;
using ForestryWeb.Models.Database.DataSets;
using System.Security.Cryptography;
using System.Text;

namespace ForestryWeb.Utils
{
    public static class UserInfo
    {
        public static byte[] EncodePassword (string password, Guid? userID)
        {
            var textArr = Encoding.UTF8.GetBytes(password + userID);
            var sha256 = SHA256.Create();
            var hashArr = sha256.ComputeHash(textArr);
            return hashArr;
        }
        
    }
}
