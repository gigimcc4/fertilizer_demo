PROGRAM main
  VAR
    start : BOOL AT %MX0.0;
    stop : BOOL AT %MX0.1;
    prox : BOOL AT %MX0.2;
    level : BOOL AT %MX0.3;
    motor : BOOL AT %QX0.0;
    solenoid : BOOL AT %QX0.1;
    run_light : BOOL AT %QX0.2;
    release : BOOL;
    mode_a : BOOL AT %MX0.4;
    mode_b : BOOL AT %MX0.5;
    mode_c : BOOL AT %MX0.6;
    fill_light : BOOL AT %QX0.3;
    full_light : BOOL AT %QX0.4;
  END_VAR

{
  "name": "main",
  "rungs": [
    {
      "id": "rung_main_523aa690-3605-4ff0-a745-fd4532a51c29",
      "comment": "",
      "defaultBounds": [
        300,
        100
      ],
      "reactFlowViewport": [
        445,
        174
      ],
      "nodes": [
        {
          "id": "left-rail-rung_main_523aa690-3605-4ff0-a745-fd4532a51c29",
          "type": "powerRail",
          "position": {
            "x": 0,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "inputHandles": [],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "outputConnector": {
              "glbPosition": {
                "x": 3,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "left-rail",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 20,
                "right": -3
              }
            },
            "numericId": "1500734",
            "variant": "left",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "5951404",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_3da0c447-3545-41c6-aa27-840c95b384a2",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "9792422",
            "variable": {
              "id": "",
              "name": "start",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_57020325-fdfc-4b5f-bcd7-d865344a7c0b",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 130
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 142
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "4752720",
            "variable": {
              "id": "",
              "name": "run_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa",
          "type": "parallel",
          "position": {
            "x": 141,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 141,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "1962244",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_f47311aa-c312-4062-b9cf-a2136f409b9f",
          "type": "contact",
          "position": {
            "x": 190,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 190,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 214,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "6879207",
            "variable": {
              "id": "",
              "name": "stop",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "COIL_2358a37b-0339-4674-af5b-39866b4c8696",
          "type": "coil",
          "position": {
            "x": 304,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 332,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 332,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 304,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 332,
                "y": 50
              },
              "relPosition": {
                "x": 28,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "1079387",
            "variable": {
              "id": "",
              "name": "run_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 28,
          "height": 24,
          "measured": {
            "width": 28,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "right-rail-rung_main_523aa690-3605-4ff0-a745-fd4532a51c29",
          "type": "powerRail",
          "position": {
            "x": 442,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                },
                "x": 442
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                }
              }
            ],
            "outputHandles": [],
            "inputConnector": {
              "glbPosition": {
                "x": 297,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "right-rail",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 20,
                "left": -3
              }
            },
            "numericId": "2167633",
            "variant": "right",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        }
      ],
      "edges": [
        {
          "id": "e_left-rail-rung_main_523aa690-3605-4ff0-a745-fd4532a51c29_PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803__left-rail_input",
          "source": "left-rail-rung_main_523aa690-3605-4ff0-a745-fd4532a51c29",
          "target": "PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803",
          "sourceHandle": "left-rail",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803_CONTACT_3da0c447-3545-41c6-aa27-840c95b384a2__output-right_input",
          "source": "PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803",
          "target": "CONTACT_3da0c447-3545-41c6-aa27-840c95b384a2",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_3da0c447-3545-41c6-aa27-840c95b384a2_PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa__output_input",
          "source": "CONTACT_3da0c447-3545-41c6-aa27-840c95b384a2",
          "target": "PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803_CONTACT_57020325-fdfc-4b5f-bcd7-d865344a7c0b__output-down_input",
          "source": "PARALLEL_OPEN_1360afdc-06f4-4668-a196-2660285c2803",
          "target": "CONTACT_57020325-fdfc-4b5f-bcd7-d865344a7c0b",
          "sourceHandle": "output-down",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_57020325-fdfc-4b5f-bcd7-d865344a7c0b_PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa__output_input-down",
          "source": "CONTACT_57020325-fdfc-4b5f-bcd7-d865344a7c0b",
          "target": "PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa_CONTACT_f47311aa-c312-4062-b9cf-a2136f409b9f__output-right_input",
          "source": "PARALLEL_CLOSE_f5b0efa7-3022-4fca-972f-ee700214befa",
          "target": "CONTACT_f47311aa-c312-4062-b9cf-a2136f409b9f",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_f47311aa-c312-4062-b9cf-a2136f409b9f_COIL_2358a37b-0339-4674-af5b-39866b4c8696__output_input",
          "source": "CONTACT_f47311aa-c312-4062-b9cf-a2136f409b9f",
          "target": "COIL_2358a37b-0339-4674-af5b-39866b4c8696",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_COIL_2358a37b-0339-4674-af5b-39866b4c8696_right-rail-rung_main_523aa690-3605-4ff0-a745-fd4532a51c29__output_right-rail",
          "source": "COIL_2358a37b-0339-4674-af5b-39866b4c8696",
          "target": "right-rail-rung_main_523aa690-3605-4ff0-a745-fd4532a51c29",
          "sourceHandle": "output",
          "targetHandle": "right-rail"
        }
      ],
      "selectedNodes": []
    },
    {
      "id": "rung_main_5127092e-272b-4741-9235-88f5abcc25ac",
      "comment": "",
      "defaultBounds": [
        300,
        100
      ],
      "reactFlowViewport": [
        445,
        174
      ],
      "nodes": [
        {
          "id": "left-rail-rung_main_5127092e-272b-4741-9235-88f5abcc25ac",
          "type": "powerRail",
          "position": {
            "x": 0,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "inputHandles": [],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "outputConnector": {
              "glbPosition": {
                "x": 3,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "left-rail",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 20,
                "right": -3
              }
            },
            "numericId": "4471833",
            "variant": "left",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "2190044",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_a1289cb9-b6d2-4741-9a2f-0aaf53d8e5bd",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "6295993",
            "variable": {
              "id": "",
              "name": "level",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_ff810896-5868-4af3-918d-be42348fe64b",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 130
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 142
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "4878205",
            "variable": {
              "id": "",
              "name": "full_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7",
          "type": "parallel",
          "position": {
            "x": 141,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 141,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "1408699",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_cafbc4a0-f9ba-41e6-8df2-8cf00bbb668b",
          "type": "contact",
          "position": {
            "x": 190,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 190,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 214,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "9296733",
            "variable": {
              "id": "",
              "name": "prox",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "COIL_d19935e0-7669-4c9c-a7a2-de8da5541ab1",
          "type": "coil",
          "position": {
            "x": 304,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 332,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 332,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 304,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 332,
                "y": 50
              },
              "relPosition": {
                "x": 28,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "5440295",
            "variable": {
              "id": "",
              "name": "full_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 28,
          "height": 24,
          "measured": {
            "width": 28,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "right-rail-rung_main_5127092e-272b-4741-9235-88f5abcc25ac",
          "type": "powerRail",
          "position": {
            "x": 442,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                },
                "x": 442
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                }
              }
            ],
            "outputHandles": [],
            "inputConnector": {
              "glbPosition": {
                "x": 297,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "right-rail",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 20,
                "left": -3
              }
            },
            "numericId": "1335060",
            "variant": "right",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        }
      ],
      "edges": [
        {
          "id": "e_COIL_d19935e0-7669-4c9c-a7a2-de8da5541ab1_right-rail-rung_main_5127092e-272b-4741-9235-88f5abcc25ac__output_right-rail",
          "source": "COIL_d19935e0-7669-4c9c-a7a2-de8da5541ab1",
          "target": "right-rail-rung_main_5127092e-272b-4741-9235-88f5abcc25ac",
          "sourceHandle": "output",
          "targetHandle": "right-rail"
        },
        {
          "id": "e_CONTACT_cafbc4a0-f9ba-41e6-8df2-8cf00bbb668b_COIL_d19935e0-7669-4c9c-a7a2-de8da5541ab1__output_input",
          "source": "CONTACT_cafbc4a0-f9ba-41e6-8df2-8cf00bbb668b",
          "target": "COIL_d19935e0-7669-4c9c-a7a2-de8da5541ab1",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_left-rail-rung_main_5127092e-272b-4741-9235-88f5abcc25ac_PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89__left-rail_input",
          "source": "left-rail-rung_main_5127092e-272b-4741-9235-88f5abcc25ac",
          "target": "PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89",
          "sourceHandle": "left-rail",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89_CONTACT_a1289cb9-b6d2-4741-9a2f-0aaf53d8e5bd__output-right_input",
          "source": "PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89",
          "target": "CONTACT_a1289cb9-b6d2-4741-9a2f-0aaf53d8e5bd",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_a1289cb9-b6d2-4741-9a2f-0aaf53d8e5bd_PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7__output_input",
          "source": "CONTACT_a1289cb9-b6d2-4741-9a2f-0aaf53d8e5bd",
          "target": "PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89_CONTACT_ff810896-5868-4af3-918d-be42348fe64b__output-down_input",
          "source": "PARALLEL_OPEN_e60052f3-01c6-4db3-a73e-b32a2a99cc89",
          "target": "CONTACT_ff810896-5868-4af3-918d-be42348fe64b",
          "sourceHandle": "output-down",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_ff810896-5868-4af3-918d-be42348fe64b_PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7__output_input-down",
          "source": "CONTACT_ff810896-5868-4af3-918d-be42348fe64b",
          "target": "PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7_CONTACT_cafbc4a0-f9ba-41e6-8df2-8cf00bbb668b__output-right_input",
          "source": "PARALLEL_CLOSE_75d7c59d-c5d1-4e12-ae91-521d52d939c7",
          "target": "CONTACT_cafbc4a0-f9ba-41e6-8df2-8cf00bbb668b",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        }
      ],
      "selectedNodes": []
    },
    {
      "id": "rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36",
      "comment": "",
      "defaultBounds": [
        300,
        100
      ],
      "reactFlowViewport": [
        681,
        358
      ],
      "nodes": [
        {
          "id": "left-rail-rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36",
          "type": "powerRail",
          "position": {
            "x": 0,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "inputHandles": [],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "outputConnector": {
              "glbPosition": {
                "x": 3,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "left-rail",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 20,
                "right": -3
              }
            },
            "numericId": "4495052",
            "variant": "left",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "4516577",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_c34cf3e8-29e2-49b8-b419-497fc6173379",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "negated",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "5898039",
            "variable": {
              "id": "",
              "name": "prox",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 141
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 142
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 142
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 142
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "9880696",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 142
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 142
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_1f7ce30a-12f6-49ad-bf3a-1547934a6eb2",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 130
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 142
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "5804291",
            "variable": {
              "id": "",
              "name": "mode_a",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 233
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 234
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 234
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 234
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 234
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "3130240",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 234
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 234
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_011cd55c-8011-4b77-8f3f-f1d1e947e454",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 222
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 234
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 234
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 234
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 234
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "804609",
            "variable": {
              "id": "",
              "name": "mode_b",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_4b950c66-f3aa-4be1-9377-7bf9534ecc8e",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 314
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 326
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 326
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 326
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 326
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 326
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 326
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "2923342",
            "variable": {
              "id": "",
              "name": "mode_c",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908",
          "type": "parallel",
          "position": {
            "x": 141,
            "y": 233
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 234
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 145,
                  "y": 234
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 234
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 141,
                "y": 234
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 234
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "2175168",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 234
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 234
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_fafa69f8-dfbb-4f79-a115-cec25cc5b926",
          "type": "contact",
          "position": {
            "x": 190,
            "y": 222
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 214,
                  "y": 234
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 234
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 214,
                  "y": 234
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 190,
                "y": 234
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 214,
                "y": 234
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "7977835",
            "variable": {
              "id": "",
              "name": "release",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97",
          "type": "parallel",
          "position": {
            "x": 259,
            "y": 141
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 259,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 263,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 263,
                  "y": 142
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 263,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 259,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 263,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 263,
                  "y": 142
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 263,
                  "y": 142
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 259,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 263,
                "y": 142
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "1038433",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 263,
                "y": 142
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 263,
                "y": 142
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_fb2c5f1a-2e87-493a-b355-4200c8aff6f2",
          "type": "contact",
          "position": {
            "x": 308,
            "y": 130
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 308,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 332,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 308,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 332,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 308,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 332,
                "y": 142
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "2299516",
            "variable": {
              "id": "",
              "name": "full_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17",
          "type": "parallel",
          "position": {
            "x": 377,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 377,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 381,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 381,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 381,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 377,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 381,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 381,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 381,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 377,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 381,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "9116338",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 381,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 381,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_3ae04959-3b3c-4cdb-80f6-a8003a217ff2",
          "type": "contact",
          "position": {
            "x": 426,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 426,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 450,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 426,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 450,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 426,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 450,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "2843400",
            "variable": {
              "id": "",
              "name": "run_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "COIL_05b8bdf9-5d3c-479f-8cd8-1dc1eb4bc0d6",
          "type": "coil",
          "position": {
            "x": 540,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 540,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 568,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 540,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 568,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 540,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 568,
                "y": 50
              },
              "relPosition": {
                "x": 28,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "10091645",
            "variable": {
              "id": "",
              "name": "motor",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 28,
          "height": 24,
          "measured": {
            "width": 28,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "right-rail-rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36",
          "type": "powerRail",
          "position": {
            "x": 678,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                },
                "x": 678
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                }
              }
            ],
            "outputHandles": [],
            "inputConnector": {
              "glbPosition": {
                "x": 297,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "right-rail",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 20,
                "left": -3
              }
            },
            "numericId": "3302880",
            "variant": "right",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        }
      ],
      "edges": [
        {
          "id": "e_COIL_05b8bdf9-5d3c-479f-8cd8-1dc1eb4bc0d6_right-rail-rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36__output_right-rail",
          "source": "COIL_05b8bdf9-5d3c-479f-8cd8-1dc1eb4bc0d6",
          "target": "right-rail-rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36",
          "sourceHandle": "output",
          "targetHandle": "right-rail"
        },
        {
          "id": "e_left-rail-rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36_PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03__left-rail_input",
          "source": "left-rail-rung_main_83ae237c-23ab-405b-aa73-33ed56f88c36",
          "target": "PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03",
          "sourceHandle": "left-rail",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03_CONTACT_c34cf3e8-29e2-49b8-b419-497fc6173379__output-right_input",
          "source": "PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03",
          "target": "CONTACT_c34cf3e8-29e2-49b8-b419-497fc6173379",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_c34cf3e8-29e2-49b8-b419-497fc6173379_PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17__output_input",
          "source": "CONTACT_c34cf3e8-29e2-49b8-b419-497fc6173379",
          "target": "PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17_CONTACT_3ae04959-3b3c-4cdb-80f6-a8003a217ff2__output-right_input",
          "source": "PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17",
          "target": "CONTACT_3ae04959-3b3c-4cdb-80f6-a8003a217ff2",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_3ae04959-3b3c-4cdb-80f6-a8003a217ff2_COIL_05b8bdf9-5d3c-479f-8cd8-1dc1eb4bc0d6__output_input",
          "source": "CONTACT_3ae04959-3b3c-4cdb-80f6-a8003a217ff2",
          "target": "COIL_05b8bdf9-5d3c-479f-8cd8-1dc1eb4bc0d6",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_fb2c5f1a-2e87-493a-b355-4200c8aff6f2_PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17__output_input-down",
          "source": "CONTACT_fb2c5f1a-2e87-493a-b355-4200c8aff6f2",
          "target": "PARALLEL_CLOSE_12c2fd03-02c8-4918-bf1a-e1531e32ad17",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03_PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595__output-down_input-top",
          "source": "PARALLEL_OPEN_7519df21-b294-4da9-817d-4fc3e8e66c03",
          "target": "PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595",
          "sourceHandle": "output-down",
          "targetHandle": "input-top"
        },
        {
          "id": "e_PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595_CONTACT_1f7ce30a-12f6-49ad-bf3a-1547934a6eb2__output-right_input",
          "source": "PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595",
          "target": "CONTACT_1f7ce30a-12f6-49ad-bf3a-1547934a6eb2",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_1f7ce30a-12f6-49ad-bf3a-1547934a6eb2_PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97__output_input",
          "source": "CONTACT_1f7ce30a-12f6-49ad-bf3a-1547934a6eb2",
          "target": "PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97_CONTACT_fb2c5f1a-2e87-493a-b355-4200c8aff6f2__output-right_input",
          "source": "PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97",
          "target": "CONTACT_fb2c5f1a-2e87-493a-b355-4200c8aff6f2",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_fafa69f8-dfbb-4f79-a115-cec25cc5b926_PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97__output_input-down",
          "source": "CONTACT_fafa69f8-dfbb-4f79-a115-cec25cc5b926",
          "target": "PARALLEL_CLOSE_7c9a207c-9e8e-4b1b-9111-bae790298f97",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595_PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce__output-down_input-top",
          "source": "PARALLEL_OPEN_d7f1ec81-e09f-400e-850a-4badaf3b7595",
          "target": "PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce",
          "sourceHandle": "output-down",
          "targetHandle": "input-top"
        },
        {
          "id": "e_PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce_CONTACT_011cd55c-8011-4b77-8f3f-f1d1e947e454__output-right_input",
          "source": "PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce",
          "target": "CONTACT_011cd55c-8011-4b77-8f3f-f1d1e947e454",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_011cd55c-8011-4b77-8f3f-f1d1e947e454_PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908__output_input",
          "source": "CONTACT_011cd55c-8011-4b77-8f3f-f1d1e947e454",
          "target": "PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce_CONTACT_4b950c66-f3aa-4be1-9377-7bf9534ecc8e__output-down_input",
          "source": "PARALLEL_OPEN_473a119f-b5e0-45cb-be65-e51721b436ce",
          "target": "CONTACT_4b950c66-f3aa-4be1-9377-7bf9534ecc8e",
          "sourceHandle": "output-down",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_4b950c66-f3aa-4be1-9377-7bf9534ecc8e_PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908__output_input-down",
          "source": "CONTACT_4b950c66-f3aa-4be1-9377-7bf9534ecc8e",
          "target": "PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908_CONTACT_fafa69f8-dfbb-4f79-a115-cec25cc5b926__output-right_input",
          "source": "PARALLEL_CLOSE_017756c8-323f-4fec-b8be-17d5bcd25908",
          "target": "CONTACT_fafa69f8-dfbb-4f79-a115-cec25cc5b926",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        }
      ],
      "selectedNodes": []
    },
    {
      "id": "rung_main_3b8af3da-92c2-498d-9943-c8f835e52725",
      "comment": "",
      "defaultBounds": [
        300,
        100
      ],
      "reactFlowViewport": [
        673,
        174
      ],
      "nodes": [
        {
          "id": "left-rail-rung_main_3b8af3da-92c2-498d-9943-c8f835e52725",
          "type": "powerRail",
          "position": {
            "x": 0,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "inputHandles": [],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "outputConnector": {
              "glbPosition": {
                "x": 3,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "left-rail",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 20,
                "right": -3
              }
            },
            "numericId": "6801682",
            "variant": "left",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "1656417",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_b6432a21-0f0f-485e-8c94-fedacf931b39",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "9473209",
            "variable": {
              "id": "",
              "name": "mode_a",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_eb488989-9896-4527-9a50-1b7e4e37a1c7",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 130
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 142
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "2931810",
            "variable": {
              "id": "",
              "name": "mode_b",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037",
          "type": "parallel",
          "position": {
            "x": 141,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 141,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "3421464",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_973e36e2-38fe-4ec2-82b8-0cbf809d883d",
          "type": "contact",
          "position": {
            "x": 190,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 190,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 214,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "9398135",
            "variable": {
              "id": "",
              "name": "run_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_0c831fc0-3edf-4bc2-9bdf-1deaaac73d2c",
          "type": "contact",
          "position": {
            "x": 304,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 328,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 328,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 304,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 328,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "4914520",
            "variable": {
              "id": "",
              "name": "prox",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_39ac89b8-195c-41cb-813b-d23152a1c56d",
          "type": "contact",
          "position": {
            "x": 418,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 418,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 442,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "negated",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 418,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 442,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 418,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 442,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "7951941",
            "variable": {
              "id": "",
              "name": "full_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "COIL_21b83f0d-ff49-4811-a540-8e623fb83011",
          "type": "coil",
          "position": {
            "x": 532,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 532,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 560,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 532,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 560,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 532,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 560,
                "y": 50
              },
              "relPosition": {
                "x": 28,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "7391901",
            "variable": {
              "id": "",
              "name": "solenoid",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 28,
          "height": 24,
          "measured": {
            "width": 28,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "right-rail-rung_main_3b8af3da-92c2-498d-9943-c8f835e52725",
          "type": "powerRail",
          "position": {
            "x": 670,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                },
                "x": 670
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                }
              }
            ],
            "outputHandles": [],
            "inputConnector": {
              "glbPosition": {
                "x": 297,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "right-rail",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 20,
                "left": -3
              }
            },
            "numericId": "6704639",
            "variant": "right",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        }
      ],
      "edges": [
        {
          "id": "e_COIL_21b83f0d-ff49-4811-a540-8e623fb83011_right-rail-rung_main_3b8af3da-92c2-498d-9943-c8f835e52725__output_right-rail",
          "source": "COIL_21b83f0d-ff49-4811-a540-8e623fb83011",
          "target": "right-rail-rung_main_3b8af3da-92c2-498d-9943-c8f835e52725",
          "sourceHandle": "output",
          "targetHandle": "right-rail"
        },
        {
          "id": "e_CONTACT_973e36e2-38fe-4ec2-82b8-0cbf809d883d_CONTACT_0c831fc0-3edf-4bc2-9bdf-1deaaac73d2c__output_input",
          "source": "CONTACT_973e36e2-38fe-4ec2-82b8-0cbf809d883d",
          "target": "CONTACT_0c831fc0-3edf-4bc2-9bdf-1deaaac73d2c",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_0c831fc0-3edf-4bc2-9bdf-1deaaac73d2c_CONTACT_39ac89b8-195c-41cb-813b-d23152a1c56d__output_input",
          "source": "CONTACT_0c831fc0-3edf-4bc2-9bdf-1deaaac73d2c",
          "target": "CONTACT_39ac89b8-195c-41cb-813b-d23152a1c56d",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_39ac89b8-195c-41cb-813b-d23152a1c56d_COIL_21b83f0d-ff49-4811-a540-8e623fb83011__output_input",
          "source": "CONTACT_39ac89b8-195c-41cb-813b-d23152a1c56d",
          "target": "COIL_21b83f0d-ff49-4811-a540-8e623fb83011",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_left-rail-rung_main_3b8af3da-92c2-498d-9943-c8f835e52725_PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5__left-rail_input",
          "source": "left-rail-rung_main_3b8af3da-92c2-498d-9943-c8f835e52725",
          "target": "PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5",
          "sourceHandle": "left-rail",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5_CONTACT_b6432a21-0f0f-485e-8c94-fedacf931b39__output-right_input",
          "source": "PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5",
          "target": "CONTACT_b6432a21-0f0f-485e-8c94-fedacf931b39",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_b6432a21-0f0f-485e-8c94-fedacf931b39_PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037__output_input",
          "source": "CONTACT_b6432a21-0f0f-485e-8c94-fedacf931b39",
          "target": "PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5_CONTACT_eb488989-9896-4527-9a50-1b7e4e37a1c7__output-down_input",
          "source": "PARALLEL_OPEN_9336a63a-5b59-45c2-901f-91f053ac36c5",
          "target": "CONTACT_eb488989-9896-4527-9a50-1b7e4e37a1c7",
          "sourceHandle": "output-down",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_eb488989-9896-4527-9a50-1b7e4e37a1c7_PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037__output_input-down",
          "source": "CONTACT_eb488989-9896-4527-9a50-1b7e4e37a1c7",
          "target": "PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037_CONTACT_973e36e2-38fe-4ec2-82b8-0cbf809d883d__output-right_input",
          "source": "PARALLEL_CLOSE_d666b528-e77a-4a9c-8c17-0a0b99a5f037",
          "target": "CONTACT_973e36e2-38fe-4ec2-82b8-0cbf809d883d",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        }
      ],
      "selectedNodes": []
    },
    {
      "id": "rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b",
      "comment": "",
      "defaultBounds": [
        300,
        100
      ],
      "reactFlowViewport": [
        323,
        120
      ],
      "nodes": [
        {
          "id": "left-rail-rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b",
          "type": "powerRail",
          "position": {
            "x": 0,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "inputHandles": [],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "outputConnector": {
              "glbPosition": {
                "x": 3,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "left-rail",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 20,
                "right": -3
              }
            },
            "numericId": "10029362",
            "variant": "left",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_5d19c016-ef07-41ed-9da6-d824040b92f6",
          "type": "contact",
          "position": {
            "x": 68,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 68,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 92,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 68,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 92,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 68,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 92,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "5787520",
            "variable": {
              "id": "",
              "name": "solenoid",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "COIL_8caa7362-5b73-46ca-9107-4785a35e8ce6",
          "type": "coil",
          "position": {
            "x": 182,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 182,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 210,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 182,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 210,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 182,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 210,
                "y": 50
              },
              "relPosition": {
                "x": 28,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "3541782",
            "variable": {
              "id": "",
              "name": "fill_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 28,
          "height": 24,
          "measured": {
            "width": 28,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "right-rail-rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b",
          "type": "powerRail",
          "position": {
            "x": 320,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                },
                "x": 320
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                }
              }
            ],
            "outputHandles": [],
            "inputConnector": {
              "glbPosition": {
                "x": 297,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "right-rail",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 20,
                "left": -3
              }
            },
            "numericId": "5257756",
            "variant": "right",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        }
      ],
      "edges": [
        {
          "id": "e_left-rail-rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b_CONTACT_5d19c016-ef07-41ed-9da6-d824040b92f6__left-rail_input",
          "source": "left-rail-rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b",
          "target": "CONTACT_5d19c016-ef07-41ed-9da6-d824040b92f6",
          "sourceHandle": "left-rail",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_5d19c016-ef07-41ed-9da6-d824040b92f6_COIL_8caa7362-5b73-46ca-9107-4785a35e8ce6__output_input",
          "source": "CONTACT_5d19c016-ef07-41ed-9da6-d824040b92f6",
          "target": "COIL_8caa7362-5b73-46ca-9107-4785a35e8ce6",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_COIL_8caa7362-5b73-46ca-9107-4785a35e8ce6_right-rail-rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b__output_right-rail",
          "source": "COIL_8caa7362-5b73-46ca-9107-4785a35e8ce6",
          "target": "right-rail-rung_main_a37c2b64-2bed-462c-8252-789cae2b8d5b",
          "sourceHandle": "output",
          "targetHandle": "right-rail"
        }
      ],
      "selectedNodes": []
    },
    {
      "id": "rung_main_c6d58123-6876-4a7b-b327-5e842681968b",
      "comment": "",
      "defaultBounds": [
        300,
        100
      ],
      "reactFlowViewport": [
        559,
        174
      ],
      "nodes": [
        {
          "id": "left-rail-rung_main_c6d58123-6876-4a7b-b327-5e842681968b",
          "type": "powerRail",
          "position": {
            "x": 0,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "inputHandles": [],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 3,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "left-rail",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "right": -3
                }
              }
            ],
            "outputConnector": {
              "glbPosition": {
                "x": 3,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "left-rail",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 20,
                "right": -3
              }
            },
            "numericId": "6286039",
            "variant": "left",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29",
          "type": "parallel",
          "position": {
            "x": 23,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 23,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "input-top",
                "position": "top",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 27,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "output-down",
                "position": "bottom",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 23,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "9117652",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "input-top",
              "position": "top",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 27,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "output-down",
              "position": "bottom",
              "type": "source",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelCloseReference": "PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c",
            "type": "open",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_72565903-63b3-420f-a239-4ba0bcf3c4bc",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "3363741",
            "variable": {
              "id": "",
              "name": "start",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_238d6aec-26c3-4793-a55a-93c93a678f9e",
          "type": "contact",
          "position": {
            "x": 72,
            "y": 130
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 72,
                  "y": 142
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 96,
                  "y": 142
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 72,
                "y": 142
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 96,
                "y": 142
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "4697944",
            "variable": {
              "id": "",
              "name": "release",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c",
          "type": "parallel",
          "position": {
            "x": 141,
            "y": 49
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 141,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 1
                },
                "id": "input",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "left": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 2
                },
                "id": "input-down",
                "position": "bottom",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "bottom": 1
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 4,
                  "y": 1
                },
                "id": "output-right",
                "position": "right",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "visibility": "hidden",
                  "right": 3
                }
              },
              {
                "glbPosition": {
                  "x": 145,
                  "y": 50
                },
                "relPosition": {
                  "x": 2,
                  "y": 0
                },
                "id": "output-top",
                "position": "top",
                "type": "source",
                "isConnectable": false,
                "style": {
                  "top": 1
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 141,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 1
              },
              "id": "input",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "left": 3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 4,
                "y": 1
              },
              "id": "output-right",
              "position": "right",
              "type": "source",
              "isConnectable": false,
              "style": {
                "visibility": "hidden",
                "right": 3
              }
            },
            "numericId": "7290717",
            "parallelInputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 2
              },
              "id": "input-down",
              "position": "bottom",
              "type": "target",
              "isConnectable": false,
              "style": {
                "bottom": 1
              }
            },
            "parallelOutputConnector": {
              "glbPosition": {
                "x": 145,
                "y": 50
              },
              "relPosition": {
                "x": 2,
                "y": 0
              },
              "id": "output-top",
              "position": "top",
              "type": "source",
              "isConnectable": false,
              "style": {
                "top": 1
              }
            },
            "parallelOpenReference": "PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29",
            "type": "close",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 4,
          "height": 2,
          "measured": {
            "width": 4,
            "height": 2
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_f5e19291-9a3c-4216-97f3-a9bbab7bf8a9",
          "type": "contact",
          "position": {
            "x": 190,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 190,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 214,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 190,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 214,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "1209642",
            "variable": {
              "id": "",
              "name": "full_light",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "CONTACT_3952895b-48ad-4d89-b50c-1ed2b2a29ed0",
          "type": "contact",
          "position": {
            "x": 304,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 328,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 304,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 328,
                  "y": 50
                },
                "relPosition": {
                  "x": 24,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 304,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 328,
                "y": 50
              },
              "relPosition": {
                "x": 24,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "8382073",
            "variable": {
              "id": "",
              "name": "prox",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 24,
          "height": 24,
          "measured": {
            "width": 24,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "COIL_d8ed68a7-7b6a-43e6-849a-d394b7798bbe",
          "type": "coil",
          "position": {
            "x": 418,
            "y": 38
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 418,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              },
              {
                "glbPosition": {
                  "x": 446,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "variant": "default",
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 418,
                  "y": 50
                },
                "relPosition": {
                  "x": 0,
                  "y": 12
                },
                "id": "input",
                "position": "left",
                "isConnectable": false,
                "type": "target",
                "style": {
                  "left": -3
                }
              }
            ],
            "outputHandles": [
              {
                "glbPosition": {
                  "x": 446,
                  "y": 50
                },
                "relPosition": {
                  "x": 28,
                  "y": 12
                },
                "id": "output",
                "position": "right",
                "isConnectable": false,
                "type": "source",
                "style": {
                  "right": -3
                }
              }
            ],
            "inputConnector": {
              "glbPosition": {
                "x": 418,
                "y": 50
              },
              "relPosition": {
                "x": 0,
                "y": 12
              },
              "id": "input",
              "position": "left",
              "isConnectable": false,
              "type": "target",
              "style": {
                "left": -3
              }
            },
            "outputConnector": {
              "glbPosition": {
                "x": 446,
                "y": 50
              },
              "relPosition": {
                "x": 28,
                "y": 12
              },
              "id": "output",
              "position": "right",
              "isConnectable": false,
              "type": "source",
              "style": {
                "right": -3
              }
            },
            "numericId": "8547495",
            "variable": {
              "id": "",
              "name": "release",
              "type": {
                "definition": "base-type",
                "value": "BOOL"
              },
              "class": "local",
              "location": "",
              "documentation": "",
              "debug": false
            },
            "executionOrder": 0,
            "draggable": true,
            "selectable": true,
            "deletable": true
          },
          "width": 28,
          "height": 24,
          "measured": {
            "width": 28,
            "height": 24
          },
          "draggable": true,
          "selectable": true,
          "selected": false,
          "dragging": false
        },
        {
          "id": "right-rail-rung_main_c6d58123-6876-4a7b-b327-5e842681968b",
          "type": "powerRail",
          "position": {
            "x": 556,
            "y": 30
          },
          "data": {
            "handles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                },
                "x": 556
              }
            ],
            "inputHandles": [
              {
                "glbPosition": {
                  "x": 297,
                  "y": 50
                },
                "relPosition": {
                  "x": 3,
                  "y": 20
                },
                "id": "right-rail",
                "position": "left",
                "type": "target",
                "isConnectable": false,
                "style": {
                  "top": 20,
                  "left": -3
                }
              }
            ],
            "outputHandles": [],
            "inputConnector": {
              "glbPosition": {
                "x": 297,
                "y": 50
              },
              "relPosition": {
                "x": 3,
                "y": 20
              },
              "id": "right-rail",
              "position": "left",
              "type": "target",
              "isConnectable": false,
              "style": {
                "top": 20,
                "left": -3
              }
            },
            "numericId": "5388719",
            "variant": "right",
            "variable": {
              "name": ""
            },
            "executionOrder": 0,
            "draggable": false,
            "selectable": false,
            "deletable": false
          },
          "width": 3,
          "height": 40,
          "measured": {
            "width": 3,
            "height": 40
          },
          "draggable": false,
          "selectable": false,
          "selected": false,
          "dragging": false
        }
      ],
      "edges": [
        {
          "id": "e_CONTACT_f5e19291-9a3c-4216-97f3-a9bbab7bf8a9_CONTACT_3952895b-48ad-4d89-b50c-1ed2b2a29ed0__output_input",
          "source": "CONTACT_f5e19291-9a3c-4216-97f3-a9bbab7bf8a9",
          "target": "CONTACT_3952895b-48ad-4d89-b50c-1ed2b2a29ed0",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_3952895b-48ad-4d89-b50c-1ed2b2a29ed0_COIL_d8ed68a7-7b6a-43e6-849a-d394b7798bbe__output_input",
          "source": "CONTACT_3952895b-48ad-4d89-b50c-1ed2b2a29ed0",
          "target": "COIL_d8ed68a7-7b6a-43e6-849a-d394b7798bbe",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_COIL_d8ed68a7-7b6a-43e6-849a-d394b7798bbe_right-rail-rung_main_c6d58123-6876-4a7b-b327-5e842681968b__output_right-rail",
          "source": "COIL_d8ed68a7-7b6a-43e6-849a-d394b7798bbe",
          "target": "right-rail-rung_main_c6d58123-6876-4a7b-b327-5e842681968b",
          "sourceHandle": "output",
          "targetHandle": "right-rail"
        },
        {
          "id": "e_left-rail-rung_main_c6d58123-6876-4a7b-b327-5e842681968b_PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29__left-rail_input",
          "source": "left-rail-rung_main_c6d58123-6876-4a7b-b327-5e842681968b",
          "target": "PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29",
          "sourceHandle": "left-rail",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29_CONTACT_72565903-63b3-420f-a239-4ba0bcf3c4bc__output-right_input",
          "source": "PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29",
          "target": "CONTACT_72565903-63b3-420f-a239-4ba0bcf3c4bc",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_72565903-63b3-420f-a239-4ba0bcf3c4bc_PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c__output_input",
          "source": "CONTACT_72565903-63b3-420f-a239-4ba0bcf3c4bc",
          "target": "PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c",
          "sourceHandle": "output",
          "targetHandle": "input"
        },
        {
          "id": "e_PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29_CONTACT_238d6aec-26c3-4793-a55a-93c93a678f9e__output-down_input",
          "source": "PARALLEL_OPEN_b7348cfc-5fa8-4abf-a01b-f94b90ba8d29",
          "target": "CONTACT_238d6aec-26c3-4793-a55a-93c93a678f9e",
          "sourceHandle": "output-down",
          "targetHandle": "input"
        },
        {
          "id": "e_CONTACT_238d6aec-26c3-4793-a55a-93c93a678f9e_PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c__output_input-down",
          "source": "CONTACT_238d6aec-26c3-4793-a55a-93c93a678f9e",
          "target": "PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c",
          "sourceHandle": "output",
          "targetHandle": "input-down"
        },
        {
          "id": "e_PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c_CONTACT_f5e19291-9a3c-4216-97f3-a9bbab7bf8a9__output-right_input",
          "source": "PARALLEL_CLOSE_68018c39-1891-4db1-93aa-caa79d5f097c",
          "target": "CONTACT_f5e19291-9a3c-4216-97f3-a9bbab7bf8a9",
          "sourceHandle": "output-right",
          "targetHandle": "input"
        }
      ],
      "selectedNodes": []
    }
  ]
}
END_PROGRAM