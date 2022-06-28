//
//  BeatyQrWidget.swift
//  BeatyQrWidget
//
//  Created by Ilya Cherkasov on 15.02.2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    let userDefaults = UserDefaults(suiteName: "group.streamQRCode")
    
    func getImageFromStorage() -> UIImage? {
        guard let data = userDefaults?.object(forKey: "streamImage") as? Data else {
            return nil
        }
        return UIImage(data: data)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        let image = getImageFromStorage()
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), image: image)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let image = getImageFromStorage()
        let entry = SimpleEntry(date: Date(), configuration: configuration, image: image)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let image = getImageFromStorage()
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, image: image)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let image: UIImage?
}

struct BeatyQrWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Image(uiImage: entry.image ?? UIImage(systemName: "house")!)
            .resizable()
    }
}

@main
struct BeatyQrWidget: Widget {
    let kind: String = "BeatyQrWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            BeatyQrWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct BeatyQrWidget_Previews: PreviewProvider {

    static var previews: some View {
        BeatyQrWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), image: UIImage(systemName: "house")!))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
