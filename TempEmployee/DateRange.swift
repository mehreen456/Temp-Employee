import Foundation


extension Calendar {
	
	func dateRange(start: Date,
	               end: Date,
	               stepUnits: Calendar.Component,
	               stepValue: Int) -> DateRange {
		let dateRange = DateRange(calendar: self,
		                          start: start,
		                          end: end,
		                          stepUnits: stepUnits,
		                          stepValue: stepValue)
		return dateRange
	}
	
}


struct DateRange: Sequence, IteratorProtocol {
	
	var calendar: Calendar
	var start: Date
	var end: Date
	var stepUnits: Calendar.Component
	var stepValue: Int
	
	private var multiplier: Int
	
	
	init(calendar: Calendar, start: Date, end: Date, stepUnits: Calendar.Component, stepValue: Int) {
		self.calendar = calendar
		self.start = start
		self.end = end
		self.stepUnits = stepUnits
		self.stepValue = stepValue
		self.multiplier = 0
	}
	
	
	mutating func next() -> Date? {
		guard let nextDate = calendar.date(byAdding: stepUnits,
		                                   value: stepValue * multiplier,
		                                   to: start,
		                                   wrappingComponents: false) else {
			return nil
		}
		
		guard nextDate < end else {
			return nil
		}
		
		multiplier += 1
		return nextDate
	}
	
}
