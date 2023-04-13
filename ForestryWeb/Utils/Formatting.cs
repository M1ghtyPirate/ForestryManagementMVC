namespace ForestryWeb.Utils
{
    public static class Formatting
    {
        public static Func<double?, string, string> toFixed = (v, p) => v == null || v == 0 ? "" : v.Value.ToString(p);
        public static Func<double?, string, string> toFixedPercent = (v, p) => v == null || v == 0 ? "" : $"{v.Value.ToString(p)} %";
    }
}
