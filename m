From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs stability problems keep me from testing
Date: Fri, 20 Nov 2015 09:48:53 +0800
Message-ID: <00ed01d12335$b2aac570$18005050$@samsung.com>
References: <20151119205614.GA10406@jaegeuk.local>
	<00a101d122a0$fb9e6ab0$f2db4010$@samsung.com>
	<20151119210130.GC2499@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZzapX-0003ut-Io
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 01:49:39 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzapV-0000up-Hw
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 01:49:39 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NY3027YVBQGEC50@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 10:49:30 +0900 (KST)
In-reply-to: <20151119210130.GC2499@schmorp.de>
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
To: 'Marc Lehmann' <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Friday, November 20, 2015 5:02 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] f2fs stability problems keep me from testing
> 
> On Thu, Nov 19, 2015 at 04:04:21PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > >    openat(AT_FDCWD, "/cold1", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 5
> > >    fchdir(5)                               = 0
> > >    getdents(5, /* 0 entries */, 32768)     = 0
> >
> > I found an issue here.
> >
> > If the dir entry of '/cold1/var' is removed from dentry page in '/cold1', at
> > least we should return entries of '.' and '..' for the getdents invoking, but
> > we didn't. So here it looks like we keep silent about some kind of error (i.e.
> > ENOMEM/EIO...) when grabing&updating the dentry page of '/cold1', obviously
> > it's better to report such error to user rather than ignoring it.
> 
> As for EIO, I would expect the kernel to log something. As for ENOMEM,
> unless f2fs tries higher order or zone-specific allocations, that's
> unlikely because the box had over 20GB memory free (according to top).
> 
> As for other errors, sure, could be.
> 
> Would that explain the sync lockup though?

I don't think so, but I hope such error code can supply some kind of clue.

> 
> > I'd like to send a patch to fix this issue, could you include the following
> > patch in your f2fs module, so when it reproduces we can catch more details
> > about this problem.
> 
> I can, but I guess you forgot to attach the patch.

Oh, I just sent it to mailing list, I thought you have received it.

>From ceedb2996a666dddd35834f30bc14bec9ccaad02 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Thu, 19 Nov 2015 15:36:11 +0800
Subject: [PATCH] f2fs: fix to report error in f2fs_readdir

get_lock_data_page in f2fs_readdir can fail due to a lot of reasons (i.e.
no memory or IO error...), it's better to report this kind of error to
user rather than ignoring it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c2b330f..f1de7ee 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -855,8 +855,13 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 
 	for (; n < npages; n++) {
 		dentry_page = get_lock_data_page(inode, n, false);
-		if (IS_ERR(dentry_page))
-			continue;
+		if (IS_ERR(dentry_page)) {
+			err = PTR_ERR(dentry_page);
+			if (err == -ENOENT)
+				continue;
+			else
+				goto out;
+		}
 
 		dentry_blk = kmap(dentry_page);
 
-- 
2.6.3

Thanks,

> 
> On Fri, Nov 20, 2015 at 04:56:14AM +0800, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > Ah, sorry if that might not have been clear - after a reboot, fsck showed
> > > no errors and all files and directories (apparently) were there, i.e. it
> > > looks like a transient problem, not a problem of the on-disk structure.
> >
> > So, it seems that the system suffers from memory pressure significantly, which
> > can incur ENOMEM, as I guess.
> > Can you catch /sys/kernel/debug/f2fs/status at that moment?
> 
> If I can, I will - I didn't attempt to stress the filesystem since then, but
> will presdumably start doing tests next week again.
> 
> --
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\


------------------------------------------------------------------------------
