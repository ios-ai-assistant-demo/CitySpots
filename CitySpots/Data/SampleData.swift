import Foundation

enum SampleData {
    static let weekendEdit = EditorialCollection(
        id: "weekend-edit",
        title: "Weekend Edit",
        subtitle: "Three easy stops for a slower city weekend.",
        summary: "Start with coffee, browse the market and finish with a sunset walk by the river.",
        spotIDs: [
            "riverside-brew",
            "lantern-market",
            "embankment-loop"
        ]
    )

    static let spots: [Spot] = [
        Spot(
            id: "riverside-brew",
            title: "Riverside Brew",
            neighborhood: "Khamovniki",
            category: .coffee,
            summary: "Quiet coffee bar with large windows and a weekend vinyl set.",
            tags: ["coffee", "quiet", "vinyl"],
            legalCopy: .bookingTerms
        ),
        Spot(
            id: "gallery-north",
            title: "Gallery North",
            neighborhood: "Tverskoy",
            category: .exhibition,
            summary: "Small contemporary art space with rotating light installations.",
            tags: ["art", "indoors", "tickets"],
            legalCopy: .ticketTerms
        ),
        Spot(
            id: "lantern-market",
            title: "Lantern Market",
            neighborhood: "Kitay-Gorod",
            category: .market,
            summary: "Covered food market with local bakeries and small weekend pop-ups.",
            tags: ["food", "market", "weekend"],
            legalCopy: nil
        ),
        Spot(
            id: "embankment-loop",
            title: "Embankment Loop",
            neighborhood: "Zamoskvorechye",
            category: .walk,
            summary: "Riverside walking route with city views and sunset benches.",
            tags: ["walk", "sunset", "outdoors"],
            legalCopy: nil
        ),
        Spot(
            id: "olive-kitchen",
            title: "Olive Kitchen",
            neighborhood: "Patriki",
            category: .food,
            summary: "All-day cafe with a short brunch menu and quiet back room.",
            tags: ["brunch", "food", "indoor"],
            legalCopy: .reservationTerms
        )
    ]
}

private extension RemoteRichText {
    static let bookingTerms = RemoteRichText(
        spans: [
            RemoteRichTextSpan(text: "Booking terms apply. Review the ", style: .body),
            RemoteRichTextSpan(text: "city guide rules", style: .link(URL(string: "https://example.com/guide-rules")!)),
            RemoteRichTextSpan(text: " before confirming.", style: .body)
        ]
    )

    static let ticketTerms = RemoteRichText(
        spans: [
            RemoteRichTextSpan(text: "Timed tickets are non-refundable after activation. See ", style: .body),
            RemoteRichTextSpan(text: "event details", style: .link(URL(string: "https://example.com/event-details")!)),
            RemoteRichTextSpan(text: " for exceptions.", style: .body)
        ]
    )

    static let reservationTerms = RemoteRichText(
        spans: [
            RemoteRichTextSpan(text: "Reservation window is held for 15 minutes. Full policy: ", style: .body),
            RemoteRichTextSpan(text: "visit terms", style: .link(URL(string: "https://example.com/visit-terms")!)),
            RemoteRichTextSpan(text: ".", style: .body)
        ]
    )
}
