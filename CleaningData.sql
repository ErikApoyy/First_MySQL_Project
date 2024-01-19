/* Reformatting data type (text to date) */ 

-- Convert date (Text format) into date_format
SELECT SaleDate, STR_TO_DATE(SaleDate, '%M %e, %Y') AS FormattedSaleDate
FROM Nashville_housing;
-- April 9, 2013 -> 2013-04-09

-- Update from text into date format
UPDATE Nashville_housing
SET SaleDate = STR_TO_DATE(SaleDate, '%M %e, %Y');

-- Revert it back into text format
UPDATE Nashville_housing
SET SaleDate = DATE_FORMAT(SaleDate, '%M %e, %Y');

select saledate 
from Nashville_housing;

-- -------------------------------------------------------------------------------------------


/* Breaking out property address column */

select propertyaddress as FullAddress,
substring(PropertyAddress, 1, Locate(',', PropertyAddress) -1) as CityAddress,
substring(PropertyAddress, Locate(',', PropertyAddress) +1) as StateAddress
from Nashville_housing;

alter table Nashville_housing
add CityAddress text(250);

update Nashville_housing
set CityAddress = substring(PropertyAddress, 1, Locate(',', PropertyAddress) -1);

alter table Nashville_housing
add StateAddress text(250);

update Nashville_housing
set StateAddress = substring(PropertyAddress, Locate(',', PropertyAddress) +1);



-- -------------------------------------------------------------------------------------------


/* Change Y and N into Yes and No  */

select distinct(SoldAsVacant), count(SoldAsVacant)
from Nashville_housing
group by SoldAsVacant;

select SoldAsVacant,
	case when SoldAsVacant = "Y" Then "Yes"
		 when SoldAsVacant = "N" Then "No"
		 else SoldAsVacant
         End as SoldAsVacant2
from Nashville_housing
group by SoldAsVacant;

update Nashville_housing
set SoldAsVacant = case when SoldAsVacant = "Y" Then "Yes"
		 when SoldAsVacant = "N" Then "No"
		 else SoldAsVacant
         End;
         
         
         
-- -------------------------------------------------------------------------------------------

/* Delete unused column */


/*  Please be mindful when executing this query 

Alter table Nashville_housing
drop column LandUse; 
				-- Column name that is not being used

*/

