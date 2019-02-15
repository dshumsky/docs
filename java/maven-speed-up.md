### Parallel builds in Maven
By default, Maven does not utilize the full power of your hardware. It builds all modules sequentially rather than in parallel. However, often your project setup does not require it to be sequential. Often you can command Maven to analyze your project including the dependency graph and build the project in parallel where possible. You can either specify the exact number of threads to use for building your project or use a portable version of the parameter and specify the number of thread in terms of CPUs available on the machine.
mvn -T 4 install -- will use 4 threads
mvn -T 1C install -- will use 1 thread per available CPU core
While it might happen that your project is not easy to build in parallel it’s worth trying, the speedup can be substantial. Using one thread per CPU core is a good default. Your development machine probably has spare computing power and speeding up the build is always useful.

### Running Maven tests in parallel
An aspect of build which probably has the biggest impact on your build speed are the tests. The most common practice is to disable the tests when you’re just interested in building your artifacts, but we cannot recommend such a non-conventional engineering practice.
If you really do intend to skip your test goals (Are you sure? Are you sure you’re sure?) during your Maven build, then the most common property that the majority plugins respect is: -DskipTests=true
However, you can achieve faster build times without damaging your feedback loop that much. The answer is running tests in parallel. The parallelization technique that we just discussed works on the module level. If you’re using an established plugin for running tests, let’s say, Surefire, you can also configure it for parallel execution within the module.
Running tests in parallel might lead to unwanted side-effects, especially if they are tangled together and expect to be executed in a certain order. However, that’s another story altogether and you should totally try it to see if it works for you and by how much it speeds up your build. You can always figure out the failures later.
https://maven.apache.org/surefire/maven-surefire-plugin/examples/fork-options-and-parallel-execution.html

###  Build necessary modules only
Let’s have a bet. I bet fifty RebelLabs dollars that when you build your project, the chances are you’re using the default command:
mvn clean install
Did I win? Thought so! While cleaning Maven is removing all the generated artifacts, all temporary files, except hopefully the configuration and the files checked in into the version control. It then generates fresh copies of those files again. It’s great for when you hit a weird caching issue or some obscure bug that you have but nobody else is able to reproduce. However, it will take extra precious seconds and CPU cycles to do what is essentially a needless job of recreating already existing files.
Instead what you most typically want to do is to build your project incrementally. Say you have a multi-module project with common core modules that rarely change and a web-interface that you’re currently working on. After changing the web-interface module try running a command like the following:
mvn install -pl $moduleName -am
First of all, we removed the implicit call to the clean phase. The project rarely requires cleaning, so we won’t want to do it all the time. Let’s take a look at the descriptions of the other options in the Maven command we just used:
-pl – makes Maven build only specified modules and not the whole project.
-am – makes Maven figure out what modules out target depends on and build them too.
The result of using these options together is the perfect combination of the flexibility and speed. We know what module we’re usually working on and if we have changed any dependencies, they will be renewed as well.
At the same time a large chunk of your project build will be skipped either because it’s still fresh and doesn’t require rebuilding or because it’s not a part of the target module and won’t play a role.

### Limit internet access
You’ll like this one. If you sometimes feel like Maven is downloading the internet, know that you’re not alone! This is one of the most common complaints of any build system, npm, gradle, sbt. You name it, you’ll be surprised at how many libraries and transitive dependencies known to humanity will need to be downloaded at an arbitrary, and usually most inopportune time.
However, there’s a simple option you can enable that will make Maven work offline. You’ve probably guessed correctly, it’s the infamous offline key. When the offline mode is enabled, Maven won’t connect to any remote repositories when resolving dependencies. All the jar files in the local repository will still be available, so it won’t break your usual workflow.
So just append your mvn command with –offline and Maven won’t be tempted to check for a new snapshot of your favorite dependency and won’t make you wait for the network to respond.
If you don’t want to take it offline, but have a shady network connection, you can try setting:
-DdependencyLocationsEnabled=false to your MAVEN_OPTS variables. This addition will mean Maven will retain fewer outgoing connections throughout the build and maybe shave a few seconds off your build as well.

### Speeding up Java startup
The last bit that I want to share with you today doesn’t come from my experience, but some research. Maven is a Java program, so it will of course run on the JVM. This in turn can be tuned for a much faster startup.
To make the JVM start a bit faster (safe in the knowledge we’re not dealing with a long-running application server process that has to be optimized for a faster execution later on), we can recommend the following two options for your Maven process:
-XX:+TieredCompilation -XX:TieredStopAtLevel=1
We just made your JVM perform the basic just-in-time compilation of the code only. It won’t try to gather a more precise profile and better optimize the execution of the code. The benefit of that is that the JIT doesn’t need that much information and the optimized code actually has a chance to kick in during a since build.
Note, that this advice is purely theoretical, I’d be happy if you could try it and mention whether your project build benefits from it.



### Concurrent Safe Local Repository

Данное усовершенствование предназначено для решения проблемы битых артефактов в локальном репозитарии.

Дело в том, что в Maven работа с локальным хранилищем (по сути каталогом на файловой системе) реализована непотокобезопасным способом. Т.е. если параллельно собирающиеся проекты начинают одновременно выкачивать одну и ту же зависимость, то в результате получается битый файл. Вот именно эту проблему и решает данное дополнение.

Для того, чтобы им воспользоваться, необходимо модифицировать непосредственно сам установленный Maven:
curl -O https://repo1.maven.org/maven2/io/takari/aether/takari-local-repository/0.10.4/takari-local-repository-0.10.4.jar
mv takari-local-repository-0.10.4.jar $M2_HOME/lib/ext
     
curl -O https://repo1.maven.org/maven2/io/takari/takari-filemanager/0.8.2/takari-filemanager-0.8.2.jar
mv takari-filemanager-0.8.2.jar $M2_HOME/lib/ext

Всё. Больше никаких дополнительный действий не требуется. Теперь все операции с локальным репозитарием будут безопасными. Само по себе это расширение может использоваться разве что на серверах CI, когда множество сборок происходит одновременно и хочется использовать один репозитарий для экономии места. Но для рядового разработчика более интересно использование совместно со Smart Builder, который работает исходя из предположения, что данное расширение уже установлено.

Как показал опыт, при использовании этого решения сборка начинает работать чуть медленнее, но зато более надёжно.

### Takari Smart Builder

Это расширение устанавливается аналогично предыдущему:
curl -O https://repo1.maven.org/maven2/io/takari/maven/takari-smart-builder/0.4.0/takari-smart-builder-0.4.0.jar
mv takari-smart-builder-0.4.0.jar $M2_HOME/lib/ext

И обеспечивает более продвинутый алгоритм распараллеливания сборки проектов Maven. Разница в работе стандартного планировщика сборки Maven и Smart Builder иллюстрирует диаграмма ниже:


Стандартная стратегия распараллеливания Maven проста и наивна. Она базируется на вычислении глубины зависимостей. Maven запускает параллельную сборку всех проектов одного уровня, пока они не закончатся и только потом переходит на следующий уровень.

Takari Smart Builder, в свою очередь, использует более продвинутую стратегию. Он вычисляет цепочки зависимостей, производит топологическую сортировку и только после этого принимает решение о том, в какой последовательности необходимо производить сборку проектов.

Более того. В процессе компиляции, он запоминает время компиляции каждого проекта в файл .mvn/timing.properties и использует его как дополнительную информацию для того, чтобы в следующий раз завершить компиляцию как можно быстрее.

Для того, чтобы воспользоваться этим функционалом, необходимо при запуске Maven указать дополнительный ключ. Например:
mvn clean install --builder smart -T1.0C

### Всё становится проще с Maven 3.3.1

В версии Maven 3.3.1 было реализовано несколько нововведений. Первое и самое главное — возможность объявлять расширения ядра Maven прямо в проекте. Для этого нужно добавить файл .mvn/extensions.xml. В приложении к описанному раньше, этот файл может иметь следующий вид:
<?xml version="1.0" encoding="UTF-8"?>
<extensions>
    <extension>
        <groupId>io.takari.maven</groupId>
        <artifactId>takari-smart-builder</artifactId>
        <version>0.4.1</version>
    </extension>
    <extension>
        <groupId>io.takari.aether</groupId>
        <artifactId>takari-local-repository</artifactId>
        <version>0.11.2</version>
    </extension>
</extensions>

Теперь нам не нужно докладывать библиотеки непосредственно в дистрибутив Maven. При этом мы получаем тот же результат.

Файл extensions.xml — не единственный возможный в каталоге .mvn. Тут могут располагаться ещё два файла: jvm.config и maven.config.

jvm.config содержит параметры JVM для запуска компиляции текущего проекта. Например этот файл может выглядеть следующим образом:
-Xmx2g
-XX:+TieredCompilation
-XX:TieredStopAtLevel=1

Первая опция задаёт размер heap равный 2 Гб, а следующие две — оптимизируют работу JVM под нужды Maven (подсмотрено тут).

maven.config — ещё один файл с параметрами, но на этот раз для самого Maven. Например:
--builder smart
-T1.0C
-e

Таким образом мы можем задать, что по умолчанию используется smart builder с количеством потоков равному количеству логических ядер. Т.е., если мы просто выполним
mvn clean install

то сборка будет выполняться в несколько потоков и с использование всех расширений и оптимизаций. Причём, если даже мы будем выполнять сборку вложенного модуля, то эти настройки всё-равно будут применены, т.к. Maven производит поиск каталога .mvn не только в текущем каталоге, но и в родительских.

Тут, правда есть один нюанс. Т.к. сборка идёт в несколько потоков, то и лог сборки выводится этими потоками конкурентно. В результате, при возникновении проблем, не всегда бывает понятно что происходит, в следствии того, что строчки оказываются перемешанными. В этом случае, если хочется запустить сборку в один поток и разобраться в причинах неприятностей, то приходится уже вручную переключать сборку в однопоточный режим:
mvn -T1 clean install

### The Takari Lifecycle

The Takari Lifecycle — альтернатива жизненному циклу Maven по умолчанию (сборка JAR файлов). Его отличительная особенность — вместо пяти отдельных плагинов для одного стандартного жизненного цикла используется один универсальный с тем же функционалом, но с гораздо меньшим количеством зависимостей. Как следствие — гораздо более быстрый старт, более оптимальная работа и меньшее потребление ресурсов. Что даёт существенный прирост производительности при компиляции сложных проектов с большим количеством модулей.

Для активации модернизированного жизненного цикла необходимо добавить takari-lifecycle-plugin в качестве расширения сборки:
    <build>
      <plugins>
        <plugin>
          <groupId>io.takari.maven.plugins</groupId>
          <artifactId>takari-lifecycle-plugin</artifactId>
          <extensions>true</extensions>
        </plugin>
      </plugins>
    </build>

А так же переопределить сборку JAR модулей как takari-jar:
    <project>
      <modelVersion>4.0.0</modelVersion>
      <groupId>io.takari.lifecycle.its.basic</groupId>
      <artifactId>basic</artifactId>
      <version>1.0</version>
      <packaging>takari-jar</packaging>

После этого все проекты типа POM, а так же takari-jar проекты будут собираться с использование нового жизненного цикла.

Так же можно включить данный жизненный цикл для всех JAR модулей (см. документацию), в нашем случае это начало приводить к конфликтам с различными плагинами Maven. В результате было принято решение просто переопределить packaging модулей, где это можно сделать без ущерба для сборки. Как показала практика этого оказалось более чем достаточно.

Следует так же отметить, что при использование расширения takari-lifecycle-plugin, изменяется расположение различных настроек сборки. Они перемещаются в секцию configuration этого плагина. Например:
    <plugins>
      <plugin>
        <groupId>io.takari.maven.plugins</groupId>
        <artifactId>takari-lifecycle-plugin</artifactId>
        <configuration>
          <source>1.8</source>
          <target>1.8</target>
        </configuration>
      </plugin>
    </plugins>

Более подробную информацию можно посмотреть в документации..


### Takari Maven Wrapper

У Takari есть ещё одна приятная вещь — Maven Wrapper. По аналогии с Gradle Wrapper, он позволяет запустить сборку проекта сразу после клонирования. Без необходимости установки и настройки Maven у себя на компьютере. К тому же, это позволяет закрепить необходимую версию Maven за проектом.

Самый простой способ добавить в свой проект враппер — воспользоваться архетипом. Выполним в корне проекта:
mvn -N io.takari:maven:wrapper

После этого в текущем каталоге у нас появятся два скрипта:
mvnw.bat — для Windows
mvnw — для *nix систем

А так же в каталоге .mvn/wrapper появится сам враппер и файл его конфигурации.

Всё. После этого можно вызывать:
./mvnw clean install

А если требуется другая версия Maven, то можно установить необходимый URL в конфигурации .mvn/wrapper/maven-wrapper.properties.

И опять-таки тут не обходится без нюансов. Так в организациях с закрытой сетью часто используют проксирующие репозитарии Maven такие как Nexus или Artifactory. В таком случае каждый разработчик вынужден отдельно настраивать у себя зеркало (mirror) Maven на этот репозитарий. Что немного противоречит идеологии враппера — отсутствие необходимости каких либо настроек.

Выйти из положения можно следующим образом: создадим в нашем проекте файл .mvn/settings.xml вида
<?xml version="1.0" encoding="UTF-8"?>
<settings>
    <mirrors>
        <mirror>
            <id>nexus-m2</id>
            <mirrorOf>*</mirrorOf>
            <url>http://repo.org.ru/nexus/content/groups/repo-all-m2</url>
            <name>Nexus M2</name>
        </mirror>
    </mirrors>
</settings>


и добавим в файл .mvn/maven.config строчку
--global-settings .mvn/settings.xml

В результате чего зеркало начнёт подхватываться автоматически.