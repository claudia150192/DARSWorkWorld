class AddRvaIndivProvAuxGrantPaymentAmtThruRvaCaidCoupleCountIncomeAmtWebVaCalcsToNumericResults < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  

  @BobWebSsiWiCalcSheetDisplay = WebNumericalResultsGroup.find_by_name('Testing WebSsiWiCalc variables') 
#to be added
#R_VA_IndivProvAuxGrantPaymentAmt   NoteVA_RateAGPersonalAllowance table needs to be set up
#R_VA_CoupleProvAuxGrantPaymentAmt
#R_VA_ProvAuxGrantPaymentAmt
#RTotCountIncFBRExceedAmt
#R_VA_AuxGrantPaymentAmt
#R_VA_CaidUnearnNoDeemAmt
#R_VA_CaidDeemedAmt
#R_VA_CaidUnearnAmt
#R_VA_CaidEarnAmt
#R_VA_CaidGrossIncomeAmt
#R_VA_CaidSpouseUnearnAmt
#R_VA_CaidSpouseEarnAmt
#R_VA_CaidSpouseGrossIncomeAmt
#R_VA_CaidCoupleEarnAmt
#R_VA_CaidCoupleUnearnAmt
#R_VA_CaidCoupleGrossIncomeAmt
#R_VA_CaidCountUnearnNoNeedIncomeAmt
#RateGeneralExclusion
#RateEarnedIncomeDisregard
#R_VA_CaidExcessGenExclude
#R_VA_CaidCountEarnAmtNoDivide
#R_VA_CaidCountEarnAmtNoBWE
#R_VA_CaidCountEarnAmt
#VA_CaidCountIncomeAmtNoPASS
#R_VA_CaidCountIncomeAmt
#R_VA_CaidSpouseExcessUserGenExclude
##R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt 
#R_VA_CaidSpouseCountUnearnAmt
#R_VA_CaidExcessGenExclude
#R_VA_CaidSpouseExcessUserGenExclude
# XX  What a huge amount of grief here, something went haywire and had to redo and insert healing code inside some of these migrations.

#R_VA_CaidSpouseUnusedGenExclude
#R_VA_CaidSpouseExcessUserEarnedIncomeDisregard
#R_VA_CaidSpouseCountEarnAmtNoDivide
#R_VA_CaidSpouseCountEarnAmtNoBWE
#R_VA_CaidSpouseCountEarnAmtNoBWE
#R_VA_CaidSpouseCountEarnAmt
#R_VA_CaidSpouseCountIncomeAmtNoPASS
#R_VA_CaidSpouseCountIncomeAmt
#R_VA_CaidCoupleCountUnearnAmt
#R_VA_CaidCoupleCountEarnAmt
#R_VA_CaidCoupleCountIncomeAmt

@R_VA_IndivProvAuxGrantPaymentAmt                = WebNumericalResult.find_by_name('R_VA_IndivProvAuxGrantPaymentAmt')  
@R_VA_CoupleProvAuxGrantPaymentAmt               = WebNumericalResult.find_by_name('R_VA_CoupleProvAuxGrantPaymentAmt')
@R_VA_ProvAuxGrantPaymentAmt                     = WebNumericalResult.find_by_name('R_VA_ProvAuxGrantPaymentAmt')
@RTotCountIncFBRExceedAmt                        = WebNumericalResult.find_by_name('RTotCountIncFBRExceedAmt')
@R_VA_AuxGrantPaymentAmt                         = WebNumericalResult.find_by_name('R_VA_AuxGrantPaymentAmt')
@R_VA_CaidUnearnNoDeemAmt                        = WebNumericalResult.find_by_name('R_VA_CaidUnearnNoDeemAmt')
@R_VA_CaidDeemedAmt                              = WebNumericalResult.find_by_name('R_VA_CaidDeemedAmt')
@R_VA_CaidUnearnAmt                              = WebNumericalResult.find_by_name('R_VA_CaidUnearnAmt')
@R_VA_CaidEarnAmt                                = WebNumericalResult.find_by_name('R_VA_CaidEarnAmt')
@R_VA_CaidGrossIncomeAmt                         = WebNumericalResult.find_by_name('R_VA_CaidGrossIncomeAmt')
@R_VA_CaidSpouseUnearnAmt                        = WebNumericalResult.find_by_name('R_VA_CaidSpouseUnearnAmt')
@R_VA_CaidSpouseEarnAmt                          = WebNumericalResult.find_by_name('R_VA_CaidSpouseEarnAmt')
@R_VA_CaidSpouseGrossIncomeAmt                   = WebNumericalResult.find_by_name('R_VA_CaidSpouseGrossIncomeAmt')
@R_VA_CaidCoupleEarnAmt                          = WebNumericalResult.find_by_name('R_VA_CaidCoupleEarnAmt')
@R_VA_CaidCoupleUnearnAmt                        = WebNumericalResult.find_by_name('R_VA_CaidCoupleUnearnAmt')
@R_VA_CaidCoupleGrossIncomeAmt                   = WebNumericalResult.find_by_name('R_VA_CaidCoupleGrossIncomeAmt')
@R_VA_CaidCountUnearnNoNeedIncomeAmt             = WebNumericalResult.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt')
@RateGeneralExclusion                            = WebNumericalResult.find_by_name('RateGeneralExclusion')
@RateEarnedIncomeDisregard                       = WebNumericalResult.find_by_name('RateEarnedIncomeDisregard')
@R_VA_CaidExcessGenExclude                       = WebNumericalResult.find_by_name('R_VA_CaidExcessGenExclude')
@R_VA_CaidCountEarnAmtNoDivide                   = WebNumericalResult.find_by_name('R_VA_CaidCountEarnAmtNoDivide')
@R_VA_CaidCountEarnAmtNoBWE                      = WebNumericalResult.find_by_name('R_VA_CaidCountEarnAmtNoBWE')
@R_VA_CaidCountEarnAmt                           = WebNumericalResult.find_by_name('R_VA_CaidCountEarnAmt')
@VA_CaidCountIncomeAmtNoPASS                     = WebNumericalResult.find_by_name('VA_CaidCountIncomeAmtNoPASS')
@R_VA_CaidCountIncomeAmt                         = WebNumericalResult.find_by_name('R_VA_CaidCountIncomeAmt')
@R_VA_CaidSpouseExcessUserGenExclude             = WebNumericalResult.find_by_name('R_VA_CaidSpouseExcessUserGenExclude')
@R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt       = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt')

@R_VA_CaidSpouseCountUnearnAmt                   = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountUnearnAmt')
@R_VA_CaidSpouseUnusedGenExclude                 = WebNumericalResult.find_by_name('R_VA_CaidSpouseUnusedGenExclude')
@R_VA_CaidSpouseExcessUserEarnedIncomeDisregard  = WebNumericalResult.find_by_name('R_VA_CaidSpouseExcessUserEarnedIncomeDisregard')
@R_VA_CaidSpouseCountEarnAmtNoDivide             = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountEarnAmtNoDivide')
@R_VA_CaidSpouseCountEarnAmtNoBWE                = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountEarnAmtNoBWE')
@R_VA_CaidSpouseCountEarnAmt                     = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountEarnAmt')
@R_VA_CaidSpouseCountIncomeAmtNoPASS             = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountIncomeAmtNoPASS')
@R_VA_CaidSpouseCountIncomeAmt                   = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountIncomeAmt')
@R_VA_CaidCoupleCountUnearnAmt                   = WebNumericalResult.find_by_name('R_VA_CaidCoupleCountUnearnAmt')
@R_VA_CaidCoupleCountEarnAmt                     = WebNumericalResult.find_by_name('R_VA_CaidCoupleCountEarnAmt')
@R_VA_CaidCoupleCountIncomeAmt                   = WebNumericalResult.find_by_name('R_VA_CaidCoupleCountIncomeAmt')

@R_VA_IndivProvAuxGrantPaymentAmt               .delete unless @R_VA_IndivProvAuxGrantPaymentAmt.blank?
@R_VA_CoupleProvAuxGrantPaymentAmt              .delete unless @R_VA_CoupleProvAuxGrantPaymentAmt.blank?
@R_VA_ProvAuxGrantPaymentAmt                    .delete unless @R_VA_ProvAuxGrantPaymentAmt.blank?
@RTotCountIncFBRExceedAmt                       .delete unless @RTotCountIncFBRExceedAmt.blank?
@R_VA_AuxGrantPaymentAmt                        .delete unless @R_VA_AuxGrantPaymentAmt.blank?
@R_VA_CaidUnearnNoDeemAmt                       .delete unless @R_VA_CaidUnearnNoDeemAmt.blank?
@R_VA_CaidDeemedAmt                             .delete unless @R_VA_CaidDeemedAmt.blank?
@R_VA_CaidUnearnAmt                             .delete unless @R_VA_CaidUnearnAmt.blank?
@R_VA_CaidEarnAmt                               .delete unless @R_VA_CaidEarnAmt.blank?
@R_VA_CaidGrossIncomeAmt                        .delete unless @R_VA_CaidGrossIncomeAmt.blank?
@R_VA_CaidSpouseUnearnAmt                       .delete unless @R_VA_CaidSpouseUnearnAmt.blank?
@R_VA_CaidSpouseEarnAmt                         .delete unless @R_VA_CaidSpouseEarnAmt.blank?
@R_VA_CaidSpouseGrossIncomeAmt                  .delete unless @R_VA_CaidSpouseGrossIncomeAmt.blank?
@R_VA_CaidCoupleEarnAmt                         .delete unless @R_VA_CaidCoupleEarnAmt.blank?
@R_VA_CaidCoupleUnearnAmt                       .delete unless @R_VA_CaidCoupleUnearnAmt.blank?
@R_VA_CaidCoupleGrossIncomeAmt                  .delete unless @R_VA_CaidCoupleGrossIncomeAmt.blank?
@R_VA_CaidCountUnearnNoNeedIncomeAmt            .delete unless @R_VA_CaidCountUnearnNoNeedIncomeAmt.blank?
@RateGeneralExclusion                           .delete unless @RateGeneralExclusion.blank?
@RateEarnedIncomeDisregard                      .delete unless @RateEarnedIncomeDisregard.blank?
@R_VA_CaidExcessGenExclude                      .delete unless @R_VA_CaidExcessGenExclude.blank?
@R_VA_CaidCountEarnAmtNoDivide                  .delete unless @R_VA_CaidCountEarnAmtNoDivide.blank?
@R_VA_CaidCountEarnAmtNoBWE                     .delete unless @R_VA_CaidCountEarnAmtNoBWE.blank?
@R_VA_CaidCountEarnAmt                          .delete unless @R_VA_CaidCountEarnAmt.blank?
@VA_CaidCountIncomeAmtNoPASS                    .delete unless @VA_CaidCountIncomeAmtNoPASS.blank?
@R_VA_CaidCountIncomeAmt                        .delete unless @R_VA_CaidCountIncomeAmt.blank?
@R_VA_CaidSpouseExcessUserGenExclude            .delete unless @R_VA_CaidSpouseExcessUserGenExclude.blank?
@R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt      .delete unless @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.blank?
@R_VA_CaidSpouseCountUnearnAmt                  .delete unless @R_VA_CaidSpouseCountUnearnAmt.blank?

@R_VA_CaidSpouseUnusedGenExclude                .delete unless @R_VA_CaidSpouseUnusedGenExclude.blank?
@R_VA_CaidSpouseExcessUserEarnedIncomeDisregard .delete unless @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.blank?
@R_VA_CaidSpouseCountEarnAmtNoDivide            .delete unless @R_VA_CaidSpouseCountEarnAmtNoDivide.blank?
@R_VA_CaidSpouseCountEarnAmtNoBWE               .delete unless @R_VA_CaidSpouseCountEarnAmtNoBWE.blank?
@R_VA_CaidSpouseCountEarnAmt                    .delete unless @R_VA_CaidSpouseCountEarnAmt.blank?
@R_VA_CaidSpouseCountIncomeAmtNoPASS            .delete unless @R_VA_CaidSpouseCountIncomeAmtNoPASS.blank?
@R_VA_CaidSpouseCountIncomeAmt                  .delete unless @R_VA_CaidSpouseCountIncomeAmt.blank?
@R_VA_CaidCoupleCountUnearnAmt                  .delete unless @R_VA_CaidCoupleCountUnearnAmt.blank?
@R_VA_CaidCoupleCountEarnAmt                    .delete unless @R_VA_CaidCoupleCountEarnAmt.blank?
@R_VA_CaidCoupleCountIncomeAmt                  .delete unless @R_VA_CaidCoupleCountIncomeAmt.blank?


@Id = WebCalc.find_by_name('R_VA_IndivProvAuxGrantPaymentAmt')  
@R_VA_IndivProvAuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_IndivProvAuxGrantPaymentAmt', :text => 'R_VA_IndivProvAuxGrantPaymentAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 150, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CoupleProvAuxGrantPaymentAmt')
@R_VA_CoupleProvAuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_CoupleProvAuxGrantPaymentAmt', :text => 'R_VA_CoupleProvAuxGrantPaymentAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 152, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_ProvAuxGrantPaymentAmt')
@R_VA_ProvAuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_ProvAuxGrantPaymentAmt', :text => 'R_VA_ProvAuxGrantPaymentAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 154, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('RTotCountIncFBRExceedAmt')
@RTotCountIncFBRExceedAmt = WebNumericalResult.create!(:name => 'RTotCountIncFBRExceedAmt', :text => 'RTotCountIncFBRExceedAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 156, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_AuxGrantPaymentAmt')
@R_VA_AuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_AuxGrantPaymentAmt', :text => 'R_VA_AuxGrantPaymentAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 158, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidUnearnNoDeemAmt')
@R_VA_CaidUnearnNoDeemAmt = WebNumericalResult.create!(:name => 'R_VA_CaidUnearnNoDeemAmt', :text => 'R_VA_CaidUnearnNoDeemAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 160, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidDeemedAmt')
@R_VA_CaidDeemedAmt = WebNumericalResult.create!(:name => 'R_VA_CaidDeemedAmt', :text => 'R_VA_CaidDeemedAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 162, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidUnearnAmt')
@R_VA_CaidUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidUnearnAmt', :text => 'R_VA_CaidUnearnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 180, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidEarnAmt')
@R_VA_CaidEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidEarnAmt', :text => 'R_VA_CaidEarnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 182, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidGrossIncomeAmt')
@R_VA_CaidGrossIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidGrossIncomeAmt', :text => 'R_VA_CaidGrossIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 184, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseUnearnAmt')
@R_VA_CaidSpouseUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseUnearnAmt', :text => 'R_VA_CaidSpouseUnearnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 186, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseEarnAmt')
@R_VA_CaidSpouseEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseEarnAmt', :text => 'R_VA_CaidSpouseEarnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 190, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseGrossIncomeAmt')
@R_VA_CaidSpouseGrossIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseGrossIncomeAmt', :text => 'R_VA_CaidSpouseGrossIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 194, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCoupleEarnAmt')
@R_VA_CaidCoupleEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleEarnAmt', :text => 'R_VA_CaidCoupleEarnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 198, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCoupleUnearnAmt')
@R_VA_CaidCoupleUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleUnearnAmt', :text => 'R_VA_CaidCoupleUnearnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 200, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCoupleGrossIncomeAmt')
@R_VA_CaidCoupleGrossIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleGrossIncomeAmt', :text => 'R_VA_CaidCoupleGrossIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 206, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt')
@R_VA_CaidCountUnearnNoNeedIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountUnearnNoNeedIncomeAmt', :text => 'R_VA_CaidCountUnearnNoNeedIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 208, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('RateGeneralExclusion')
@RateGeneralExclusion = WebNumericalResult.create!(:name => 'RateGeneralExclusion', :text => 'RateGeneralExclusion',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 210, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('RateEarnedIncomeDisregard')
@RateEarnedIncomeDisregard = WebNumericalResult.create!(:name => 'RateEarnedIncomeDisregard', :text => 'RateEarnedIncomeDisregard',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 220, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidExcessGenExclude')
@R_VA_CaidExcessGenExclude = WebNumericalResult.create!(:name => 'R_VA_CaidExcessGenExclude', :text => 'R_VA_CaidExcessGenExclude',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 222, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCountEarnAmtNoDivide')
@R_VA_CaidCountEarnAmtNoDivide = WebNumericalResult.create!(:name => 'R_VA_CaidCountEarnAmtNoDivide', :text => 'R_VA_CaidCountEarnAmtNoDivide',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 240, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCountEarnAmtNoBWE')
@R_VA_CaidCountEarnAmtNoBWE = WebNumericalResult.create!(:name => 'R_VA_CaidCountEarnAmtNoBWE', :text => 'R_VA_CaidCountEarnAmtNoBWE',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 244, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCountEarnAmt')
@R_VA_CaidCountEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountEarnAmt', :text => 'R_VA_CaidCountEarnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 248, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('VA_CaidCountIncomeAmtNoPASS')
@VA_CaidCountIncomeAmtNoPASS = WebNumericalResult.create!(:name => 'VA_CaidCountIncomeAmtNoPASS', :text => 'VA_CaidCountIncomeAmtNoPASS',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 250, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCountIncomeAmt')
@R_VA_CaidCountIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountIncomeAmt', :text => 'R_VA_CaidCountIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 254, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserGenExclude')
@R_VA_CaidSpouseExcessUserGenExclude = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseExcessUserGenExclude', :text => 'R_VA_CaidSpouseExcessUserGenExclude',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 260, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt')
@R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt', :text => 'R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 264, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnAmt')
@R_VA_CaidSpouseCountUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountUnearnAmt', :text => 'R_VA_CaidSpouseCountUnearnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 266, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseUnusedGenExclude')
@R_VA_CaidSpouseUnusedGenExclude = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseUnusedGenExclude', :text => 'R_VA_CaidSpouseUnusedGenExclude',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 284, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserEarnedIncomeDisregard')
@R_VA_CaidSpouseExcessUserEarnedIncomeDisregard = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseExcessUserEarnedIncomeDisregard', :text => 'R_VA_CaidSpouseExcessUserEarnedIncomeDisregard',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 288, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoDivide')
@R_VA_CaidSpouseCountEarnAmtNoDivide = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountEarnAmtNoDivide', :text => 'R_VA_CaidSpouseCountEarnAmtNoDivide',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 290, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoBWE')
@R_VA_CaidSpouseCountEarnAmtNoBWE = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountEarnAmtNoBWE', :text => 'R_VA_CaidSpouseCountEarnAmtNoBWE',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 294, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmt')
@R_VA_CaidSpouseCountEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountEarnAmt', :text => 'R_VA_CaidSpouseCountEarnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 296, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmtNoPASS')
@R_VA_CaidSpouseCountIncomeAmtNoPASS = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountIncomeAmtNoPASS', :text => 'R_VA_CaidSpouseCountIncomeAmtNoPASS',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 300, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmt')
@R_VA_CaidSpouseCountIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountIncomeAmt', :text => 'R_VA_CaidSpouseCountIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 304, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCoupleCountUnearnAmt')
@R_VA_CaidCoupleCountUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleCountUnearnAmt', :text => 'R_VA_CaidCoupleCountUnearnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 306, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCoupleCountEarnAmt')
@R_VA_CaidCoupleCountEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleCountEarnAmt', :text => 'R_VA_CaidCoupleCountEarnAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 308, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


@Id = WebCalc.find_by_name('R_VA_CaidCoupleCountIncomeAmt')
@R_VA_CaidCoupleCountIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleCountIncomeAmt', :text => 'R_VA_CaidCoupleCountIncomeAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
RShowWorkVar = (RShowWorkVar.calculate manager)
if RShowWorkVar then
  true
else
 false
end", 
:order => 310, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)



 
  end

  def self.down
  end
end
