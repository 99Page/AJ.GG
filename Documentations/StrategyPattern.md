# Strategy Pattern 

## 도입 

프로젝트를 진행하면서 객체지향과 테스트 주도 개발을 적극적으로 사용해보기로 했다. 두개다 개념만 알고있지 실제로는 어떻게 해야 제대로 적용하는지 모르고있어서 책을 사서 읽어보고 하나씩 적용할 예정이다. 우선은 객체지향부터 시작했다. 

'개발자가 반드시 정복해야 할 객체지향과 디자인 패턴' 이라는 책을 구매했다. 객체지향의 4대 속성과 5대 법칙을 배웠는데 이 내용들은 내가 코드로는 표현을 잘 못하고 있어도 강의에 들어본 적은 있는 내용들이다. 책의 가장 후반부인 디자인 패턴은 처음 본 내용들이 나오는데 첫 내용이 바로 전략 패턴(Strategy Pattern)이다. 

## 어디에 적용되어야 하는가? 

Strategy Pattern뿐 아니라 다른 디자인 패턴들, 그리고 추상화 및 SOLID가 적용되어야 하는 부분은 어느 정도 명확한 것 같다.'변화가 발생하는 곳'에 적용되어야 한다. 그리고 변화가 일어나는 곳은 일반적으로 타입캐스팅이나 if else 문을 사용하고 있다. 

Strategy Pattern은 그 중에서도 특히, 비슷한 알고리즘을 선택적으로 사용해야 할 때 적용되어야 한다. 

```swift
private func fetchEntities() {
    var predicate: NSPredicate

    if isMyChampion {
        predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.myChampionID), champion.name)
    } else {
        predicate = NSPredicate(format: "%K == %@", #keyPath(CDMatch.enemyChampionID), champion.name)
    }

    let predicate: NSPredicate = context.predicate(championName: championName)
    
    self.matches = matchManager.fetchEntites(predicate: predicate).map({ Match($0) })
}

var championWithRates: [ChampionWithRate] {
    // 생략 
}

var myChampionWithRates: [ChampionWithRate] {
    // 생략 
}

var rates: [ChampionWithRate] {
    if self.isMyChampion {
        return championWithRates
    } else {
        return myChampionWithRates
    }
}
``` 

if else 문이 사용되는 코드만 개선되어도 많은 부분이 개선된다. 이전 프로젝트인 'Ren2U'도 마찬가지고 이번 프로젝트인 'AJ.GG'에서도 if else 문은 자주 사용되고 있었다. 

## 추상화 하기 

if문을 살펴보면 두가지에 대한 추상화가 필요하다. 

1. 코어데이터에 적용할 NSPredicate 
2. 코어데이터에서 Match를 가져온 후 ChampionWithRate로 나타내기 위한 알고리즘 

2번이 상황에 따라 다른 알고리즘을 적용해야하는 상황이니 이곳에만 StrategyPattern을 적용하는게 더 맞다고 생각하지만 우선은 편의상 1번과 2번을 모두 한가지 프로토콜에 추상화했다. 

```swift 
potocol RecordStrategy {
     func sort(matches: [Match]) -> [ChampionWithRate]
     func predicate(championName: String) -> NSPredicate
 }

 struct MyRecordStrategy: RecordStrategy {
     func predicate(championName: String) -> NSPredicate {
         NSPredicate(format: "%K == %@", #keyPath(CDMatch.myChampionID), championName)
     }

     func sort(matches: [Match]) -> [ChampionWithRate] {
         var dictionary: [String: [Int]] = [:]

         for match in matches {
             if dictionary[match.rivalChampionName] == nil {
                 dictionary[match.rivalChampionName] = [0, 0]
             }

             if match.isWin {
                 dictionary[match.rivalChampionName]![0] += 1
             } else {
                 dictionary[match.rivalChampionName]![1] += 1
             }
         }

         var result: [ChampionWithRate] = []

         for (k, v) in dictionary {
             let array = v
             result.append(ChampionWithRate(champion: Champion(name: k), win: array[0], lose: array[1]))
         }

         return result
     }
 }


 struct CounterRecordContext {
     var strategy: RecordStrategy

     func sort(matches: [Match]) -> [ChampionWithRate] {
         strategy.sort(matches: matches)
     }

     func predicate(championName: String) -> NSPredicate {
         strategy.predicate(championName: championName)
     }
 }
 ``` 

 이 프로토콜을 사용하는 `ChampionRecordViewModel`은 이제 `RecordStrategy`를 준수하는 새로운 정렬 방식이 나와도 OCP를 지키면서 확장할 수 있다. 