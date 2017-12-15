From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 15/24] f2fs: switch to fscrypt_get_symlink()
Date: Fri, 15 Dec 2017 09:42:16 -0800
Message-ID: <20171215174225.31583-16-ebiggers3@gmail.com>
References: <20171215174225.31583-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1ePu4b-0005m8-1L
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 17:47:01 +0000
Received: from mail-pf0-f194.google.com ([209.85.192.194])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1ePu4a-0008La-4t
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 17:47:00 +0000
Received: by mail-pf0-f194.google.com with SMTP id p84so6639596pfd.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Dec 2017 09:47:00 -0800 (PST)
In-Reply-To: <20171215174225.31583-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/namei.c | 66 ++++++++-------------------------------------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5b114844806c..37816d2ebb93 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1137,68 +1137,20 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 					   struct inode *inode,
 					   struct delayed_call *done)
 {
-	struct page *cpage = NULL;
-	char *caddr, *paddr = NULL;
-	struct fscrypt_str cstr = FSTR_INIT(NULL, 0);
-	struct fscrypt_str pstr = FSTR_INIT(NULL, 0);
-	struct fscrypt_symlink_data *sd;
-	u32 max_size = inode->i_sb->s_blocksize;
-	int res;
+	struct page *page;
+	const char *target;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	res = fscrypt_get_encryption_info(inode);
-	if (res)
-		return ERR_PTR(res);
-
-	cpage = read_mapping_page(inode->i_mapping, 0, NULL);
-	if (IS_ERR(cpage))
-		return ERR_CAST(cpage);
-	caddr = page_address(cpage);
-
-	/* Symlink is encrypted */
-	sd = (struct fscrypt_symlink_data *)caddr;
-	cstr.name = sd->encrypted_path;
-	cstr.len = le16_to_cpu(sd->len);
-
-	/* this is broken symlink case */
-	if (unlikely(cstr.len == 0)) {
-		res = -ENOENT;
-		goto errout;
-	}
-
-	if ((cstr.len + sizeof(struct fscrypt_symlink_data) - 1) > max_size) {
-		/* Symlink data on the disk is corrupted */
-		res = -EIO;
-		goto errout;
-	}
-	res = fscrypt_fname_alloc_buffer(inode, cstr.len, &pstr);
-	if (res)
-		goto errout;
-
-	res = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
-	if (res)
-		goto errout;
-
-	/* this is broken symlink case */
-	if (unlikely(pstr.name[0] == 0)) {
-		res = -ENOENT;
-		goto errout;
-	}
-
-	paddr = pstr.name;
-
-	/* Null-terminate the name */
-	paddr[pstr.len] = '\0';
+	page = read_mapping_page(inode->i_mapping, 0, NULL);
+	if (IS_ERR(page))
+		return ERR_CAST(page);
 
-	put_page(cpage);
-	set_delayed_call(done, kfree_link, paddr);
-	return paddr;
-errout:
-	fscrypt_fname_free_buffer(&pstr);
-	put_page(cpage);
-	return ERR_PTR(res);
+	target = fscrypt_get_symlink(inode, page_address(page),
+				     inode->i_sb->s_blocksize, done);
+	put_page(page);
+	return target;
 }
 
 const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
