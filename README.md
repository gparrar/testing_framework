ROBOT TESTING FRAMEWORK
=======================
# Folder Structure:

```
.
├── keywords/
├── libraries/
├── resources/
├── variables/
├── tests/
├── README.md
├── Dockerfile
├── requirements.txt
├── run.sh
├── Makefile
└── pre-install.sh

```

## Keywords
In this folder specific user keywords for each component of the application are stored. These are used to create new higher-level keywords by combining existing keywords together. these keywords are called user keywords to differentiate them from lowest level library keywords that are implemented in test libraries.
```
.
├── keywords
│   ├── object_vehicle_counting
│   │   └── keywords_vehicle_counting.robot
│   ├── service_influence_zone
│   │   ├── keywords_influence_zone.robot
│   │   └── keywords_gui_influence_zone.robot
│   ├── ...
│   └── keywords_commons.robot
.
```

## Resources
Multiple types of resource files used by keywords of the different components of the application, such as images, json, initial data, scripts among others.
```
.
├── resources
│   ├── object_vehicle_counting
│   │   ├── images
│   │   │   ├── xxx.png
│   │   │   └── yyy.png
│   │   └── initial_data
│   │       └── insert.py
│   ├── service_influence_zone
│   │   ├── images
│   │   │   ├── xxx.png
│   │   │   └── yyy.png
│   │   └── initial_data
│   │       └── insert.py
│   ├── ...
.
```

## Libraries
Robot Framework's actual testing capabilities are provided by test libraries. When something can't be implemented with the already existing libraries there is an option to create specific ones.

The public libraries used in this project are:
- [OperatingSystem](http://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Grep%20File)
- [DatabaseLibrary](http://franz-see.github.io/Robotframework-Database-Library/api/0.5/DatabaseLibrary.html#Connect To Database Using Custom Params)
- [Collections](http://robotframework.org/robotframework/latest/libraries/Collections.html)
- [Selenium2Library](http://robotframework.org/Selenium2Library/Selenium2Library.html#Element%20Text%20Should%20Be)
- [SSHLibrary](http://robotframework.org/SSHLibrary/latest/SSHLibrary.html)
- [HttpLibrary.HTTP](http://peritus.github.io/robotframework-httplibrary/HttpLibrary.html)
- [String](http://robotframework.org/robotframework/latest/libraries/String.html)
- [SikuliLibrary](http://rainmanwy.github.io/robotframework-SikuliLibrary/doc/SikuliLibrary.html)

In this folder there are the required specific libraries to communicate to the different components of the application.

```
.
├── libraries
│   ├── object_traffic
│   │   └── traffic_library.py
│   ├── service_actions
│   │    └── ActionController.py
│   ├── ...
.
```

## Tests
Contains all test protocols for the different components of the application. The hierarchical structure for arranging test cases is built as follows:

- Test cases are created in test case files.
- A test case file automatically creates a test suite containing the test cases in that file.
- A directory containing test case files forms a higher-level test suite. Such a test suite directory has suites created from test case files as its sub test suites.
- A test suite directory can also contain other test suite directories, and this hierarchical structure can be as deeply nested as needed.

### Naming Convention

*Directories:* Should be named as the component in test.

*Test Case Files:* Should be named depending on the part of the component which is being tested, such as `package` if the test relates to the Front End or `object|service|datafeed` if the test relates to the Back End.

### Tags

*By Test Type:*

- Smoke
- Integration
- Functional
- E2E
- Performance

*By Importance:*

- Critical
- High
- Medium
- Low

```
.
├── tests
│   ├── custom_object
│   │   └── service.robot
│   ├── datawarehouse
│   │   └── database.robot
│   ├── incidents
│   │   └── package.robot
│   ├── influence_zones
│   │   ├── package_map.robot
│   │   ├── package_panel.robot
│   │   └── service.robot
│   ├── tracking
│   │   ├── object.robot
│   │   └── package.robot
│   └── ...
.
```

## Variables
Contains set of variables by component of the application to run test over multiple testing scenarios or environments.
```
.
├── variables
│   ├── datafeed_traveltimes
│   │   ├── envXXX_variables.py
│   │   ├── envYYY_variables.py
│   │   └── ${ENV}_variables.py
│   ├── object_tracking
│   │   ├── envXXX_variables.py
│   │   ├── envYYY_variables.py
│   │   ├── ${ENV}_variables.py
│   └── ...
.
```

# Execution

There are different ways of execution:

`make run` will run all tests for all components, it is possible to add two parameters `ROBOT_TESTS` to select the tests to run and `LOG_LEVEL` to select the logging level [TRACE, DEBUG, INFO (default), WARN, NONE (no logging)]

`make run ROBOT_TESTS={tests_here}` regex to match whatever test suite in the structure above.

Ex:
- `make run ROBOT_TESTS=actions/` to run all actions tests
- `make run ROBOT_TESTS=tracking/package.robot` to run only gui tests for tracking component
- `make run ROBOT_TESTS=**/api.object.robot` to run object tests for all components.


`make run-jenkins` to run tests in jenkins. Same parameters apply.

`make run interactive` to start the container interactively

# Reports
After each run, report files are created containing an overview of the test execution results in HTML format.

They have statistics based on tags and executed test suites, as well as a list of all executed test cases. When both reports and logs are generated, the report has links to the log file for easy navigation to more detailed information. It is easy to see the overall test execution status from report, because its background color is green, if all critical tests pass, and bright red otherwise.

- log.html
- output.xml
- report.html

All reports will be stored at the following [Link](http://ci.wocs3.com/robot_reports/) grouped by *environment*, *component* and *date of execution*
