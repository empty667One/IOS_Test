
/**
 *  适配器模式 - Adapter :适配器把自己封装起来然后暴露统一的接口给其他类，这样即使其他类的接口各不相同，也能相安无事，一起工作。
 */


import UIKit


protocol SelectNumBtnDelegate {
    //num of textField
    func selectNums(num:Int)
    //
    // func frameOfSelectNumBtnView()->(winth:Int,height:Int,center:CGPoint,num:Int)
    //
    // func btnBackGroundImg() -> (reduceImg:UIImage,addBtnImg:UIImage)
}

class SelectNumBtn: UIView,UITextFieldDelegate,Shakeable {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    private let maxValue = 100
    
    private func baseCheckForRegEx(regEx:String,data:String)->Bool {
        let card = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        guard card.evaluateWithObject(data) else{
            return false
        }
        return true
    }
    
    func checkForInputIsNumber(inputNumber:String)->Bool{
        let regEx = "^[1-9]+\\d{\(1),\(2)}$"
        return baseCheckForRegEx(regEx, data: inputNumber)
    }
    
    
    func checkForNumber(number:String)->Bool {
        let regEx = "^[0-9]*$"
        return baseCheckForRegEx(regEx, data: number)
    }
    
    //textField value
    var num:Int = 0 {
        didSet{
            //changeNumTextField.text = num.description
            
        }
    }
    
    private var valueChanged:Int = 0{
        didSet{
            returnNum(num)
        }
    }
    
    var numValue:Int {
        set{
            var value = newValue
            if newValue > maxValue {
                value = 100
            }
            self.num = value
            changeNumTextField.text = num.description
            //值改变代理处理触发
            valueChanged += 1
        }
        get{
            return self.num
        }
    }
    
    var delegate:SelectNumBtnDelegate?
    
    
    private let addBtn = UIButton()
    private let reduceBtn = UIButton()
    private let changeNumTextField = UITextField()
    
    
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(addBtn)
        self.addSubview(reduceBtn)
        self.addSubview(changeNumTextField)
        
        //setBubViewFrame
        let w = frame.maxX - frame.minX
        let h = frame.maxY - frame.minY
        
        //left Btn
        addBtn.frame = CGRect(x: w - h, y: 0, width: h, height: h)
        //right Btn
        reduceBtn.frame = CGRect(x: 0, y: 0, width: h, height: h)
        
        addBtn.setBackgroundImage(UIImage(named: "addIcon") , forState: UIControlState.Normal)
        reduceBtn.setBackgroundImage(UIImage(named: "reduceIcon") , forState: UIControlState.Normal)
        
        //middle textField
        changeNumTextField.frame = CGRect(x: reduceBtn.frame.maxX, y: 0, width: w - h*2, height: h)
        
        changeNumTextField.textAlignment = NSTextAlignment.Center
        changeNumTextField.delegate = self
        changeNumTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        changeNumTextField.adjustsFontSizeToFitWidth = true
        changeNumTextField.returnKeyType = UIReturnKeyType.Done
        
        //addAction
        addBtn.addTarget(self, action: #selector(SelectNumBtn.addBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        reduceBtn.addTarget(self, action: #selector(SelectNumBtn.reduceBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        changeNumTextField.addTarget(self, action: #selector(SelectNumBtn.changeNumTextFieldValueChanged), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        guard  let input = textField.text where input != ""  else{
            self.numValue = self.num
            return
        }
        
        
        
        
        guard  self.checkForInputIsNumber(input)  else{
            
            if input.characters.count == 1 {
                self.numValue = Int(input)!
            }else{
                self.numValue = self.num
            }
            
            return
        }
        
        self.numValue = Int(textField.text!)!
        
    }
    
    func changeNumTextFieldValueChanged(text:UITextField){
        
        if text.text?.characters.count  > 3 {
            let str1 = text.text
            let str3=str1!.substringToIndex(str1!.startIndex.advancedBy(3))
            text.text = str3
        }
        
        
        guard let  input = text.text else{
            return
        }
        
        guard  self.checkForNumber(input)  else{
            self.numValue = self.num
            return
        }
    }
    
    func addBtnClk(){
        num += 1
        self.numValue = num
        
        
    }
    
    func reduceBtnClk(){
        if num > 1 {
            num -= 1
        }
        self.numValue = num
        
        
        
    }
    
    func returnNum(num:Int)  {
        //隐藏减号
        if num == 1 {
           reduceBtn.hidden = true
        }else{
            reduceBtn.hidden = false
        }
        //隐藏加号
        if num == 100 {
            addBtn.hidden = true
        }else{
            addBtn.hidden = false
        }
        
        delegate?.selectNums(num)
    }
    
    convenience init(width:Int,height:Int,center:CGPoint,num:Int){
        let frame:CGRect = CGRect(origin: center, size: CGSize(width: width, height: height))
        self.init(frame: frame)
        
        self.num = num
        changeNumTextField.text = num.description
        
        //隐藏减号
        if num == 1 {
            reduceBtn.hidden = true
        }else{
            reduceBtn.hidden = false
        }
        //隐藏加号
        if num == 100 {
            addBtn.hidden = true
        }else{
            addBtn.hidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    func reload() {
//        let (winth,height,center,num) = (delegate?.frameOfSelectNumBtnView())!
//        let frame:CGRect = CGRect(origin: center, size: CGSize(width: winth, height: height))
//        self.frame = frame
//        
//        self.num = num
//        changeNumTextField.text = num.description
//        
//        
//        let (reduceImg,addBtnImg) = (delegate?.btnBackGroundImg())!
//        addBtn.setBackgroundImage(addBtnImg, forState: UIControlState.Normal)
//        reduceBtn.setBackgroundImage(reduceImg, forState: UIControlState.Normal)
//    }
    
    func test() {
        addBtn.backgroundColor = UIColor.redColor()
        reduceBtn.backgroundColor = UIColor.redColor()
        self.layer.borderWidth = 1
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
    }
    
}

//
//let selectNumBtn = SelectNumBtn(winth: 120, height: 30, center: CGPoint(x: 50, y: 10),num: 16)
//selectNumBtn.checkForInputIsNumber("110")


struct Result {
    
}

enum NetworkHelper {
    case usrRegist(tel:String,pwd:String)
    
    static var param = ["login":"id"]
    
    private static let baseUrl = "https://gskjak"
    
    func usrReloadRegist(completion:([Result]?,String?)->Void)  {
        var error:String?
        
        switch self {
        case .usrRegist(tel: let tel, pwd: let pwd):
            NetworkHelper.param["tel"] = tel
            NetworkHelper.param["pwd"] = pwd
            
            error = "ok"
            
            let result = [Result]()
            completion(result,error)
        
        }
        
    }
}


    






