# Overriding Keydown in a User Control using ProcessKeyPreview

https://www.codeproject.com/Articles/22570/Overriding-Keydown-in-a-User-Control-using-Process

```csharp
//----------------------------------------------
// Define the PeekMessage API call
//----------------------------------------------

private struct MSG
{
    public IntPtr hwnd;
    public int message;
    public IntPtr wParam;
    public IntPtr lParam;
    public int time;
    public int pt_x;
    public int pt_y;
}

[DllImport("user32.dll", CharSet = CharSet.Auto)]
private static extern bool PeekMessage([In, Out] ref MSG msg, 
    HandleRef hwnd, int msgMin, int msgMax, int remove);

//----------------------------------------------
 
/// <span class="code-SummaryComment"><summary> </span>
/// Trap any keypress before child controls get hold of them
/// <span class="code-SummaryComment"></summary></span>
/// <span class="code-SummaryComment"><param name="m">Windows message</param></span>
/// <span class="code-SummaryComment"><returns>True if the keypress is handled</returns></span>
protected override bool ProcessKeyPreview(ref Message m)
{
    const int WM_KEYDOWN = 0x100;
    const int WM_KEYUP = 0x101;
    const int WM_CHAR = 0x102;
    const int WM_SYSCHAR = 0x106;
    const int WM_SYSKEYDOWN = 0x104;
    const int WM_SYSKEYUP = 0x105;
    const int WM_IME_CHAR = 0x286;

    KeyEventArgs e = null;

    if ((m.Msg != WM_CHAR) && (m.Msg != WM_SYSCHAR) && (m.Msg != WM_IME_CHAR))
    {
        e = new KeyEventArgs(((Keys)((int)((long)m.WParam))) | ModifierKeys);
        if ((m.Msg == WM_KEYDOWN) || (m.Msg == WM_SYSKEYDOWN))
        {
            TrappedKeyDown(e);
        }
        //else
        //{
        //    TrappedKeyUp(e);
        //}
            
        // Remove any WM_CHAR type messages if supresskeypress is true.
        if (e.SuppressKeyPress)
        {
            this.RemovePendingMessages(WM_CHAR, WM_CHAR);
            this.RemovePendingMessages(WM_SYSCHAR, WM_SYSCHAR);
            this.RemovePendingMessages(WM_IME_CHAR, WM_IME_CHAR);
        }

        if (e.Handled)
        {
            return e.Handled;
        }
    }
    return base.ProcessKeyPreview(ref m);
}

private void RemovePendingMessages(int msgMin, int msgMax)
{
    if (!this.IsDisposed)
    {
        MSG msg = new MSG();
        IntPtr handle = this.Handle;
        while (PeekMessage(ref msg, 
        new HandleRef(this, handle), msgMin, msgMax, 1))
        {
        }
    }
}

/// <span class="code-SummaryComment"><summary></span>
/// This routine gets called if a keydown has been trapped 
/// before a child control can get it.
/// <span class="code-SummaryComment"></summary></span>
/// <span class="code-SummaryComment"><param name="e"></param></span>
private void TrappedKeyDown(KeyEventArgs e)
{
    if (e.KeyCode == Keys.A)
    {
        e.Handled = true;
        e.SuppressKeyPress = true;
    }
}
```
