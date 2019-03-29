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
        bool SELECT_WITHOUT_WHERE = query.Contains("SELECT") && !query.Contains("WHERE");
        bool WHERE_XX_IN_XX = query.Contains("SELECT") && query.Contains("WHERE") && query.Contains(" IN (");

        bool needToAddStackTrace = SELECT_WITHOUT_WHERE || WHERE_XX_IN_XX;

        if (!needToAddStackTrace)
            return query;

        var stackTrace = string.Join("\n", Environment.StackTrace.Split('\n')
            .Where(line => !line.Contains(".StackTraceInterceptor."))
            .Where(line => string.IsNullOrWhiteSpace(_includedNameSpace) || line.Contains(_includedNameSpace))
            .Select(x => "-- " + x));

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
