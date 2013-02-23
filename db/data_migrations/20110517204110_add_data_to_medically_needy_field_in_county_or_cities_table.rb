class AddDataToMedicallyNeedyFieldInCountyOrCitiesTable < ActiveRecord::Migration
  def self.up
 # @CountyOrCity_Start_Up_Information = CountyOrCity.find(:first, :conditions => ['name = ?', 'Start-Up Information'])
 # @CountyOrCity_Start_Up_Information.update_attribute(:reference_id, '1.0') unless @CountyOrCity_Start_Up_Information.blank?
 #Bedford City and Bedford County - Group I
 #Franklin City and Franklin County - Group I (distinguish city and county in list of localities)
 #Fairfax City and Faifax County - Group III
 #Poquoson City - Group II
 #Salem City - Group II
 #
 #Clifton Forge City - remove from list (relinquished city status in 2001 and is now a town in Alleghany County)
 

   @Accomack                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Accomack County'])         
   @Albemarle               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Albemarle County'])        
   @Alexandria              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Alexandria City'])         
   @Alleghany               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Alleghany County'])        
   @Amelia                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Amelia County'])           
   @Amherst                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Amherst County'])          
   @Appomattox              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Appomattox County'])       
   @Arlington               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Arlington County'])        
   @Augusta                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Augusta County'])          
   @Bath                    = CountyOrCity.find(:first, :conditions => ['name = ?', 'Bath County'])             
   @BedfordCity             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Bedford City'])            
   @BedfordCounty           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Bedford County'])          
   @Bland                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Bland County'])            
   @Botetourt               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Botetourt County'])        
   @Bristol                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Bristol City'])            
   @Brunswick               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Brunswick County'])        
   @Buchanan                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Buchanan County'])         
   @Buckingham              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Buckingham County'])       
   @Buena_Vista             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Buena Vista City'])        
   @Campbell                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Campbell County'])         
   @Caroline                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Caroline County'])         
   @Carroll                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Carroll County'])          
   @Charles_City            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Charles City County'])     
   @Charlotte               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Charlotte County'])        
   @Charlottesville         = CountyOrCity.find(:first, :conditions => ['name = ?', 'Charlottesville City'])    
   @Chesapeake              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Chesapeake City'])         
   @Chesterfield            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Chesterfield County'])     
   @Clarke                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Clarke County'])           
   @Colonial_Heights        = CountyOrCity.find(:first, :conditions => ['name = ?', 'Colonial Heights City'])        
   @Covington               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Covington City'])               
   @Craig                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Craig County'])            
   @Culpeper                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Culpeper County'])         
   @Cumberland              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Cumberland County'])       
   @Danville                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Danville City'])           
   @Dickenson               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Dickenson County'])        
   @Dinwiddie               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Dinwiddie County'])        
   @Emporia                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Emporia City'])            
   @Essex                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Essex County'])            
   @FairfaxCity             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Fairfax City'])            
   @FairfaxCounty           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Fairfax County'])          
   @Falls_Church            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Falls Church City'])       
   @Fauquier                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Fauquier County'])         
   @Floyd                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Floyd County'])            
   @Fluvanna                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Fluvanna County'])         
   @FranklinCity            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Franklin City'])           
   @FranklinCounty          = CountyOrCity.find(:first, :conditions => ['name = ?', 'Franklin County'])         
   @Frederick               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Frederick County'])        
   @Fredericksburg          = CountyOrCity.find(:first, :conditions => ['name = ?', 'Fredericksburg City'])          
   @Galax                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Galax City'])              
   @Giles                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Giles County'])            
   @Gloucester              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Gloucester County'])       
   @Goochland               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Goochland County'])        
   @Grayson                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Grayson County'])          
   @Greene                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Greene County'])           
   @Greensville             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Greensville County'])      
   @Halifax                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Halifax County'])          
   @Hampton                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Hampton City'])            
   @Hanover                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Hanover County'])          
   @Harrisonburg            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Harrisonburg City'])       
   @Henrico                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Henrico County'])          
   @Henry                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Henry County'])            
   @Highland                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Highland County'])         
   @Hopewell                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Hopewell City'])           
   @Isle_of_Wight           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Isle of Wight County'])    
   @James_City              = CountyOrCity.find(:first, :conditions => ['name = ?', 'James City County'])       
   @King_Queen              = CountyOrCity.find(:first, :conditions => ['name = ?', 'King and Queen County'])     
   @King_George             = CountyOrCity.find(:first, :conditions => ['name = ?', 'King George County'])      
   @King_William            = CountyOrCity.find(:first, :conditions => ['name = ?', 'King William County'])     
   @Lancaster               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Lancaster County'])        
   @Lee                     = CountyOrCity.find(:first, :conditions => ['name = ?', 'Lee County'])              
   @Lexington               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Lexington City'])          
   @Loudoun                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Loudoun County'])          
   @Louisa                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Louisa County'])           
   @Lunenburg               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Lunenburg County'])        
   @Lynchburg               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Lynchburg City'])          
   @Madison                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Madison County'])          
   @Manassas                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Manassas City'])           
   @Manassas_Park           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Manassas Park City'])      
   @Martinsville            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Martinsville City'])       
   @Mathews                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Mathews County'])          
   @Mecklenburg             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Mecklenburg County'])      
   @Middlesex               = CountyOrCity.find(:first, :conditions => ['name = ?', 'Middlesex County'])        
   @Montgomery              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Montgomery County'])       
   @Nelson                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Nelson County'])           
   @New_Kent                = CountyOrCity.find(:first, :conditions => ['name = ?', 'New Kent County'])         
   @Newport_News            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Newport News City'])       
   @Norfolk                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Norfolk City'])            
   @Northampton             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Northampton County'])      
   @Northumberland          = CountyOrCity.find(:first, :conditions => ['name = ?', 'Northumberland County'])   
   @Norton                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Norton City'])             
   @Nottoway                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Nottoway County'])         
   @Orange                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Orange County'])           
   @Page                    = CountyOrCity.find(:first, :conditions => ['name = ?', 'Page County'])             
   @Patrick                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Patrick County'])          
   @Petersburg              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Petersburg City'])         
   @Pittsylvania            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Pittsylvania County'])     
   @Poquoson_City           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Poquoson City'])          
   @Portsmouth              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Portsmouth City'])         
   @Powhatan                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Powhatan County'])         
   @Prince_Edward           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Prince Edward County'])    
   @Prince_George           = CountyOrCity.find(:first, :conditions => ['name = ?', 'Prince George County'])    
   @Prince_William          = CountyOrCity.find(:first, :conditions => ['name = ?', 'Prince William County'])   
   @Pulaski                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Pulaski County'])          
   @Radford                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Radford City'])            
   @Rappahannock            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Rappahannock County'])     
   @Richmond                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Richmond City'])           
   @Richmond_County         = CountyOrCity.find(:first, :conditions => ['name = ?', 'Richmond County'])         
   @Roanoke                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Roanoke City'])            
   @Roanoke_County          = CountyOrCity.find(:first, :conditions => ['name = ?', 'Roanoke County'])          
   @Rockbridge              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Rockbridge County'])       
   @Rockingham              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Rockingham County'])       
   @Russell                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Russell County'])          
   @Salem_City              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Salem City'])              
   @Scott                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Scott County'])            
   @Shenandoah              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Shenandoah County'])       
   @Smyth                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Smyth County'])     
   @Southampton             = CountyOrCity.find(:first, :conditions => ['name = ?', 'Southampton County'])      
   @Spotsylvania            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Spotsylvania County'])     
   @Stafford                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Stafford County'])         
   @Staunton                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Staunton City'])           
   @Suffolk                 = CountyOrCity.find(:first, :conditions => ['name = ?', 'Suffolk City'])            
   @Surry                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Surry County'])            
   @Sussex                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Sussex County'])           
   @Tazewell                = CountyOrCity.find(:first, :conditions => ['name = ?', 'Tazewell County'])         
   @Virginia_Beach          = CountyOrCity.find(:first, :conditions => ['name = ?', 'Virginia Beach City'])     
   @Warren                  = CountyOrCity.find(:first, :conditions => ['name = ?', 'Warren County'])           
   @Washington              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Washington County'])       
   @Waynesboro              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Waynesboro City'])         
   @Westmoreland            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Westmoreland County'])     
   @Williamsburg            = CountyOrCity.find(:first, :conditions => ['name = ?', 'Williamsburg City'])       
   @Winchester              = CountyOrCity.find(:first, :conditions => ['name = ?', 'Winchester City'])         
   @Wise                    = CountyOrCity.find(:first, :conditions => ['name = ?', 'Wise County'])             
   @Wythe                   = CountyOrCity.find(:first, :conditions => ['name = ?', 'Wythe County'])            
   @York                    = CountyOrCity.find(:first, :conditions => ['name = ?', 'York County'])             
  
  
   #Bedford City and Bedford County - Group I
    #Franklin City and Franklin County - Group I (distinguish city and county in list of localities)
    #Fairfax City and Faifax County - Group III
    #Poquoson City - Group II
    #Salem City - Group II
    #
    #@NSsdiEarnAmt  = WebCalc.find_by_name('nSsdiEarnAmt')
    #   @NSsdiEarnAmt.update_attribute(:name, 'NSsdiEarnAmt') unless @NSsdiEarnAmt.blank?
    
    #Clifton Forge City - remove from list (relinquished city status in 2001 and is now a town in Alleghany County)
    @Accomack.update_attribute(:medically_needy_group, '1') 
    @Albemarle.update_attribute(:medically_needy_group, '2') unless  @Albemarle.blank?	
    @Alexandria.update_attribute(:medically_needy_group, '3') unless  @Alexandria.blank?
    @Alleghany.update_attribute(:medically_needy_group, '1') unless  @Alleghany.blank?
    @Amelia.update_attribute(:medically_needy_group, '1') unless  @Amelia.blank?
    @Amherst.update_attribute(:medically_needy_group, '1') unless  @Amherst.blank?
    @Appomattox.update_attribute(:medically_needy_group, '1') unless  @Appomattox.blank?
    @Arlington.update_attribute(:medically_needy_group, '3') unless  @Arlington.blank?
    @Augusta.update_attribute(:medically_needy_group, '2') unless  @Augusta.blank?
    @Bath.update_attribute(:medically_needy_group, '1') unless  @Bath.blank?
    @BedfordCity.update_attribute(:medically_needy_group, '1') unless  @BedfordCity.blank?
    @BedfordCounty.update_attribute(:medically_needy_group, '1') unless  @BedfordCounty.blank?
    @Bland.update_attribute(:medically_needy_group, '1') unless  @Bland.blank?
    @Botetourt.update_attribute(:medically_needy_group, '1') unless  @Botetourt.blank?
    @Bristol.update_attribute(:medically_needy_group, '1') unless  @Bristol.blank?
    @Brunswick.update_attribute(:medically_needy_group, '1') unless  @Brunswick.blank?
    @Buchanan.update_attribute(:medically_needy_group, '1') unless  @Buchanan.blank?
    @Buckingham.update_attribute(:medically_needy_group, '1') unless  @Buckingham.blank?
    @Buena_Vista.update_attribute(:medically_needy_group, '1') unless  @Buena_Vista.blank?
    @Campbell.update_attribute(:medically_needy_group, '1') unless  @Campbell.blank?
    @Caroline.update_attribute(:medically_needy_group, '1') unless  @Caroline.blank?
    @Carroll.update_attribute(:medically_needy_group, '1') unless  @Carroll.blank?
    @Charles_City.update_attribute(:medically_needy_group, '1') unless  @Charles_City.blank?
    @Charlotte.update_attribute(:medically_needy_group, '1') unless  @Charlotte.blank?
    @Charlottesville.update_attribute(:medically_needy_group, '3') unless  @Charlottesville.blank?
    @Chesapeake.update_attribute(:medically_needy_group, '2') unless  @Chesapeake.blank?
    @Chesterfield.update_attribute(:medically_needy_group, '2') unless  @Chesterfield.blank?
    @Clarke.update_attribute(:medically_needy_group, '1') unless  @Clarke.blank?
    @Colonial_Heights.update_attribute(:medically_needy_group, '3') unless  @Colonial_Heights.blank?
    @Covington.update_attribute(:medically_needy_group, '2') unless  @Covington.blank?
    @Craig.update_attribute(:medically_needy_group, '1') unless  @Craig.blank?
    @Culpeper.update_attribute(:medically_needy_group, '1') unless  @Culpeper.blank?
    @Cumberland.update_attribute(:medically_needy_group, '1') unless  @Cumberland.blank?
    @Danville.update_attribute(:medically_needy_group, '1') unless  @Danville.blank?
    @Dickenson.update_attribute(:medically_needy_group, '1') unless  @Dickenson.blank?
    @Dinwiddie.update_attribute(:medically_needy_group, '1') unless  @Dinwiddie.blank?
    @Emporia.update_attribute(:medically_needy_group, '1') unless  @Emporia.blank?
    @Essex.update_attribute(:medically_needy_group, '1') unless  @Essex.blank?
    @FairfaxCity.update_attribute(:medically_needy_group, '3') unless  @FairfaxCity.blank?
    @FairfaxCounty.update_attribute(:medically_needy_group, '3') unless  @FairfaxCounty.blank?
    @Falls_Church.update_attribute(:medically_needy_group, '3') unless  @Falls_Church.blank?
    @Fauquier.update_attribute(:medically_needy_group, '1') unless  @Fauquier.blank?
    @Floyd.update_attribute(:medically_needy_group, '1') unless  @Floyd.blank?
    @Fluvanna.update_attribute(:medically_needy_group, '1') unless  @Fluvanna.blank?
    @FranklinCity.update_attribute(:medically_needy_group, '1') unless  @FranklinCity.blank?
    @FranklinCounty.update_attribute(:medically_needy_group, '1') unless  @FranklinCounty.blank?
    @Frederick.update_attribute(:medically_needy_group, '1') unless  @Frederick.blank?
    @Fredericksburg.update_attribute(:medically_needy_group, '3') unless  @Fredericksburg.blank?
    @Galax.update_attribute(:medically_needy_group, '1') unless  @Galax.blank?
    @Giles.update_attribute(:medically_needy_group, '1') unless  @Giles.blank?
    @Gloucester.update_attribute(:medically_needy_group, '1') unless  @Gloucester.blank?
    @Goochland.update_attribute(:medically_needy_group, '1') unless  @Goochland.blank?
    @Grayson.update_attribute(:medically_needy_group, '1') unless  @Grayson.blank?
    @Greene.update_attribute(:medically_needy_group, '1') unless  @Greene.blank?
    @Greensville.update_attribute(:medically_needy_group, '1') unless  @Greensville.blank?
    @Halifax.update_attribute(:medically_needy_group, '1') unless  @Halifax.blank?
    @Hampton.update_attribute(:medically_needy_group, '3') unless  @Hampton.blank?
    @Hanover.update_attribute(:medically_needy_group, '1') unless  @Hanover.blank?
    @Harrisonburg.update_attribute(:medically_needy_group, '2') unless  @Harrisonburg.blank?
    @Henrico.update_attribute(:medically_needy_group, '2') unless  @Henrico.blank?
    @Henry.update_attribute(:medically_needy_group, '1') unless  @Henry.blank?
    @Highland.update_attribute(:medically_needy_group, '1') unless  @Highland.blank?
    @Hopewell.update_attribute(:medically_needy_group, '2') unless  @Hopewell.blank?
    @Isle_of_Wight.update_attribute(:medically_needy_group, '1') unless  @Isle_of_Wight.blank?
    @James_City.update_attribute(:medically_needy_group, '1') unless  @James_City.blank?
    @King_Queen.update_attribute(:medically_needy_group, '1') unless  @King_Queen.blank?
    @King_George.update_attribute(:medically_needy_group, '1') unless  @King_George.blank?
    @King_William.update_attribute(:medically_needy_group, '1') unless  @King_William.blank?
    @Lancaster.update_attribute(:medically_needy_group, '1') unless  @Lancaster.blank?
    @Lee.update_attribute(:medically_needy_group, '1') unless  @Lee.blank?
    @Lexington.update_attribute(:medically_needy_group, '2') unless  @Lexington.blank?
    @Loudoun.update_attribute(:medically_needy_group, '2') unless  @Loudoun.blank?
    @Louisa.update_attribute(:medically_needy_group, '1') unless  @Louisa.blank?
    @Lunenburg.update_attribute(:medically_needy_group, '1') unless  @Lunenburg.blank?
    @Lynchburg.update_attribute(:medically_needy_group, '2') unless  @Lynchburg.blank?
    @Madison.update_attribute(:medically_needy_group, '1') unless  @Madison.blank?
    @Manassas.update_attribute(:medically_needy_group, '3') unless  @Manassas.blank?
    @Manassas_Park.update_attribute(:medically_needy_group, '3') unless  @Manassas_Park.blank?
    @Martinsville.update_attribute(:medically_needy_group, '2') unless  @Martinsville.blank?
    @Mathews.update_attribute(:medically_needy_group, '1') unless  @Mathews.blank?
    @Mecklenburg.update_attribute(:medically_needy_group, '1') unless  @Mecklenburg.blank?
    @Middlesex.update_attribute(:medically_needy_group, '1') unless  @Middlesex.blank?
    @Montgomery.update_attribute(:medically_needy_group, '3') unless  @Montgomery.blank?
    @Nelson.update_attribute(:medically_needy_group, '1') unless  @Nelson.blank?
    @New_Kent.update_attribute(:medically_needy_group, '1') unless  @New_Kent.blank?
    @Newport_News.update_attribute(:medically_needy_group, '2') unless  @Newport_News.blank?
    @Norfolk.update_attribute(:medically_needy_group, '2') unless  @Norfolk.blank?
    @Northampton.update_attribute(:medically_needy_group, '1') unless  @Northampton.blank?
    @Northumberland.update_attribute(:medically_needy_group, '1') unless  @Northumberland.blank?
    @Norton.update_attribute(:medically_needy_group, '1') unless  @Norton.blank?
    @Nottoway.update_attribute(:medically_needy_group, '1') unless  @Nottoway.blank?
    @Orange.update_attribute(:medically_needy_group, '1') unless  @Orange.blank?
    @Page.update_attribute(:medically_needy_group, '1') unless  @Page.blank?
    @Patrick.update_attribute(:medically_needy_group, '1') unless  @Patrick.blank?
    @Petersburg.update_attribute(:medically_needy_group, '2') unless  @Petersburg.blank?
    @Pittsylvania.update_attribute(:medically_needy_group, '1') unless  @Pittsylvania.blank?
    @Poquoson_City.update_attribute(:medically_needy_group, '2') unless  @Poquoson_City.blank?
                            
    @Portsmouth.update_attribute(:medically_needy_group, '2') unless  @Portsmouth.blank?
    @Powhatan.update_attribute(:medically_needy_group, '1') unless  @Powhatan.blank?
    @Prince_Edward.update_attribute(:medically_needy_group, '1') unless  @Prince_Edward.blank?
    @Prince_George.update_attribute(:medically_needy_group, '1') unless  @Prince_George.blank?
    @Prince_William.update_attribute(:medically_needy_group, '3') unless  @Prince_William.blank?
    @Pulaski.update_attribute(:medically_needy_group, '1') unless  @Pulaski.blank?
    @Radford.update_attribute(:medically_needy_group, '2') unless  @Radford.blank?
    @Rappahannock.update_attribute(:medically_needy_group, '1') unless  @Rappahannock.blank?
    @Richmond.update_attribute(:medically_needy_group, '2') unless  @Richmond.blank?
    @Richmond_County.update_attribute(:medically_needy_group, '1') unless  @Richmond_County.blank?
    @Roanoke.update_attribute(:medically_needy_group, '2') unless  @Roanoke.blank?
    @Roanoke_County.update_attribute(:medically_needy_group, '2') unless  @Roanoke_County.blank?
    @Rockbridge.update_attribute(:medically_needy_group, '1') unless  @Rockbridge.blank?
    @Rockingham.update_attribute(:medically_needy_group, '2') unless  @Rockingham.blank?
    @Russell.update_attribute(:medically_needy_group, '1') unless  @Russell.blank?
    @Salem_City.update_attribute(:medically_needy_group, '2') unless  @Salem_City.blank?
                            
    @Scott.update_attribute(:medically_needy_group, '1') unless  @Scott.blank?
    @Shenandoah.update_attribute(:medically_needy_group, '1') unless  @Shenandoah.blank?
    @Smyth.update_attribute(:medically_needy_group, '1') unless  @Smyth.blank?
    @Southampton.update_attribute(:medically_needy_group, '1') unless  @Southampton.blank?
    @Spotsylvania.update_attribute(:medically_needy_group, '1') unless  @Spotsylvania.blank?
    @Stafford.update_attribute(:medically_needy_group, '1') unless  @Stafford.blank?
    @Staunton.update_attribute(:medically_needy_group, '2') unless  @Staunton.blank?
    @Suffolk.update_attribute(:medically_needy_group, '1') unless  @Suffolk.blank?
    @Surry.update_attribute(:medically_needy_group, '1') unless  @Surry.blank?
    @Sussex.update_attribute(:medically_needy_group, '1') unless  @Sussex.blank?
    @Tazewell.update_attribute(:medically_needy_group, '1') unless  @Tazewell.blank?
    @Virginia_Beach.update_attribute(:medically_needy_group, '2') unless  @Virginia_Beach.blank?
    @Warren.update_attribute(:medically_needy_group, '2') unless  @Warren.blank?
    @Washington.update_attribute(:medically_needy_group, '1') unless  @Washington.blank?
    @Waynesboro.update_attribute(:medically_needy_group, '3') unless  @Waynesboro.blank?
    @Westmoreland.update_attribute(:medically_needy_group, '1') unless  @Westmoreland.blank?
    @Williamsburg.update_attribute(:medically_needy_group, '2') unless  @Williamsburg.blank?
    @Winchester.update_attribute(:medically_needy_group, '2') unless  @Winchester.blank?
    @Wise.update_attribute(:medically_needy_group, '1') unless  @Wise.blank?
    @Wythe.update_attribute(:medically_needy_group, '1') unless  @Wythe.blank?
    @York.update_attribute(:medically_needy_group, '1') unless  @York.blank?

    #  	(1, 'Accomack County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(2, 'Albemarle County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(3, 'Alexandria City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(4, 'Alleghany County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(5, 'Amelia County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(6, 'Amherst County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(7, 'Appomattox County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(8, 'Arlington County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(9, 'Augusta County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(10, 'Bath County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(11, 'Bedford City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(12, 'Bedford County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(13, 'Bland County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(14, 'Botetourt County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(15, 'Bristol City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(16, 'Brunswick County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(17, 'Buchanan County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(18, 'Buckingham County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(19, 'Buena Vista City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(20, 'Campbell County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(21, 'Caroline County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(22, 'Carroll County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(23, 'Charles City County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(24, 'Charlotte County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(25, 'Charlottesville City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(26, 'Chesapeake City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(27, 'Chesterfield County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(28, 'Clarke County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(29, 'Clifton Forge City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'), Not a city anymore
    #  	(30, 'Colonial Heights City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(31, 'Covington City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(32, 'Craig County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(33, 'Culpeper County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(34, 'Cumberland County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(35, 'Danville City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(36, 'Dickenson County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(37, 'Dinwiddie County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(38, 'Emporia City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(39, 'Essex County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(40, 'Fairfax City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(41, 'Fairfax County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(42, 'Falls Church City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(43, 'Fauquier County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(44, 'Floyd County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(45, 'Fluvanna County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(46, 'Franklin City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(47, 'Franklin County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(48, 'Frederick County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(49, 'Fredericksburg City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(50, 'Galax City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(51, 'Giles County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(52, 'Gloucester County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(53, 'Goochland County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(54, 'Grayson County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(55, 'Greene County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(56, 'Greensville County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(57, 'Halifax County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(58, 'Hampton City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(59, 'Hanover County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(60, 'Harrisonburg City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(61, 'Henrico County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(62, 'Henry County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(63, 'Highland County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(64, 'Hopewell City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(65, 'Isle of Wight County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(66, 'James City County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(67, 'King and Queen County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(68, 'King George County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(69, 'King William County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(70, 'Lancaster County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(71, 'Lee County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(72, 'Lexington City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(73, 'Loudoun County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(74, 'Louisa County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(75, 'Lunenburg County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(76, 'Lynchburg City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(77, 'Madison County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(78, 'Manassas City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(79, 'Manassas Park City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(80, 'Martinsville City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(81, 'Mathews County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(82, 'Mecklenburg County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(83, 'Middlesex County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(84, 'Montgomery County', '2010-08-12 20:23:27', '2010-08-12 20:23:27');"
    #  	(85, 'Nelson County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(86, 'New Kent County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(87, 'Newport News City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(88, 'Norfolk City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(89, 'Northampton County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(90, 'Northumberland County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(91, 'Norton City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(92, 'Nottoway County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(93, 'Orange County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(94, 'Page County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(95, 'Patrick County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(96, 'Petersburg City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(97, 'Pittsylvania County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(98, 'Poquoson City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(99, 'Portsmouth City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(100, 'Powhatan County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(101, 'Prince Edward County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(102, 'Prince George County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(103, 'Prince William County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(104, 'Pulaski County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(105, 'Radford City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(106, 'Rappahannock County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(107, 'Richmond City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(108, 'Richmond County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(109, 'Roanoke City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(110, 'Roanoke County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(111, 'Rockbridge County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(112, 'Rockingham County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(113, 'Russell County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(114, 'Salem City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(115, 'Scott County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(116, 'Shenandoah County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(117, 'Smyth County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(118, 'Southampton County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(119, 'Spotsylvania County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(120, 'Stafford County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(121, 'Staunton City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(122, 'Suffolk City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(123, 'Surry County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(124, 'Sussex County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(125, 'Tazewell County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(126, 'Virginia Beach City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(127, 'Warren County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(128, 'Washington County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(129, 'Waynesboro City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(130, 'Westmoreland County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(131, 'Williamsburg City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(132, 'Winchester City', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(133, 'Wise County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(134, 'Wythe County', '2010-08-12 20:23:27', '2010-08-12 20:23:27'),
    #  	(135, 'York County', '2010-08-12 20:23:27', '2010-08-12 20:23:27');"

  end

  def self.down
  end
end
