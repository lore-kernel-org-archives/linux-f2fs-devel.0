From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 3/5] f2fs: report readonly status in ->fsync
Date: Wed, 30 Dec 2015 14:46:03 +0800
Message-ID: <00e201d142cd$d75c14c0$86143e40$@samsung.com>
References: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
	<20151226063258.GA4641@schmorp.de>
	<006c01d14156$83ab2780$8b017680$@samsung.com>
	<20151228224340.GA61500@jaegeuk.local>
	<00c501d14201$3d7f79e0$b87e6da0$@samsung.com>
	<20151230003246.GB13809@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aEAX5-0005ps-J4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 06:46:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aEAX4-0004Bi-DU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 06:46:51 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0501OISS5UWI60@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 15:46:42 +0900 (KST)
In-reply-to: <20151230003246.GB13809@jaegeuk.local>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, December 30, 2015 8:33 AM
> To: Chao Yu
> Cc: 'Marc Lehmann'; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: report readonly status in ->fsync
> 
> Hi Chao,
> 
> ...
> 
> > > > And one more thing is how do you think of moving inline dot recovery into
> > > > fsck?
> > >
> > > Hmm, we can't move that part entirely into fsck regarding to backward
> > > compatibility.
> >
> > IMO, dynamical repair could be optional, not a must. Because when touching
> > such incomplete directory in ->lookup, we could leave some dmesg to remind
> > user to repair. Or if user found this issue by himself, also he could
> > repair it by using fsck. So this shouldn't case a backward compatibility
> > issue, or am I missing something?
> 
> Hmm, it seems that maybe I misunderstood your *moving it into fsck*.

What I mean is 1) enable repair ability in fsck, 2) keep repair in kernel
side optionally. For compatibility, we leave dmesg for user when touch this
kind of dir if we choose to disable repair in kernel.

> Anyway, I'm fine to add kernel messages as well.

OK, will do it in ("f2fs: fix to stop recovering dot dentries in a readonly fs")

> And, in any case, the only way to fix this case is to run fsck at first.
> One approach, as I implemented, is to set a flag and then repair it at runtime.
> 
> The other one is to repair by fsck, as you suggested.
> In this case, my concern is that current fsck is working without allocating
> blocks, since it is a little bit risky right now.
> For example, if there is no valid user block, not free space, fsck should handle
> ENOSPC while changing the existing disk, which has not been fully validated so
> far.

That' right.

> 
> Ah, otherwise, we can activate inline_dentry by fsck for this special case, once
> inline_dentry in f2fs becomes pretty much stable later. :)

Or we can active inline_data for file which has i_size less than MAX_INLINE_SIZE.

That will be cool to use inline_dentry by default! :)

Thanks,

> 
> Thanks,
> 
> >
> > > We can add that in fsck, but it needs another block
> > > allocation part which we need to handle -ENOSPC in fsck as well.
> >
> > That's right, is it possible to do defragment (gc) if there is no
> > more space when allocating block?
> >
> > Thanks,
> >
> > >
> > > Thanks,
> > >
> > > >
> > > > Thanks,
> > > >
> > > > >
> > > > > I only looked at the diff, so if I missed the context and my reasoning
> > > > > doesn't apply, forgive and ignore me :)
> > > > >
> > > > > --
> > > > >                 The choice of a       Deliantra, the free code+content MORPG
> > > > >       -----==-     _GNU_              http://www.deliantra.net
> > > > >       ----==-- _       generation
> > > > >       ---==---(_)__  __ ____  __      Marc Lehmann
> > > > >       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
> > > > >       -=====/_/_//_/\_,_/ /_/\_\


------------------------------------------------------------------------------
