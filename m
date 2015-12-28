From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/5] f2fs: report readonly status in ->fsync
Date: Mon, 28 Dec 2015 14:43:40 -0800
Message-ID: <20151228224340.GA61500@jaegeuk.local>
References: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
	<20151226063258.GA4641@schmorp.de>
	<006c01d14156$83ab2780$8b017680$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aDgW5-0002n0-54
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 22:43:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aDgW4-0005up-18 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 22:43:49 +0000
Content-Disposition: inline
In-Reply-To: <006c01d14156$83ab2780$8b017680$@samsung.com>
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

Thanks Marc for your report.

On Mon, Dec 28, 2015 at 05:59:19PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Marc Lehmann [mailto:schmorp@schmorp.de]
> > Sent: Saturday, December 26, 2015 2:33 PM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: report readonly status in ->fsync
> > 
> > On Thu, Dec 24, 2015 at 06:07:25PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > > Report readonly status of filesystem during fsync.
> > 
> > If this means that fsync returns EROFS when used on a file on a read-only
> > filesystem., then this looks buggy - EROFS is not documented for
> > fsync (only as "fd is bound to a special file which does not support
> > synchronization") for this condition, and I don't think other filesystems
> > do that (just tried xfs).
> 
> Yes.
> 
> > 
> > It also doesn't quite make sense - fsync should only fail when the file
> > couldn't be synced, but in most (probably all) cases, the file is already
> > synchronised, otherwise the filesystem shouldn't be RO.
> 
> Agreed,
> 
> One situation here is if '.' or '..' in dentry page of directory inode was
> missing (corrupted directory), once fsck found this kind of inode exist in
> the image, it will mark inode with F2FS_INLINE_DOTS flag, after that f2fs
> will try to recover it to normal one if user touch such inode in ->lookup,
> so the dirty data was generated even in a readonly fs.
> 
> Actually even for above case, it would be better to avoid generating dirty
> data rather than stop user fsync in a readonly fs.
> 
> Hi Jaegeuk, could you help to drop this patch?

Okay.

> 
> And one more thing is how do you think of moving inline dot recovery into
> fsck?

Hmm, we can't move that part entirely into fsck regarding to backward
compatibility. We can add that in fsck, but it needs another block
allocation part which we need to handle -ENOSPC in fsck as well.

Thanks,

> 
> Thanks,
> 
> > 
> > I only looked at the diff, so if I missed the context and my reasoning
> > doesn't apply, forgive and ignore me :)
> > 
> > --
> >                 The choice of a       Deliantra, the free code+content MORPG
> >       -----==-     _GNU_              http://www.deliantra.net
> >       ----==-- _       generation
> >       ---==---(_)__  __ ____  __      Marc Lehmann
> >       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
> >       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
