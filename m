From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: add missing quota_initialize in f2fs_set_acl
Date: Wed, 25 Oct 2017 07:43:48 +0200
Message-ID: <20171025054348.GA83348@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171023221409.59148-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171023221409.59148-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to call quota_intialize in f2fs_set_acl.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 147b481c6902..8801db019892 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -686,6 +686,10 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
 	/* this case is only from init_inode_metadata */
 	if (ipage)
 		return __f2fs_setxattr(inode, index, name, value,
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
