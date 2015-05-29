From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev]   Not use inline_data  after file shrink
Date: Fri, 29 May 2015 18:51:12 +0800
Message-ID: <003601d099fd$837394b0$8a5abe10$@samsung.com>
References: <5567F382.5060403@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <5567F382.5060403@huawei.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'He YunLei' <heyunlei@huawei.com>, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlei,

> -----Original Message-----
> From: He YunLei [mailto:heyunlei@huawei.com]
> Sent: Friday, May 29, 2015 1:05 PM
> To: jaegeuk@kernel.org
> Cc: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] Not use inline_data after file shrink
> 
> Hi Jaegeuk,
> 
> I found that when files(size > MAX_INLINE_DATA) shrink(size < MAX_INLINE_DATA),
> inline_data option is not used in the file after narrow
> 
> I mount f2fs with inline_data as follow:
> 
> /dev/block/mmcblk0p40 /data f2fs rw,nosuid,nodev,noatime,background_gc=on,discard,
> user_xattr,inline_xattr,acl,inline_data,active_logs=6 0 0
> 
> First,I create a small file by command echo for testing inline_data.
> 
> root@hyl:/data # echo 123 > tmp1
> root@hyl:/data # busybox stat tmp1
>    File: tmp1
>    Size: 4               Blocks: 8          IO Block: 4096   regular file
> Device: 10300h/66304d   Inode: 2173        Links: 1
> Access: (0666/-rw-rw-rw-)  Uid: (    0/ UNKNOWN)   Gid: (    0/ UNKNOWN)
> Access: 2015-05-29 02:59:53.000000000
> Modify: 2015-05-29 02:59:53.000000000
> Change: 2015-05-29 02:59:53.000000000
> 
> It works well, then I create a file with size 4096(>MAX_INLINE_DATA).
> 
> 127|root@hyl:/data # busybox stat tmp
>    File: tmp
>    Size: 4096            Blocks: 16         IO Block: 4096   regular file
> Device: 10300h/66304d   Inode: 109         Links: 1
> Access: (0666/-rw-rw-rw-)  Uid: (    0/ UNKNOWN)   Gid: (    0/ UNKNOWN)
> Access: 2015-05-28 08:48:50.000000000
> Modify: 2015-05-28 08:48:50.000000000
> Change: 2015-05-28 08:53:18.000000000
> 
> It doesn't use inline_data because file size 4096 > MAX_INLINE_DATA,
> So I shrink the file by I/O redirection
> 
> root@hyl:/data # echo 123 > tmp
> root@hyl:/data # busybox stat tmp
>    File: tmp
>    Size: 4               Blocks: 16         IO Block: 4096   regular file
> Device: 10300h/66304d   Inode: 109         Links: 1
> Access: (0666/-rw-rw-rw-)  Uid: (    0/ UNKNOWN)   Gid: (    0/ UNKNOWN)
> Access: 2015-05-28 08:48:50.000000000
> Modify: 2015-05-29 02:58:31.000000000
> Change: 2015-05-29 02:58:31.000000000
> 
> We can see that file still uses 16 Blocks
> 
> How do we deal with such situation?

Now, f2fs does not convert non-inline inode to inline one for these potential
inodes with small size. So, once inline inode is converted, there is no
procedure to revert it.

> it's meaningful to reuse inline_data?

Actually, I did not know the history reason why we don't implement the
reverse procedure, as inline_data feature is designed and implemented
by Huajun and Jaegeuk. I can't find any clues in old threads.

But I think it's meaningful for performance and space usage rate if we
can re-enable inline_data for inode which may inline.

Jaegeuk, is there any problem for its implementation? SPO?

I wrote a patch, not well tested, how do you think of it?

>From 07f0152f8fa7e424c2194c0858cd8b75ff83ebba Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Fri, 29 May 2015 14:08:03 +0800
Subject: [PATCH] f2fs: enable inline for inode of size shrunk

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c   |  2 ++
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/inline.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ab30a31..e1b2ce0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1765,6 +1765,8 @@ write:
 	if (f2fs_has_inline_data(inode))
 		err = f2fs_write_inline_data(inode, page);
 	if (err == -EAGAIN)
+		err = try_convert_to_inline_inode(inode, page);
+	if (err == -EAGAIN)
 		err = do_write_data_page(&fio);
 	f2fs_unlock_op(sbi);
 done:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3587576..011bc1f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1936,6 +1936,7 @@ bool truncate_inline_inode(struct page *, u64);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
 int f2fs_convert_inline_inode(struct inode *);
+int try_convert_to_inline_inode(struct inode *, struct page *);
 int f2fs_write_inline_data(struct inode *, struct page *);
 bool recover_inline_data(struct inode *, struct page *);
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 38e75fb..87620e3 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -199,6 +199,40 @@ out:
 	return err;
 }
 
+int try_convert_to_inline_inode(struct inode *inode, struct page *page)
+{
+	void *src_addr, *dst_addr;
+	struct dnode_of_data dn;
+	int err;
+
+	if (!f2fs_may_inline_data(inode))
+		return -EAGAIN;
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = get_dnode_of_data(&dn, 0, LOOKUP_NODE);
+	if (err)
+		return -EAGAIN;
+
+	f2fs_bug_on(F2FS_I_SB(inode), f2fs_has_inline_data(inode));
+
+	f2fs_wait_on_page_writeback(dn.inode_page, NODE);
+
+	src_addr = kmap_atomic(page);
+	dst_addr = inline_data_addr(dn.inode_page);
+	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
+	kunmap_atomic(src_addr);
+
+	truncate_data_blocks_range(&dn, 1);
+
+	set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
+	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+
+	sync_inode_page(&dn);
+	f2fs_put_dnode(&dn);
+	return 0;
+}
+
 int f2fs_write_inline_data(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
-- 
2.3.3


> I wish you and other developers in this list could help me in a correct way.
> 
> Thanks,
> He


