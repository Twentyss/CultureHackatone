import UIKit

class ImageScrollView: UIScrollView {
    
    var imageView: UIImageView!
    
    private lazy var zoomTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomImage))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.zoomTapRecognizer.numberOfTapsRequired = 2
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }
    
    func set(image: UIImage) {
        if self.imageView != nil {
            if self.imageView.superview != nil {
                self.imageView.removeFromSuperview()
            }
            self.imageView = nil
        }
        self.imageView = UIImageView(image: image)
        self.addSubview(self.imageView)
        self.contentSize = image.size
        self.setZoomScales()
        self.imageView.addGestureRecognizer(self.zoomTapRecognizer)
        self.imageView.isUserInteractionEnabled = true
    }
    
    @objc private func zoomImage(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: sender.view)
        if !(self.minimumZoomScale == self.maximumZoomScale && self.minimumZoomScale > 1) {
            let finalScale: CGFloat = self.zoomScale == self.minimumZoomScale ? self.maximumZoomScale : self.minimumZoomScale
            let zoomRect = self.getZoomRect(scale: finalScale, center: point)
            self.zoom(to: zoomRect, animated: true)
        }
    }
    
    func centerImage() {
        let boundsSize = self.bounds.size
        var frameToCenter = self.imageView.frame
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        }
        else {
            frameToCenter.origin.x = 0
        }
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin
                .y = ((boundsSize.height - frameToCenter.size.height) / 2)
        }
        else {
            frameToCenter.origin.y = 0
        }
        self.imageView.frame = frameToCenter
    }
    
    private func setZoomScales() {
        let boundsSize = self.bounds.size
        let imageSize = self.imageView.bounds.size
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        self.minimumZoomScale = min(xScale, yScale)
        self.maximumZoomScale = self.minimumZoomScale * 2
        self.zoomScale = self.minimumZoomScale
    }
    
    private func getZoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.width = self.bounds.size.width / scale
        zoomRect.size.height = self.bounds.size.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
}
