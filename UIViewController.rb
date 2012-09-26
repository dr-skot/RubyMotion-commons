class UIViewController

  def addButton(title, options = {})
    action = options[:action] || (title + "Button")
    label = options[:label] || title

    button = UIButton.buttonWithType UIButtonTypeRoundedRect
    button.setTitle title, forState:UIControlStateNormal
    button.setAccessibilityLabel label
    button.sizeToFit
    button.addTarget(self, action:action,
                     forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(button)
    button
  end

end
