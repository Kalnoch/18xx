{ id: '18AU',
  slug: '18AU',
  file: '18AU.json',
  title: '18AU',
  designer: '',
  publisher: '',
  minPlayers: 2,
  maxPlayers: 3 }
# frozen_string_literal: true

# File original exported from 18xx-maker/export-rb
# https://github.com/18xx-maker/export-rb
# rubocop:disable Lint/RedundantCopDisableDirective, Layout/LineLength, Layout/HeredocIndentation

module Engine
  module Config
    module Game
      module G18AU
        JSON = <<-'DATA'
{
  "filename": "18_au",
  "modulename": "18AU",
  "currencyFormatStr": "$%d",
  "bankCash": 9000,
  "certLimit": {
    "2": 12,
    "3": 9
  },
  "startingCash": {
    "2": 450,
    "3": 300
  },
  "capitalization": "incremental",
  "layout": "pointy",
  "mustSellInBlocks": false,
  "locationNames": {
    "C9": "Plzen",
    "D8": "Linz",
    "E3": "Innsbruck",
    "G9": "Laibach",
    "J16": "Sarajevo",
    "G29": "Kronstadt",
    "K21": "Novi Bazar",
    "E7": "Salzburg",
    "F26": "Klausenburg",
    "D6": "Munchen",
    "B10": "Braha",
    "E17": "Budapest",
    "D12": "Wien",
    "H8": "Trieste",
    "F10": "Graz",
    "H12": "Zagreb",
    "B26": "Lemberg",
    "B18": "Krakau",
    "C13": "Brno",
    "D14": "Presburg",
    "G13": "Csaktornya",
    "F18": "Kecskemet",
    "G19": "Szeged",
    "J12": "Spalato",
    "C29": "Ternopol",
    "D22": "Kosice",
    "E23": "Debrecen",
    "G21": "Arad & Temesvar",
    "A13": "Berlin"
  },
  "tiles": {
    "1oe": 1,
    "2oe": 1,
    "3oe": 1,
    "3": 5,
    "4": 5,
    "5": 5,
    "6": 5,
    "77": 10,
    "78": 10,
    "79": 10,
    "12": 4,
    "13": 4,
    "57": 5,
    "58": 5,
    "80": 5,
    "81": 5,
    "82": 5,
    "83": 5,
    "141": 4,
    "142": 4,
    "143": 4,
    "144": 4,
    "145": 2,
    "146": 2,
    "147": 2,
    "201": 2,
    "202": 2,
    "205": 4,
    "206": 4,
    "207": 2,
    "208": 2,
    "544": 2,
    "545": 2,
    "546": 2,
    "621": 2,
    "622": 1,
    "891Y": 1,
    "451oe": 1,
    "452oe": 1,
    "492oe": 1,
    "990oe": 1
  },
  "market": [
    [
      "",
      "110",
      "120",
      "135",
      "150",
      "165",
      "180",
      "200",
      "225",
      "250",
      "280",
      "310",
      "350",
      "390",
      "440",
      "490",
      "550"
    ],
    [
      "90",
      "100",
      "110",
      "120",
      "135",
      "150",
      "165",
      "180",
      "200",
      "225",
      "250",
      "280",
      "310",
      "350",
      "390",
      "440",
      "490"
    ],
    [
      "80",
      "90p",
      "100",
      "110",
      "120",
      "135",
      "150",
      "165",
      "180",
      "200",
      "225",
      "250",
      "280",
      "310"
    ],
    [
      "75",
      "80p",
      "90",
      "100",
      "110",
      "120",
      "135",
      "150",
      "165",
      "180",
      "200"
    ],
    [
      "70",
      "75p",
      "80",
      "90",
      "100",
      "110",
      "120",
      "135",
      "150"
    ],
    [
      "65",
      "70p",
      "75",
      "80",
      "90",
      "100",
      "110"
    ],
    [
      "60",
      "65p",
      "70",
      "75",
      "80"
    ],
    [
      "50",
      "60p",
      "65",
      "70"
    ]
  ],
  "companies": [
    {
      "name": "Robert Stephenson and Company",
      "value": 20,
      "revenue": 5,
      "sym": "RSC",
      "desc": "No special abilities."
    },
    {
      "name": "Hochberg Mining & Lumber",
      "value": 80,
      "revenue": 20,
      "sym": "HML",
      "desc": "Can place a token to do stuff"
    },
    {
      "name": "Brandt & Brandau, Engineers",
      "value": 100,
      "revenue": 25,
      "sym": "B&B",
      "desc": "Free mountain tile lay."
    },
    {
      "name": "White Peak Mountain Railway",
      "value": 120,
      "revenue": 0,
      "sym": "F",
      "desc": "33% discount to construction in mountains",
      "abilities": [
        {
          "type": "float_minor",
          "minor": "F",
          "owner_type": "player"
        }
      ]
    },
    {
      "name": "Krasnaya Strela",
      "value": 120,
      "revenue": 0,
      "sym": "L",
      "desc": "1+1 token that adds to any one trains limits",
      "abilities": [
        {
          "type": "float_minor",
          "minor": "L",
          "owner_type": "player"
        }
      ]
    }
  ],
  "minors": [
    {
      "float_percent": 100,
      "sym": "F",
      "name": "White Peak Mountain Railway",
      "logo": "18_au/F",
      "tokens": [
        20,
        20
      ],
      "color": "lightGray",
      "type": "minor"
    },
    {
      "float_percent": 100,
      "sym": "L",
      "name": "Krasnaya Strela",
      "logo": "18_au/L",
      "tokens": [
        20,
        20
      ],
      "color": "brown"
    }
  ],
  "corporations": [
    {
      "float_percent": 20,
      "sym": "KBS",
      "name": "Koniglich Bayerische Staatseisenbahnen",
      "logo": "18_au/KBS",
      "shares": [50, 25, 25],
      "max_ownership_percent": 100,
      "tokens": [
        20,
        20
      ],
      "coordinates": "D6",
      "always_market_price": true,
      "color": "lightBlue"
    },
    {
      "float_percent": 20,
      "sym": "SB",
      "name": "Osterreichische Sudbahn",
      "logo": "18_au/SB",
      "shares": [50, 25, 25],
      "max_ownership_percent": 100,
      "tokens": [
        20,
        20
      ],
      "coordinates": "D12",
      "always_market_price": true,
      "color": "orange"
    },
    {
      "float_percent": 20,
      "sym": "MAV",
      "name": "Magyar Allamvasutak",
      "logo": "18_au/MAV",
      "shares": [50, 25, 25],
      "max_ownership_percent": 100,
      "tokens": [
        20,
        20
      ],
      "coordinates": "E17",
      "always_market_price": true,
      "color": "black"
    }
  ],
  "trains": [
    {
      "name": "2+2",
      "distance": [
        {
          "nodes": [
            "town"
          ],
          "pay": 2,
          "visit": 99
        },
        {
          "nodes": [
            "city",
            "offboard",
            "town"
          ],
          "pay": 2,
          "visit": 2
        }
      ],
      "price": 100,
      "rusts_on": "4",
      "num": 5
    },
    {
      "name": "3",
      "distance": [
        {
          "nodes": [
            "town"
          ],
          "pay": 0,
          "visit": 99
        },
        {
          "nodes": [
            "city",
            "offboard",
            "town"
          ],
          "pay": 3,
          "visit": 3
        }
      ],
      "price": 200,
      "variants": [
         {
           "name": "3+3",
           "distance": [
             {
               "nodes": [
                 "town"
               ],
               "pay": 3,
               "visit": 99
             },
             {
               "nodes": [
                 "city",
                 "offboard",
                 "town"
               ],
               "pay": 3,
               "visit": 3
             }
           ],
           "price": 225
         }
      ],
      "rusts_on": "6",
      "num": 4
    },
    {
      "name": "4",
      "distance": 4,
      "price": 300,
      "variants": [
         {
           "name": "4+4",
           "distance": [
             {
               "nodes": [
                 "town"
               ],
               "pay": 4,
               "visit": 99
             },
             {
               "nodes": [
                 "city",
                 "offboard",
                 "town"
               ],
               "pay": 4,
               "visit": 4
             }
           ],
           "price": 350
         }
      ],
      "rusts_on": "5D",
      "num": 3
    },
    {
      "name": "5",
      "distance": 5,
      "price": 400,
      "variants": [
         {
           "name": "5+5",
           "distance": [
             {
               "nodes": [
                 "town"
               ],
               "pay": 5,
               "visit": 99
             },
             {
               "nodes": [
                 "city",
                 "offboard",
                 "town"
               ],
               "pay": 5,
               "visit": 5
             }
           ],
           "price": 475
         }
      ],
      "num": 2
    },
    {
      "name": "6",
      "distance": 6,
      "price": 525,
      "variants": [
         {
           "name": "6+6",
           "distance": [
             {
               "nodes": [
                 "town"
               ],
               "pay": 6,
               "visit": 99
             },
             {
               "nodes": [
                 "city",
                 "offboard",
                 "town"
               ],
               "pay": 6,
               "visit": 6
             }
           ],
           "price": 600
         }
      ],
      "num": 2
    },
    {
      "name": "4D",
      "distance": 4,
      "price": 850,
      "variants": [
         {
           "name": "7+7",
           "distance": [
             {
               "nodes": [
                 "town"
               ],
               "pay": 7,
               "visit": 99
             },
             {
               "nodes": [
                 "city",
                 "offboard",
                 "town"
               ],
               "pay": 7,
               "visit": 7
             }
           ],
           "price": 750
         }
      ],
      "num": 2
    },
    {
      "name": "5D",
      "distance": 5,
      "price": 1000,
      "variants": [
         {
           "name": "8+8",
           "distance": [
             {
               "nodes": [
                 "town"
               ],
               "pay": 8,
               "visit": 99
             },
             {
               "nodes": [
                 "city",
                 "offboard",
                 "town"
               ],
               "pay": 8,
               "visit": 8
             }
           ],
           "price": 900
         }
      ],
      "num": 4
    }
  ],
  "hexes": {
    "white": {
      "": [
        "B6",
        "B8",
        "B16",
        "B20",
        "B22",
        "B24",
        "B28",
        "B30",
        "C11",
        "C15",
        "C23",
        "C31",
        "D10",
        "D16",
        "D20",
        "D24",
        "D30",
        "E13",
        "E15",
        "E21",
        "E25",
        "E31",
        "F12",
        "F14",
        "F16",
        "F20",
        "F22",
        "G7",
        "G11",
        "G15",
        "G17",
        "H14",
        "H16",
        "H18",
        "H20",
        "I13",
        "I15",
        "I17"
      ],
      "upgrade=cost:45,terrain:water": [
        "F32",
        "K15"
      ],
      "upgrade=cost:60,terrain:water": [
        "K13"
      ],
      "upgrade=cost:30,terrain:mountain": [
        "A9",
        "B14",
        "C27",
        "E19",
        "E27",
        "H10",
        "I11"
      ],
      "upgrade=cost:45,terrain:mountain": [
        "B12",
        "C7",
        "C17",
        "C19",
        "C21",
        "C25",
        "D18",
        "D26",
        "E1",
        "E5",
        "F24",
        "F28",
        "F30",
        "G23",
        "G31",
        "H22",
        "H26",
        "I25",
        "J14",
        "J18",
        "K19"
      ],
      "upgrade=cost:60,terrain:mountain": [
        "D28",
        "E9",
        "E11",
        "E29",
        "F6",
        "F8",
        "G3",
        "G25",
        "G27",
        "H24",
        "K17",
        "A11"
      ],
      "upgrade=cost:120,terrain:mountain": [
        "F2",
        "F4",
        "G1"
      ],
      "town=revenue:0;upgrade=cost:45,terrain:mountain": [
        "C9",
        "D8",
        "G9",
        "K21"
      ],
      "town=revenue:0;upgrade=cost:60,terrain:mountain": [
        "E3",
        "G29"
      ],
      "town=revenue:0;upgrade=cost:30,terrain:mountain": [
        "J16"
      ],
      "city=revenue:0;upgrade=cost:30,terrain:mountain": [
        "E7",
        "F26"
      ],
      "city=revenue:0;label=Y": [
        "B10",
        "E17"
      ],
      "city=revenue:0;label=A": [
        "D12"
      ],
      "city=revenue:0": [
        "H8",
        "F10",
        "H12",
        "B26"
      ],
      "town=revenue:0": [
        "B18",
        "C13",
        "D14",
        "G13",
        "F18",
        "G19",
        "J12",
        "C29",
        "D22",
        "E23"
      ],
      "town=revenue:0;town=revenue:0": [
        "G21"
      ]
    },
    "yellow": {
      "city=revenue:30;path=a:3,b:_0;path=a:4,b:_0;path=a:5,b:_0;path=a:0,b:_0;label=Y": [
        "D6"
      ]
    },
    "red": {
      "offboard=revenue:yellow_30|green_60|brown_90|gray_120;path=a:1,b:_0;path=a:5,b:_0;path=a:0,b:_0": [
        "A13"
      ]
    }
  },
  "phases": [
    {
      "name": "2",
      "train_limit": 4,
      "tiles": [
        "yellow"
      ],
      "operating_rounds": 2
    },
    {
      "name": "3",
      "on": "3",
      "train_limit": 4,
      "tiles": [
        "yellow",
        "green"
      ],
      "operating_rounds": 2,
      "buy_companies": true
    },
    {
      "name": "4",
      "on": "4",
      "train_limit": 3,
      "tiles": [
        "yellow",
        "green"
      ],
      "operating_rounds": 2,
      "buy_companies": true
    },
    {
      "name": "5",
      "on": "5",
      "train_limit": 3,
      "tiles": [
        "yellow",
        "green",
        "brown"
      ],
      "operating_rounds": 2,
      "events": {
        "close_companies": true
      }
    },
    {
      "name": "6",
      "on": "6",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown"
      ],
      "operating_rounds": 2
    },
    {
      "name": "7",
      "on": "4D",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ],
      "operating_rounds": 2
    },
    {
      "name": "8",
      "on": "5D",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ],
      "operating_rounds": 2
    }
  ]
}
        DATA
      end
    end
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective, Layout/LineLength, Layout/HeredocIndentation
