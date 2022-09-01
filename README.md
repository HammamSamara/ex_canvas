# ExCanvas

Elixir Backend APIs to store and serve Canvases with shapes - currently only supports rectangles.

```Elixir
  "6ad93412-d661-4407-983d-f703e2ecea0e"
  |> ExCanvas.Projects.get_canvas
  |> case do
    {:ok, canvas} ->
      canvas
      |> ExCanvas.Sketch.Buffer.build
      |> IO.puts
  end
```

```TEXT
________________________________________
______@@@@@@@@@@@@@@@@@@@@@@@@@@@@______
______@                          @______
______@ ..........   ..........  @______
______@ ..........   ..........  @______
______@ ..........   ..........  @______
______@                          @______
______@            ||            @______
______@            ||            @______
______@                          @______
______@@@@@@@@@@@@@@@@@@@@@@@@@@@@______
________________________________________
```

## Features

  * Create Canvases which are persistent with every application launch.
  * Creates rectangles shapes on top on created Canvases.
  * Simple text renderer to display drawing on canvases.

## Rest API

As of any other phoenix apps, run `mix phx.routes` for the comprehensive lists of available routes.

List all canvases currently exist in the system:
```curl
  - GET /api/canvases
```

Sample response:

```JSON
[
    {
        "height": 12,
        "id": "8b8f19bf-4467-4f61-b587-9246d5f4d837",
        "inserted_at": "2022-08-27T21:36:04",
        "updated_at": "2022-08-27T21:36:04",
        "width": 12
    },
    {
        "height": 10,
        "id": "d6644381-481f-4ecc-9240-8b2ea7df12bf",
        "inserted_at": "2022-08-26T21:57:12",
        "updated_at": "2022-08-26T21:57:12",
        "width": 10
    }
]
```

To show one canvas by id, use the show canvas route:
```curl
 - GET /api/canvases/:id
```

Where the `:id` is the binary uuid from the found canvases list.
Canvas show route by default preloads or previously attached shapes in the rectangles list.

Example response:

```JSON
{
    "height": 12,
    "id": "8b8f19bf-4467-4f61-b587-9246d5f4d837",
    "inserted_at": "2022-08-27T21:36:04",
    "rectangles": [
        {
            "fill": ".",
            "height": 4,
            "id": "05a1a9a7-0f7c-468e-ba34-4b0313f1209b",
            "inserted_at": "2022-08-30T00:54:10",
            "outline": null,
            "updated_at": "2022-08-30T00:54:10",
            "width": 4,
            "x": 0,
            "y": 0
        },
        {
            "fill": null,
            "height": 2,
            "id": "736a6c41-af08-4868-a4d6-0cc9ea74f693",
            "inserted_at": "2022-08-30T00:57:52",
            "outline": "H",
            "updated_at": "2022-08-30T00:57:52",
            "width": 2,
            "x": 0,
            "y": 0
        }
    ],
    "updated_at": "2022-08-27T21:36:04",
    "width": 12
}
```

To start a new canvas with width 20, and height of 60:

```curl
 - POST '/api/canvases'
--header 'Content-Type: application/json'
--data-raw '{
    "width": 20,
    "height": 60
}'
```

Sample response:
```JSON
{
    "height": 60,
    "id": "de60b477-4cb7-4033-98ff-bd50c407c8a7",
    "inserted_at": "2022-09-01T13:17:41",
    "updated_at": "2022-09-01T13:17:41",
    "width": 20
}
```

To start adding rectangles, use the created canvas to draw on:

Create rectangle api:
```curl
  - POST /api/canvases/:canvas_id/rectangles
--header 'Content-Type: application/json'
--data-raw '{
    "width": 16,
    "height": 50,
    "fill": "A",
    "outline": "A",
    "x": 2,
    "y": 5
}'
```

Rectangles have a starting coordinates (x, y) and a width and height with a fill or outline character or both.

The API allows to create as many shapes as you want within a canvas given that they fit in the canvas boundary.

To Visualize your work, there's the `:sketch` endpoint to call:
```curl
  - GET   /api/canvases/:canvas_id/sketch
```

For better visuals, the sketch API uses "_" to draw the initial slate of a given canvas.

```TEXT
____________________
____________________
____________________
____________________
____________________
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
__AAAAAAAAAAAAAAAA__
____________________
____________________
____________________
____________________
____________________
```

## API Installation

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Run `docker-compose up --build` to create a docker container for a local postgres database.
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Implementation details

  * Pure Elixir/Phoenix implementation following best practices from the community.
  * Uses Ecto for DB communication to a postgres instance, including:
    * Changesets creation and validations.
    * Relationships and ordered preloads.
  * The sketch api is based on converting shapes to IO Lists of coordinates using protocols and protocols implementation to form meaningful visuals.
  * Adding more shapes as polygons and boxes is a matter of implementing the `ExCanvas.Sketch.Render.render/1` function.
    * If a shape can be converted into a list of points then you will find the implementation is adaptive.

## Future consideration and todos

  * Add more tests besides the two required fixtures by the project requirement.
  * Expose `{x, y}` as a proper Ecto embed schema for reusability in future shapes.
  * Allow creating shapes on dynamic canvas size as in real world scenario canvases are "infinitely" scalable as the user keeps drawing.
  * Add a local git hook and a Github Action to run the `mix credo` and `mix dialyzer` on every code commit and as a requirement before code merging.

