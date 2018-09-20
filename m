From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2 v3] f2fs: report ENOENT correct in
 f2fs_rename
Date: Thu, 20 Sep 2018 14:35:01 -0700
Message-ID: <20180920213501.GA35918@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fixes wrong error report in f2fs_rename.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Change log from v2:
  - remove needless err assignment
  - relocate err precisely

 fs/f2fs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 98d3ab7c3ce6..abbad9610fad 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
 	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -860,6 +860,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out;
 	}
 
+	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
@@ -1025,7 +1026,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_dir_entry = NULL, *new_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry, *new_entry;
 	int old_nlink = 0, new_nlink = 0;
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -1049,6 +1050,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
+	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
-- 
2.17.0.441.gb46fe60e1d-goog
