  $ cat > test.ml <<EOF
  > module A = struct
  >   type t = { xxxxxx : int; yyyyyy : float }
  > end
  > 
  > let xxxxxx = 1
  > let yyyyyy = 1.0
  > let yyyyyyx = 1.0
  > let x = { A.x; yyyyyy }
  > let x' = { A.xxxxxx; y }
  > let fooooooooo = 0
  > let x'' = { A.xxxxxx = foo; y }
  > EOF

  $ $MERLIN single complete-prefix -position 4:0 -prefix "A.x" \
  > -filename test.ml < test.ml | jq '.value.entries'
  []

  $ $MERLIN single complete-prefix -position 7:12 -prefix "A.x" \
  > -filename test.ml < test.ml | jq '.value.entries'
  [
    {
      "name": "xxxxxx",
      "kind": "Label",
      "desc": "A.t -> int",
      "info": "",
      "deprecated": false
    }
  ]

  $ $MERLIN single complete-prefix -position 8:12 -prefix "A.x" \
  > -filename test.ml < test.ml | jq '.value.entries'
  [
    {
      "name": "xxxxxx",
      "kind": "Label",
      "desc": "A.t -> int",
      "info": "",
      "deprecated": false
    }
  ]

  $ $MERLIN single complete-prefix -position 8:12 -prefix "x" \
  > -filename test.ml < test.ml | jq '.value.entries'
  [
    {
      "name": "xxxxxx",
      "kind": "Value",
      "desc": "int",
      "info": "",
      "deprecated": false
    }
  ]

  $ $MERLIN single complete-prefix -position 9:21 -prefix "y" \
  > -filename test.ml < test.ml | jq '.value.entries'
  [
    {
      "name": "yyyyyy",
      "kind": "Value",
      "desc": "float",
      "info": "",
      "deprecated": false
    },
    {
      "name": "yyyyyyx",
      "kind": "Value",
      "desc": "float",
      "info": "",
      "deprecated": false
    }
  ]

  $ $MERLIN single complete-prefix -position 11:24 -prefix "foo" \
  > -filename test.ml < test.ml
  {
    "class": "return",
    "value": {
      "entries": [
        {
          "name": "fooooooooo",
          "kind": "Value",
          "desc": "int",
          "info": "",
          "deprecated": false
        }
      ],
      "context": null
    },
    "notifications": []
  }
