From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: add tracepoint for f2fs_direct_IO
Date: Thu, 31 Jul 2014 21:11:22 +0800
Message-ID: <017201cfacc1$0b3a7600$21af6200$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XCq9i-0007Zp-T9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Jul 2014 13:12:26 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XCq9g-00052F-T8
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Jul 2014 13:12:26 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9K00I8IVCG8F40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Jul 2014 22:12:16 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds a tracepoint for f2fs_direct_IO.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              |  5 ++++
 include/trace/events/f2fs.h | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ec3c886..03313099 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1086,9 +1086,14 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 	/* clear fsync mark to recover these blocks */
 	fsync_mark_clear(F2FS_SB(inode->i_sb), inode->i_ino);
 
+	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
+
 	err = blockdev_direct_IO(rw, iocb, inode, iter, offset, get_data_block);
 	if (err < 0 && (rw & WRITE))
 		f2fs_write_failed(mapping, offset + count);
+
+	trace_f2fs_direct_IO_exit(inode, offset, count, rw, err);
+
 	return err;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 7d2e70e..d06d443 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -587,6 +587,69 @@ TRACE_EVENT(f2fs_fallocate,
 		__entry->ret)
 );
 
+TRACE_EVENT(f2fs_direct_IO_enter,
+
+	TP_PROTO(struct inode *inode, loff_t offset, unsigned long len, int rw),
+
+	TP_ARGS(inode, offset, len, rw),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t,	pos)
+		__field(unsigned long,	len)
+		__field(int,	rw)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->pos	= offset;
+		__entry->len	= len;
+		__entry->rw	= rw;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu rw = %d",
+		show_dev_ino(__entry),
+		__entry->pos,
+		__entry->len,
+		__entry->rw)
+);
+
+TRACE_EVENT(f2fs_direct_IO_exit,
+
+	TP_PROTO(struct inode *inode, loff_t offset, unsigned long len,
+		 int rw, int ret),
+
+	TP_ARGS(inode, offset, len, rw, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t,	pos)
+		__field(unsigned long,	len)
+		__field(int,	rw)
+		__field(int,	ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->pos	= offset;
+		__entry->len	= len;
+		__entry->rw	= rw;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu "
+		"rw = %d ret = %d",
+		show_dev_ino(__entry),
+		__entry->pos,
+		__entry->len,
+		__entry->rw,
+		__entry->ret)
+);
+
 TRACE_EVENT(f2fs_reserve_new_block,
 
 	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node),
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
