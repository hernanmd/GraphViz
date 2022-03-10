[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

# Table of Contents

- [Description](#description)
- [Installation](#installation)
- [Examples](#examples)
- [License](#license)

# Description

This is a Pharo Smalltalk GraphViz binding. 

This repository contains the updated code (from the original code found in the Lukas Renggli [repository](http://source.lukas-renggli.ch/)) for versions higher than Pharo >= 6 (Pharo 10 supported).

Note: If you are using Roassal engine, you can also work with GraphViz layouts using [a specialized package for GraphViz+Roassal](https://github.com/peteruhnak/graphviz-layout).

# Installation

Make sure you have installed the [graphviz binaries](https://graphviz.org/) in your system.
There are several ways to install the **GraphViz** package in Pharo:

## Core version

The Core version includes only the basic GraphViz classes which provide core features, without examples and tests

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new
		baseline: 'GraphViz';
		repository: 'github://hernanmd/GraphViz';
		load ]
```

## Full version

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new
		baseline: 'GraphViz';
		repository: 'github://hernanmd/GraphViz';
		load: #('All') ]
```

# Examples


```smalltalk
GraphVizExamples familiesOfSmalltalk
```

![FamiliesOfSmalltalk](https://user-images.githubusercontent.com/4825959/155390651-1ba889f3-f32a-41f1-9ff1-c4de6d865b45.svg)


```smalltalk
GraphVizExamples exampleUndirectedGraph 
```

![undirectedGraphSample](https://user-images.githubusercontent.com/4825959/155387760-9c7528db-b502-4551-bb40-a030fa029ba0.png)


```smalltalk
GraphVizExamples exampleUndirectedGraph 
```

![UsersOfWeakRegistry](https://user-images.githubusercontent.com/4825959/155387908-b8e933a3-1bbb-4dc5-b082-ff66e28f0beb.png)


# License
	
This software is licensed under the MIT License.

Copyright Hernán Morales Durand, 2018-2022.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Authors

Hernán Morales Durand
