From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] libf2fs: propagate error from f2fs_{finalize,
 fsync}_device
Date: Fri, 24 Nov 2017 17:33:39 +0800
Message-ID: <20171124093339.112384-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eIAN9-0004mi-2h
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Nov 2017 09:34:11 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eIAN6-0003uj-0Z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Nov 2017 09:34:11 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

tests/generic/405 of fstest suit expects that mkfs will return error
when it hits EIO, so let's propagate error from
f2fs_{finalize,fsync}_device, then mkfs can be aware of fsync error.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/main.c             |  4 +++-
 fsck/mount.c            |  3 ++-
 include/f2fs_fs.h       |  4 ++--
 lib/libf2fs_io.c        | 24 ++++++++++++++++++------
 mkfs/f2fs_format_main.c |  3 ++-
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index b62fc29e027a..543c10f66406 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -676,7 +676,9 @@ retry:
 				goto fsck_again;
 		}
 	}
-	f2fs_finalize_device();
+	ret = f2fs_finalize_device();
+	if (ret < 0)
+		return ret;
 
 	printf("\nDone.\n");
 	return 0;
diff --git a/fsck/mount.c b/fsck/mount.c
index 4ad22a136ca9..3efa29813853 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2098,7 +2098,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 
 	/* in case of sudden power off */
-	f2fs_fsync_device();
+	ret = f2fs_fsync_device();
+	ASSERT(ret >= 0);
 
 	/* write the last cp */
 	ret = dev_write_block(cp, cp_blk_no++);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 05b893a24b66..5a59a7097af6 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1056,8 +1056,8 @@ extern int f2fs_devs_are_umounted(void);
 extern int f2fs_dev_is_umounted(char *);
 extern int f2fs_get_device_info(void);
 extern int get_device_info(int);
-extern void f2fs_finalize_device(void);
-extern void f2fs_fsync_device(void);
+extern int f2fs_finalize_device(void);
+extern int f2fs_fsync_device(void);
 
 extern int dev_read(void *, __u64, size_t);
 extern int dev_write(void *, __u64, size_t);
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 268dcfae490e..72898b381fcf 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -213,19 +213,23 @@ int dev_reada_block(__u64 blk_addr)
 	return dev_readahead(blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
 }
 
-void f2fs_fsync_device(void)
+int f2fs_fsync_device(void)
 {
 	int i;
 
 	for (i = 0; i < c.ndevs; i++) {
-		if (fsync(c.devices[i].fd) < 0)
+		if (fsync(c.devices[i].fd) < 0) {
 			MSG(0, "\tError: Could not conduct fsync!!!\n");
+			return -1;
+		}
 	}
+
+	return 0;
 }
 
-void f2fs_finalize_device(void)
+int f2fs_finalize_device(void)
 {
-	int i;
+	int i, ret;
 
 #ifdef WITH_ANDROID
 	if (c.sparse_mode) {
@@ -246,11 +250,19 @@ void f2fs_finalize_device(void)
 	 * in the block device page cache.
 	 */
 	for (i = 0; i < c.ndevs; i++) {
-		if (fsync(c.devices[i].fd) < 0)
+		ret = fsync(c.devices[i].fd);
+		if (ret < 0) {
 			MSG(0, "\tError: Could not conduct fsync!!!\n");
+			break;
+		}
 
-		if (close(c.devices[i].fd) < 0)
+		ret = close(c.devices[i].fd);
+		if (ret < 0) {
 			MSG(0, "\tError: Failed to close device file!!!\n");
+			break;
+		}
 	}
 	close(c.kd);
+
+	return ret;
 }
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index e61c066a3f3a..691d3863a6c8 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -333,7 +333,8 @@ int main(int argc, char *argv[])
 	if (f2fs_format_device() < 0)
 		return -1;
 
-	f2fs_finalize_device();
+	if (f2fs_finalize_device() < 0)
+		return -1;
 
 	MSG(0, "Info: format successful\n");
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
