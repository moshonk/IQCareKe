﻿
using System;
using Entities.Common;
using System.Collections.Generic;
namespace Entities.FormBuilder
{
    [Serializable]
    public class FormTab : BaseObject
    {
        /// <summary>
        /// Gets or sets the rank.
        /// </summary>
        /// <value>
        /// The rank.
        /// </value>
        public double Rank { get; set; }
        /// <summary>
        /// Gets or sets a value indicating whether [grid view].
        /// </summary>
        /// <value>
        ///   <c>true</c> if [grid view]; otherwise, <c>false</c>.
        /// </value>
        public bool Signature { get; set; }
        /// <summary>
        /// Gets or sets the form identifier.
        /// </summary>
        /// <value>
        /// The form identifier.
        /// </value>
        public virtual int FormId { get; set; }
        /// <summary>
        /// Gets or sets the form.
        /// </summary>
        /// <value>
        /// The form.
        /// </value>
        public virtual FormObject Form { get; set; }

        public virtual List<FormSection> Section { get; set; }
    }
}
