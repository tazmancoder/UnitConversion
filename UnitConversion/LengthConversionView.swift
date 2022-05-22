//
//  LengthConversionView.swift
//  UnitConversion
//
//  Created by Mark Perryman on 5/11/22.
//

import SwiftUI

struct LengthConversionView: View {
    @State private var numberToConvert = ""
    @State private var inputUnit = "Kilometer"
    @State private var outputUnit = "Meter"
    @State private var convertedValue = ""
    
    let units = ["Kilometer", "Meter", "Centimeter", "Millimeter", "Micrometer", "Nanometer", "Mile", "Yard", "Foot", "Inch", "Nautical Mile"]

    var body: some View {
        Form {
            Section("Units") {
                VStack(alignment: .leading) {
                    Text("Select Input Unit")
                        .font(.caption)
                        .foregroundColor(.label)
                        .offset(x: Constants.f5)

                    Picker("Input Length", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                .padding(.horizontal, Constants.f10)
                .padding(.bottom, Constants.f10)

                VStack(alignment: .leading) {
                    Text("Select Output Unit")
                        .font(.caption)
                        .foregroundColor(.label)
                        .offset(x: Constants.f5)

                    Picker("Output Length", selection: $outputUnit) {
                        ForEach(units.filter { $0 != inputUnit }, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                .padding(.horizontal, Constants.f10)
                .padding(.bottom, Constants.f10)
            }

            HStack {
                Spacer()

                Text("Convert from \(inputUnit) to \(outputUnit)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.label)

                Spacer()
            }
            .padding(.top, Constants.f10)
            .padding(.horizontal, Constants.f5)
            .padding(.bottom, Constants.f10)

            VStack(alignment: .leading) {
                Text("Enter Length")
                    .font(.caption)
                    .foregroundColor(.label)

                TextField("Number to convert", text: $numberToConvert)
                    .textFieldStyle(.roundedBorder)
            }

            VStack {
                Button(action: {
                    guard let value = convert(
                        temperature: String(numberToConvert),
                        from: covertPickerToUnitTemp(inputUnit),
                        to: covertPickerToUnitTemp(outputUnit)
                    ) else { return }
                    convertedValue = value
                }, label: {
                    Text("Tap To Convert")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                })
                .frame(maxWidth: .infinity, minHeight: Constants.f44)
                .background(
                    LinearGradient(gradient: Gradient(colors: [
                        .themeBlue, .systemRed
                    ]), startPoint: .leading, endPoint: .trailing)
                )
                .foregroundColor(.white)
                .cornerRadius(Constants.f10)
                .buttonStyle(.plain)
                .padding()

                Text(convertedValue)
                    .font(.system(size: Constants.f50, weight: .semibold, design: .rounded))
            }
        }
        .navigationTitle("Length Conversions")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func convert(temperature: String, from inputUnit: UnitLength, to outputUnit: UnitLength) -> String? {
        let inputFormatter = NumberFormatter()
        guard let value = inputFormatter.number(from: temperature) else { return nil }

        let inputTemp = Measurement(value: value.doubleValue, unit: inputUnit)
        let outputTemp = inputTemp.converted(to: outputUnit)

        let outputformatter = MeasurementFormatter()
        outputformatter.unitOptions = .providedUnit
        return outputformatter.string(from: outputTemp)
    }

    private func covertPickerToUnitTemp(_ value: String) -> UnitLength {
//        ["Kilometer", "Meter", "Centimeter", "Millimeter", "Micrometer", "Nanometer", "Mile", "Yard", "Foot", "Inch", "Nautical Mile"]
        switch value {
        case "Kilometer":
            return .kilometers
        case "Meter":
            return .meters
        case "Centimeter":
            return .centimeters
        case "Millimeter":
            return .millimeters
        case "Micrometer":
            return .micrometers
        case "Nanometer":
            return .nanometers
        case "Mile":
            return .miles
        case "Yard":
            return .yards
        case "Foot":
            return .feet
        case "Inch":
            return .inches
        default:
            return .nauticalMiles
        }
    }

}

struct LengthConversionView_Previews: PreviewProvider {
    static var previews: some View {
        LengthConversionView()
    }
}
