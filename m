From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [f2fs-dev] [PATCH 04/28] f2fs: replace a build-time warning with runtime WARN_ON
Date: Wed, 26 Oct 2016 16:57:05 +0200
Message-ID: <3766259.9ZsupLsmdk@wuerfel>
References: <20161017220342.1627073-1-arnd@arndb.de> <20161017220557.1688282-4-arnd@arndb.de> <c23b0800-c9db-d62c-fc05-d6f2208c01ff@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c23b0800-c9db-d62c-fc05-d6f2208c01ff@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Weichao Guo <guoweichao@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wednesday, October 26, 2016 10:05:00 PM CEST Chao Yu wrote:
> On 2016/10/18 6:05, Arnd Bergmann wrote:
> > gcc is unsure about the use of last_ofs_in_node, which might happen
> > without a prior initialization:
> > 
> > fs/f2fs//git/arm-soc/fs/f2fs/data.c: In function ‘f2fs_map_blocks’:
> > fs/f2fs/data.c:799:54: warning: ‘last_ofs_in_node’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {
> 
> In each round of dnode block traverse, we will init 'prealloc' and then update
> 'prealloc' and 'last_ofs_in_node' together in below lines of f2fs_map_blocks:
>                         if (flag == F2FS_GET_BLOCK_PRE_AIO) {
>                                 if (blkaddr == NULL_ADDR) {
>                                         prealloc++;
>                                         last_ofs_in_node = dn.ofs_in_node;
>                                 }
>                         }
> 
> Then in below codes, it is safe to use 'last_ofs_in_node' since we will check
> 'prealloc' firstly, so if 'prealloc' is non-zero, 'last_ofs_in_node' must be valid.
>         if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {
> 
> So I think we should not add WARN_ON there.

Ok, that make sense. Thanks for taking a closer look!

Should we just set last_ofs_in_node to the same value as ofs_in_node
before the loop?

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ae194f..14db4b7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -716,7 +716,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	}
 
 	prealloc = 0;
-	ofs_in_node = dn.ofs_in_node;
+	last_ofs_in_node = ofs_in_node = dn.ofs_in_node;
 	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 next_block:

	Arnd
