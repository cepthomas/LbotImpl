using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using System.Diagnostics;
using Ephemera.NBagOfTricks;
using Ephemera.NBagOfTricks.Slog;


// Entry.
var app = new CppCli.App();
app.Dispose();


namespace CppCli
{
    /// <summary>A typical application using interop.</summary>
    public class App : IDisposable
    {
        #region Fields
        /// <summary>App logger.</summary>
        readonly Logger _logger = LogManager.CreateLogger("HST");

        /// <summary>Script logger.</summary>
        readonly Logger _loggerScript = LogManager.CreateLogger("SCR");

        /// <summary>The interop.</summary>
        protected Interop _interop = new();
        #endregion

        #region Lifecycle
        /// <summary>
        /// Constructor.
        /// </summary>
        public App()
        {
            // Where are we?
            var srcDir = MiscUtils.GetSourcePath();

            // Setup logging.
            LogManager.MinLevelFile = LogLevel.Trace;
            LogManager.MinLevelNotif = LogLevel.Info;
            LogManager.Run(Path.Combine(srcDir, "log.txt"), 50000);
            LogManager.LogMessage += (object? sender, LogMessageEventArgs e) => Console.WriteLine(e.ShortMessage);

            try
            {
                // Hook script callbacks.
                Interop.Log += Interop_Log;
                Interop.Notification += Interop_Notification;

                // Load script.
                var scriptFn = Path.Combine(srcDir, "script_test.lua");
                var luaPath = $"{srcDir}\\..\\LBOT\\?.lua;{srcDir}\\lua\\?.lua;;";
                _interop.Run(scriptFn, luaPath);

                // Execute script functions.
                int res = _interop.Setup(12345);
                for (int i = 0; i < res; i++)
                {
                    var cmdResp = _interop.DoCommand("cmd", i * 2);
                    _logger.Info($"cmd {i} gave me {cmdResp}");
                }
            }
            catch (LuaException ex)
            {
                _loggerScript.Exception(ex);
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
            _interop.Dispose();
        }
        #endregion

        #region Script Event Handlers
        /// <summary>
        /// Log something from script.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void Interop_Log(object? sender, LogArgs args) 
        {
            var level = MathUtils.Constrain(args.level, (int)LogLevel.Trace, (int)LogLevel.Error);
            _loggerScript.Log((LogLevel)level, args.msg);
        }

        /// <summary>
        /// Script wants me to know something.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void Interop_Notification(object? sender, NotificationArgs args) 
        {
            _loggerScript.Info($"Notification: {args.num} {args.text}");
        }
        #endregion
    }
}
