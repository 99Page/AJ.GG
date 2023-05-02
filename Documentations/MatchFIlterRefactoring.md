# Null object pattern 

null 값을 사용했을 때의 문제는 두가지가 있다. 
1. null 검사를 누락하면 Null pointor exception이 발생한다. 
2. null 검사 과정으로 인해 pyramid of doom이 생기고 가독성이 떨어진다. 

스위프트는 옵셔널 체이닝으로 인해 1번의 문제에서는 자유로울 수 있으나 가독성이 떨어지는 문제에서는 자유롭지 못하다. 

```swift
struct MatchFilterContext: {
    var myChampionFilterStrategy: MatchFilterStrategy?
    var rivalChampionFilterStrategy: MatchFilterStrategy?
    
    func execute(_ matches: [Match]) -> [Match] {
        
        var result: [Match] = matches
        
        if let myChampionFilterStrategy = myChampionFilterStrategy {
            result = myChampionFilterStrategy.filter(result)
        }
        
        if let rivalChampionFilterStrategy = rivalChampionFilterStrategy {
            result = rivalChampionFilterStrategy.filter(result)
        }
        
        return result
    }
}
``` 

nil 타입이 한개만 쓰여서 비교적 읽기 쉬운 코드이지만 nil 타입의 객체 내부에 또 nil 타입이 있다면 2단게 중첩만으로도 더러운 코드가 될 것이다. 

Null object pattern을 이용해서 코드를 더 읽기 쉽게 해줄 수 있다. 

```swift
struct NullFilterStrategy: MatchFilterStrategy {
    func filter(_ matches: [Match]) -> [Match] {
        return matches
    }
}

struct MatchFilterContext: {
    var myChampionFilterStrategy: MatchFilterStrategy = NullFilterStrategy()
    var rivalChampionFilterStrategy: MatchFilterStrategy = NullFilterStrategy()
    
    func execute(_ matches: [Match]) -> [Match] {
        
        var result: [Match] = matches
        
        result = myChampionFilterStrategy.filter(result)
        result = rivalChampionFilterStrategy.filter(result)
        
        return result
    }
}
``` 

Null object pattern은 null 타입 대신에 아무 동작도 하지 않는 객체를 이용해주는 패턴이다. `NullFilterStrategy`를 보면 parameter를 그대로 반환해주고 있다. 

# Decorator pattern 

`MatchFilterContext`는 `MatchFilterStrategy`를 준수하는 두가지 객체를 갖고있다. 여기서 파생된 문제점은 `myChampionFilterStrategy`에 실제로는 상대 챔피언을 이용해 필터링 해주는 객체가 들어갈 수 있다는 점이다. Strategy pattern은 알고리즘의 흐름을 분기해주고 상황에 맞는 알고리즘을 적절히 사용하기에 좋은 패턴이고, 같은 프로토콜을 준수하는 프로퍼티를 갖고 있으면 좋지 않다는 것을 느꼈다.

기존의 기능을 확장해주는데 유용한 것은 Decorator pattern이다. Strategy pattern을 이용한 필터링을 모두 없애고 Decorator pattern으로 모두 바꾸었다. 코드는 생략한다. 

# 결론 

이번 리팩토링을 통해 배운 점은 세가지다.
1. Strategy pattern과 Null object pattern은 좋은 조합이다.
2. Strategy context에 같은 프로토콜을 준수하는 프로퍼티가 있으면 안 된다. 
3. 2번 문제가 우려될 경우 Decorator pattern을 고려하자. 

