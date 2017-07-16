From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: avoid cpu lockup
Date: Sat, 15 Jul 2017 18:04:22 -0700
Message-ID: <20170716010422.GA51202@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170715012245.24640-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170715012245.24640-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Before retrying to flush data or dentry pages, we need to release cpu in order
to prevent watchdog.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - timeout more specifically

 fs/f2fs/checkpoint.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 56bbf592e487..5b876f6d3f6b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -879,6 +879,7 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
 	bool is_dir = (type == DIR_INODE);
+	unsigned long ino = 0;
 
 	trace_f2fs_sync_dirty_inodes_enter(sbi->sb, is_dir,
 				get_pages(sbi, is_dir ?
@@ -901,8 +902,17 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	inode = igrab(&fi->vfs_inode);
 	spin_unlock(&sbi->inode_lock[type]);
 	if (inode) {
+		unsigned long cur_ino = inode->i_ino;
+
 		filemap_fdatawrite(inode->i_mapping);
 		iput(inode);
+		/* We need to give cpu to another writers. */
+		if (ino == cur_ino) {
+			congestion_wait(BLK_RW_ASYNC, HZ/50);
+			cond_resched();
+		} else {
+			ino = cur_ino;
+		}
 	} else {
 		/*
 		 * We should submit bio, since it exists several
-- 
2.13.0.rc1.294.g07d810a77f-goog
