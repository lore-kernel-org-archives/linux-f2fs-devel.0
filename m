Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8B606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HUiuxYmF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EQp4D8b6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lZVUuOSF;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TKeU8/Ul
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=VBh7a4tuVhnYO9y5ZMldg/xHxrY82WB16tXd779Kij0=; b=HUiuxYmFYVq13mS8hU5Q+Fd6/f
	QZUOz2Ixt11FNLQLbu7JiM2RVuELzbYuF9AQp6n0LGBJ5zkSSHcvG2BkwVuPiwO1bcHmFohGPGq5F
	vW5A2S5An5jmmV5rOm9qtGE0kZOcN0Iv7BRfiwt8rkKMSd+KSFIf1d2/WWDii8pW1MF4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJw5U-000000004Py-1iTf;
	Thu, 22 Oct 2026 16:56:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xJw4w-000000004PO-09DR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 16:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cGA7aNtopU1D3jFV3b7MKOoXob/OOTqjubBjksI2s90=; b=EQp4D8b65MDY22tacoYjee1pxS
 x6zhvb8tcl9svXFkVe0DNZtN8XdG3J50Rw/EvD4nX/KiryrpzT9zoeVRZXPmWjw8244CiUz33gXTu
 V7t6+VljVSwknKx83b80FcCDACvUsrlzSFy3MdmZjMZAwiClnUMneQuLKQcn8nx4wrdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cGA7aNtopU1D3jFV3b7MKOoXob/OOTqjubBjksI2s90=; b=lZVUuOSFRnFBeKvAq0/hPrtzf4
 38FNEKFkhZAECmMxhTy+L02GnFLTaBqq+R25vmNiu+vvIIkMRqUl1PdZz6zbVv23l121sqcMOSzsh
 5oEHv7jxJdpYPMDf8IFHFsoQjMUKtqZBHbWYq5qq1g2WykGjLI36atL/MWfqgwTv6uhY=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJw4u-0000000008K-1lZc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 16:55:45 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so38876a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792688139; x=1793292939; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cGA7aNtopU1D3jFV3b7MKOoXob/OOTqjubBjksI2s90=;
 b=TKeU8/Ul6dpRYsDOl37kCEp8Q0KTAfjnoHwttSu3yqcmUiIFLTc+DE5Ig9zHvisp8I
 EuFKonktiV41xGrdwp9a1EbnEWqbSgKBAyAXdEqPl16Xhrs4t7kaN25LE4oasQOlw5aN
 dWoQP3mFOGzz8hLpKU9n2/8ZBnVP+80SevZqUojHl0EzcFdzbxzSx3r0vvRD9xqI01AP
 cuCDjRxylT29CEjx2IJvRk5abIWtrQ5wW9uaPM3EydgzVRNH4WcozQpQgIFfISVejHcH
 B5xaQFAQmBFGy47kp8X6AYzs+TpgMj9hCKoEKHlftotkn8o7Wb7XpVfAhI27DEgJsyZ1
 pYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688139; x=1793292939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cGA7aNtopU1D3jFV3b7MKOoXob/OOTqjubBjksI2s90=;
 b=f1ES6tEIiHAIyb/Vn3ZT4ITJo51tFIHOP0fEq4lU+S+y/QgE5+MsXMRzjrPRQxm5Nd
 X/B1YbNLWZlMC4+ZiNGN8Nra1UXKdjktDQHICUF5jocTop8wqZREDocOnrEGeDcYliQb
 XVFkwUQAbjuJLK+gIJCYxx64jqRhnMmH7hS1iFQ2ID38CzixW0fEzGeLFDD/RZxcWsYO
 Bvt4S6+nko4feIhvyRAWLkicFE/2G3gyDuRV7nSnnztdBryoQf3d1Aa8zTzxdDr76oUq
 AZi/T51mnRxFAvNRlCD5g9oIwoUoWVPjgv8EMYYnnjBN9v6ZxrvRUIjKeUVKiFJ4YTyK
 GQ/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuy4rFg4OrmFsAkY8wE2B4hjrF6yveSgUMR6+TTQcXH9Q5Ejg1+P/vB4l+qbch0BTj/MS64CeS9hAnz9uh4ma1@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJM4ez8kDa/L5IMl2JPf+BkeUE/eMbKo1zfm3NZUWK+0Ructj1v
 8Ya5/lXoBO0IseFUxyZyaucKGsZ6qNhS3sMHGvcp+fyZyDgCWPIkBUu3Re0XDg==
X-Gm-Gg: AYBFou2OosRtIt4nJy0UaJQKY7Te0TktWsH49nx7ghp7dI0f2Pxu69+LPvbb7/CazH2
 U+HgnCAQjpKg1RKGGaxeqH8eiPkqtvL7+CNEMxWYQ335i6VrOGxM6GgmY2tybEm960rcgtewHUi
 XWiCxdAeOPmHcoBbt8N8k5aLxPLOBhUcUQzdvJ0vfkHNJudGpLEGoFBT2a8me2juoZgUoFcqtJT
 F9IxjqwdRqYh5j0Ow5k3G6JcPlIHFFdTOruZHdOogH1940zaxOdv9YRgIeUvuUAqNJUy6z0IkXc
 TtHWr++KrvtElSFwEBkTuvXsXExddo6GzhIr+kCs4rVf32Mjgy1iT+o9I7EaCU+kTiKwvdT0GCp
 7tA31fghyOB+OAcVeh/J5/LLb22OZ8uuJfUDc2cOsuPOQat/iA2cZUPs1LoqvM8qRkvTuzOaADt
 bT/UQKMuubgklIt3GpjE9UckPB1KsX/B1bdpfa9BP/Sh94EZ0590vzlz/PSFlOFYEexLAHf+UXJ
 yhUAjC7Waa/bFWRYybiaHUNYmPZFkuz2La3OUsbg2baMuSmg3qdecoMMNAODlaHyRfH4HwJ7+h7
 yQ9TmtTWPHxykMpiLQ7D0C1z7oVQMr5jZlYFquzGLH1GyNxAJDFpH+K7tbURpO66Dfw+R1LZeg=
 =
X-Received: by 2002:a17:90b:3bcc:b0:3ac:b3c7:de14 with SMTP id
 98e67ed59e1d1-3ad86d6cd8fmr4895188a91.61.1792688138335; 
 Thu, 22 Oct 2026 09:55:38 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48879a0sm5057688a91.4.2026.10.22.09.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:55:37 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 22 Oct 2026 16:55:26 +0000
Message-ID: <20261022165526.1539629-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xJw4u-0000000008K-1lZc
Subject: [f2fs-dev] [PATCH v2] f2fs: reserve space to be shrunk during
 resize_fs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

f2fs_resize_fs() drops gc_lock and the cp lock between the free space
check and freeze_super(). In that window, others can allocate the free
space, so the second check after freeze_super() fails with -ENOSPC.
This is easy to hit on a busy filesystem, e.g. at OTA install time.

Reserve the space to be shrunk via resize_reserved_blocks once the
first check passes, and deduct it in __get_available_block_count() like
alias_reserved_blocks. Release it on success or on error.

With the reservation, the second check should not fail anymore, so:
- allow root reserved blocks, which root may use in the meantime,
- recheck DISABLE_CHECKPOINT, which remount may set in the meantime,
  since freeze_super() fails only when the fs is still dirty,
- keep the check only as a WARN_ON_ONCE() safety net.

Also exclude the alias/resize reservations when updating
current_reserved_blocks via sysfs, otherwise it can underflow
__get_available_block_count().

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
Changes in v2:
- Exclude alias/resize reservations from current_reserved_blocks.
- Allow root reserved blocks in the second check, with WARN_ON_ONCE().
- Recheck DISABLE_CHECKPOINT after freeze_super().
---
 fs/f2fs/f2fs.h  | 18 +++++++++++++----
 fs/f2fs/gc.c    | 54 ++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/super.c |  1 +
 fs/f2fs/sysfs.c | 12 ++++++++++-
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 089a62c054e..6b9e1d0e71c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1897,6 +1897,7 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 	block_t alias_reserved_blocks;		/* reserved blocks for device alias */
+	block_t resize_reserved_blocks;		/* reserved blocks for resize_fs */
 
 	/* Additional tracking for no checkpoint mode */
 	block_t unusable_block_count;		/* # of blocks saved by last cp */
@@ -2666,16 +2667,18 @@ static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 	return false;
 }
 
-static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
-						struct inode *inode, bool cap)
+static inline unsigned int __get_available_block_count(
+					struct f2fs_sb_info *sbi,
+					bool allow_root)
 {
 	block_t avail_user_block_count;
 
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks -
-					sbi->alias_reserved_blocks;
+					sbi->alias_reserved_blocks -
+					sbi->resize_reserved_blocks;
 
-	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !allow_root)
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -2688,6 +2691,13 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	return avail_user_block_count;
 }
 
+static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
+						struct inode *inode, bool cap)
+{
+	return __get_available_block_count(sbi,
+				__allow_reserved_root(sbi, inode, cap));
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 926e6976bc2..955224f4166 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2374,6 +2374,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	struct f2fs_lock_context glc;
 	struct f2fs_lock_context clc;
 	unsigned int secs;
+	bool reserved = false;
 	int err = 0;
 	__u32 rem;
 
@@ -2425,10 +2426,17 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	f2fs_lock_op(sbi, &lc);
 
 	spin_lock(&sbi->stat_lock);
-	if (shrunk_blocks + valid_user_blocks(sbi) +
-		sbi->current_reserved_blocks + sbi->unusable_block_count +
-		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
+	if (shrunk_blocks + valid_user_blocks(sbi) >
+			__get_available_block_count(sbi, false)) {
 		err = -ENOSPC;
+	} else {
+		/*
+		 * Reserve the space to be shrunk so that no one, including
+		 * root, can allocate it until the shrink is done.
+		 */
+		sbi->resize_reserved_blocks += shrunk_blocks;
+		reserved = true;
+	}
 	spin_unlock(&sbi->stat_lock);
 
 	if (err)
@@ -2442,29 +2450,45 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 out_drop_write:
 	mnt_drop_write_file(filp);
 	if (err)
-		return err;
+		goto out_release;
 
 	err = freeze_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
 	if (err)
-		return err;
+		goto out_release;
 
 	if (f2fs_readonly(sbi->sb)) {
 		err = thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
-		if (err)
-			return err;
-		return -EROFS;
+		if (!err)
+			err = -EROFS;
+		goto out_release;
+	}
+
+	/* checkpoint can be disabled by remount before freeze_super() */
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		f2fs_err(sbi, "Checkpoint should be enabled.");
+		err = thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
+		if (!err)
+			err = -EINVAL;
+		goto out_release;
 	}
 
 	f2fs_down_write_trace(&sbi->gc_lock, &glc);
 	f2fs_down_write_trace(&sbi->cp_global_sem, &clc);
 
 	spin_lock(&sbi->stat_lock);
-	if (shrunk_blocks + valid_user_blocks(sbi) +
-		sbi->current_reserved_blocks + sbi->unusable_block_count +
-		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
+	/*
+	 * shrunk_blocks is already accounted in resize_reserved_blocks, so
+	 * this should not fail. Allow root reserved blocks here since root
+	 * may have used them after the first check, regardless of resize.
+	 */
+	if (WARN_ON_ONCE(valid_user_blocks(sbi) >
+			__get_available_block_count(sbi, true))) {
 		err = -ENOSPC;
-	else
+	} else {
 		sbi->user_block_count -= shrunk_blocks;
+		sbi->resize_reserved_blocks -= shrunk_blocks;
+		reserved = false;
+	}
 	spin_unlock(&sbi->stat_lock);
 	if (err)
 		goto out_err;
@@ -2510,5 +2534,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	f2fs_up_write_trace(&sbi->cp_global_sem, &clc);
 	f2fs_up_write_trace(&sbi->gc_lock, &glc);
 	thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
+out_release:
+	if (reserved) {
+		spin_lock(&sbi->stat_lock);
+		sbi->resize_reserved_blocks -= shrunk_blocks;
+		spin_unlock(&sbi->stat_lock);
+	}
 	return err;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d683240040f..28e49e8d71e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5345,6 +5345,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
 	sbi->alias_reserved_blocks = 0;
+	sbi->resize_reserved_blocks = 0;
 	limit_reserve_root(sbi);
 	adjust_unusable_cap_perc(sbi);
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9749da70089..ce70d81eba3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -594,6 +594,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	}
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
+		block_t avail, valid;
+
 		spin_lock(&sbi->stat_lock);
 		if (t > (unsigned long)(sbi->user_block_count -
 				F2FS_OPTION(sbi).root_reserved_blocks)) {
@@ -601,8 +603,16 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 		}
 		*ui = t;
+		/*
+		 * Exclude the space reserved for device aliasing and resize_fs,
+		 * otherwise the reserved blocks can overlap with them and
+		 * __get_available_block_count() can underflow.
+		 */
+		avail = sbi->user_block_count - sbi->alias_reserved_blocks -
+					sbi->resize_reserved_blocks;
+		valid = valid_user_blocks(sbi);
 		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
-				sbi->user_block_count - valid_user_blocks(sbi));
+				avail > valid ? avail - valid : 0);
 		spin_unlock(&sbi->stat_lock);
 		return count;
 	}
-- 
2.56.0.218.g1ec904b173-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
