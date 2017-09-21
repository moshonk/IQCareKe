﻿using System;
using System.Collections.Generic;
using Application.Presentation;
using DataAccess.Base;
using Interface.Interop;
using IQCare.CCC.UILogic.Interoperability;
using IQCare.DTO;
using IQCare.Events;
using IQCare.Web.ApiLogic.Infrastructure.Interface;
using IQCare.Web.ApiLogic.Model;
using IQCare.Web.MessageProcessing.JsonEntityMapper;
using Newtonsoft.Json;

namespace IQCare.Web.ApiLogic.MessageHandler
{
    public class OutgoingMessageService : ProcessBase, IOutgoingMessageService, ISendData
    {
        private readonly IJsonEntityMapper _jsonEntityMapper;
        IApiOutboxManager _apiOutboxManager = (IApiOutboxManager)ObjectFactory.CreateInstance("IQCare.Web.API.BusinessProcess.BPApiOutbox, IQCare.Web.API");


        //public event InteropEventHandler OnDataExchage;


        ////public event InteropEventHandler ILHandler;

        ////protected virtual void OnInterop(IlMessageEventArgs e)
        ////{
        ////    Handle(e);


        ////}
        //IDataExchange d;//= dataExchange;
        ////public OutgoingMessageService(IDataExchange dataExchange)
        ////{
        ////    IDataExchange d = dataExchange;
        ////    d.OnDataExchage += D_OnDataExchage; 
        ////}

        //private void D_OnDataExchage(MessageEventArgs e)
        //{
        //    Handle(e);
        //}
        //public void Subscribe(Publisher p)
        //{
        //    p.DataExchangeEvent += OnDataExchangeEvent;
        //}

        //private void OnDataExchangeEvent(object sender, MessageEventArgs args)
        //{
        //    Handle(args);
        //}


        //public void OnNotification(IDataExchange dataExchange)
        //{
        //    d = dataExchange;
        //    d.OnDataExchage += D_OnDataExchage;
        //}

        //public void NotifyListeners()
        //{
        //    throw new System.NotImplementedException();
        //}
        public OutgoingMessageService()
        {
            _jsonEntityMapper = new JsonEntityMapper();
        }


        public OutgoingMessageService(IJsonEntityMapper jsonEntityMapper)
        {
            _jsonEntityMapper = jsonEntityMapper;
        }

        public  void Handle(MessageEventArgs messageEvent)
        {
            switch (messageEvent.MessageType)
            {
                case MessageType.NewClientRegistration:
                    HandleNewClientRegistration(messageEvent);
                    break;

                case MessageType.PatientTransferIn:
                    HandlePatientTransferIn(messageEvent);
                    break;

                case MessageType.UpdatedClientInformation:
                    HandleUpdatedClientInformation(messageEvent);
                    break;

                case MessageType.PatientTransferOut:
                    HandlePatientTransferOut(messageEvent);
                    break;

                case MessageType.RegimenChange:
                    HandleRegimenChange(messageEvent);
                    break;

                case MessageType.StopDrugs:
                    HandleStopDrugs(messageEvent);
                    break;

                case MessageType.DrugPrescriptionRaised:
                    HandleDrugPrescriptionRaised(messageEvent);
                    break;

                case MessageType.DrugOrderCancel:
                    HandleDrugOrdercancel(messageEvent);
                    break;

                case MessageType.DrugOrderFulfilment:
                    HandleDrugOrderFulfilment(messageEvent);
                    break;

                case MessageType.AppointmentScheduling:
                    HandleAppointmentScheduling(messageEvent);
                    break;

                case MessageType.AppointmentUpdated:
                    HandleAppointmentUpdated(messageEvent);
                    break;

                case MessageType.AppointmentRescheduling:
                    HandleAppointmentRescheduling(messageEvent);
                    break;

                case MessageType.AppointmentCanceled:
                    HandleAppointmentCancelled(messageEvent);
                    break;

                case MessageType.AppointmentHonored:
                    HandleAppointmentHonored(messageEvent);
                    break;

                case MessageType.UniquePatientIdentification:
                    HandleUniquePatientIdentification(messageEvent);
                    break;

                case MessageType.ViralLoadLabOrder:
                    HandleViralLoadLabOrder(messageEvent);
                    break;

                case MessageType.ViralLoadResults:
                    HandleNewViralLoadResults(messageEvent);
                    break;
            }
        }

        private void HandleNewClientRegistration(MessageEventArgs messageEvent)
        {
            var processRegistration = new ProcessRegistration();
            var registrationDto = processRegistration.Get(messageEvent.PatientId);
            var registrationEntity = _jsonEntityMapper.PatientRegistration(registrationDto);
            string registrationJson = JsonConvert.SerializeObject(registrationEntity);
            //save/send
            var apiOutbox = new ApiOutbox()
            {
                DateRead = DateTime.Now,
                Message = registrationJson

            };

            _apiOutboxManager.AddApiOutbox(apiOutbox);
            //Send
            SendData(registrationJson,"");

        }
        public void SendData(string jsonString, string endPoint)
        {
            ISendData mgr = (ISendData)ObjectFactory.CreateInstance("BusinessProcess.Interop.TcpDataExchange, BusinessProcess.Interop");
            mgr.SendData(jsonString, "");
        }
        private void HandlePatientTransferIn(MessageEventArgs messageEvent)
        {

        }

        private void HandleUpdatedClientInformation(MessageEventArgs messageEvent)
        {

        }

        private void HandlePatientTransferOut(MessageEventArgs messageEvent)
        {

        }

        private void HandleRegimenChange(MessageEventArgs messageEvent)
        {

        }

        private void HandleStopDrugs(MessageEventArgs messageEvent)
        {

        }

        private void HandleDrugPrescriptionRaised(MessageEventArgs messageEvent)
        {
            try
            {
                var prescriptionManager = new DrugPrescriptionMessage();

                var messageDto = prescriptionManager.GetPrescriptionMessage(messageEvent.EntityId, messageEvent.PatientId);
                List<PharmacyEncodedOrder> encorderOrder=new List<PharmacyEncodedOrder>();

                foreach (var message in messageDto)
                {
                    var messageOrder=new PharmacyEncodedOrder()
                    {
                        DrugName = message.DRUG_NAME,
                        CodingSystem = message.CODING_SYSTEM,
                        Strength = message.STRENGTH,
                        Dosage = message.DOSAGE,
                        Frequency = message.FREQUENCY,
                        Duration = message.DURATION,
                        QuantityPrescribed = Convert.ToInt32(message.QUANTITY_PRESCRIBED),
                        PrescriptionNotes = message.NOTES
                    };
                    encorderOrder.Add(messageOrder);
                }

                
                var drugOrderDto = new PrescriptionDto()
                {
                    InternalPatientIdentifier =
                    {
                        IdentifierType = messageDto[0].IDENTIFIER_TYPE,
                        IdentifierValue = messageDto[0].Id,
                        AssigningAuthority = "CCC"
                        
                    },
                    Patientname =
                    {
                        FirstName = messageDto[0].FIRST_NAME,
                        MiddleName = messageDto[0].MIDDLE_NAME,
                        LastName = messageDto[0].LAST_NAME
                    },
                    CommonOrderDetails =
                    {
                        OrderControl = messageDto[0].ORDER_CONTROL,
                        PlacerOrderNumber =
                        {
                            Number = messageDto[0].NUMBER,
                            Entity = "IQCare"
                        },
                        OrderStatus = messageDto[0].ORDER_STATUS,
                        OrderingPhysician =
                        {
                            FirstName = "",MiddleName = "",LastName = ""
                        },
                        TransactionDatetime = messageDto[0].TRANSACTION_DATETIME,
                        Notes = messageDto[0].NOTES
                    },
                    PharmacyEncodedOrder =encorderOrder   
                };

                var prescriptionEntity = _jsonEntityMapper.DrugPrescriptionRaised(drugOrderDto);

                string prescriptionJson = JsonConvert.SerializeObject(prescriptionEntity);
                   var apiOutbox = new ApiOutbox()
                   {
                       DateRead = DateTime.Now,
                       Message = prescriptionJson,

                   };

                _apiOutboxManager.AddApiOutbox(apiOutbox);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
               throw;
            }
        }

        private void HandleDrugOrdercancel(MessageEventArgs messageEvent)
        {

        }

        private void HandleDrugOrderFulfilment(MessageEventArgs messageEvent)
        {

        }

        private void HandleAppointmentScheduling(MessageEventArgs messageEvent)
        {

        }

        private void HandleAppointmentUpdated(MessageEventArgs messageEvent)
        {

        }

        private void HandleAppointmentRescheduling(MessageEventArgs messageEvent)
        {

        }

        private void HandleAppointmentHonored(MessageEventArgs messageEvent)
        {

        }

        private void HandleAppointmentCancelled(MessageEventArgs messageEvent)
        {

        }

        private void HandleUniquePatientIdentification(MessageEventArgs messageEvent)
        {

        }

        private void HandleViralLoadLabOrder(MessageEventArgs messageEvent)
        {

        }

        private void HandleNewViralLoadResults(MessageEventArgs messageEvent)
        {

        }

        
    }
}
