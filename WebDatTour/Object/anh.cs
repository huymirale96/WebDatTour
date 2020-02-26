using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDatTour.Object
{
    public class anh
    {
        int stt;
        string url;

        public anh(int stt, string url)
        {
            this.stt = stt;
            this.url = url;
        }

        public int Stt { get => stt; set => stt = value; }
        public string Url { get => url; set => url = value; }
    }
}