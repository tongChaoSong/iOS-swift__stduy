//
//  ClassStructEnum.swift
//  SwiftStudyBook
//
//  Created by TCS on 2022/11/10.
//  Copyright © 2022 tcs. All rights reserved.
//
//链接：https://www.jianshu.com/p/6cd6ec8d5b4f

extension ThirdVC{

    enum StydentType {
        case pupil
        case middleSchoolStudent
        case collegeStudent
    }


    enum StudentType1: Int{
          case pupil = 10
          case middleSchoolStudent = 15
          case collegeStudents = 20
    }
    
    enum StudentType2 {
        case pupil(String)
        case middleSchoolStudent(Int, String)
        case collegeStudents(Int, String)
    }
    
    struct Student3 {
        var chinese: Int
        var math: Int
        var english: Int
     }
    
    struct Student4 {
        var chinese: Int = 50
        var math: Int = 50
        var english: Int = 50

        init() {}
        init(chinese: Int, math: Int, english: Int) {
            self.chinese = chinese
            self.math = math
            self.english = english
        }
        init(stringScore: String) {
            let cme = stringScore.split(separator: ",")
            chinese = Int(atoi(String(cme.first!)))
            math = Int(atoi(String(cme[1])))
            english = Int(atoi(String(cme.last!)))
        }
        //修改数学成绩
            mutating func changeMath(num: Int) {
                self.math += num
            }
    }
    // Person 类
    class Person1 {
          var name: String = "jack"
          let life: Int = 1
    }
    // People 结构体数据结构
    struct People1 {
          var name: String = "jack"
          let life: Int = 1
    }
    /**
    Swift主要为我们提供了以下四种”named types“ 分别是：enum、struct、class和protocol。相信熟悉iOS开发的同学们对于枚举、结构体和类的概念一点都不陌生。相比于前辈Objective-C中的这三者，Swift将enum和struct变得更加灵活且强大，并且赋予了他们很多和class相同的属性实现更加丰富多彩的功能，以至于有时候我们很难分清他们到底有什么区别以及我该什么时候用哪种类型，接下来本文将重点介绍一下在Swift中enum和struct的定义和新特性以及两者与class之间的异同，也是自己学习Swift以来的阶段性总结。

    枚举（enum）

    枚举的定义：

    Swift中的枚举是为一组有限种可能性的相关值提供的通用类型（在C/C++/Objective-C中，枚举是一个被命名的整型常数的集合）；使用枚举可以类型安全并且有提示性地操作这些值。与结构体、类相似，使用关键词enum来定义枚举，并在一对大括号内定义具体内容包括使用case关键字列举成员。就像下面一样：

    //定义一个表示学生类型的全新枚举类型 StudentType，他有三个成员分别是pupil（小学生，玩LOL最怕遇到这种队友了）、middleSchoolStudent（中学生，现在的中学生都很拽）、collegeStudents（大学生，据说大学生活很不错，注意断句）
    enum StudentType {
        case pupil
        case middleSchoolStudent
        case collegeStudent
    }
    上面的代码可以读作：如果存在一个StudentType的实例，他要么是pupil （小学生）、要么是middleSchoolStudent（中学生）、要么是collegeStudent（大学生）。注意，和C、Objective-C中枚举的不同，Swift 中的枚举成员在被创建时不会分配一个默认的整数值。而且不需要给枚举中的每一个成员都提供值(如果你需要也是可以的)。如果一个值（所谓“原始值”）要被提供给每一个枚举成员，那么这个值可以是字符串、字符、任意的整数值，或者是浮点类型（引自文档翻译）。简单说Swift中定义的枚举只需要帮助我们表明不同的情况就够了，他的成员可以没有值，也可以有其他类型的值（不局限于整数类型）。
    枚举中有两个很容易混淆的概念：原始值(raw value)、关联值(associated value)，两个词听起来比较模糊，下面简单介绍一下：

    枚举的原始值(raw value)
    枚举成员可以用相同类型的默认值预先填充，这样的值我们称为原始值(raw value)，下面的StudentType中三个成员分别被Int类型的10、15、 20填充表示不同阶段学生的年龄。注意：Int修饰的是StudentType成员原始值的类型而不是StudentType的类型，StudentType类型从定义开始就是一个全新的枚举类型。

    enum StudentType: Int{
          case pupil = 10
          case middleSchoolStudent = 15
          case collegeStudents = 20
    }
    定义好StudentType成员的原始值之后，我们可以使用枚举成员的rawValue属性来访问成员的原始值，或者是使用原始值初始化器来尝试创建一个枚举的新实例

    //  常量student1值是 10
    let student1 = StudentType.pupil.rawValue
    //  变量student2值是 15
    var student2 = StudentType.middleSchoolStudent.rawValue
    //  使用成员rawValue属性创建一个`StudentType`枚举的新实例
    let student3 = StudentType.init(rawValue: 15)
    //  student3的值是 Optional<Senson>.Type
    type(of: student3)
    //  student4的值是nil，因为并不能通过整数30得到一个StudentType实例的值
    let student4 = StudentType.init(rawValue: 30)
    使用原始值初始化器这种方式初始化创建得到StudentType的实例student4是一个StudentType的可选类型，因为并不是给定一个年龄就能找到对应的学生类型，比如在StudentType中给定年龄为30就找不到对应的学生类型（很可能30岁的人已经是博士了）。所以原始值初始化器是一个可失败初始化器。
    总结一句：原始值是为枚举的成员们绑定了一组类型必须相同值不同的固定的值（可能是整型，浮点型，字符类型等等）。这样很好解释为什么提供原始值的时候用的是等号。

    * 枚举的关联值(associated value)

    关联值和原始值不同，关联值更像是为枚举的成员们绑定了一组类型，不同的成员可以是不同的类型(提供关联值时用的是括号)。例如下面的代码：

    //定义一个表示学生类型的枚举类型 StudentType，他有三个成员分别是pupil、middleSchoolStudent、collegeStudents
    enum StudentType {
        case pupil(String)
        case middleSchoolStudent(Int, String)
        case collegeStudents(Int, String)
    }
    这里我们并没有为StudentType的成员提供具体的值，而是为他们绑定了不同的类型，分别是pupil绑定String类型、middleSchoolStudent和collegeStudents绑定（Int， String）元祖类型。接下来就可以创建不同StudentType枚举实例并为对应的成员赋值了。

        //student1 是一个StudentType类型的常量，其值为pupil（小学生），特征是"have fun"（总是在玩耍）
    let student1 = StudentType.pupil("have fun")
        //student2 是一个StudentType类型的常量，其值为middleSchoolStudent（中学生），特征是 7, "always study"（一周7天总是在学习）
    let student2 = StudentType.middleSchoolStudent(7, "always study")
        //student3 是一个StudentType类型的常量，其值为collegeStudent（大学生），特征是 7, "always LOL"（一周7天总是在撸啊撸）
    let student3 = StudentType.middleSchoolStudent(7, "always LOL")
    这个时候如果需要判断某个StudentType实例的具体的值就需要这样做了：

    switch student3 {
          case .pupil(let things):
              print("is a pupil and \(things)")
          case .middleSchoolStudent(let day, let things):
              print("is a middleSchoolStudent and \(day) days \(things)")
          case .collegeStudent(let day, let things):
              print("is a collegeStudent and \(day) days \(things)")
        }
    控制台输出：is a collegeStudent and 7 days always LOL，看到这你可能会想，是否可以为一个枚举成员提供原始值并且绑定类型呢，答案是不能的！因为首先给成员提供了固定的原始值，那他以后就不能改变了；而为成员提供关联值(绑定类型)就是为了创建枚举实例的时候赋值。这不是互相矛盾吗。

    * 递归枚举

    递归枚举是拥有另一个枚举作为枚举成员关联值的枚举（引自文档翻译）。
    关于递归枚举我们可以拆封成两个概念来看：递归 + 枚举。递归是指在程序运行中函数（或方法）直接或间接调用自己的这样一种方式，其特点为重复有限个步骤、格式较为简单。下面是一个经典的通过递归算法求解n!（阶乘）的函数。

    func factorial(n: Int)->Int {
          if n > 0 {
              return n * factorial(n: n - 1)
          } else {
              return 1
          }
      }
      //1 * 2 * 3 * 4 * 5 * 6 = 720
      let sum = factorial(n: 6)
    函数factorial (n: int)-> Int在执行过程中很明显的调用了自身。结合枚举的概念我们这里可以简单的理解为递归枚举类似上面将枚举值本身传入给成员去判断的情况。因为实在没找到很好体现递归枚举的例子，而且本人对递归枚举的使用场景都用在哪些地方还不是很了解，所以呢这里就不献丑了。

    可以看出Swift中枚举变得更加灵活和复杂，有递归枚举的概念，还有很多和Class类似的特性，比如：计算属性用来提供关于枚举当前值的额外信息；实例方法提供与枚举表示值相关的功能；定义初始化器来初始化成员值；而且能够遵循协议来提供标准功能等等，由于笔者目前还没有更加深入的学习这些东西，所以这些内容有机会将在后面的章节讲到。

    结构体（struct）

    * 结构体的定义：

    结构体是由一系列具有相同类型或不同类型的数据构成的数据集合。结构体是一种值类型的数据结构，在Swift中常常使用结构体封装一些属性甚至是方法来组成新的复杂类型，目的是简化运算。我们通过使用关键词struct来定义结构体。并在一对大括号内定义具体内容包括他的成员和自定义的方法（是的，Swift中的结构体有方法了），定义好的结构体存在一个自动生成的成员初始化器，使用它来初始化结构体实例的成员属性。废话不多说直接上代码：

     //定义一个 Student（学生）类型的结构体用于表示一个学生，Student的成员分别是语、数、外三科`Int`类型的成绩
     struct Student {
        var chinese: Int
        var math: Int
        var english: Int
     }
    看到这里熟悉Swift的同学可能已经发现了一点结构体和类的区别了：定义结构体类型时其成员可以没有初始值。如果使用这种格式定义一个类，编译器是会报错的，他会提醒你这个类没有被初始化。

    结构体实例的创建 ：
    创建结构体和类的实例的语法非常相似，结构体和类两者都能使用初始化器语法来生成新的实例。最简单的语法是在类或结构体名字后面接一个空的圆括号，例如 let student1 = Student()。这样就创建了一个新的类或者结构体的实例，任何成员都被初始化为它们的默认值（前提是成员均有默认值）。但是结合上面的代码，由于在定义Student结构体时我们并没有为他的成员赋初值，所以let student1 = Student()在编译器中报错了，此处报错并不是因为不能这样创建实例而是因为student1成员没有默认值，所以我们可以使用下面的方式创建实例：
     //使用Student类型的结构体创建Student类型的实例（变量或常量）并初始化三个成员（这个学生的成绩会不会太好了点）
     let student2 = Student(chinese: 90, math: 80, english: 70)
    所有的结构体都有一个自动生成的成员初始化器，你可以使用它来初始化新结构体实例的成员就像上面一样（前提是没有自定义的初始化器）。如果我们在定义Student时为他的成员赋上初值，那么下面的代码是编译通过的：

    struct Student {
        var chinese: Int = 50
        var math: Int = 50
        var english: Int = 50
    }
    let student2 = Student(chinese: 90, math: 80, english: 70)
    let student4 = Student()
    总结一句：定义结构体类型时其成员可以没有初始值，但是创建结构体实例时该实例的成员必须有初值。

    自定义的初始化器

    当我们想要使用自己的方式去初始化创建一个Student类型的实例时，系统提供的成员初始化器可能就不够用了。例如，我们希望通过形如：let student5 = Student(stringScore: "70,80,90")的方式创建实例时，就需要自定义初始化方法了：

    struct Student {
        var chinese: Int = 50
        var math: Int = 50
        var english: Int = 50
            init() {}
            init(chinese: Int, math: Int, english: Int) {
                  self.chinese = chinese
                  self.math = math
                 self.english = english
            }
            init(stringScore: String) {
                 let cme = stringScore.characters.split(separator: ",")
                 chinese = Int(atoi(String(cme.first!)))
                 math = Int(atoi(String(cme[1])))
                 english = Int(atoi(String(cme.last!)))
            }
        }
        let student6 = Student()
        let student7 = Student(chinese: 90, math: 80, english: 70)
        let student8 = Student(stringScore: "70,80,90")
    一旦我们自定义了初始化器，系统自动的初始化器就不起作用了，如果还需要使用到系统提供的初始化器，在我们自定义初始化器后就必须显式的定义出来。

    定义其他方法

    如果此时需要修改某个学生某科的成绩，该如何实现呢？当然，我们可以定义下面的方法：

    //更改某个学生某门学科的成绩
    func changeChinese(num: Int, student: inout Student){
        student.chinese += num
    }
    changeChinese(num: 20, student: &student7)
    此时student7的语文成绩就由原来的90被修改到了110，但是此方法有两个明显的弊端：1，学生的语文成绩chinese是Student结构体的内部成员，一个学生的某科成绩无需被Student的使用者了解。即我们只关心学生的语文成绩更改了多少，而不是关心学生语文成绩本身是多少。2，更改一个学生的语文成绩本身就是和Student结构体内部成员计算相关的事情，我们更希望达到形如：student7.changeChinese(num: 10)的效果，因为只有学生本身清楚自己需要将语文成绩更改多少（更像是面向对象封装的思想）。很明显此时changeChinese(num:)方法是Student结构体内部的方法而不是外部的方法，所以我定义了一个修改某个学生数学成绩的内部方法用于和之前修改语文成绩的外部方法对比：

    struct Student {
        var chinese: Int = 50
        var math: Int = 50
        var english: Int = 50
       //修改数学成绩
        mutating func changeMath(num: Int) {
            self.math += num
        }
      }
      var student7 = Student(chinese: 20, math: 30, english: 40)
      //更改分数中语文学科的成绩
      func changeChinese(num: Int, student: inout Student){
          student.chinese += num
        }
      changeChinese(num: 20, student: &student7)
      student7.changeMath(num: 10)
    尽管两者都能达到同样的效果，但是把修改结构体成员的方法定义在结构体内部显得更加合理同时满足面向对象封装的特点。以上两点就是我们为Student结构体内部添加changeMath(num:)的原因，他让我们把类型相关的计算表现的更加自然和统一，即自己的事情应该用自己的方法实现不应该被别人关心。值得一提的是在结构体内部方法中如果修改了结构体的成员，那么该方法之前应该加入：mutating关键字。

    由于结构体是值类型，Swift规定不能直接在结构体的方法（初始化器除外）中修改成员。原因很简单，结构体作为值的一种表现类型怎么能提供改变自己值的方法呢，但是使用mutating我们便可以办到这点，当然这也是和类的不同点。

    常见的结构体

    Swift中很多的基础数据类型都是结构体类型，下面列举的是一些常用的结构体类型：

    //表示数值类型的结构体：
        Int，Float，Double，CGFloat...
    //表示字符和字符串类型的结构体
        Character，String...
    //位置和尺寸的结构体
        CGPoint，CGSize...
    //集合类型结构体
        Array，Set，Dictionary...
    很多时候你不细心观察的话可能不会想到自己信手拈来的代码中居然藏了这么多结构体。另外有时候在使用类和结构体的时候会出现下面的情况

    // Person 类
    class Person {
          var name: String = "jack"
          let life: Int = 1
    }
          var s1 = Person()
          var s2 = s1
           s2.name = "mike"
           s1
    // People 结构体数据结构
    struct People {
          var name: String = "jack"
          let life: Int = 1
    }
          var p1 = People()
          var p2 = p1
            p2.name = "mike"
            p1
    细心的同学可能已经发现了其中的诡异。变量s1、s2是Person类的实例，修改了s2的name属性，s1的name也会改变；而p1、p2作为People结构体的实例，修改了p1的name属性，p2的name并不会发生改变。这是为什么呢？总结中告诉你。

    总结

    枚举、结构体、类的共同点：

    1，定义属性和方法；
    2，下标语法访问值；
    3，初始化器；
    4，支持扩展增加功能；
    5，可以遵循协议；

    类特有的功能:

    1，继承；
    2，允许类型转换；
    3，析构方法释放资源；
    4，引用计数；

    类是引用类型:

    引用类型(reference types，通常是类)被复制的时候其实复制的是一份引用，两份引用指向同一个对象。所以在修改一个实例的数据时副本的数据也被修改了(s1、s2)。

    枚举,结构体是值类型

    值类型(value types)的每一个实例都有一份属于自己的数据，在复制时修改一个实例的数据并不影响副本的数据(p1、p2)。值类型和引用类型是这三兄弟最本质的区别。

    我该如何选择

    关于在新建一个类型时如何选择到底是使用值类型还是引用类型的问题其实在理解了两者之间的区别后是非常简单的，在这苹果官方已经做出了非常明确的指示（以下内容引自苹果官方文档）：

    当你使用Cocoa框架的时候，很多API都要通过NSObject的子类使用，所以这>时候必须要用到引用类型class。在其他情况下，有下面几个准则：
    什么时候该用值类型：
    要用==运算符来比较实例的数据时
    你希望那个实例的拷贝能保持独立的状态时
    数据会被多个线程使用时
    什么时候该用引用类型（class）：
    要用==运算符来比较实例身份的时候
    你希望有创建一个共享的、可变对象的时候
    相对于 Objective-C 中的结构体，Swift 对结构体的使用比重大了很多，结构体成为了实现面向对象的重要工具。Swift 中的结构体与 C++ 和 Objective-C 中的结构体有很大的差别，C++ 和 Objective-C 中的结构体只能定义一组相关的成员变量，而 Swift 中的结构体不仅可以定义成员变量（属性），还可以定义成员方法。因此，我们可以把结构体看做是一种轻量级的类。Swift 中类和结构体非常类似，都具有定义和使用属性、方法、下标和构造器等面向对象特性，但是结构体不具有继承性，也不具备运行时强制类型转换、使用析构器和使用引用计等能力。Swift 中 struct 是值类型，而 class 是引用类型，所以这篇文章 struct 的行为也可以用到所有的值类型上面，相同地 class 的行为也可以用到引用类型上。值类型的变量直接包含他们的数据，而引用类型的变量存储对他们的数据引用，因此后者称为对象，因此对一个变量操作可能影响另一个变量所引用的对象。对于值类型都有他们自己的数据副本，因此对一个变量操作不可能影响另一个变量。

    1.类和结构体定义

    Swift中的类和结构体定义的语法是非常相似的。我们可以使用 class 关键词定义类，使用 struct 关键词定义结构体，它们的语法格式如下：

    // 定义类

    class 类名 {

    定义类的成员

    }

    // 建立一个 class 名称为 ClassCoder

    class ClassCoder {

    var name = "IAMCJ"

    var age = 0

    }

    // 定义结构体

    struct 结构体名 {

    定义结构体的成员

    }

    // 建立一个 struct 名称为 StructCoder

    struct StructCoder {

    var name = "IAMCJ"

    var age = 0

    }

    2.类和结构体实例化

    // 类实例化

    let classCoder = ClassCoder()

    // class 不能直接用 ClassCoder(name:"CJ",age:18) 必需要自己创建构造函数才可以

    classCoder.name = "CJ"

    classCoder.age = 18

    // 结构体实例化

    var structCoder = StructCoder(name:"CJ",age:18)

    // 另外一种实例化方法

    var structCoder = StructCoder()

    structCoder.name = "CJ"

    structCoder.age = 18

    区别：class 在实例化的时候不能自动把 property 放在 constructor 的参数里面去，想要和 struct 一样的效果就需要我们自己去创建构造函数了。

    赋值给另外一个变量

    // 类赋值

    let classCoder = ClassCoder()

    classCoder.name = "CJ"

    classCoder.age = 18

    // classCoder.name=CJ,classCoder.age=18

    let classCoder1 = classCoder

    classCoder1.name = "NOTCJ"

    classCoder1.age = 100

    // classCoder.name=NOTCJ,classCoder.age=100,classCoder1.name=NOTCJ,classCoder1.age=100

    // 结构体赋值

    var structCoder = StructCoder()

    structCoder.name = "CJ"

    structCoder.age = 18

    // structCoder.name=CJ,structCoder.age=18

    var structCoder1 = structCoder

    structCoder1.name = "NOTCJ"

    structCoder1.age = 100

    // structCoder.name=CJ,structCoder.age=18,structCoder1.name=NOTCJ,structCoder1.age=100

    区别：class 是引用类型，顾名思义在赋值的时候只是给另外一个变量赋予了一个引用的效果，而 struct 是值类型，它会复制一份完全相同的内容给另外一个变量，从上面的测试可以清晰的分辨出他们的不同之处。结合这篇文章可能能让你更好的理解。

    是否可变

    let classCoder = ClassCoder()

    classCoder.name = "CJ"

    classCoder.age = 18

    // 此处可以修改

    let structCoder = StructCoder()

    structCoder.name = "CJ"

    区别：let 在 class 上并不会报错。但是 Swift 常用的 String, Array, Dictionary 都是 struct，所以 let 是会有效果的，这里需要大家注意一下。

    5. mutating 关键字

    //在不修改原 class 和 struct 的情况下添加一个 method：modifyCoderName(newName:)

    // 类

    class ClassCoder {

    var name = "IAMCJ"

    var age = 0

    }

    extension ClassCoder {

    func modifyCoderName(newName:String) {

    self.name = newName

    }

    }

    // 结构体

    struct StructCoder {

    var name = "IAMCJ"

    var age = 0

    }

    extension StructCoder {

    mutating func modifyCoderName(newName:String) {

    self.name = newName

    }

    }

    区别：struct 在 function 里面需要修改 property 的时候需要加上 mutating 关键字，而 class 就不用了。

    6.关于继承

    // 创建一个 继承与 ClassCoder 类的 ClassSwiftCoder：

    class ClassCoder {

    var name = "IAMCJ"

    var age = 0

    }

    extension ClassCoder {

    func modifyCoderName(newName:String) {

    self.name = newName

    }

    }

    class ClassSwiftCoder:ClassCoder {

    }

    // 实例化一个 Swift 程序员 ClassSwiftCoder：

    let swiftCoder = ClassSwiftCoder()

    swiftCoder.name = "CJ"

    swiftCoder.name = "18"

    swiftCoder.modifyCoderName(newName: "帅")

    */
   
}
