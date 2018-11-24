From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] f2fs: make "f2fs_fault_name[]" const char *
Date: Sat, 24 Nov 2018 12:06:42 +0300
Message-ID: <20181124090642.GA10969@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <adobriyan@gmail.com>) id 1gQTtt-00008A-2s
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Nov 2018 09:06:53 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gQTtr-001qRM-G1
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Nov 2018 09:06:53 +0000
Received: by mail-wr1-f49.google.com with SMTP id 96so14282030wrb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 24 Nov 2018 01:06:51 -0800 (PST)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Those strings are immutable.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/f2fs/f2fs.h  |    2 +-
 fs/f2fs/super.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -67,7 +67,7 @@ struct f2fs_fault_info {
 	unsigned int inject_type;
 };
 
-extern char *f2fs_fault_name[FAULT_MAX];
+extern const char *f2fs_fault_name[FAULT_MAX];
 #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
 #endif
 
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -38,7 +38,7 @@ static struct kmem_cache *f2fs_inode_cachep;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 
-char *f2fs_fault_name[FAULT_MAX] = {
+const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
 	[FAULT_KVMALLOC]	= "kvmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
