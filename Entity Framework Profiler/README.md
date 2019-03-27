```c#
    public class StackTraceInterceptor : DbCommandInterceptor
    {
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
            var stackTrace = string.Join("\n", Environment.StackTrace.Split('\n')
                .Where(line => line.Contains("Your Namespace you want to include in stack trace") && !line.Contains("StackTraceInterceptor.AddStackTrace"))
                .Select(x => "-- " + x));
            return query += Environment.NewLine + stackTrace + Environment.NewLine;
        }
    }
```
