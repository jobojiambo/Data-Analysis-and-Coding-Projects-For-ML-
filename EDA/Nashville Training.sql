select*
from Maria.dbo.Nashville

select*
from Maria.dbo.Nashille2

select* from Nashville
inner join Nashille2 on Nashville.[UniqueID ]=Nashille2.[UniqueID ]

--How to standardize and split the dates

select SaleDate, CONVERT(DATE, SaleDate) from Nashville

update Nashville
set SaleDate=CONVERT(DATE, SaleDate)

alter table nashville
add Saledateconverted Date;

update Nashville
set saledateconverted=CONVERT(DATE, SaleDate)

select saledateconverted, CONVERT(DATE, SaleDate) from Nashville

--How to populate null Property addres data

select propertyaddress
from Nashville
where propertyaddress is null

select *
from Nashville
--where propertyaddress is null
order by ParcelID

select a.parcelid, a.PropertyAddress, b.parcelid, b.PropertyAddress, isnull(a.propertyaddress, b.propertyaddress)
from Nashville a
Join Nashville b on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.propertyaddress is null

update a
set propertyaddress=isnull(a.propertyaddress,b.propertyaddress)
from Nashville a
Join Nashville b on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.propertyaddress is null

--How to breaup the address into individual columns (Address, City, State)

select propertyaddress
from Nashville


-- breaking up propertyaddress
---using parsename
select
parsename(replace(PropertyAddress,',','.'),2) as address
,parsename(replace(PropertyAddress,',','.'),1) as city
from nashville

alter table nashville
add propertysplitaddress1 varchar (255);

update nashville
set propertysplitaddress1 = parsename(replace(PropertyAddress,',','.'),2) 

alter table nashville
add propertysplitaddress2 varchar (255);

update nashville
set propertysplitaddress2 = parsename(replace(PropertyAddress,',','.'),1) 

---Altenatively using the longer substring method

select 
substring(propertyaddress, 1, charindex(',' , propertyaddress)-1) as address
, substring (propertyaddress, charindex(',', propertyaddress)+1, len (propertyaddress)) as address
from Nashville

alter table nashville
add propertysplitaddress varchar (255)

update Nashville
set propertysplitaddress = substring (propertyaddress, 1, charindex(',', propertyaddress)-1)

alter table nashville 
add propertysplitcity varchar(255);

update nashville
set propertysplitcity = SUBSTRING(propertyaddress, charindex(',', propertyaddress)+1, len (propertyaddress))


--breaking up owneraddress

select OwnerAddress
from nashville

select substring (owneraddress, 1, charindex(',', owneraddress)-1) as owner
, substring(owneraddress, charindex(',', owneraddress)+1, len(owneraddress)) as owner
from Nashville

alter table nashville
add ownersplitaddress varchar(255);

update nashville
set ownersplitaddress = substring(owneraddress,1, charindex(',', owneraddress)-1)

alter table nashville
add ownersplitcity varchar (255)

update nashville
set ownersplitcity = substring (owneraddress, charindex(',', owneraddress)+1, len(owneraddress))


---alternatively we can use the parsename functipon and complete the entire split using very few lines of code
select
parsename(replace(owneraddress,',','.'),3)
,parsename(replace(owneraddress,',','.'),2)
,parsename(replace(owneraddress,',','.'),1)
from nashville

--Change Y and N to Yes and No in SoldAsVacant field

select distinct (SoldAsVacant), count (soldasvacant)
from nashville
group by SoldAsVacant
order by 2

select soldasvacant
, case when SoldAsVacant='Y'  then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	Else SoldAsVacant
	end 
from Nashville

update Nashville
set SoldAsVacant= case when SoldAsVacant='Y'  then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	Else SoldAsVacant
	end 

--Removing Duplicates

---identifying duplicates
with rownumcte as(
select*,
	row_number() over(
	partition by parcelid,
				 propertyaddress,
				 saleprice, 
				 saledate,
				 legalreference
				 order by 
				 uniqueid
				 ) row_num

from Nashville
--order by parcelid
)
select*
from rownumcte
where row_num>1
order by PropertyAddress

---Now deleting the duplicates
with rownumcte as(
select*,
	row_number() over(
	partition by parcelid,
				 propertyaddress,
				 saleprice, 
				 saledate,
				 legalreference
				 order by 
				 uniqueid
				 ) row_num

from Nashville
--order by parcelid
)
delete
from rownumcte
where row_num>1
--order by PropertyAddress

select*
from Nashville
order by [UniqueID ] desc

--deleting the unused columns

alter table nashville
drop column owneraddress, taxdistrict, propertyaddress, saledate

select*
from Nashville
