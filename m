From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/5] f2fs: report readonly status in ->fsync
Date: Tue, 29 Dec 2015 16:32:46 -0800
Message-ID: <20151230003246.GB13809@jaegeuk.local>
References: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
	<20151226063258.GA4641@schmorp.de>
	<006c01d14156$83ab2780$8b017680$@samsung.com>
	<20151228224340.GA61500@jaegeuk.local>
	<00c501d14201$3d7f79e0$b87e6da0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aE4hE-0004pl-Aj
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 00:32:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aE4hC-0004LR-I7 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 00:32:56 +0000
Content-Disposition: inline
In-Reply-To: <00c501d14201$3d7f79e0$b87e6da0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

...

> > > And one more thing is how do you think of moving inline dot recovery into
> > > fsck?
> > 
> > Hmm, we can't move that part entirely into fsck regarding to backward
> > compatibility.
> 
> IMO, dynamical repair could be optional, not a must. Because when touching
> such incomplete directory in ->lookup, we could leave some dmesg to remind
> user to repair. Or if user found this issue by himself, also he could
> repair it by using fsck. So this shouldn't case a backward compatibility
> issue, or am I missing something?

Hmm, it seems that maybe I misunderstood your *moving it into fsck*.
Anyway, I'm fine to add kernel messages as well.
And, in any case, the only way to fix this case is to run fsck at first.
One approach, as I implemented, is to set a flag and then repair it at runtime.

The other one is to repair by fsck, as you suggested.
In this case, my concern is that current fsck is working without allocating
blocks, since it is a little bit risky right now.
For example, if there is no valid user block, not free space, fsck should handle
ENOSPC while changing the existing disk, which has not been fully validated so
far.

Ah, otherwise, we can activate inline_dentry by fsck for this special case, once
inline_dentry in f2fs becomes pretty much stable later. :)

Thanks,

> 
> > We can add that in fsck, but it needs another block
> > allocation part which we need to handle -ENOSPC in fsck as well.
> 
> That's right, is it possible to do defragment (gc) if there is no
> more space when allocating block?
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > >
> > > Thanks,
> > >
> > > >
> > > > I only looked at the diff, so if I missed the context and my reasoning
> > > > doesn't apply, forgive and ignore me :)
> > > >
> > > > --
> > > >                 The choice of a       Deliantra, the free code+content MORPG
> > > >       -----==-     _GNU_              http://www.deliantra.net
> > > >       ----==-- _       generation
> > > >       ---==---(_)__  __ ____  __      Marc Lehmann
> > > >       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
> > > >       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
