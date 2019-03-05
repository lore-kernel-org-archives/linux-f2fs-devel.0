From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to use kvfree instead of kzfree
Date: Tue, 5 Mar 2019 17:52:33 +0800
Message-ID: <20190305095233.126601-2-yuchao0@huawei.com>
References: <20190305095233.126601-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305095233.126601-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As Jiqun Li reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202747

System can panic due to using wrong allocate/free function pair
in xattr interface:
- use kvmalloc to allocate memory
- use kzfree to free memory

Let's fix to use kvfree instead of kzfree, BTW, we are safe to
get rid of kzfree, since there is no such confidential data stored
as xattr, we don't need to zero it before free memory.

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Reported-by: Jiqun Li <jiqun.li@unisoc.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index fa620d31ea5f..ca47224d78ab 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -340,7 +340,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 out:
-	kzfree(txattr_addr);
+	kvfree(txattr_addr);
 	return err;
 }
 
@@ -383,7 +383,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 fail:
-	kzfree(txattr_addr);
+	kvfree(txattr_addr);
 	return err;
 }
 
@@ -510,7 +510,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	}
 	error = size;
 out:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
@@ -556,7 +556,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	}
 	error = buffer_size - rest;
 cleanup:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
@@ -687,7 +687,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
-- 
2.18.0.rc1
