defmodule Pushups.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json],
                   pass:  ["text/*"],
                   json_decoder: Poison
  plug :match
  plug :dispatch

  def start_link do
    Plug.Adapters.Cowboy.http(Pushups.Router, [])
  end

  get "/" do
    conn
    |> send_resp(200, "Plug!")
  end

  post "/boop" do
    IO.puts "post!"
    IO.puts inspect conn.body_params, pretty: true, limit: 30000

    # resp = %{fulfillment: %{ speech: "Gregor", displayText: "Gregor", source: "agent"}}

    resp = conn.body_params
    |> Map.get("result")
    |> Map.get("fulfillment")
    |> Map.put("speech", "cool story bro!!!!!!!!")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(resp))
  end

  test "" do

    msg = %{"id" => "e10c77c8-3f20-485f-8f3d-d879f5f07cbf", "lang" => "en",
      "result" => %{"action" => "input.welcome", "actionIncomplete" => false,
        "contexts" => [%{"lifespan" => 2, "name" => "defaultwelcomeintent-followup",
           "parameters" => %{}}],
        "fulfillment" => %{"messages" => [%{"speech" => "Hi! Are you ready to do some pushups? :-)",
             "type" => 0}],
          "speech" => "Hi! Are you ready to do some pushups? :-)"},
        "metadata" => %{"intentId" => "3bb1908c-c8d9-43d0-a51f-37ceb74dcca8",
          "intentName" => "Default Welcome Intent",
          "webhookForSlotFillingUsed" => "false", "webhookUsed" => "true"},
        "parameters" => %{}, "resolvedQuery" => "Hi", "score" => 1.0,
        "source" => "agent", "speech" => ""},
      "sessionId" => "d8e0a474-43fc-4b9e-961d-41fd34c87a44",
      "status" => %{"code" => 200, "errorType" => "success"},
      "timestamp" => "2017-04-01T19:50:32.356Z"}

  end


end
