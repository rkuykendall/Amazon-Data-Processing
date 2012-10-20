# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.27)
# Database: UIC-Dataset
# Generation Time: 2012-10-15 16:00:31 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Booksinfo
# ------------------------------------------------------------

CREATE TABLE `Booksinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `RowID` varchar(255) DEFAULT NULL,
  `ProductID` varchar(255) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `ReleaseDate` varchar(255) DEFAULT NULL,
  `ProductDimensions` varchar(255) DEFAULT NULL,
  `ShippingWeight` varchar(255) DEFAULT NULL,
  `Language` varchar(255) DEFAULT NULL,
  `NumPages` varchar(255) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Edition` varchar(255) DEFAULT NULL,
  `More` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table Locations
# ------------------------------------------------------------

CREATE TABLE `Locations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) DEFAULT NULL,
  `MemberRank` varchar(255) DEFAULT NULL,
  `Birthday` varchar(255) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `MemberID` varchar(255) DEFAULT NULL,
  `State` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table productInfoXMLReviewedAudioCDs
# ------------------------------------------------------------

CREATE TABLE `productInfoXMLReviewedAudioCDs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `OneProductID` varchar(255) DEFAULT NULL,
  `OneSalesRank` int(11) DEFAULT NULL,
  `OneLabel` varchar(255) DEFAULT NULL,
  `OneSalesPrice` varchar(255) DEFAULT NULL,
  `Artist` varchar(255) DEFAULT NULL,
  `Binding` varchar(255) DEFAULT NULL,
  `EAN` varchar(255) DEFAULT NULL,
  `Format` varchar(255) DEFAULT NULL,
  `ISBN` varchar(255) DEFAULT NULL,
  `Label` varchar(255) DEFAULT NULL,
  `ListPrice` varchar(255) DEFAULT NULL,
  `Manufacturer` varchar(255) DEFAULT NULL,
  `NumberOfDiscs` varchar(255) DEFAULT NULL,
  `PackageDimensions` varchar(255) DEFAULT NULL,
  `ProductGroup` varchar(255) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `ReleaseDate` varchar(255) DEFAULT NULL,
  `Studio` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Creator` varchar(255) DEFAULT NULL,
  `UPC` varchar(255) DEFAULT NULL,
  `NumberOfTracks` varchar(255) DEFAULT NULL,
  `PublicationDate` varchar(255) DEFAULT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  `MPN` varchar(255) DEFAULT NULL,
  `Edition` varchar(255) DEFAULT NULL,
  `NumberOfItems` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `RegionCode` varchar(255) DEFAULT NULL,
  `DVDLayers` varchar(255) DEFAULT NULL,
  `DVDSides` varchar(255) DEFAULT NULL,
  `AspectRatio` varchar(255) DEFAULT NULL,
  `RunningTime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table productInfoXMLReviewedMProducts
# ------------------------------------------------------------

CREATE TABLE `productInfoXMLReviewedMProducts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `OneProductID` varchar(255) DEFAULT NULL,
  `OneSalesRank` varchar(255) DEFAULT NULL,
  `OneBrand` varchar(255) DEFAULT NULL,
  `OneSalesPrice` varchar(255) DEFAULT NULL,
  `OneTitle` varchar(255) DEFAULT NULL,
  `Binding` varchar(255) DEFAULT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  `EAN` varchar(255) DEFAULT NULL,
  `ISBN` varchar(255) DEFAULT NULL,
  `Label` varchar(255) DEFAULT NULL,
  `Manufacturer` varchar(255) DEFAULT NULL,
  `Platform` varchar(255) DEFAULT NULL,
  `ProductGroup` varchar(255) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `ReleaseDate` varchar(255) DEFAULT NULL,
  `Studio` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `Edition` varchar(255) DEFAULT NULL,
  `Format` varchar(255) DEFAULT NULL,
  `PublicationDate` varchar(255) DEFAULT NULL,
  `Feature` varchar(255) DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `Actor` varchar(255) DEFAULT NULL,
  `AudienceRating` varchar(255) DEFAULT NULL,
  `Director` varchar(255) DEFAULT NULL,
  `NumberOfItems` varchar(255) DEFAULT NULL,
  `RunningTime` varchar(255) DEFAULT NULL,
  `TheatricalReleaseDate` varchar(255) DEFAULT NULL,
  `UPC` varchar(255) DEFAULT NULL,
  `MPN` varchar(255) DEFAULT NULL,
  `NumberOfPages` varchar(255) DEFAULT NULL,
  `SpecialFeatures` varchar(255) DEFAULT NULL,
  `ESRBAgeRating` varchar(255) DEFAULT NULL,
  `ManufacturerMaximumAge` varchar(255) DEFAULT NULL,
  `ManufacturerMinimumAge` varchar(255) DEFAULT NULL,
  `Color` varchar(255) DEFAULT NULL,
  `SystemMemorySize` varchar(255) DEFAULT NULL,
  `CPUManufacturer` varchar(255) DEFAULT NULL,
  `CPUSpeed` varchar(255) DEFAULT NULL,
  `CPUType` varchar(255) DEFAULT NULL,
  `HardDiskSize` varchar(255) DEFAULT NULL,
  `ModemDescription` varchar(255) DEFAULT NULL,
  `ProcessorCount` varchar(255) DEFAULT NULL,
  `SystemBusSpeed` varchar(255) DEFAULT NULL,
  `SystemMemoryType` varchar(255) DEFAULT NULL,
  `Artist` varchar(255) DEFAULT NULL,
  `NumberOfDiscs` varchar(255) DEFAULT NULL,
  `IsAutographed` varchar(255) DEFAULT NULL,
  `IsMemorabilia` varchar(255) DEFAULT NULL,
  `LegalDisclaimer` varchar(255) DEFAULT NULL,
  `VariationDescription` varchar(255) DEFAULT NULL,
  `Warranty` varchar(255) DEFAULT NULL,
  `Creator` varchar(255) DEFAULT NULL,
  `NumberOfTracks` varchar(255) DEFAULT NULL,
  `MaximumFocalLength` varchar(255) DEFAULT NULL,
  `MinimumFocalLength` varchar(255) DEFAULT NULL,
  `OpticalZoom` varchar(255) DEFAULT NULL,
  `HasRedEyeReduction` varchar(255) DEFAULT NULL,
  `BatteriesIncluded` varchar(255) DEFAULT NULL,
  `IsFragile` varchar(255) DEFAULT NULL,
  `MaterialType` varchar(255) DEFAULT NULL,
  `Batteries` varchar(255) DEFAULT NULL,
  `Compatibility` varchar(255) DEFAULT NULL,
  `BatteryType` varchar(255) DEFAULT NULL,
  `AmazonMaximumAge` varchar(255) DEFAULT NULL,
  `AmazonMinimumAge` varchar(255) DEFAULT NULL,
  `DisplaySize` varchar(255) DEFAULT NULL,
  `FloppyDiskDriveDescription` varchar(255) DEFAULT NULL,
  `Size` varchar(255) DEFAULT NULL,
  `ClothingSize` varchar(255) DEFAULT NULL,
  `NetworkInterfaceDescription` varchar(255) DEFAULT NULL,
  `KeyboardDescription` varchar(255) DEFAULT NULL,
  `GraphicsMemorySize` varchar(255) DEFAULT NULL,
  `BatteryDescription` varchar(255) DEFAULT NULL,
  `MaximumWeightRecommendation` varchar(255) DEFAULT NULL,
  `ComputerHardwareType` varchar(255) DEFAULT NULL,
  `RemovableMemory` varchar(255) DEFAULT NULL,
  `Connectivity` varchar(255) DEFAULT NULL,
  `DigitalZoom` varchar(255) DEFAULT NULL,
  `NativeResolution` varchar(255) DEFAULT NULL,
  `IncludesMp3Player` varchar(255) DEFAULT NULL,
  `ISOEquivalent` varchar(255) DEFAULT NULL,
  `MaximumAperture` varchar(255) DEFAULT NULL,
  `MaximumResolution` varchar(255) DEFAULT NULL,
  `MaximumShutterSpeed` varchar(255) DEFAULT NULL,
  `MaximumVerticalResolution` varchar(255) DEFAULT NULL,
  `MinimumShutterSpeed` varchar(255) DEFAULT NULL,
  `NumberOfRapidFireShots` varchar(255) DEFAULT NULL,
  `HasTripodMount` varchar(255) DEFAULT NULL,
  `MonitorSize` varchar(255) DEFAULT NULL,
  `ApertureModes` varchar(255) DEFAULT NULL,
  `Department` varchar(255) DEFAULT NULL,
  `AspectRatio` varchar(255) DEFAULT NULL,
  `RegionCode` varchar(255) DEFAULT NULL,
  `SecondaryCacheSize` varchar(255) DEFAULT NULL,
  `GraphicsDescription` varchar(255) DEFAULT NULL,
  `GraphicsCardInterface` varchar(255) DEFAULT NULL,
  `IncludedSoftware` varchar(255) DEFAULT NULL,
  `MemorySlotsAvailable` varchar(255) DEFAULT NULL,
  `MacroFocusRange` varchar(255) DEFAULT NULL,
  `HardDiskCount` varchar(255) DEFAULT NULL,
  `LineVoltage` varchar(255) DEFAULT NULL,
  `ManufacturerLaborWarrantyDescription` varchar(255) DEFAULT NULL,
  `ManufacturerPartsWarrantyDescription` varchar(255) DEFAULT NULL,
  `MaximumColorDepth` varchar(255) DEFAULT NULL,
  `MonitorViewableDiagonalSize` varchar(255) DEFAULT NULL,
  `NotebookDisplayTechnology` varchar(255) DEFAULT NULL,
  `NotebookPointingDeviceDescription` varchar(255) DEFAULT NULL,
  `SoundCardDescription` varchar(255) DEFAULT NULL,
  `SpeakerDescription` varchar(255) DEFAULT NULL,
  `SystemMemorySizeMax` varchar(255) DEFAULT NULL,
  `TotalFirewirePorts` varchar(255) DEFAULT NULL,
  `TotalPCCardSlots` varchar(255) DEFAULT NULL,
  `TotalUSBPorts` varchar(255) DEFAULT NULL,
  `CaseType` varchar(255) DEFAULT NULL,
  `CDRWDescription` varchar(255) DEFAULT NULL,
  `MouseDescription` varchar(255) DEFAULT NULL,
  `TotalExternalBaysFree` varchar(255) DEFAULT NULL,
  `TotalInternalBaysFree` varchar(255) DEFAULT NULL,
  `TotalNTSCPALPorts` varchar(255) DEFAULT NULL,
  `TotalParallelPorts` varchar(255) DEFAULT NULL,
  `TotalPCISlotsFree` varchar(255) DEFAULT NULL,
  `TotalSerialPorts` varchar(255) DEFAULT NULL,
  `VariationDenomination` varchar(255) DEFAULT NULL,
  `BandMaterialType` varchar(255) DEFAULT NULL,
  `BezelMaterialType` varchar(255) DEFAULT NULL,
  `CalendarType` varchar(255) DEFAULT NULL,
  `CaseMaterialType` varchar(255) DEFAULT NULL,
  `ClaspType` varchar(255) DEFAULT NULL,
  `DialColor` varchar(255) DEFAULT NULL,
  `WatchMovementType` varchar(255) DEFAULT NULL,
  `WaterResistanceDepth` varchar(255) DEFAULT NULL,
  `MiniMovieDescription` varchar(255) DEFAULT NULL,
  `DelayBetweenShots` varchar(255) DEFAULT NULL,
  `HasAutoFocus` varchar(255) DEFAULT NULL,
  `HasSelfTimer` varchar(255) DEFAULT NULL,
  `HasVideoOut` varchar(255) DEFAULT NULL,
  `MaximumHighResolutionImages` varchar(255) DEFAULT NULL,
  `MaximumHorizontalResolution` varchar(255) DEFAULT NULL,
  `MaximumLowResolutionImages` varchar(255) DEFAULT NULL,
  `ResolutionModes` varchar(255) DEFAULT NULL,
  `FabricType` varchar(255) DEFAULT NULL,
  `ExternalDisplaySupportDescription` varchar(255) DEFAULT NULL,
  `DVDRWDescription` varchar(255) DEFAULT NULL,
  `DialWindowMaterialType` varchar(255) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `Ingredients` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table Reviews
# ------------------------------------------------------------

CREATE TABLE `Reviews` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MemberID` varchar(255) DEFAULT NULL,
  `ProductID` varchar(255) DEFAULT NULL,
  `Date` varchar(255) DEFAULT NULL,
  `dateReal` date DEFAULT NULL,
  `NumHelpfulFeedbacks` varchar(255) DEFAULT NULL,
  `NumFeedbacks` varchar(255) DEFAULT NULL,
  `Rating` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Body` text,
  PRIMARY KEY (`id`),
  KEY `ProductID` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table shortSummary
# ------------------------------------------------------------

CREATE TABLE `shortSummary` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MemberID` varchar(255) DEFAULT NULL,
  `MemberName` varchar(255) DEFAULT NULL,
  `NumReviews` int(255) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `MyWords` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table productinfo
# ------------------------------------------------------------

CREATE TABLE `productinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Raverage0t` double DEFAULT NULL,
  `Raverage1t` double DEFAULT NULL,
  `Raverage2t` double DEFAULT NULL,
  `Raverage3t` double DEFAULT NULL,
  `Raverage4t` double DEFAULT NULL,
  `Raverage5t` double DEFAULT NULL,
  `Raverage6t` double DEFAULT NULL,
  `Raverage7t` double DEFAULT NULL,
  `Raverage8t` double DEFAULT NULL,
  `Raverage9t` double DEFAULT NULL,
  `Rlatest` date DEFAULT NULL,
  `ProductID` varchar(255) DEFAULT NULL,
  `ProductName` varchar(255) DEFAULT NULL,
  `NumReviews` int(255) DEFAULT NULL,
  `ProductType` varchar(255) DEFAULT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  `SalesPrice` varchar(255) DEFAULT NULL,
  `ListPrice` varchar(255) DEFAULT NULL,
  `ShortProductDescription` varchar(255) DEFAULT NULL,
  `CatPaths` text,
  `break` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProductID` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
