From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: sync/umount hang on 3.18.21, 1.4TB gone after crash
Date: Fri, 25 Sep 2015 08:01:21 +0200
Message-ID: <20150925060121.GD486@schmorp.de>
References: <20150923215850.GC2360@schmorp.de>
	<20150924185023.GE40291@jaegeuk-mac02>
	<20150925060018.GC486@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfM4X-0006TX-Lf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 06:01:29 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfM4W-0002d3-0m
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 06:01:29 +0000
Content-Disposition: inline
In-Reply-To: <20150925060018.GC486@schmorp.de>
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

On Fri, Sep 25, 2015 at 08:00:19AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> On Thu, Sep 24, 2015 at 11:50:23AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > When I came back after ~10 hours, I found a number of hung task messages
> > > in syslog, and when I entered sync, sync was consuming 100% system time.
> > 
> > Hmm, at this time, it would be good to check what process is stuck through
> > sysrq.
> 
> It was only intermittently, but here they are.

I meant "here are backtraces from the stuck process", from syslog, not via
sysrq of course.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
