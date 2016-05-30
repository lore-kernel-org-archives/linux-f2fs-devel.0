From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: propagate error given by
 f2fs_find_entry
Date: Sun, 29 May 2016 19:39:01 -0700
Message-ID: <20160530023901.GC78763@jaegeuk.hsd1.ca.comcast.net>
References: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
 <5747D1B0.2000006@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5747D1B0.2000006@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: He YunLei <heyunlei@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 27, 2016 at 12:48:48PM +0800, He YunLei wrote:
> On 2016/5/27 8:25, Jaegeuk Kim wrote:
> >If we get ENOMEM or EIO in f2fs_find_entry, we should stop right away.
> >Otherwise, for example, we can get duplicate directory entry by ->chash and
> >->clevel.
> >
> >Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >---
> >  fs/f2fs/dir.c    | 23 ++++++++++++++++-------
> >  fs/f2fs/inline.c |  4 +++-
> >  fs/f2fs/namei.c  |  5 +++++
> >  3 files changed, 24 insertions(+), 8 deletions(-)
> >
> >diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >index 24d1308..ae37543 100644
> >--- a/fs/f2fs/dir.c
> >+++ b/fs/f2fs/dir.c
> >@@ -185,8 +185,13 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> >  		/* no need to allocate new dentry pages to all the indices */
> >  		dentry_page = find_data_page(dir, bidx);
> >  		if (IS_ERR(dentry_page)) {
> >-			room = true;
> >-			continue;
> >+			if (PTR_ERR(dentry_page) == -ENOENT) {
> >+				room = true;
> >+				continue;
> >+			} else {
> >+				*res_page = dentry_page;
> >+				break;
> >+			}
> >  		}
> >
> >  		de = find_in_block(dentry_page, fname, namehash, &max_slots,
> >@@ -223,19 +228,22 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
> >  	struct fscrypt_name fname;
> >  	int err;
> >
> >-	*res_page = NULL;
> >-
> >  	err = fscrypt_setup_filename(dir, child, 1, &fname);
> >-	if (err)
> >+	if (err) {
> >+		*res_page = ERR_PTR(-ENOMEM);
> >  		return NULL;
> >+	}
> >
> >  	if (f2fs_has_inline_dentry(dir)) {
> >+		*res_page = NULL;
> >  		de = find_in_inline_dir(dir, &fname, res_page);
> >  		goto out;
> >  	}
> >
> >-	if (npages == 0)
> >+	if (npages == 0) {
> >+		*res_page = NULL;
> >  		goto out;
> >+	}
> >
> >  	max_depth = F2FS_I(dir)->i_current_depth;
> >  	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
> >@@ -247,8 +255,9 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
> >  	}
> >
> >  	for (level = 0; level < max_depth; level++) {
> >+		*res_page = NULL;
> >  		de = find_in_level(dir, level, &fname, res_page);
> >-		if (de)
> >+		if (de || IS_ERR(*res_page))
> >  			break;
> >  	}
> 
> Hi, kim
> 	Here, we return NULL for the error of find_data_page, it means
> the file looked up is not exist to vfs, but may be the file has already exist
> behind the block read error. So maybe we 'd better reported the error to vfs.
> 

How about this? :)

>From a9098ceb560174debca8b5f06658d7a91cdd7fff Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 27 May 2016 10:10:41 -0700
Subject: [PATCH] f2fs: return error of f2fs_lookup

Now we can report an error to f2fs_lookup given by f2fs_find_entry.

Suggested-by: He YunLei <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c   | 2 +-
 fs/f2fs/namei.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ae37543..6fbb1ed 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -230,7 +230,7 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 
 	err = fscrypt_setup_filename(dir, child, 1, &fname);
 	if (err) {
-		*res_page = ERR_PTR(-ENOMEM);
+		*res_page = ERR_PTR(err);
 		return NULL;
 	}
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3f6119e..78efe00 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -287,8 +287,11 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
-	if (!de)
+	if (!de) {
+		if (IS_ERR(page))
+			return (struct dentry *)page;
 		return d_splice_alias(inode, dentry);
+	}
 
 	ino = le32_to_cpu(de->ino);
 	f2fs_dentry_kunmap(dir, page);
-- 
2.6.3
