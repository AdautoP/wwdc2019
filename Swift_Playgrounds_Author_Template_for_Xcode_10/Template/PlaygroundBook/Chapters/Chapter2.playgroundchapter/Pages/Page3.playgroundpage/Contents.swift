//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, manualInjection())
import PlaygroundSupport
func manualInjection(){
if let controller = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler{
    
    controller.send(.string("startInsemination"))
    }
}
//#-end-hidden-code

/*:
 
 # Fertilization
 ## Natural Fertilization
 
 ###
 The first type of fertilization is the natural one. In case the sample of sperm is healthy enough, all that need to be done is incubate the ovule with the sperm on a favorable solution and let the fertilization occur.
 
 - Note:
 The ovule produces a chemical that attracts the sperm. Try moving the ovule, the sperm will always try to reach it.
 
 ## Manual Fertilization
 ###
 On the cases where the sperm is not healthy enough, manual fertilization is required. It consists on using a needle to inject the sperm directly inside the ovule.
 ###
 Try injecting the sperm inside the ovule using the command below:
 - Example:
 manualInjection()
 */

/*#-editable-code Try injection*//*#-end-editable-code*/

/*:
 ###
 That's it! The ovule is fertilized and ready to be put in the patient's uterus. Once this is a different technique, it won't be covered in this playground.
 
 # Some extras about IVF:
 * For homossexual women couples, it's possible to get a sperm donor, one of them's ovules and fertilize it and inseminate it on the other one so the couple will have biological children. It's a big advance in medicine.
 * It's even possible that both the sperm and ovule are donated and can be inseminated into the patient. So in cases where both of the couple present any kind of infertility, they can still have children.
 * Sometimes the couple is fertile but the woman can't gestate due another medical problems. In this case, it's even possible that the patients donate the sperm and ovule and find another woman to gestate.
 
 [Next Page: Num Sei](@next)
 
 */
