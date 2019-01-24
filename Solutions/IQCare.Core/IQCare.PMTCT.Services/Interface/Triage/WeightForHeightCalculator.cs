﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IQCare.PMTCT.Services.Interface.Triage
{
    public class WeightForHeightCalculator : LmsZscoreAbstractCalculator, IZscoreCalculator
    {
        public bool IsValidScoreType(ZscoreType scoreType)
        {
            return scoreType == ZscoreType.WeightForHeight;
        }

        public double CalculateZscore(ZScoreCalculationInfo calculationInfo)
        {
            if (!IsValidScoreType(calculationInfo.ZscoreType))
                return 0;

            return CalculateZscore(calculationInfo.Weight, calculationInfo.LmsParameter.Median, 
                calculationInfo.LmsParameter.Lambda, calculationInfo.LmsParameter.Sigma);
        }
    }
}
