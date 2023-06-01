# Go - Useful Code Snippets



## Unmarshal JSON to Struct

```go
type ResultingStruct struct {
	Value       float32       `json:"value"`
	Description string        `json:"description"`
}	

func convertJsonToStruct(inputJson string) ResultingStruct {
	var resultingStruct ResultingStruct
	byteData := []byte(inputJson)
  
	err := json.Unmarshal(byteData, &ResultingStruct)  
}
```



## Unmarshal JSON to Map Structure

```go
type ResultingStruct struct {
	Value       float32       `json:"value"`
	Description string        `json:"description"`
  
  // optional
  Explanation AnotherObject `json:"explanation"`
}	

func convertJsonToMap(inputJson string) ResultingStruct {
	var result map[string]interface{}
	err := json.Unmarshal([]byte(inputJson), &result)
	
  // If you want to extract a field and it's childs (array, another object etc.) then use the following
	explanation := result["explanation"].(map[string]interface{}) 
}
```



## Custom toString() function

```go
type CustomStruct struct {
	Name string
}	

func (cs CustomStruct) String() string {
  return fmt.Sprintf()"Your custom string: %s", cs.name)
}
```