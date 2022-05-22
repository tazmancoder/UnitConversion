//
//  TemperatureConversionView.swift
//  UnitConversion
//
//  Created by Mark Perryman on 5/11/22.
//

import SwiftUI

struct TemperatureConversionView: View {
    @State private var numberToConvert = ""
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @State private var convertedValue = ""

    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]

    var body: some View {
        Form {
            Section("Units") {
                VStack(alignment: .leading) {
                    Text("Select Input Unit")
                        .font(.caption)
                        .foregroundColor(.label)
                        .offset(x: Constants.f5)

                    Picker("Input Temperature", selection: $inputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
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

                    Picker("Output Temperature", selection: $outputUnit) {
                        ForEach(temperatureUnits.filter { $0 != inputUnit }, id: \.self) {
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
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.label)

                Spacer()
            }
            .padding(.top, Constants.f10)
            .padding(.horizontal, Constants.f5)
            .padding(.bottom, Constants.f10)

            VStack(alignment: .leading) {
                Text("Enter Temperature")
                    .font(.caption)
                    .foregroundColor(.label)

                TextField("Number to convert", text: $numberToConvert)
                    .textFieldStyle(.roundedBorder)
            }

            VStack {
                Button(action: {
                    guard let value = convert(
                        temperature: numberToConvert,
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
        .navigationTitle("Temperature Conversions")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func convert(temperature: String, from inputUnit: UnitTemperature, to outputUnit: UnitTemperature) -> String? {
        let inputFormatter = NumberFormatter()
        guard let value = inputFormatter.number(from: temperature) else { return nil }

        let inputTemp = Measurement(value: value.doubleValue, unit: inputUnit)
        let outputTemp = inputTemp.converted(to: outputUnit)

        let outputformatter = MeasurementFormatter()
        outputformatter.unitOptions = .providedUnit
        return outputformatter.string(from: outputTemp)
    }

    private func covertPickerToUnitTemp(_ value: String) -> UnitTemperature {
        switch value {
        case "Celsius":
            return .celsius
        case "Fahrenheit":
            return .fahrenheit
        case "Kelvin":
            return .kelvin
        default:
            return .fahrenheit
        }
    }
}

struct TemperatureConversionView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversionView()
    }
}
