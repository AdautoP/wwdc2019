//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, injectHormone(), extractOvules())
//#-end-hidden-code

//#-hidden-code

// This Won't be shown
import PlaygroundSupport
func injectHormone(){
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        
//        let action = .string("inject")
//        let target = .string("target")
//        let message = .dictionary(["action": action, "target": target])
        
        controller.send(.string("injectHormone"))
    }
}

func extractOvules(){
    if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
        controller.send(.string("extractOvules"))
    }
}

//#-end-hidden-code


//#-hidden-code
// Beneath there is a markdown block
//#-end-hidden-code

/*:
 
 # Estimulation
 ## Subtitle
 
 ### Paragraph
 
 Normal Text
 
 - Important:
 There are some other kinds of highlights.
 
 - Note:
 Give me an E Major, conductor.
 
 + Important:
 This is very cool.
 
 + Example:
 This is an example.
 
 # Photo:
 ![Description of Photo](Alysson.HEIC "Um cara diferenciado")
 
 # List:
 * First item
 * Second Item
 
 # Link to Web:
 [Apple Site](htttp://www.apple.com)
 
 # Link to other Pages:
 [Next Page: Num Sei](@next)
 
 Now, try to inject hormones with code.
 
 
 */



/*#-editable-code Try injecting the hormone*//*#-end-editable-code*/

