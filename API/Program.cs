using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.EntityFrameworkCore;
using Persistence;
using System.Linq.Expressions;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<Datacontext>(opt =>
{
    opt.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnection"));
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}



app.UseAuthorization();

app.MapControllers();
//jab hum normally ek service access krte hai na wo hum krte hai dependency injection bnake but abhi hum data context
//ka dependency injection nahi bnaa sakte hai toh humne aisa scope bnaa liya and using statement use
//kri because ek baari scope khatam hua toh ye apne aap clean krdegi
using var scope = app.Services.CreateScope();
var services = scope.ServiceProvider;
//abb hum try krenge database banane ka 
try
{
    var context = services.GetRequiredService<Datacontext>();
    await context.Database.MigrateAsync();
    await Seed.SeedData(context);

}
catch (Exception ex)
{

	var logger = services.GetRequiredService<ILogger<Program>>();
    logger.LogError(ex, "An error occured during migration");
}

app.Run();
