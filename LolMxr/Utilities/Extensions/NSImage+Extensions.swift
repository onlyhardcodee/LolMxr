import AppKit

extension NSImage {
    func resized(to size: NSSize) -> NSImage {
        let newImage = NSImage(size: size)
        newImage.lockFocus()
        draw(in: NSRect(origin: .zero, size: size))
        newImage.unlockFocus()
        return newImage
    }
}
