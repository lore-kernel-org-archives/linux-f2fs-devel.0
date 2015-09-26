From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Sat, 26 Sep 2015 15:59:57 +0200
Message-ID: <20150926135957.GB9860@schmorp.de>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zfq1F-0007X4-Kt
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 14:00:05 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zfq1E-0008QU-46
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 14:00:05 +0000
Content-Disposition: inline
In-Reply-To: <20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 26, 2015 at 12:52:53AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > Just for fun I'll start doing a -s64 run.

(which had the same result).

> Okay, so before finding bad commits, if possible, can you get block traces?

If you can teach me how to, sure!

In the meantime, maybe what happened is that f2fs leaves some gaps (e.g.
for alignment) when writing now, and didn't in 3.18? That would somehow
explain what I see.

Except that with the 3.18 code, there is virtually no read access while
writing to the disk for hours. With f2fs git, there is a small 16kb read
every half a minute or so, and after a while, a lot of "reading a few
mb/s, while writing a few mb/s".

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
