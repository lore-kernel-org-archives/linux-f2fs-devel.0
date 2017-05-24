From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: BUG: effect of immutable attribute (chattr +i) is
 gone after remount
Date: Tue, 23 May 2017 21:06:32 -0700
Message-ID: <20170524040632.GA30325@jaegeuk-macbookpro.roam.corp.google.com>
References: <HK2PR04MB064473E2C9EE4462A3BC0A5088E60@HK2PR04MB0644.apcprd04.prod.outlook.com>
	<20170516202858.GA16238@jaegeuk.local>
	<27601c5c-eb07-ab16-4cfe-c87668138d82@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dDNZJ-0001V8-0s
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 May 2017 04:06:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dDNZH-0000HP-2q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 May 2017 04:06:40 +0000
Content-Disposition: inline
In-Reply-To: <27601c5c-eb07-ab16-4cfe-c87668138d82@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao,

On 05/23, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/5/17 4:28, Jaegeuk Kim wrote:
> > Hi Tom,
> > 
> > On 05/16, Tom Yan wrote:
> >> Hi all.
> >>
> >> Just happen to notice that a file on my f2fs filesystem marked as immutable is actually "mutable". At first I thought it was because of file corruption or so, but after some test it appears that the effect will be gone anyway once the filesystem is remounted. The flag remains though, as per the output of lsattr.
> >>
> > 
> > Thank you so much for the report.
> > 
> >> Here is a test case:
> >>
> >> [tom@localhost ~]$ truncate -s 256M f2fs.img
> >> [tom@localhost ~]$ sudo losetup -f f2fs.img 
> >> [tom@localhost ~]$ sudo mkfs.f2fs /dev/loop0 
> >>
> >> 	F2FS-tools: mkfs.f2fs Ver: 1.8.0 (2017-02-03)
> >>
> >> Info: Debug level = 0
> >> Info: Label = 
> >> Info: Trim is enabled
> >> Info: Segments per section = 1
> >> Info: Sections per zone = 1
> >> Info: sector size = 512
> >> Info: total sectors = 524288 (256 MB)
> >> Info: zone aligned segment0 blkaddr: 512
> >> Info: format version with
> >>   "Linux version 4.10.13-1-ARCH (builduser@tobias) (gcc version 6.3.1 20170306 (GCC) ) #1 SMP PREEMPT Thu Apr 27 12:15:09 CEST 2017"
> >> Info: [/dev/loop0] Discarding device
> >> Info: This device doesn't support BLKSECDISCARD
> >> Info: Discarded 256 MB
> >> Info: Overprovision ratio = 15.000%
> >> Info: Overprovision segments = 35 (GC reserved = 21)
> >> Info: format successful
> >> [tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
> >> [tom@localhost ~]$ sudo chown tom:tom /mnt/
> >> [tom@localhost ~]$ touch /mnt/testfile
> >> [tom@localhost ~]$ sudo chattr +i /mnt/testfile 
> >> [tom@localhost ~]$ echo test > /mnt/testfile 
> >> bash: /mnt/testfile: Operation not permitted
> >> [tom@localhost ~]$ rm /mnt/testfile 
> >> rm: cannot remove '/mnt/testfile': Operation not permitted
> >> [tom@localhost ~]$ sudo umount /mnt/
> >> [tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
> >> [tom@localhost ~]$ lsattr /mnt/testfile 
> >> ----i-------------- /mnt/testfile
> >> [tom@localhost ~]$ echo test > /mnt/testfile 
> >> [tom@localhost ~]$ rm /mnt/testfile 
> >> [tom@localhost ~]$ sudo umount /mnt/
> >> [tom@localhost ~]$ uname -a
> >> Linux localhost 4.10.13-1-ARCH #1 SMP PREEMPT Thu Apr 27 12:15:09 CEST 2017 x86_64 GNU/Linux
> >>
> >> As you can see, mkfs.f2fs is of version 1.8.0, and the kernel is as of 4.10.13. Let me know if you need further information. Thanks in advance.
> > 
> > I could simply reproduce this, and wrote a patch to fix it like below. ;)
> > Could you please check this patch as well?
> > 
> > Thanks,
> > 
> >>From 8aee3d3a0244802b141d1b2ae95c568d1aa26118 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 16 May 2017 13:20:16 -0700
> > Subject: [PATCH] f2fs: load inode's flag from disk
> > 
> > This patch fixes missing inode flag loaded from disk, reported by Tom.
> > 
> > [tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
> > [tom@localhost ~]$ sudo chown tom:tom /mnt/
> > [tom@localhost ~]$ touch /mnt/testfile
> > [tom@localhost ~]$ sudo chattr +i /mnt/testfile
> > [tom@localhost ~]$ echo test > /mnt/testfile
> > bash: /mnt/testfile: Operation not permitted
> > [tom@localhost ~]$ rm /mnt/testfile
> > rm: cannot remove '/mnt/testfile': Operation not permitted
> > [tom@localhost ~]$ sudo umount /mnt/
> > [tom@localhost ~]$ sudo mount /dev/loop0 /mnt/
> > [tom@localhost ~]$ lsattr /mnt/testfile
> > ----i-------------- /mnt/testfile
> > [tom@localhost ~]$ echo test > /mnt/testfile
> > [tom@localhost ~]$ rm /mnt/testfile
> > [tom@localhost ~]$ sudo umount /mnt/
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Tom Yan <tom.ty89@outlook.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 518f49643092..7aab8837b6b4 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -226,6 +226,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >  		ret = -EIO;
> >  		goto bad_inode;
> >  	}
> > +	f2fs_set_inode_flags(inode);
> 
> f2fs_iget will make inode dirty after f2fs_set_inode_flags, it's not needed. So
> how about changing like this?

Yup, I applied this.

Thanks,

> 
> ---
>  fs/f2fs/file.c  | 1 +
>  fs/f2fs/inode.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e20a1c01e556..8ccbfe53c03c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1514,6 +1514,7 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
> 
>  	inode->i_ctime = current_time(inode);
>  	f2fs_set_inode_flags(inode);
> +	f2fs_mark_inode_dirty_sync(inode, false);
> 
>  	inode_unlock(inode);
>  out:
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 518f49643092..e53c784ab11e 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -44,7 +44,6 @@ void f2fs_set_inode_flags(struct inode *inode)
>  		new_fl |= S_DIRSYNC;
>  	inode_set_flags(inode, new_fl,
>  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
> -	f2fs_mark_inode_dirty_sync(inode, false);
>  }
> 
>  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
> @@ -226,6 +225,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>  		ret = -EIO;
>  		goto bad_inode;
>  	}
> +	f2fs_set_inode_flags(inode);
>  	unlock_new_inode(inode);
>  	trace_f2fs_iget(inode);
>  	return inode;
> -- 
> 2.13.0.67.g10c78a162fa8
> 
> >  	unlock_new_inode(inode);
> >  	trace_f2fs_iget(inode);
> >  	return inode;
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
