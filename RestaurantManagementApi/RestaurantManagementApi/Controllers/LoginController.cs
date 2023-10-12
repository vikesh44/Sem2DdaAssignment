using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using RestaurantManagementApi.DTO;
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

            List<PersonLoginDetail> result = await DbHelper.Instance.GetData<PersonLoginDetail>("SSP_ValidateUser", parameters);

            if (result == null || 
                result.Count < 1 || 
                result[0] == null ||
                string.IsNullOrEmpty(result[0].FirstName))
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
                    new Claim ("FirstName", result[0].FirstName),
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

                return Ok(new UserLogin(result[0].PersonId, result[0].FirstName, jwtToken));
            }
        }
    }

    public class UserLogin
    {
        public UserLogin(long personId, string personName, string accessToken)
        {
            PersonId = personId;
            PersonName = personName;
            AccessToken = accessToken;
        }
        public long PersonId { get; set; }
        public string PersonName { get; set; }
        public string AccessToken { get; set; }
    }
}
