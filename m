From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to keep backward compatibility of
 flexible inline xattr feature
Date: Thu, 26 Oct 2017 12:37:28 +0200
Message-ID: <20171026103728.GA62112@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171025103124.63162-1-yuchao0@huawei.com>
 <20171026084243.GA54331@jaegeuk-macbookpro.roam.corp.google.com>
 <37f397bd-fa5b-c7f0-bb20-ea3be98437cd@huawei.com>
 <20171026091108.GC54331@jaegeuk-macbookpro.roam.corp.google.com>
 <20171026100257.GA60038@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e7fXe-0000xK-JV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Oct 2017 10:37:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e7fXd-0007Yp-J6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Oct 2017 10:37:38 +0000
Content-Disposition: inline
In-Reply-To: <20171026100257.GA60038@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 10/26, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 10/26, Jaegeuk Kim wrote:
> > On 10/26, Chao Yu wrote:
> > > Hi Jaegeuk,
> > > 
> > > On 2017/10/26 16:42, Jaegeuk Kim wrote:
> > > > Hi Chao,
> > > > 
> > > > It seems this is a critical problem, so let me integrate this patch with your
> > > > initial patch "f2fs: support flexible inline xattr size".
> > > > Let me know, if you have any other concern.
> > > 
> > > Better. ;)
> > > 
> > > Please add commit message of this patch into initial patch "f2fs: support
> > > flexible inline xattr size".
> 
> BTW, I read the patch again, and couldn't catch the problem actually.
> We didn't assign inline_xattr all the time, instead do if inline_xattr
> is set. Have you done some tests with this? I'm failing tests with these
> changes.

Could you take a look at this change?

---
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/inode.c | 20 ++++++--------------
 fs/f2fs/namei.c | 16 ++++++++++------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7fb295..97358d7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2373,7 +2373,6 @@ static inline int get_extra_isize(struct inode *inode)
 static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb);
 static inline int get_inline_xattr_addrs(struct inode *inode)
 {
-
 	return F2FS_I(inode)->i_inline_xattr_size;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cef2f65..eb9a21e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -233,21 +233,14 @@ static int do_read_inode(struct inode *inode)
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
 
-	/*
-	 * Previously, we will always reserve DEFAULT_INLINE_XATTR_ADDRS size
-	 * space for inline xattr datas, if inline xattr is not enabled, we
-	 * can expect all zero in reserved area, so for regular or symlink,
-	 * it will be safe to reuse reserved area, but for directory, we
-	 * should keep the reservation for stablizing directory structure.
-	 */
-	if (f2fs_has_extra_attr(inode) &&
-		f2fs_sb_has_flexible_inline_xattr(sbi->sb))
+	if (f2fs_sb_has_flexible_inline_xattr(sbi->sb)) {
+		f2fs_bug_on(sbi, !f2fs_has_extra_attr(inode));
 		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);
-	else if (!f2fs_has_inline_xattr(inode) &&
-		(S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)))
+	} else if (!f2fs_has_inline_xattr(inode)) {
 		fi->i_inline_xattr_size = 0;
-	else
+	} else {
 		fi->i_inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
+	}
 
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
@@ -401,8 +394,7 @@ int update_inode(struct inode *inode, struct page *node_page)
 	if (f2fs_has_extra_attr(inode)) {
 		ri->i_extra_isize = cpu_to_le16(F2FS_I(inode)->i_extra_isize);
 
-		if (f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb) &&
-			f2fs_has_inline_xattr(inode))
+		if (f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb))
 			ri->i_inline_xattr_size =
 				cpu_to_le16(F2FS_I(inode)->i_inline_xattr_size);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e8fdd5e..7ec86d3 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -29,6 +29,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	nid_t ino;
 	struct inode *inode;
 	bool nid_free = false;
+	int xattr_size = 0;
 	int err;
 
 	inode = new_inode(dir->i_sb);
@@ -87,12 +88,15 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (test_opt(sbi, INLINE_XATTR))
 		set_inode_flag(inode, FI_INLINE_XATTR);
 
-	if (f2fs_sb_has_extra_attr(sbi->sb) &&
-		f2fs_sb_has_flexible_inline_xattr(sbi->sb) &&
-		f2fs_has_inline_xattr(inode))
-		F2FS_I(inode)->i_inline_xattr_size = sbi->inline_xattr_size;
-	else
-		F2FS_I(inode)->i_inline_xattr_size = 0;
+	if (f2fs_has_inline_xattr(inode)) {
+		if (f2fs_sb_has_flexible_inline_xattr(sbi->sb)) {
+			f2fs_bug_on(sbi, !f2fs_has_extra_attr(inode));
+			xattr_size = sbi->inline_xattr_size;
+		} else {
+			xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
+		}
+	}
+	F2FS_I(inode)->i_inline_xattr_size = xattr_size;
 
 	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
 		set_inode_flag(inode, FI_INLINE_DATA);
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
