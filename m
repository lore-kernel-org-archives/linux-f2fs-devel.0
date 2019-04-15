From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 11/13] f2fs: fix to avoid panic in
 f2fs_inplace_write_data()
Date: Mon, 15 Apr 2019 15:30:52 +0800
Message-ID: <20190415073054.2577-3-yuchao0@huawei.com>
References: <20190415073054.2577-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hFw5B-0005EG-26
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 07:31:13 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFw59-007Q9U-Hc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 07:31:12 +0000
In-Reply-To: <20190415073054.2577-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203239

- Overview
When mounting the attached crafted image and running program, following errors are reported.
Additionally, it hangs on sync after running program.

The image is intentionally fuzzed from a normal f2fs image for testing.
Compile options for F2FS are as follows.
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_CHECK_FS=y

- Reproduces
cc poc_15.c
./run.sh f2fs
sync

- Kernel messages
 ------------[ cut here ]------------
 kernel BUG at fs/f2fs/segment.c:3162!
 RIP: 0010:f2fs_inplace_write_data+0x12d/0x160
 Call Trace:
  f2fs_do_write_data_page+0x3c1/0x820
  __write_data_page+0x156/0x720
  f2fs_write_cache_pages+0x20d/0x460
  f2fs_write_data_pages+0x1b4/0x300
  do_writepages+0x15/0x60
  __filemap_fdatawrite_range+0x7c/0xb0
  file_write_and_wait_range+0x2c/0x80
  f2fs_do_sync_file+0x102/0x810
  do_fsync+0x33/0x60
  __x64_sys_fsync+0xb/0x10
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason is f2fs_inplace_write_data() will trigger kernel panic due
to data block locates in node type segment.

To avoid panic, let's just return error code and set SBI_NEED_FSCK to
give a hint to fsck for latter repairing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b59d1c85863b..8388d2abacb5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3184,13 +3184,18 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 {
 	int err;
 	struct f2fs_sb_info *sbi = fio->sbi;
+	unsigned int segno;
 
 	fio->new_blkaddr = fio->old_blkaddr;
 	/* i/o temperature is needed for passing down write hints */
 	__get_segment_type(fio);
 
-	f2fs_bug_on(sbi, !IS_DATASEG(get_seg_entry(sbi,
-			GET_SEGNO(sbi, fio->new_blkaddr))->type));
+	segno = GET_SEGNO(sbi, fio->new_blkaddr);
+
+	if (!IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -EFAULT;
+	}
 
 	stat_inc_inplace_blocks(fio->sbi);
 
-- 
2.18.0.rc1
