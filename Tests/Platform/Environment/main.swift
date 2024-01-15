import Test
import Platform

test("Environment") {
    expect(Environment["test"] == nil)
    Environment["test"] = "value"
    expect(Environment["test"] == "value")
}

test("DynamicMemberLookup") {
    expect(Environment.test == "value")
    Environment.test = "dynamic lookup value"
    expect(Environment.test == "dynamic lookup value")
}

test("values") {
    expect(Environment.values.count > 0)
    expect(Environment.values["test"] == "dynamic lookup value")
    Environment["test"] = "value"
    expect(Environment.values["test"] == "value")
}

test("Environment values with equal sign in the value") {
    expect(Environment["test"] == "value")
    Environment["test"] = "test=test"
    expect(Environment.values["test"] == "test=test")
}

await run()
