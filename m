From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: avoid reading NAT page by
 get_node_info
Date: Thu, 23 Feb 2017 10:20:00 -0800
Message-ID: <20170223182000.GA2026@jaegeuk.local>
References: <20170214020644.18189-1-jaegeuk@kernel.org>
 <20170214020644.18189-3-jaegeuk@kernel.org>
 <c911629f-7c6c-00d3-3d94-8c6a9a5fb0ca@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c911629f-7c6c-00d3-3d94-8c6a9a5fb0ca@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/23, Chao Yu wrote:
> On 2017/2/14 10:06, Jaegeuk Kim wrote:
> > We've not seen this buggy case for a long time, so it's time to avoid this
> > unnecessary get_node_info() call which reading NAT page to cache nat entry.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/node.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index e001d084667f..b63bdb85ad66 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1033,7 +1033,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
> >  				unsigned int ofs, struct page *ipage)
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> > -	struct node_info old_ni, new_ni;
> > +	struct node_info new_ni;
> >  	struct page *page;
> >  	int err;
> >  
> > @@ -1049,12 +1049,11 @@ struct page *new_node_page(struct dnode_of_data *dn,
> >  		goto fail;
> >  	}
> >  
> > -	get_node_info(sbi, dn->nid, &old_ni);
> > -
> > -	/* Reinitialize old_ni with new node page */
> > -	f2fs_bug_on(sbi, old_ni.blk_addr != NULL_ADDR);
> 
> What about keeping get_node_info covered with CONFIG_F2FS_CHECK_FS for
> consistence as we just introduce two new free nid caches, I think it will be
> helpful for detecting bugs of these new codes.

Good idea!
I added it like this.

>From a60572a7e9826b26f9634073ba9178762a9e0e7a Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 13 Feb 2017 17:02:44 -0800
Subject: [PATCH] f2fs: avoid reading NAT page by get_node_info

We've not seen this buggy case for a long time, so it's time to avoid this
unnecessary get_node_info() call which reading NAT page to cache nat entry.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index baef30e230d9..42bb6f3f4757 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1033,7 +1033,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 				unsigned int ofs, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct node_info old_ni, new_ni;
+	struct node_info new_ni;
 	struct page *page;
 	int err;
 
@@ -1048,13 +1048,15 @@ struct page *new_node_page(struct dnode_of_data *dn,
 		err = -ENOSPC;
 		goto fail;
 	}
-
-	get_node_info(sbi, dn->nid, &old_ni);
-
-	/* Reinitialize old_ni with new node page */
-	f2fs_bug_on(sbi, old_ni.blk_addr != NULL_ADDR);
-	new_ni = old_ni;
+#ifdef CONFIG_F2FS_CHECK_FS
+	get_node_info(sbi, dn->nid, &new_ni);
+	f2fs_bug_on(sbi, new_ni.blk_addr != NULL_ADDR);
+#endif
+	new_ni.nid = dn->nid;
 	new_ni.ino = dn->inode->i_ino;
+	new_ni.blk_addr = NULL_ADDR;
+	new_ni.flag = 0;
+	new_ni.version = 0;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
 	f2fs_wait_on_page_writeback(page, NODE, true);
-- 
2.11.0
