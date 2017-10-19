From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle error case when adding xattr
 entry
Date: Thu, 19 Oct 2017 11:54:12 -0700
Message-ID: <20171019185412.GA82186@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171016230642.94228-1-jaegeuk@kernel.org>
 <cfca102c-fcd9-4d43-80a7-1684a59f5e95@kernel.org>
 <20171017164154.GA5509@jaegeuk-macbookpro.roam.corp.google.com>
 <de3db7b8-51cf-08be-1117-af08bf87a55e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <de3db7b8-51cf-08be-1117-af08bf87a55e@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/18, Chao Yu wrote:
> On 2017/10/18 0:41, Jaegeuk Kim wrote:
> > On 10/17, Chao Yu wrote:
> >> On 2017/10/17 7:06, Jaegeuk Kim wrote:
> >>> This patch fixes recovering incomplete xattr entries remaining in inline xattr
> >>> and xattr block, caused by any kind of errors.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/xattr.c | 48 ++++++++++++++++++++++++++++--------------------
> >>>  1 file changed, 28 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> >>> index e74a4d7f744a..5a9c5e6ad714 100644
> >>> --- a/fs/f2fs/xattr.c
> >>> +++ b/fs/f2fs/xattr.c
> >>> @@ -389,10 +389,11 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> >>>  {
> >>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >>>  	size_t inline_size = inline_xattr_size(inode);
> >>> -	void *xattr_addr;
> >>> +	struct page *in_page = NULL;
> >>> +	void *xattr_addr, *inline_addr;
> >>>  	struct page *xpage;
> >>>  	nid_t new_nid = 0;
> >>> -	int err;
> >>> +	int err = 0;
> >>>  
> >>>  	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
> >>>  		if (!alloc_nid(sbi, &new_nid))
> >>> @@ -400,30 +401,30 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> >>>  
> >>>  	/* write to inline xattr */
> >>>  	if (inline_size) {
> >>> -		struct page *page = NULL;
> >>> -		void *inline_addr;
> >>> -
> >>>  		if (ipage) {
> >>>  			inline_addr = inline_xattr_addr(inode, ipage);
> >>> -			f2fs_wait_on_page_writeback(ipage, NODE, true);
> >>> -			set_page_dirty(ipage);
> >>>  		} else {
> >>> -			page = get_node_page(sbi, inode->i_ino);
> >>> -			if (IS_ERR(page)) {
> >>> +			in_page = get_node_page(sbi, inode->i_ino);
> >>> +			if (IS_ERR(in_page)) {
> >>>  				alloc_nid_failed(sbi, new_nid);
> >>> -				return PTR_ERR(page);
> >>> +				return PTR_ERR(in_page);
> >>>  			}
> >>> -			inline_addr = inline_xattr_addr(inode, page);
> >>> -			f2fs_wait_on_page_writeback(page, NODE, true);
> >>> +			inline_addr = inline_xattr_addr(inode, in_page);
> >>>  		}
> >>> -		memcpy(inline_addr, txattr_addr, inline_size);
> >>> -		f2fs_put_page(page, 1);
> >>>  
> >>> +		f2fs_wait_on_page_writeback(ipage ? ipage : in_page,
> >>> +							NODE, true);
> >>>  		/* no need to use xattr node block */
> >>>  		if (hsize <= inline_size) {
> >>>  			err = truncate_xattr_node(inode, ipage);
> >>
> >> truncate_xattr_node(inode, ipage ? ipage : in_page);
> > 
> > No, that should be ipage.
> 
> I just noted that dn.inode_page_locked in truncate_xattr_node will be set wrong,
> but, anyway, it looks that won't be problem because we didn't use inode_page_locked
> later.
> 
> There is no more users of ipage in truncate_xattr_node, so no matter we passing,
> there will be safe for us, right?

Oh, yes, like this?

>From e5ae89e3c20c1c6a12cee27f6265427d99412dc8 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 19 Oct 2017 11:48:57 -0700
Subject: [PATCH] f2fs: remove obsolete pointer for truncate_xattr_node

This patch removes obosolete parameter for truncate_xattr_node.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/node.c  | 10 ++++------
 fs/f2fs/xattr.c |  2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6301ccca8888..2a97cc5e3cd8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2523,7 +2523,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni);
 pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
 int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
 int truncate_inode_blocks(struct inode *inode, pgoff_t from);
-int truncate_xattr_node(struct inode *inode, struct page *page);
+int truncate_xattr_node(struct inode *inode);
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
 int remove_inode_page(struct inode *inode);
 struct page *new_inode_page(struct inode *inode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ac629d6258ca..f44d83705245 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -962,7 +962,8 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	return err > 0 ? 0 : err;
 }
 
-int truncate_xattr_node(struct inode *inode, struct page *page)
+/* caller must lock inode page */
+int truncate_xattr_node(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t nid = F2FS_I(inode)->i_xattr_nid;
@@ -978,10 +979,7 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
 
 	f2fs_i_xnid_write(inode, 0);
 
-	set_new_dnode(&dn, inode, page, npage, nid);
-
-	if (page)
-		dn.inode_page_locked = true;
+	set_new_dnode(&dn, inode, NULL, npage, nid);
 	truncate_node(&dn);
 	return 0;
 }
@@ -1000,7 +998,7 @@ int remove_inode_page(struct inode *inode)
 	if (err)
 		return err;
 
-	err = truncate_xattr_node(inode, dn.inode_page);
+	err = truncate_xattr_node(inode);
 	if (err) {
 		f2fs_put_dnode(&dn);
 		return err;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 5a9c5e6ad714..147b481c6902 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -416,7 +416,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 							NODE, true);
 		/* no need to use xattr node block */
 		if (hsize <= inline_size) {
-			err = truncate_xattr_node(inode, ipage);
+			err = truncate_xattr_node(inode);
 			alloc_nid_failed(sbi, new_nid);
 			if (err) {
 				f2fs_put_page(in_page, 1);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
