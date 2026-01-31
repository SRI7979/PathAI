import SwiftUI

struct ContentView: View {
    private let macroItems: [MacroItem] = [
        MacroItem(title: "Protein", value: "45g", goal: "70g", progress: 0.64, tint: .pink),
        MacroItem(title: "Carb to hit", value: "89g", goal: "120g", progress: 0.74, tint: .orange),
        MacroItem(title: "Fat left", value: "48g", goal: "65g", progress: 0.74, tint: .blue)
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.11, green: 0.12, blue: 0.17),
                    Color(red: 0.06, green: 0.07, blue: 0.11)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    header
                    todaySummary
                    macroRow
                    recentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
        }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "applelogo")
                    .font(.system(size: 18, weight: .semibold))
                Text("Cal AI")
                    .font(.system(size: 20, weight: .semibold))
            }
            .foregroundStyle(.white)

            Spacer()

            HStack(spacing: 14) {
                Image(systemName: "cube")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(Circle().fill(Color.white.opacity(0.12)))

                HStack(spacing: 6) {
                    Image(systemName: "flame.fill")
                    Text("15")
                        .font(.footnote.weight(.semibold))
                }
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(Capsule().fill(Color.white.opacity(0.12)))
            }
        }
        .padding(.horizontal, 4)
    }

    private var todaySummary: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("2500")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                    Text("of 2800 kcal")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }

                Spacer()

                ProgressRing(progress: 0.84, lineWidth: 10)
                    .frame(width: 92, height: 92)
            }

            HStack(spacing: 16) {
                TodayTab(title: "Today", isActive: true)
                TodayTab(title: "Yesterday", isActive: false)
                Spacer()
            }
        }
        .padding(20)
        .background(CardBackground())
    }

    private var macroRow: some View {
        HStack(spacing: 12) {
            ForEach(macroItems) { item in
                MacroCard(item: item)
            }
        }
    }

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recently uploaded")
                .font(.headline)
                .foregroundStyle(.white)

            RecentMealCard(
                title: "Apple Salmon salad",
                subtitle: "500 kcal",
                macros: [
                    MacroValue(label: "Carb", value: "32g"),
                    MacroValue(label: "Prot", value: "24g"),
                    MacroValue(label: "Fat", value: "18g")
                ]
            )
        }
        .padding(20)
        .background(CardBackground())
    }
}

private struct TodayTab: View {
    let title: String
    let isActive: Bool

    var body: some View {
        Text(title)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(isActive ? .white : .white.opacity(0.5))
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(isActive ? Color.white.opacity(0.18) : Color.clear)
            )
    }
}

private struct MacroItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let goal: String
    let progress: Double
    let tint: Color
}

private struct MacroCard: View {
    let item: MacroItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.value)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)

            Text(item.title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))

            ProgressRing(progress: item.progress, lineWidth: 7, tint: item.tint)
                .frame(width: 42, height: 42)
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background(CardBackground())
    }
}

private struct RecentMealCard: View {
    let title: String
    let subtitle: String
    let macros: [MacroValue]

    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.44, green: 0.27, blue: 0.65),
                            Color(red: 0.22, green: 0.15, blue: 0.34)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 72, height: 72)
                .overlay(
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))

                HStack(spacing: 12) {
                    ForEach(macros) { item in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.value)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white)
                            Text(item.label)
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

private struct MacroValue: Identifiable {
    let id = UUID()
    let label: String
    let value: String
}

private struct ProgressRing: View {
    let progress: Double
    let lineWidth: CGFloat
    var tint: Color = .white

    var body: some View {
        ZStack {
            Circle()
                .stroke(tint.opacity(0.2), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    tint,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

private struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.white.opacity(0.08))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
