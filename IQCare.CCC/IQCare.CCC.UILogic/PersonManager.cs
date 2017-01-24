﻿using System;
using System.Globalization;
using Entities.Common;
using Application.Presentation;
using Application.Common;
using BusinessProcess.CCC;
using Interface.CCC;

namespace IQCare.CCC.UILogic
{
    public class PersonManager
    {
        Utility util = new Utility();
        readonly TextInfo _textInfo = new CultureInfo("en-US", false).TextInfo;
        IPersonManager _mgr =  (IPersonManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPersonManager, BusinessProcess.CCC");

        public int AddPersonUiLogic(string firstName, string midName, string lastName, int gender, string nationalId,
            int userId)
        {
            int retval;

            try
            {
                Person p = new Person()
                {
                    FirstName = util.Encrypt(_textInfo.ToTitleCase(firstName)),
                    MidName = util.Encrypt(_textInfo.ToTitleCase(midName)),
                    LastName = util.Encrypt(_textInfo.ToTitleCase(lastName)),
                    Sex = gender,
                    NationalId = util.Encrypt(nationalId),
                    CreatedBy = userId

                };
                retval = _mgr.AddPerson(p);
                //HttpContext.Current.Session["PersonId"] = p.Id;
            }
            catch (Exception exception)
            {
                    
               throw new Exception(exception.Message);
            }

            return retval;
        }

        public void UpdatePerson(Person person,int id)
        {
            _mgr.UpdatePerson(person,id);
        }

        public void DeletePerson(int id)
        {
            IPersonManager mgr = (IPersonManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPersonManager, BusinessProcess.CCC");
            mgr.DeletePerson(id);  
        }

        public Person GetPerson(int id)
        {
            IPersonManager mgr = (IPersonManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPersonManager, BusinessProcess.CCC");
            Person p = mgr.GetPerson(id);
            p.FirstName = util.Decrypt(p.FirstName);
            return p;
        }
    }
}
