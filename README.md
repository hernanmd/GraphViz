[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

# Description

This is a Pharo Smalltalk GraphViz binding. It is a port to Pharo >= 6 of the work found in the Lukas Renggli [repository](http://source.lukas-renggli.ch/). Note that if you are using Roassal engine, you can also with GraphViz layouts using [a specialized package for this](https://github.com/peteruhnak/graphviz-layout).

# Installation

There are several ways to install the **GraphViz** package:

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

## Examples

```smalltalk
GraphViz exampleUndirectedGraph 
```

![undirectedGraphSample](https://user-images.githubusercontent.com/4825959/155387760-9c7528db-b502-4551-bb40-a030fa029ba0.png)


```smalltalk
GraphViz exampleUndirectedGraph 
```

![UsersOfWeakRegistry](https://user-images.githubusercontent.com/4825959/155387908-b8e933a3-1bbb-4dc5-b082-ff66e28f0beb.png)

