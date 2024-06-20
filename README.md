# Amazing Quizz

## Prerequisites:
- iOS 17, ipadOS 17
- Xcode 15
- Swift 5

_French version below (original version)_

## English
Amazing Quizz is a quiz application available on **iOS** and **ipadOS**, which allows the user to create collections of quizzes, in which the user can create several questions.

Amazing Quizz was born out of a need I had in my first academic year, which was to revise my lessons and in particular specific elements of them, such as dates, definitions and key concepts.

Amazing Quizz is based on Apple's frameworks, **SwiftUI** and **SwiftData**. It was created for iOS 17. 

### Warning!
Amazign Quizz is currently 75% complete, but I've encountered a problem displaying the answers in the views responsible for displaying them (**"PageQuestionView "** or **"PlayingQuestionView "**). Unfortunately, this problem persists and is preventing me from continuing to develop the app. In fact, I should complete the logical construction of the navigation, after the user has finished his question collection: so that he is returned to the detail view of the question collection that was playing.
Also, I'd like to integrate a better architecture into my application. I didn't do this when I first created Amazing Quizz, because Apple's **SwiftData** framework had just been launched and iOS developers, notably Paul Hudson (Hacking With Swift), had noted that **SwiftData** had difficulty integrating with a software architecture such as **"MVVM "**. However, now that the framework has celebrated its 1 year of existence, I'm thinking of looking at techniques/methods to make **SwiftData** "compatible" with **MVMM**.

### Last notes:
- The **"ResultView "** view isn't finished at all, I didn't want to go any further because of problems displaying answers in the **"PageQuestionView "** or **"PlayingQuestionView "** view.
- In the **"QuestionCollectionLandscapeView "** view, the **QuestionCollectionSortingLandscapeView** sub-view which is entitled to display question collections in the sidebar, I'm having problems with the item selection effect, which is the default.
- I've tested two approaches to managing the display of questions and answers, using a "test" view, **PlayingQuestionView** which is based on Apple's Navigation API. Note that I sometimes get route errors due to incorrect use of the Navigation API (which I haven't managed to debug).


## French
Amazing Quizz est une application de quiz disponible sur **iOS** et **ipadOS**, qui permet à l'utilisateur de créer des collections de quiz, dans lesquelles l'utisateur peut créer plusieurs questions.

L'origine d'Amazing Quizz vient d'un besoin que j'ai éprouvé lors de ma première année académique, qui était de réviser mes cours et notamment des éléments précis de ces derniers, comme des dates, des définitions et des notions clées.

Amazing Quizz repose sur les frameworks d'Apple, **SwiftUI** et **SwiftData**. Elle a été créer sous iOS 17. 

### Avertissement !
A l'heure actuelle, Amazign Quizz est complète à 75%, j'ai rencontré un problème dans laffichage des réponses, dans les views responsables de l'affichage (**"PageQuestionView"** ou **"PlayingQuestionView"**). Malheureusement, ce problème perxiste et m'empêche de continuer le déveleoppement de l'app. En effet, je devrais terminer la construction logique de la navigation, après que l'utilisateur a fini sa collection de question: pour qu'il soit renvoyé a la view détail de la collection de question qui jouait.
Aussi, j'aimerais intégrer une meilleure architecture à mon application. Je ne l'ai pas fait dès le début de la création d'Amazing Quizz, car le framework **SwiftData** d'Apple venait d'être lancé et les développeurs iOS, et notamment Paul Hudson (Hacking With Swift) avait noté que **SwiftData** s'intégrait avec difficulté à une architecture logicielle, comme **"MVVM"**. Cepandant, maintenant que le framework a fêter ses 1 an d'existance, je pense regarder à des techniques/méthodes pour rendre **SwiftData** "compatible" avec **MVMM**.

### Dernières notes:
- La view **"ResultView"** n'est pas du tout finie, je n'ai plus eu envie d'avancées à cause des soucis d'affichage des réponses dans la view **"PageQuestionView"** ou **"PlayingQuestionView"**.
- Dans la view **"QuestionCollectionLandscapeView"** la sous view **QuestionCollectionSortingLandscapeView** qui droit afficher les collections de question dans la "sidebar", j'ai un souci avec l'effet de sélection de l'élément, qui est par défaut.
- J'ai testé deux approches pour gérer l'affichage des questions et des réponses, à travers d'une view "test", **PlayingQuestionView** qui s'appuie sur l'API Navigation d'Apple. A noter que j'ai parfois des erreurs de routes à cause d'une mauvaise utilisation d'API Navigation (que je n'ai pas réussi à débuguer).
