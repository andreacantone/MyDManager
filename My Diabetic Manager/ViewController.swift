//
//  ViewController.swift
//  My Diabetic Manager
//
//  Created by Emmanuele Montagna on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate,UIViewControllerTransitioningDelegate {
    
    
    let transition = CircularTransition()
    var tupla = (name: "", featureArray)
    
    
    
    
    @IBOutlet weak var calcola: UIButton!
    
    @IBOutlet weak var featureScrollView: UIScrollView!
    @IBOutlet weak var featurePageControl: UIPageControl!
    @IBOutlet weak var uncheck_button: UIButton!
    @IBOutlet weak var check_button: UIButton!
    @IBOutlet weak var risultatoInsu: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var VisibleCounterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius=menuButton.frame.size.width / 2
        //   calcola.layer.cornerRadius=calcola.frame.size.width/2
        check_button.layer.cornerRadius=check_button.frame.size.width/2
        uncheck_button.layer.cornerRadius=uncheck_button.frame.size.width/2
        
        
        
        switch tupla.name {
        case "Boiled pasta":
            featureArray=[pasta_mini,pasta_mid,pasta_max]
        case "Gnocchi":
            featureArray=[pasta_mini,pasta_mid,pasta_max]
        case "Rice salad":
            featureArray=[insa_riso_mini,insa_riso_mid,insa_riso_max]
        case "Lasagne":
            featureArray=[lasagne_mini,lasagne_mid,lasagne_max]
        case "Roast chicken":
            featureArray=[pollo_arrosto]
        case "Cutlet":
            featureArray=[cotoletta]
        case "Hamburger":
            featureArray=[hamburger]
        case "Chickpeas":
            featureArray=[ceci_min,ceci_mid,ceci_max]
        case "Beans":
            featureArray=[fagioli_min,fagioli_mid,fagioli_max]
        case "Peas":
            featureArray=[piselli_min,piselli_mid,piselli_max]
        case "Coffe":
            featureArray=[caffe]
        case "Coca Cola":
            featureArray=[coca]
        case "Blonde beer":
            featureArray=[birra_chiara]
        case "Dark beer":
            featureArray=[birra_scura]
        case "Cheesburger":
            featureArray=[panino_hamb]
        case "Pizza Margherita":
            featureArray=[pizza]
        case "Hot Dog":
            featureArray=[hot_dog]
        case "Watermelon":
            featureArray=[anguria]
        case "Orange":
            featureArray=[arancia]
        case "Banana":
            featureArray=[banana]
        case "Sicilian cassata":
            featureArray=[cassata]
        case "Napolitan pastiera":
            featureArray=[pastiera]
        case "Chocolate croissant":
            featureArray=[briosche]
        default: break
            
        }
        
        
        featureScrollView.isPagingEnabled = true
        featureScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(featureArray.count), height: 250)
        featureScrollView.showsHorizontalScrollIndicator = false
        featureScrollView.delegate = self
        
        loadFeatures()
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! secondViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animation")
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    
    func loadFeatures() {
        for (index, feature) in featureArray.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
                featureView.featureImageView.image = UIImage(named: feature["image"]!)
                featureView.weight_uncooked.text = feature["pesoGrammiCrudo"]
                featureView.weigth_cooked.text = feature["pesoGrammiCotto"]
                featureView.cho.text=feature["CHO"]
                featureView.kcal.text=feature["kcal"]
                featureScrollView.addSubview(featureView)
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                
            }
            
        }
        
        
    }
    
    
    func toggleButton(button:UIButton,onImage:UIImage,offImage:UIImage)  {
        if button.currentImage == offImage{
            button.setImage(onImage, for: .normal)
        }
        else{
            button.setImage(offImage, for: .normal)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func push_check(_ sender: Any) {
        
        valore_tot=featureArray[singola_pagina.paginaCorrente]["CHO"]!
        valore_tot=valore_tot.replacingOccurrences(of: ",", with: ".")
        
        totali[singola_pagina.paginaCorrente]+=NSString(string: valore_tot).doubleValue
        contatori[singola_pagina.paginaCorrente]+=1
        visibleCounter+=1
        VisibleCounterLabel.text=String(visibleCounter)
        
        singola_pagina.nomeElemChecked.append(featureArray[singola_pagina.paginaCorrente]["nome"]!)
        print(totali[singola_pagina.paginaCorrente])
        
    }
    
    
    @IBAction func uncheck_push(_ sender: Any) {
        
        valore_tot=featureArray[singola_pagina.paginaCorrente]["CHO"]! //prendo valore di cho per ogni pagina
        valore_tot=valore_tot.replacingOccurrences(of: ",", with: ".")
        
        if (contatori[singola_pagina.paginaCorrente]>0)         //posso sottrarre dal "carrello" solo se ho aggiunto
        {
            totali[singola_pagina.paginaCorrente]-=NSString(string: valore_tot).doubleValue
            contatori[singola_pagina.paginaCorrente]-=1
            visibleCounter-=1               //Contatore della pressione tasti
            VisibleCounterLabel.text=String(visibleCounter)
            
            if !singola_pagina.nomeElemChecked.isEmpty {            //rimuovo dall array della lista di resoconto
                singola_pagina.nomeElemChecked.removeLast()
                
            }
            print(totali[singola_pagina.paginaCorrente])
            
            
            
            
        }
    }
    
    
    
    
    
    @IBAction func calcola_action(_ sender: Any) {
        conta()
    }
    
    
    func conta (){
        let valore_anna:Double=14.0
        var zz:Double=0.0
        for i in totali.indices
        {
            zz+=totali[i]
            print("TOT singolo \(totali[i]) ")
            print("tot array \(appoggio)")
        }
        appoggio=zz
        print("tot array \(appoggio)")
        appoggio2 = appoggio / valore_anna
        risultatoInsu.text=String(appoggio2)
    }
    
    
    
    
    
    @IBAction func menu_check(_ sender: Any) {
                risultatoInsu.text=nil
                VisibleCounterLabel.text=nil
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        featurePageControl.currentPage = Int(page)
        singola_pagina.paginaCorrente = featurePageControl.currentPage
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

