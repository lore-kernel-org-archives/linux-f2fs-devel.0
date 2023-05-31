Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B784AC77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 May 2023 01:41:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4Apr-0003qQ-Rr;
	Wed, 31 May 2023 01:41:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q4Apq-0003qJ-Fx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 01:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OhZ2PWqOKrhS4cARZAE+8Tychmt4hv58e3dC7tq3FAs=; b=C09V2LLOV0GjCUUVVw5PGmTssf
 hBIff2H1LecNt5/xs1pUKUSvO5/m1rburCfUEiqDpA9b6dgiPuc6oa1EXiySXh90p2QsijFGW+cs8
 geuzpmnf3O+ffbrBWee3Zi6/p8snT59ohwH8ehvx2HJuSLEqZWsaw1aSwlpXXkzO9Pe8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OhZ2PWqOKrhS4cARZAE+8Tychmt4hv58e3dC7tq3FAs=; b=U
 B6Io5gg0dlyrOjaPuaL8Ww20Ld6+b+Nn3wNuUYReeRdKIqu9jbEJ0nRoLPXz7aoaLAgYu6fh/bZXF
 zaQe9wxXUw82UEoWI0avsdYcBFMjvRsi+0TgNrvpVv1ditDXuSMRHbZ//pGW21eFU7UZMldMODjV0
 iUzHy07BwX7El928=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4Apn-0003iS-9C for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 01:41:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DB2E663030
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 31 May 2023 01:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECC1C433D2;
 Wed, 31 May 2023 01:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685497261;
 bh=Ka/BcrgbTNTVs7DWpgzzzFck8oroxpb1zdPJdwMwR6c=;
 h=From:To:Cc:Subject:Date:From;
 b=bcqEZB+G6EfPu+bDyb3s+T8DQ+2LUBiFkBpvbtJLPyKzm6uUoLxvtd8SpUbs0sbfH
 WDU6imq8USvxwo0QqHMBphHA5MyyqYSQXcPM96fzyCs+S2Pd+MV/d8tmvKGCwQR3Dh
 uXHeywokn+pq3V9SaIbMkJMeRhab3AT97sP86uOzw6IqW8zemKPfWtAGwIrAEJ7k4E
 i7dmNeHHTWmA6TYdy86nzGaa3wVHLFaJYwiyunHrR+Fo4PdOrKEKBeILJ6cTg7xw/v
 ZZSoV8rkptEhrGb9j2uZIYBRYll9FS9yIwZ/pcfNIGvz0p5Ia5Qb5aG+8W39BUTKmy
 ZU9JZMKND1zRA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 31 May 2023 09:40:55 +0800
Message-Id: <20230531014055.3904072-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q4Apn-0003iS-9C
Subject: [f2fs-dev] [PATCH v2] f2fs: do more sanity check on inode
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

There are several issues in sanity_check_inode():
- The code looks not clean, it checks extra_attr related condition
dispersively.
- It missed to check i_extra_isize w/ lower boundary
- It missed to check feature dependency: prjquota, inode_chksum,
inode_crtime, compression features rely on extra_attr feature.
- It's not necessary to check i_extra_isize due to it will only
be assigned to non-zero value if f2fs_has_extra_attr() is true
in do_read_inode().

Fix them all in this patch.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- describe current problem in commit message
 fs/f2fs/f2fs.h  |   2 +
 fs/f2fs/inode.c | 108 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e406da8b4b3..619ad49993ce 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3413,6 +3413,8 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
+#define F2FS_MIN_EXTRA_ATTR_SIZE		(sizeof(__le32))
+
 #define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
 	(offsetof(struct f2fs_inode, i_extra_end) -	\
 	offsetof(struct f2fs_inode, i_extra_isize))	\
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0a1748444329..1e49009831c1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -300,41 +300,79 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (f2fs_sb_has_flexible_inline_xattr(sbi)
-			&& !f2fs_has_extra_attr(inode)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
-			  __func__, inode->i_ino);
-		return false;
-	}
-
-	if (f2fs_has_extra_attr(inode) &&
-			!f2fs_sb_has_extra_attr(sbi)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
-			  __func__, inode->i_ino);
-		return false;
-	}
-
-	if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+	if (f2fs_has_extra_attr(inode)) {
+		if (!f2fs_sb_has_extra_attr(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
+				  __func__, inode->i_ino);
+			return false;
+		}
+		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize % sizeof(__le32)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
-			  __func__, inode->i_ino, fi->i_extra_isize,
-			  F2FS_TOTAL_EXTRA_ATTR_SIZE);
-		return false;
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
+				  __func__, inode->i_ino, fi->i_extra_isize,
+				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
+			return false;
+		}
+		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+			f2fs_has_inline_xattr(inode) &&
+			(!fi->i_inline_xattr_size ||
+			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
+				  __func__, inode->i_ino, fi->i_inline_xattr_size,
+				  MAX_INLINE_XATTR_SIZE);
+			return false;
+		}
+		if (f2fs_sb_has_compression(sbi) &&
+			fi->i_flags & F2FS_COMPR_FL &&
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
+						i_compress_flag)) {
+			if (!sanity_check_compress_inode(inode, ri))
+				return false;
+		}
+	} else {
+		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
+				  __func__, inode->i_ino);
+			return false;
+		}
 	}
 
-	if (f2fs_has_extra_attr(inode) &&
-		f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		f2fs_has_inline_xattr(inode) &&
-		(!fi->i_inline_xattr_size ||
-		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
-			  __func__, inode->i_ino, fi->i_inline_xattr_size,
-			  MAX_INLINE_XATTR_SIZE);
-		return false;
+	if (!f2fs_sb_has_extra_attr(sbi)) {
+		if (f2fs_sb_has_project_quota(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
+			return false;
+		}
+		if (f2fs_sb_has_inode_chksum(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
+			return false;
+		}
+		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
+			return false;
+		}
+		if (f2fs_sb_has_inode_crtime(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
+			return false;
+		}
+		if (f2fs_sb_has_compression(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
+			return false;
+		}
 	}
 
 	if (f2fs_sanity_check_inline_data(inode)) {
@@ -358,12 +396,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
-			fi->i_flags & F2FS_COMPR_FL &&
-			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-						i_compress_flag))
-		return sanity_check_compress_inode(inode, ri);
-
 	return true;
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
