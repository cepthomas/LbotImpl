using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using System.Diagnostics;
using Ephemera.NBagOfTricks;
using Ephemera.NBagOfTricks.Slog;
using KeraLuaEx;


// Entry.
var app = new Csh.App();
app.Dispose();


namespace Csh
{
    /// <summary>A typical application.</summary>
    public partial class App : IDisposable
    {
        #region Fields
        /// <summary>App logger.</summary>
        readonly Logger _logger = LogManager.CreateLogger("App");
        #endregion

        #region Lifecycle
        /// <summary>
        /// Constructor.
        /// </summary>
        public App()
        {
            // Where are we?
            var thisDir = MiscUtils.GetSourcePath();
            var lbotDir = Path.Combine(thisDir, "..", "LBOT");

            // Setup logging.
            LogManager.MinLevelFile = LogLevel.Trace;
            LogManager.MinLevelNotif = LogLevel.Info;
            LogManager.Run(Path.Combine(thisDir, "log.txt"), 50000);
            LogManager.LogMessage += (object? sender, LogMessageEventArgs e) => Console.WriteLine(e.ShortMessage);

            try
            {
                // Load our luainterop lib.
                LoadInterop();

                var scriptFn = Path.Combine(thisDir, "script_example.lua");
                LoadScript(scriptFn, [thisDir, lbotDir]);

                // LuaType t = _l.GetGlobal("thing1");
                // var i = _l.ToInteger(-1);

                // Execute script functions.
                List<int> lint = [34, 608, 999];
                TableEx t1 = new(lint);

                var res1 = MyLuaFunc("abcdef", 74747, t1);
                var res2 = MyLuaFunc2(true);
                var res3 = NoArgsFunc();
                var res4 = OptionalFunc();
            }
            catch (SyntaxException ex)
            {
                _logger.Exception(ex);
            }
            catch (LuaException ex)
            {
                _logger.Exception(ex);
            }
            catch (Exception ex)
            {
                _logger.Exception(ex);
            }

            LogManager.Stop();
        }

        /// <summary>
        /// Clean up resources. https://stackoverflow.com/a/4935448
        /// </summary>
        public void Dispose()
        {
           _l.Dispose();
        }
        #endregion

        #region Lua call Host functions
        /// <summary>
        /// Bound lua callback work function.
        /// </summary>
        /// <returns></returns>
        int LogCb(int? level, string? msg)
        {
            _logger.Log((LogLevel)level!, msg ?? "NULL");
            return 0;
        }
        
        /// <summary>
        /// Bound lua callback work function.
        /// </summary>
        /// <returns>answer</returns>
        string GetTimeCb(int? tzone)
        {
            return DateTime.Now.ToString();
        }
        #endregion
    }
}
