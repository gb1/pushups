defmodule RoutineTest do
  use ExUnit.Case
  alias Pushups.{Routine}

  @json %{"id" => "0d1c919b-39b0-4f28-8024-ed94229fd643", "lang" => "en",
  "result" => %{"action" => "input.welcome", "actionIncomplete" => false,
    "contexts" => [],
    "fulfillment" => %{"messages" => [%{"speech" => "", "type" => 0}],
      "speech" => ""},
    "metadata" => %{"intentId" => "3bb1908c-c8d9-43d0-a51f-37ceb74dcca8",
      "intentName" => "Default Welcome Intent",
      "webhookForSlotFillingUsed" => "false", "webhookUsed" => "true"},
    "parameters" => %{}, "resolvedQuery" => "Hi", "score" => 1.0,
    "source" => "agent", "speech" => ""},
  "sessionId" => "29426390-9f20-4a19-b433-ce45d660dc45",
  "status" => %{"code" => 200, "errorType" => "success"},
  "timestamp" => "2017-04-05T18:49:41.263Z"}

  test "extract the session id from the json" do

    assert Routine.get_session_id(@json)
      == "29426390-9f20-4a19-b433-ce45d660dc45"
      
  end

end
