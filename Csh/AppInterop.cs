using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using KeraLuaEx;


// Handmade glue file. TODO1 delete


namespace Csh
{
    ///// <summary>Event payload.</summary>
    //public class LogEventArgs : EventArgs
    //{
    //    public int Level { get; set; } = 0;
    //    public string Msg { get; set; } = "???";
    //};

    /// <summary></summary>
    public partial class App//Interop
    {
        ///// <summary>Main execution lua state.</summary>
        //readonly Lua _l;

        ///// <summary>Callback.</summary>
        //public event EventHandler<LogEventArgs>? LogEvent;

        //#region Lifecycle
        ///// <summary>
        ///// Load the lua libs implemented in C#.
        ///// </summary>
        ///// <param name="l">Lua context.</param>
        //public Interop(Lua l)
        //{
        //    _l = l;

        //    // Load our lib stuff.
        //    LoadInterop();
        //}
        //#endregion


//         #region Lua call Host functions
//         /// <summary>
//         /// Bound lua callback work function.
//         /// </summary>
//         /// <returns></returns>
//         int LogCb(int? level, string? msg)
//         {
// //TODO1 these????            LogEvent?.Invoke(this, new LogEventArgs() { Level = (int)level!, Msg = msg });
//             return 0;
//         }
        
//         /// <summary>
//         /// Bound lua callback work function.
//         /// </summary>
//         /// <returns>answer</returns>
//         string GetTimeCb(int? tzone)
//         {
//             return DateTime.Now.ToString();
//         }
//         #endregion
    }
}
