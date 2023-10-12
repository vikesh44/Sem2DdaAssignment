using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using RestaurantManagementApi.Helper;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace RestaurantManagementApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoginController : Controller
    {
        IConfiguration _configuration;

        public LoginController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost]
        public async Task<IActionResult> ValidateUser(string userName, string password)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@UserName", userName),
                new ProcedureParameter ("@Password", password)
            };

            string? result = await DbHelper.Instance.GetFirstRecord<string>("SSP_ValidateUser", parameters);

            if (string.IsNullOrEmpty(result))
            {
                return Unauthorized();
            }
            else
            {
                //Try 1
                var claims = new[]
                            {
                    new Claim (JwtRegisteredClaimNames.Sub, _configuration["Jwt:Subject"]),
                    new Claim (JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim (JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
                    new Claim ("FirstName", result),
                    new Claim ("UserName", userName),
                };

                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
                var signIn = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
                var token = new JwtSecurityToken(_configuration["Jwt:Issuer"],
                                                 _configuration["Jwt:Audience"],
                                                 claims,
                                                 expires: DateTime.UtcNow.AddMinutes(5),
                                                 signingCredentials: signIn);

                string jwtToken = new JwtSecurityTokenHandler().WriteToken(token);

                return Ok(new UserLogin(userName, result, jwtToken));
            }
        }
    }

    public class UserLogin
    {
        public UserLogin(string personId, string personName, string accessToken)
        {
            PersonId = personId;
            PersonName = personName;
            AccessToken = accessToken;
        }
        public string PersonId { get; set; }
        public string PersonName { get; set; }
        public string AccessToken { get; set; }
    }
}
