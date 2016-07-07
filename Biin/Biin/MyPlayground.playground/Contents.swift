//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 1))
title.text = "Este es el titulo de un regalo y tambien alguna de las cosas mas importantes."
title.font = UIFont(name: "Lato-Black", size: 24)
title.textAlignment = NSTextAlignment.Left
title.numberOfLines = 0
title.sizeToFit()
title.textColor = UIColor.redColor()


print("height: \(title.frame.height)")
print("width: \(title.frame.width)")