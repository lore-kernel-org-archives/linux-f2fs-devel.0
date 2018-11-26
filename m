From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: allow to fsck readonly image w/ -f
 option
Date: Mon, 26 Nov 2018 18:53:37 +0800
Message-ID: <20181126105337.33783-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gREX1-0004Wz-Ka
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 10:54:23 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gREWf-00Fb60-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 10:54:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

To keep line with e2fsprogs, let's allow to fsck mounted image as
readonly w/ -f option.

Reported-by: Perfect Gentleman <perfect007gentleman@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/main.c       | 1 +
 include/f2fs_fs.h | 1 +
 lib/libf2fs.c     | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 675c603b1a76..bb79f6e9fc89 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -249,6 +249,7 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 'f':
 			case 'y':
 				c.fix_on = 1;
+				c.force = 1;
 				MSG(0, "Info: Force to fix corruption\n");
 				break;
 			case 'q':
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 65cc8fdb3c22..6eebb3ac44e1 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -369,6 +369,7 @@ struct f2fs_configuration {
 	void *private;
 	int dry_run;
 	int fix_on;
+	int force;
 	int defset;
 	int bug_on;
 	int alloc_failed;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index cc335dbb48ee..498f6c0968d8 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -821,7 +821,7 @@ int get_device_info(int i)
 			return -1;
 		}
 
-		if (S_ISBLK(stat_buf->st_mode))
+		if (S_ISBLK(stat_buf->st_mode) && !c.force)
 			fd = open(dev->path, O_RDWR | O_EXCL);
 		else
 			fd = open(dev->path, O_RDWR);
-- 
2.18.0.rc1
