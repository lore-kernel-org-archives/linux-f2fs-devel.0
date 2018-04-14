From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] fs: f2fs: Adding new return type vm_fault_t
Date: Sun, 15 Apr 2018 01:40:02 +0530
Message-ID: <20180414201001.GA20256@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jrdr.linux@gmail.com>) id 1f7RTC-00014k-Pr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 20:08:22 +0000
Received: from mail-pl0-f66.google.com ([209.85.160.66])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f7RTA-00Bndt-SV
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 20:08:22 +0000
Received: by mail-pl0-f66.google.com with SMTP id k9-v6so3100742pll.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Apr 2018 13:08:20 -0700 (PDT)
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
Cc: willy@infradead.org, linux-f2fs-devel@lists.sourceforge.net

Use new return type vm_fault_t for page_mkwrite
and fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/f2fs/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542..045337a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -33,19 +33,19 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-static int f2fs_filemap_fault(struct vm_fault *vmf)
+static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	int err;
+	vm_fault_t ret;
 
 	down_read(&F2FS_I(inode)->i_mmap_sem);
-	err = filemap_fault(vmf);
+	ret = filemap_fault(vmf);
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
-	return err;
+	return ret;
 }
 
-static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
