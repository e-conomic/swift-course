//: Playground - noun: a place where people can play
// Working with dates and date formats. The below is taken from how this is handled in the Twitter SmashTag request code.
//
// The below should give a deeper (and important) understanding of how NSDate and NSDateFormatters work together.
// In real applications you often do not have to worry about this as formatting dates will do the right thing, displaying
// dates localized to the users locale.
// However when parsing date strings to NSDate this understanding may be necessary.

import Foundation

// Example of the `created_at` string we get from the Twitter API
var created_at = "Wed Oct 21 07:36:06 +0000 2015"

// Taken from the SmashTag Twitter request serializer
let df = NSDateFormatter()
df.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"

// What does the NSDateFormatter default to? if "en_US" the `dateFromString` will return a NSDate
df.locale.localeIdentifier
let tweetDate:NSDate = df.dateFromString(created_at)!

// Set NSDateFormatter explicitly to use Danish locale - date format is no longer valid
df.locale = NSLocale(localeIdentifier: "da")
df.dateFromString(created_at) // nil

// Set it back a make it work again
df.locale = NSLocale(localeIdentifier: "en_UK")
df.dateFromString(created_at) // "Oct 21, 2015, 9:36 AM"


// But how to Danish? Get a NSDate with the en_US date formatter, and format that to Danish or others.
//
// The following is ok because NSDateFormatter was set to en_US above,
// the returned NSDate knows nothing about locales or time zones - Greenwich Mean Time (GMT)
let dateInGMT = df.dateFromString(created_at)
let danishDateFormatter = NSDateFormatter()
danishDateFormatter.locale = NSLocale(localeIdentifier: "da")

// Unless you have very specific requirement for formatting the date, do it with the build in formats
// instead of df.dateFormat
danishDateFormatter.dateStyle = .LongStyle
danishDateFormatter.timeStyle = .LongStyle
danishDateFormatter.timeZone = NSTimeZone(name: "GMT+0200")

// Now print the date with Danish localization and time zone
danishDateFormatter.stringFromDate(dateInGMT!) // "21. oktober 2015 kl. 09.36.06 CEST"
