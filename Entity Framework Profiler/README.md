```c#
public class StackTraceInterceptor : DbCommandInterceptor
{
    public static void Initialize()
    {
        if (ConfigurationManager.AppSettings["Tracing.EnableStackTraceInterceptor"] == "true")
        {
            var includedNameSpace = "YourNameSpace.";
            DbInterception.Add(new StackTraceInterceptor(includedNameSpace));
        }
    }
    
    private string _includedNameSpace;

    public StackTraceInterceptor(string includedNameSpace)
    {
        _includedNameSpace = includedNameSpace;
    }

    public override void NonQueryExecuting(DbCommand command, DbCommandInterceptionContext<int> interceptionContext)
    {
        command.CommandText = AddStackTrace(command.CommandText);
    }

    public override void ReaderExecuting(DbCommand command, DbCommandInterceptionContext<DbDataReader> interceptionContext)
    {
        command.CommandText = AddStackTrace(command.CommandText);
    }

    public override void ScalarExecuting(DbCommand command, DbCommandInterceptionContext<object> interceptionContext)
    {
        command.CommandText = AddStackTrace(command.CommandText);
    }

    private string AddStackTrace(string query)
    {
        Stopwatch watch = new Stopwatch();
        watch.Start();

        var stackTrace = string.Join("\n", Environment.StackTrace.Split('\n')
            .Where(line => !line.Contains(".StackTraceInterceptor."))
            .Where(line => string.IsNullOrWhiteSpace(_includedNameSpace) || line.Contains(_includedNameSpace))
            .Select(x => "-- " + x));

        watch.Stop();

        return query += Environment.NewLine + stackTrace + Environment.NewLine;
    }
}
```

```c#
public static void Main(string[] args)
{
    StackTraceInterceptor.Initialize();
	....
}
```

```c#
protected void Application_Start()
{
    StackTraceInterceptor.Initialize();
	....
}
```
