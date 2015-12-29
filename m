From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 3/5] f2fs: report readonly status in ->fsync
Date: Tue, 29 Dec 2015 14:21:25 +0800
Message-ID: <00c501d14201$3d7f79e0$b87e6da0$@samsung.com>
References: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
	<20151226063258.GA4641@schmorp.de>
	<006c01d14156$83ab2780$8b017680$@samsung.com>
	<20151228224340.GA61500@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aDnfj-0006Yt-Qe
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 06:22:15 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aDnfh-0004Ji-MS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 06:22:15 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0300U0SWCMI630@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Dec 2015 15:22:05 +0900 (KST)
In-reply-to: <20151228224340.GA61500@jaegeuk.local>
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
> Sent: Tuesday, December 29, 2015 6:44 AM
> To: Chao Yu
> Cc: 'Marc Lehmann'; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: report readonly status in ->fsync
> 
> Hi Chao,
> 
> Thanks Marc for your report.
> 
> On Mon, Dec 28, 2015 at 05:59:19PM +0800, Chao Yu wrote:
> > > -----Original Message-----
> > > From: Marc Lehmann [mailto:schmorp@schmorp.de]
> > > Sent: Saturday, December 26, 2015 2:33 PM
> > > To: Chao Yu
> > > Cc: linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: report readonly status in ->fsync
> > >
> > > On Thu, Dec 24, 2015 at 06:07:25PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > > > Report readonly status of filesystem during fsync.
> > >
> > > If this means that fsync returns EROFS when used on a file on a read-only
> > > filesystem., then this looks buggy - EROFS is not documented for
> > > fsync (only as "fd is bound to a special file which does not support
> > > synchronization") for this condition, and I don't think other filesystems
> > > do that (just tried xfs).
> >
> > Yes.
> >
> > >
> > > It also doesn't quite make sense - fsync should only fail when the file
> > > couldn't be synced, but in most (probably all) cases, the file is already
> > > synchronised, otherwise the filesystem shouldn't be RO.
> >
> > Agreed,
> >
> > One situation here is if '.' or '..' in dentry page of directory inode was
> > missing (corrupted directory), once fsck found this kind of inode exist in
> > the image, it will mark inode with F2FS_INLINE_DOTS flag, after that f2fs
> > will try to recover it to normal one if user touch such inode in ->lookup,
> > so the dirty data was generated even in a readonly fs.
> >
> > Actually even for above case, it would be better to avoid generating dirty
> > data rather than stop user fsync in a readonly fs.
> >
> > Hi Jaegeuk, could you help to drop this patch?
> 
> Okay.
> 
> >
> > And one more thing is how do you think of moving inline dot recovery into
> > fsck?
> 
> Hmm, we can't move that part entirely into fsck regarding to backward
> compatibility.

IMO, dynamical repair could be optional, not a must. Because when touching
such incomplete directory in ->lookup, we could leave some dmesg to remind
user to repair. Or if user found this issue by himself, also he could
repair it by using fsck. So this shouldn't case a backward compatibility
issue, or am I missing something?

> We can add that in fsck, but it needs another block
> allocation part which we need to handle -ENOSPC in fsck as well.

That's right, is it possible to do defragment (gc) if there is no
more space when allocating block?

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > >
> > > I only looked at the diff, so if I missed the context and my reasoning
> > > doesn't apply, forgive and ignore me :)
> > >
> > > --
> > >                 The choice of a       Deliantra, the free code+content MORPG
> > >       -----==-     _GNU_              http://www.deliantra.net
> > >       ----==-- _       generation
> > >       ---==---(_)__  __ ____  __      Marc Lehmann
> > >       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
> > >       -=====/_/_//_/\_,_/ /_/\_\


------------------------------------------------------------------------------
