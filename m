From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Fri, 25 Sep 2015 07:42:25 +0200
Message-ID: <20150925054225.GB486@schmorp.de>
References: <20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<20150923220823.GE36564@jaegeuk-mac02.mot.com>
	<20150923233937.GE3463@schmorp.de>
	<20150924172749.GB40291@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfLmE-0006F5-Ux
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 05:42:34 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfLmD-0000Jz-60
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 05:42:34 +0000
Content-Disposition: inline
In-Reply-To: <20150924172749.GB40291@jaegeuk-mac02>
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

On Thu, Sep 24, 2015 at 10:27:49AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > In the end, I might settle with -s64, and currently do tests with -s90.
> 
> Got it. But why -s90? :)

He :) It's a nothing-special number between 64 and 128, that's all.

> I just pushed the patches to master branch in f2fs-tools.git.
> Could you pull them and check them?

Got them, last patch was the "check sit types" change.

> I added one more patch to avoid harmless sit_type fixes previously you reported.
> 
> And, for the 8TB case, let me check again. It seems that we need to handle under
> 1% overprovision ratio. (e.g., 0.5%)

That might make me potentially very happy. But my main concern at the
moment is stability - even when you have a backup, restoring 8TB will take
days, and backups are never uptodate.

It would be nice to be able to control it more from the user side though.

For example, I have not yet reached 0.0% free with f2fs. That's fine, I don't
plan9 to, but I need to know at which percentage should I stop, which is
something I can only really find out with experiments.

And just filling these 8TB disks takes days, so the question is, can I
simulate near-full behaviour with smaller partitions.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
