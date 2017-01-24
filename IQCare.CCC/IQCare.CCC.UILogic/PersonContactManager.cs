﻿using System;
using System.Collections.Generic;
using Application.Common;
using Application.Presentation;
using Entities.Common;
using Interface.CCC;

namespace IQCare.CCC.UILogic
{
    public class PersonContactManager
    {
        private int _result;
        IPersonContactManager _mgr =  (IPersonContactManager) ObjectFactory.CreateInstance("BusinessProcess.CCC.BPersonContactManager, BusinessProcess.CCC");

        public int AddPersonContact(int personId, string physicalAddress, string mobileNumber)
        {
            Utility x = new Utility();

            PersonContact personContact = new PersonContact
            {
                PersonId = personId,
                PhysicalAddress = x.Encrypt(physicalAddress),
                MobileNumber = x.Encrypt(mobileNumber)
            };

            _result = _mgr.AddPersonContact(personContact);

            return _result;
        }

        public int DeletePersonContact(int id)
        {
            return _result = _mgr.DeletePersonContact(id);
        }

        public int UpdatePatientContact(PersonContact personContact)
        {
           return  _result= _mgr.UpdatePersonContact(personContact);
        }

        public List<PersonContact> GetPersonContactList(int personId)
        {
            List<PersonContact> myList=new List<PersonContact>();
            try
            {
                myList = _mgr.GetAllPersonContact(personId);
            }
            catch (Exception)
            {
                
                throw;
            }

            return myList;
        }
    }
}
