import SwiftUI
import Swinject

extension FPUConfig {
    struct RootView: BaseView {
        let resolver: Resolver
        @StateObject var state = StateModel()

        private var conversionFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 1

            return formatter
        }

        private var intFormater: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.allowsFloats = false
            return formatter
        }

        var body: some View {
            Form {
                Section(header: Text("Convert Fat and Protein")) {
                    Toggle("Enable", isOn: $state.useFPUconversion)
                }

                Section(header: Text("Optional conversion settings")) {
                    HStack {
                        Text("Delay In Minutes")
                        Spacer()
                        DecimalTextField("8", value: $state.delay, formatter: intFormater)
                    }
                    HStack {
                        Text("Maximum Time Cap In Hours")
                        Spacer()
                        DecimalTextField("8", value: $state.timeCap, formatter: intFormater)
                    }
                    HStack {
                        Text("Interval In Minutes")
                        Spacer()
                        DecimalTextField("60", value: $state.minuteInterval, formatter: intFormater)
                    }
                    HStack {
                        Text("Override with a factor of ")
                        Spacer()
                        DecimalTextField("0.8", value: $state.individualAdjustmentFactor, formatter: conversionFormatter)
                    }
                }

                Section(
                    footer: Text(
                        "Allows fat and protein to be converted to future carb equivalents.\n\nDefault settings:\n\nDelay: 60 minutes\nTime Cap: 8 hours\nInterval: 60 min\nFactor: 0.5"
                    )
                )
                    {}
            }
            .onAppear(perform: configureView)
            .navigationBarTitle("Fat and Protein")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
