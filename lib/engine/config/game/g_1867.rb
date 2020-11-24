# frozen_string_literal: true

# File original exported from 18xx-maker/export-rb
# https://github.com/18xx-maker/export-rb
# rubocop:disable Lint/RedundantCopDisableDirective, Layout/LineLength, Layout/HeredocIndentation

module Engine
  module Config
    module Game
      module G1867
        JSON = <<-'DATA'
{
  "filename": "1867",
  "modulename": "1867",
  "currencyFormatStr": "$%d",
  "bankCash": 15000,
  "certLimit": {
    "3": 21,
    "4": 16,
    "5": 13,
    "6": 11
  },
  "startingCash": {
    "3": 420,
    "4": 315,
    "5": 252,
    "6": 210
  },
  "capitalization": "full",
  "layout": "flat",
  "mustSellInBlocks": false,
  "locationNames": {
    "D2": "Timmins",
    "D8": "Sudbury",
    "F8": "North Bay",
    "E13": "Barrie",
    "E15": "Guelph",
    "E17": "Hamilton",
    "D16": "Berlin",
    "C17": "London",
    "G15": "Peterborough",
    "I15": "Kingston",
    "J12": "Ottawa",
    "M9": "Trois-Rivières",
    "O7": "Quebec",
    "N12": "Sherbrooke",
    "C15": "Goderich",
    "B18": "Sarnia",
    "H14": "Belleville",
    "H10": "Pembroke",
    "K13": "Cornwall",
    "L10": "St. Jerome",
    "M13": "Granby",
    "L12": "Montreal",
    "F16": "Toronto",
    "A7": "Sault Ste. Marie",
    "F18": "Buffalo",
    "M15": "New England",
    "O13": "Maine",
    "P8": "Maritime Provinces",
    "A19": "Detroit"
  },
  "tiles": {
    "3": 2,
    "4": 4,
    "5": 2,
    "6": 2,
    "7": 3,
    "8": 19,
    "9": 24,
    "14": 2,
    "15": 4,
    "16": 2,
    "17": 2,
    "18": 2,
    "19": 2,
    "20": 2,
    "21": 2,
    "22": 2,
    "23": 5,
    "24": 5,
    "25": 4,
    "26": 2,
    "27": 2,
    "28": 2,
    "29": 2,
    "30": 2,
    "31": 2,
    "39": 2,
    "40": 2,
    "41": 2,
    "42": 2,
    "43": 2,
    "44": 2,
    "45": 2,
    "46": 2,
    "47": 2,
    "57": 2,
    "58": 4,
    "63": 3,
    "70": 2,
    "87": 2,
    "88": 2,
    "120": 1,
    "122": 1,
    "124": 1,
    "201": 3,
    "202": 3,
    "204": 2,
    "207": 5,
    "208": 2,
    "611": 3,
    "619": 2,
    "621": 2,
    "622": 2,
    "623": 3,
    "624": 1,
    "625": 1,
    "626": 1,
    "637": 1,
    "639": 1,
    "801": 2,
    "911": 3,
    "X1": {
      "count": 1,
      "color": "green",
      "code": "city=revenue:50;city=revenue:50;city=revenue:50;path=a:0,b:_0;path=a:_0,b:3;path=a:1,b:_0;path=a:_0,b:4;path=a:2,b:_0;path=a:_0,b:5;label=M"
    },
    "X2": {
      "count": 1,
      "color": "green",
      "code": "city=revenue:50;city=revenue:50;city=revenue:50;path=a:0,b:_0;path=a:_0,b:3;path=a:2,b:_0;path=a:_0,b:4;path=a:1,b:_0;path=a:_0,b:5;label=M"
    },
    "X3": {
      "count": 1,
      "color": "green",
      "code": "city=revenue:50;city=revenue:50;city=revenue:50;path=a:0,b:_0;path=a:_0,b:1;path=a:3,b:_0;path=a:_0,b:5;path=a:2,b:_0;path=a:_0,b:4;label=M"
    },
    "X4": {
      "count": 1,
      "color": "green",
      "code": "city=revenue:50;city=revenue:50;city=revenue:50;path=a:1,b:_0;path=a:_0,b:2;path=a:0,b:_0;path=a:_0,b:3;path=a:4,b:_0;path=a:_0,b:5;label=M"
    },
    "X5": {
      "count": 1,
      "color": "brown",
      "code": "city=revenue:70,slots:2;city=revenue:70;path=a:5,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0;label=M"
    },
    "X6": {
      "count": 1,
      "color": "brown",
      "code": "city=revenue:70,slots:2;city=revenue:70;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0;path=a:_0,b:5;label=M"
    },
    "X7": {
      "count": 1,
      "color": "brown",
      "code": "city=revenue:70,slots:2;city=revenue:70;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:_0,b:4;path=a:3,b:_0;path=a:5,b:_0;label=M"
    },
    "X8": {
      "count": 1,
      "color": "gray",
      "code": "city=revenue:60,slots:3;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0;path=a:5,b:_0;label=O"
    }
  },
  "market": [
    [
      "35",
      "40",
      "45",
      "50p",
      "55p",
      "60p",
      "65p",
      "70p",
      "80p",
      "90p",
      "100y",
      "110y",
      "120y",
      "135y",
      "150y",
      "165y",
      "180y",
      "200y",
      "220",
      "245",
      "270",
      "300",
      "330",
      "360",
      "400",
      "440",
      "490",
      "540"
    ]
  ],
  "companies": [
    {
      "name": "Champlain & St. Lawrence",
      "sym": "C&SL",
      "value": 30,
      "revenue": 10,
      "desc": "No special abilities."
    },
    {
      "name": "Niagara Falls Bridge",
      "sym": "NFB",
      "value": 45,
      "revenue": 15,
      "desc": "+10 Buffalo"
    },
    {
      "name": "Montreal Bridge",
      "sym": "MB",
      "value": 60,
      "revenue": 20,
      "desc": "+10 Montreal"
    },
    {
      "name": "Quebec Bridge",
      "sym": "QB",
      "value": 75,
      "revenue": 25,
      "desc": "+10 Quebec"
    },
    {
      "name": "St. Clair Tunnel",
      "sym": "SCT",
      "value": 90,
      "revenue": 30,
      "desc": "+10 Detroit"
    }
  ],
  "corporations": [
    {
      "sym": "CNR",
      "name": "Canadian Northern Railway",
      "logo": "1867/CNR",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "green"
    },
    {
      "sym": "CPR",
      "name": "Canadian Pacific Railway",
      "logo": "1867/CPR",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "red"
    },
    {
      "sym": "C&O",
      "name": "Chesapeake and Ohio Railway",
      "logo": "1867/CO",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "cyan"
    },
    {
      "sym": "GTR",
      "name": "Grand Trunk Railway",
      "logo": "1867/GTR",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "orange"
    },
    {
      "sym": "GWR",
      "name": "Great Western Railway",
      "logo": "1867/GWR",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "brown"
    },
    {
      "sym": "ICR",
      "name": "Intercolonial Railway",
      "logo": "1867/ICR",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "NTR",
      "name": "National Transcontinental Railway",
      "logo": "1867/NTR",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "tan"
    },
    {
      "sym": "NYC",
      "name": "New York Central Railroad",
      "logo": "1867/NYC",
      "tokens": [
        0,
        0,
        0
      ],
      "color": "black"
    },
    {
      "sym": "BBG",
      "name": "Buffalo, Brantford, and Goderich",
      "logo": "1867/BBG",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "BO",
      "name": "Brockville and Ottawa",
      "logo": "1867/BO",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "CS",
      "name": "Canada Southern",
      "logo": "1867/CS",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "CV",
      "name": "Credit Valley Railway",
      "logo": "1867/CV",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "KP",
      "name": "Kingston and Pembroke",
      "logo": "1867/KP",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "LPS",
      "name": "London and Port Stanley",
      "logo": "1867/LPS",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "OP",
      "name": "Ottawa and Prescott",
      "logo": "1867/OP",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "SLA",
      "name": "St. Lawrence and Atlantic",
      "logo": "1867/SLA",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "TGB",
      "name": "Toronto, Grey, and Bruce",
      "logo": "1867/TGB",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "TN",
      "name": "Toronto and Nipissing",
      "logo": "1867/TN",
      "tokens": [
        0
      ],
      "color": "yellow"
    },
    {
      "sym": "TN",
      "name": "Algoma Eastern Railway",
      "logo": "1867/TN",
      "tokens": [
        0
      ],
      "color": "green"
    },
    {
      "sym": "CA",
      "name": "Canada Atlantic Railway",
      "logo": "1867/CA",
      "tokens": [
        0
      ],
      "color": "green"
    },
    {
      "sym": "NYO",
      "name": "New York and Ottawa",
      "logo": "1867/NYO",
      "tokens": [
        0
      ],
      "color": "green"
    },
    {
      "sym": "PM",
      "name": "Pere Marquette Railway",
      "logo": "1867/PM",
      "tokens": [
        0
      ],
      "color": "green"
    },
    {
      "sym": "QLS",
      "name": "Quebec and Lake St. John",
      "logo": "1867/QLS",
      "tokens": [
        0
      ],
      "color": "green"
    },
    {
      "sym": "THB",
      "name": "Toronto, Hamilton and Buffalo",
      "logo": "1867/THB",
      "tokens": [
        0
      ],
      "color": "green"
    },
    {
      "sym": "CN",
      "name": "Canadian National",
      "logo": "1867/CN",
      "tokens": [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
      "color": "white"
    }
  ],
  "trains": [
    {
      "name": "2",
      "distance": 2,
      "price": 100,
      "rusts_on": "4",
      "num": 10
    },
    {
      "name": "3",
      "distance": 3,
      "price": 225,
      "rusts_on": "6",
      "num": 7
    },
    {
      "name": "4",
      "distance": 4,
      "price": 350,
      "rusts_on": "8",
      "num": 4
    },
    {
      "name": "5",
      "distance": 5,
      "price": 550,
      "num": 4
    },
    {
      "name": "6",
      "distance": 6,
      "price": 650,
      "num": 2
    },
    {
      "name": "7",
      "distance": 7,
      "price": 800,
      "num": 2
    },
    {
      "name": "8",
      "distance": 8,
      "price": 1000,
      "num": 6
    },
    {
      "name": "2+2",
      "distance": 2,
      "price": 600,
      "num": 6
    },
    {
      "name": "5+5E",
      "distance": 5,
      "price": 1500,
      "num": 7
    }
  ],
  "hexes": {
    "white": {
      "": [
        "B6",
        "B8",
        "C5",
        "C7",
        "C19",
        "D4",
        "D6",
        "D14",
        "D18",
        "E3",
        "E5",
        "E7",
        "E9",
        "F2",
        "F4",
        "F6",
        "F10",
        "F12",
        "F14",
        "G3",
        "G5",
        "G7",
        "G9",
        "G11",
        "G13",
        "H4",
        "H6",
        "H8",
        "H12",
        "I5",
        "I7",
        "I9",
        "I11",
        "I13",
        "J6",
        "J8",
        "J10",
        "J14",
        "K5",
        "K7",
        "K9",
        "L6",
        "L8",
        "M5",
        "M7",
        "N6",
        "O11",
        "N8",
        "O9",
        "N10",
        "M11",
        "C9",
        "D10",
        "E11",
        "C11",
        "D12",
        "C13"
      ],
      "upgrade=cost:20,terrain:water": [
        "K11"
      ],
      "city=revenue:0": [
        "D8",
        "F8",
        "E13",
        "E15",
        "C17",
        "G15",
        "I15",
        "M9",
        "N12"
      ],
      "city=revenue:0;label=Y": [
        "E17",
        "D16",
        "O7"
      ],
      "city=revenue:0;label=Y;label=O;upgrade=cost:20,terrain:water": [
        "J12"
      ],
      "town=revenue:0": [
        "C15",
        "B18",
        "H14",
        "H10",
        "K13",
        "L10",
        "M13"
      ]
    },
    "gray": {
      "city=revenue:40;path=a:0,b:_0;path=a:1,b:_0;path=a:4,b:_0;path=a:5,b:_0": [
        "D2"
      ],
      "path=a:0,b:4": [
        "C3"
      ],
      "path=a:1,b:5": [
        "E1"
      ],
      "path=a:0,b:5": [
        "B16"
      ],
      "path=a:2,b:3": [
        "L14"
      ]
    },
    "yellow": {
      "city=revenue:40;city=revenue:40;city=revenue:40;path=a:1,b:_0;path=a:3,b:_0;label=M;upgrade=cost:20,terrain:water": [
        "L12"
      ],
      "city=revenue:30;city=revenue:30;path=a:1,b:_0;path=a:4,b:_0;label=T": [
        "F16"
      ]
    },
    "red": {
      "offboard=revenue:yellow_20|green_30|brown_40|gray_40;path=a:4,b:_0;path=a:5,b:_0": [
        "A7"
      ],
      "offboard=revenue:yellow_30|green_40|brown_50|gray_60;path=a:2,b:_0": [
        "F18"
      ],
      "offboard=revenue:yellow_30|green_40|brown_50|gray_60;path=a:3,b:_0": [
        "M15"
      ],
      "offboard=revenue:yellow_20|green_30|brown_40|gray_40;path=a:2,b:_0;path=a:3,b:_0": [
        "O13"
      ],
      "offboard=revenue:yellow_30|green_30|brown_40|gray_40;path=a:2,b:_0;path=a:1,b:_0": [
        "P8"
      ],
      "path=a:5,b:0;border=edge:0": [
        "A17"
      ],
      "offboard=revenue:yellow_30|green_40|brown_50|gray_70;path=a:4,b:_0;border=edge:3": [
        "A19"
      ]
    },
    "blue": {
      "offboard=revenue:10;path=a:3,b:_0": [
        "E19"
      ],
      "offboard=revenue:10;path=a:2,b:_0;path=a:4,b:_0": [
        "H16"
      ]
    }
  },
  "phases": [
    {
      "name": "3",
      "train_limit": 4,
      "tiles": [
        "yellow",
        "green"
      ]
    },
    {
      "name": "4",
      "train_limit": 3,
      "tiles": [
        "yellow",
        "green"
      ]
    },
    {
      "name": "5",
      "train_limit": 3,
      "tiles": [
        "yellow",
        "green",
        "brown"
      ]
    },
    {
      "name": "6",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown"
      ]
    },
    {
      "name": "7",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ]
    },
    {
      "name": "8",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ]
    },
    {
      "name": "2+2",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ]
    },
    {
      "name": "5+5E",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ]
    },
    {
      "name": "2",
      "train_limit": 2,
      "tiles": [
        "yellow"
      ]
    },
    {
      "name": "3",
      "train_limit": 2,
      "tiles": [
        "yellow",
        "green"
      ]
    },
    {
      "name": "4",
      "train_limit": 1,
      "tiles": [
        "yellow",
        "green"
      ]
    },
    {
      "name": "5",
      "train_limit": 1,
      "tiles": [
        "yellow",
        "green",
        "brown"
      ]
    },
    {
      "name": "6",
      "train_limit": 1,
      "tiles": [
        "yellow",
        "green",
        "brown"
      ]
    },
    {
      "name": "7",
      "train_limit": 1,
      "tiles": [
        "yellow",
        "green",
        "brown",
        "gray"
      ]
    }
  ]
}
        DATA
      end
    end
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective, Layout/LineLength, Layout/HeredocIndentation
