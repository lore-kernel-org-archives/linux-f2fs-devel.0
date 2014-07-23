From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs: Possible use-after-free when umount filesystem
Date: Wed, 23 Jul 2014 10:12:52 +0800
Message-ID: <000001cfa61b$c693b350$53bb19f0$@samsung.com>
References: <52F320FC.50803@ispras.ru> <534BC29B.3020408@ispras.ru>
	<53CCF1EC.30008@ispras.ru> <53CDC9AF.2050605@cn.fujitsu.com>
	<53CE3722.60307@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X9m4N-0004p4-Sl
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Jul 2014 02:14:15 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X9m4L-0000AC-5s
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Jul 2014 02:14:15 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9500DM37JGH6B0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Jul 2014 11:14:04 +0900 (KST)
In-reply-to: <53CE3722.60307@ispras.ru>
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
To: 'Andrey Tsyvarev' <tsyvarev@ispras.ru>, 'Gu Zheng' <guz.fnst@cn.fujitsu.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Alexey Khoroshilov' <khoroshilov@ispras.ru>, linux-f2fs-devel@lists.sourceforge.net

Hi Andrey Gu,

> -----Original Message-----
> From: Andrey Tsyvarev [mailto:tsyvarev@ispras.ru]
> Sent: Tuesday, July 22, 2014 6:04 PM
> To: Gu Zheng
> Cc: Jaegeuk Kim; linux-kernel; Alexey Khoroshilov; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] f2fs: Possible use-after-free when umount filesystem
> 
> Hi Gu,
> 
> >> Investigation shows, that f2fs_evict_inode, when called for 'meta_inode', uses
> invalidate_mapping_pages() for 'node_inode'.
> >> But 'node_inode' is deleted before 'meta_inode' in f2fs_put_super via iput().
> >>
> >> It seems that in common usage scenario this use-after-free is benign, because 'node_inode'
> remains partially valid data even after kmem_cache_free().
> >> But things may change if, while 'meta_inode' is evicted in one f2fs filesystem, another (mounted)
> f2fs filesystem requests inode from cache, and formely
> >> 'node_inode' of the first filesystem is returned.
> > The analysis seems reasonable. Have you tried to swap the reclaim order of node_inde
> > and meta_inode?
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 870fe19..e114418 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -430,8 +430,8 @@ static void f2fs_put_super(struct super_block *sb)
> >          if (sbi->s_dirty && get_pages(sbi, F2FS_DIRTY_NODES))
> >                  write_checkpoint(sbi, true);
> >
> > -       iput(sbi->node_inode);
> >          iput(sbi->meta_inode);
> > +       iput(sbi->node_inode);
> >
> >          /* destroy f2fs internal modules */
> >          destroy_node_manager(sbi);
> >
> > Thanks,
> > Gu
> 
> With reclaim order of node_inode and meta_inode swapped, use-after-free
> error disappears.
> 
> But shouldn't initialization order of these inodes be swapped too?
> As meta_inode uses node_inode, it seems logical that it should be
> initialized after it.

IMO, it's not easy to exchange order of initialization between meta_inode and
node_inode, because we should use meta_inode in get_valid_checkpoint for valid
cp first for usual verification, then init node_inode.

As I checked, nids for both meta_inode and node_inode are reservation, so it's not
necessary for us to invalidate pages which will never alloced.

How about skipping it as following?

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2cf6962..cafba3c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -273,7 +273,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
 			inode->i_ino == F2FS_META_INO(sbi))
-		goto no_delete;
+		goto out_clear;
 
 	f2fs_bug_on(get_dirty_dents(inode));
 	remove_dirty_dir_inode(inode);
@@ -295,6 +295,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	sb_end_intwrite(inode->i_sb);
 no_delete:
-	clear_inode(inode);
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
+out_clear:
+	clear_inode(inode);
 }

> 
> --
> Best regards,
> 
> Andrey Tsyvarev
> Linux Verification Center, ISPRAS
> web:http://linuxtesting.org
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
