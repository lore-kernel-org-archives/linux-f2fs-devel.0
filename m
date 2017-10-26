From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to keep backward compatibility of flexible
 inline xattr feature
Date: Thu, 26 Oct 2017 12:40:55 +0200
Message-ID: <20171026104055.GA62368@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171025103124.63162-1-yuchao0@huawei.com>
 <20171026084243.GA54331@jaegeuk-macbookpro.roam.corp.google.com>
 <37f397bd-fa5b-c7f0-bb20-ea3be98437cd@huawei.com>
 <20171026091108.GC54331@jaegeuk-macbookpro.roam.corp.google.com>
 <20171026100257.GA60038@jaegeuk-macbookpro.roam.corp.google.com>
 <20171026103728.GA62112@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026103728.GA62112@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/26, Jaegeuk Kim wrote:
> On 10/26, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On 10/26, Jaegeuk Kim wrote:
> > > On 10/26, Chao Yu wrote:
> > > > Hi Jaegeuk,
> > > > 
> > > > On 2017/10/26 16:42, Jaegeuk Kim wrote:
> > > > > Hi Chao,
> > > > > 
> > > > > It seems this is a critical problem, so let me integrate this patch with your
> > > > > initial patch "f2fs: support flexible inline xattr size".
> > > > > Let me know, if you have any other concern.
> > > > 
> > > > Better. ;)
> > > > 
> > > > Please add commit message of this patch into initial patch "f2fs: support
> > > > flexible inline xattr size".
> > 
> > BTW, I read the patch again, and couldn't catch the problem actually.
> > We didn't assign inline_xattr all the time, instead do if inline_xattr
> > is set. Have you done some tests with this? I'm failing tests with these
> > changes.
> 
> Could you take a look at this change?

In addition to this f2fs-tools?

---
 include/f2fs_fs.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 09b2a60..66c446c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1056,14 +1056,12 @@ static inline int __get_extra_isize(struct f2fs_inode *inode)
 extern struct f2fs_configuration c;
 static inline int get_inline_xattr_addrs(struct f2fs_inode *inode)
 {
-	if ((c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) &&
-		(c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)))
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR))
 		return le16_to_cpu(inode->i_inline_xattr_size);
-	else if (!(inode->i_inline & F2FS_INLINE_XATTR) &&
-		(S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)))
-		return 0;
-	else
+	else if (inode->i_inline & F2FS_INLINE_XATTR)
 		return DEFAULT_INLINE_XATTR_ADDRS;
+	else
+		return 0;
 }
 
 #define get_extra_isize(node)	__get_extra_isize(&node->i)
-- 
2.7.4
