From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] f2fs: fix sparse warnings
Date: Tue, 11 Oct 2016 10:36:12 -0700
Message-ID: <1476207372-9894-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers@google.com>) id 1bu0zY-0001ql-IV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 17:37:28 +0000
Received: from mail-pf0-f181.google.com ([209.85.192.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bu0zX-00014x-LS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 17:37:28 +0000
Received: by mail-pf0-f181.google.com with SMTP id s8so5551435pfj.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 11 Oct 2016 10:37:27 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net

f2fs contained a number of endianness conversion bugs.

Also, one function should have been 'static'.

Found with sparse by running 'make C=2 CF=-D__CHECK_ENDIAN__ fs/f2fs/'

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c     | 4 ++--
 fs/f2fs/inline.c  | 2 +-
 fs/f2fs/node.c    | 5 +++--
 fs/f2fs/node.h    | 2 +-
 fs/f2fs/segment.c | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 12b5836..43c941c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -136,7 +136,7 @@ struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
 
 		/* show encrypted name */
 		if (fname->hash) {
-			if (de->hash_code == fname->hash)
+			if (de->hash_code == cpu_to_le32(fname->hash))
 				goto found;
 		} else if (de_name.len == name->len &&
 			de->hash_code == namehash &&
@@ -816,7 +816,7 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int err;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
-						(u32)de->hash_code, 0,
+						le32_to_cpu(de->hash_code), 0,
 						&de_name, fstr);
 			if (err)
 				return true;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 34234d8..8eb9e79 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -419,7 +419,7 @@ static int f2fs_add_inline_entries(struct inode *dir,
 		}
 
 		new_name.name = d.filename[bit_pos];
-		new_name.len = de->name_len;
+		new_name.len = le16_to_cpu(de->name_len);
 
 		ino = le32_to_cpu(de->ino);
 		fake_mode = get_de_type(de) << S_SHIFT;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8831035..342d48f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -270,8 +270,9 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 		e = grab_nat_entry(nm_i, nid);
 		node_info_from_raw_nat(&e->ni, ne);
 	} else {
-		f2fs_bug_on(sbi, nat_get_ino(e) != ne->ino ||
-				nat_get_blkaddr(e) != ne->block_addr ||
+		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
+				nat_get_blkaddr(e) !=
+					le32_to_cpu(ne->block_addr) ||
 				nat_get_version(e) != ne->version);
 	}
 }
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 868bec6..cfdcf98 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -313,7 +313,7 @@ static inline bool is_recoverable_dnode(struct page *page)
 				((unsigned char *)ckpt + crc_offset)));
 		cp_ver |= (crc << 32);
 	}
-	return cpu_to_le64(cp_ver) == cpver_of_node(page);
+	return cp_ver == cpver_of_node(page);
 }
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc886f0..0ab44ea 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -633,7 +633,7 @@ static void f2fs_submit_bio_wait_endio(struct bio *bio)
 }
 
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
-int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi, sector_t sector,
+static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
-- 
2.8.0.rc3.226.g39d4020


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
