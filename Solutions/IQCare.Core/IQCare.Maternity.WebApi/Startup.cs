﻿using AutoMapper;
using IQCare.Maternity.BusinessProcess.Commands.Maternity;
using IQCare.Maternity.BusinessProcess.MapperProfiles;
using IQCare.Maternity.Infrastructure.Installers;
using IQCare.SharedKernel.Infrastructure.Helpers;
using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using static IQCare.SharedKernel.Infrastructure.Helpers.ConnectionStringBuilder;


namespace IQCareMaternityWebApi
{
    public class Startup
    {
        readonly string IQCareConnectionString = string.Empty;

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
            IQCareConnectionString = BuildConnectionString(Configuration, new ConnectionString());
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();
            services.AddMaternityDbContext(IQCareConnectionString);

            services.AddMediatR(typeof(AddMaternalPatientDeliveryInfoCommand).Assembly);
            services.AddAutoMapper(typeof(DeliveredBabyBirthInformationProfile).Assembly);
            services.AddCors();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseCors(builder => builder
               .AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader()
               .AllowCredentials());

            app.UseMvc();
        }
    }
}
