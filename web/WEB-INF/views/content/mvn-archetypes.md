##(µ)Micro Archetypes

Micro's [archetypes directory](https://github.com/florinpatrascu/micro/tree/master/archetypes) is a collection of Apache Maven project archetypes designed for the (µ)Micro framework.


#### Requirements
To install and use these archetypes [Apache Maven](http://maven.apache.org) needs to be present.


#### Getting started
Installation:

    cd archetypes/quickstart
    mvn install

#### Usage from command line

    mvn archetype:generate \
      -DarchetypeGroupId=ca.simplegames.micro\
      -DarchetypeArtifactId=micro-quickstart \
      -DarchetypeVersion=0.2.2 \
      -DgroupId=com.mycompany \
      -DartifactId=myproject

#### Usage from [IntelliJ IDEA](https://www.jetbrains.com/idea/)
Open IntelliJ. Choose `File/Import/Existing Project` and point it to `myproject` directory. Or, you can add the `quickstart` archetype in IntelliJ by simply following the few next steps:

- `File/New Project`
- select `Create from archetype` and click the `Add Archetype` button
- choose `ca.simplegames.micro:micro-quickstart` from the list

And simply follow the dialog prompted by IntelliJ :)

#### Launching the generated application using the embedded Jetty web server

    cd myproject
    mvn compile install exec:java

    #or: mvn exec:java

Browse to http://localhost:8080/
