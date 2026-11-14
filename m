Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0E606A33B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QUnVww2c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KngSgI9Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EAGnCsb3;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvwEiiRK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=q1fkHXQLSRebhCjrHXyaNAACgpJ1YNsSseWf/7PJBiU=; b=QUnVww2cEL6cGt3M+UD86IVC/h
	J3JgEhXbfmHL9A3Y2fizpYHnL0XWbquf5O5HSye8MFfMlyrU5oDA7mxm7MiYdjDpTw8xP0v7GE42D
	k/065wrz6fj796Y06ipdespTRYDEfD1At20aPx/RZv0MTMlG8oTGveuRLF7iEld/MF0U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xS2PL-000000002pg-0009;
	Sat, 14 Nov 2026 01:18:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xS2PK-000000002pa-0ZNq
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 01:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/NJq1tNVgAxL0JcudyOin08tnS8RNWNKJF+n6CZo2GE=; b=KngSgI9ZHMH8SmVdeicVMjOuWS
 KRnLBs+9wUaXtyukp6FweOl5NnGYygAbQqHwUUnvTyxisoAMP0Zw02TdYKvpLVPRUOx126IO5OOtm
 GWwFnReqDMVV3vfvCiFAwEhfHHHlezX5jXsn54887379Z1vW11w5xaZAUP90sAA8oAC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/NJq1tNVgAxL0JcudyOin08tnS8RNWNKJF+n6CZo2GE=; b=EAGnCsb3xD4V40zWaY8b9NrnZN
 5OYMfbFA3+BcnxZxjOwvdFMWtFahzEq4ozEt1K5YZunS6lEl3TaOmVk9GZMm1+yzGOvjc/9jAzJl0
 +DSBbU2WqM7iu2wPj3kDu78H+t3c6m+Q0khL9wPQGd3YlR6Yp0CnDua8OryMhpMl0JtM=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xS2PI-000000000wQ-3etv
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 01:18:17 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8b600fae14dso907712b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794619091; x=1795223891; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/NJq1tNVgAxL0JcudyOin08tnS8RNWNKJF+n6CZo2GE=;
 b=IvwEiiRKHQ0OYXTjWxBI5A6IWrj2D1ZZ43hLrKyn4vsjrtE9a+cAN202H4ZT2XawZd
 EODrxy7xWViaif5MCTn7xTsVsm0Gy9vgLihK0zW3P7mDkAjAg+L3I+t+LTei7JL5Lde6
 AlVjIoJAjYF9Bb4eBRPxZ5A3oOgB6iZE8YiCS8eSeyILHsVGP0eIEkpSfy9QEKnX242O
 /kdcy4DmGR+/YWq18VUwRkP59PvHRHP2hoH70tTFSetvkg1zWHFKngLwhL2T1eCp+Ahf
 2knjWReI9BAuNhoJoWrAQp68BGwN3XKt3h/HeHltPtaIKKHsKjrToJZAIG0MDFy8Lbaa
 OdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794619091; x=1795223891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/NJq1tNVgAxL0JcudyOin08tnS8RNWNKJF+n6CZo2GE=;
 b=l1wefFzeuZ5AxigM5R04h8jV4nAmG07agvc/mDWV6Fkvc+X11q3ONc10LvOH8tmI/W
 C6zxZqrTxI5IsjpttZ+lb5KXx1Sv19mBH1tQuDFvYb97c870eYLwcce6Gs5bbbuvETQT
 BV/BorvqC2mg9hLWXuT0tkItXT0J/GJmwQp+/FG2DLvDrwZ6ojiFUAz/+4ujSGCNCfE7
 qNVRN5emAcb+zmrpmpL6vyOuXqreHgwL6D67PFzOeIYWj2PEQvwJDG6BFeGj7NyGkREu
 sbavLj5vnjBKxj32KiGWnkhbXiQH/Lypz3+CxQ41AWDqAPqTteJMn9+5slQfEdPrV0wS
 uMtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHcCxAED4Y/72noonNNhx/dabNXwvVXm+/fXRzNSK6vR8AuZa4KmAP6YO1edrR95I97SpQjU/2H2pe73/RurEGe@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+SMs7Nce1Cb89cbA00+olc6zISQhH8OqakiHG9Rx5ZK0l3Tvba
 ivJeRsXNI3cexj8ll+IBsoh5BWyH+x0mAIajPdaeDMV3ZOCESZNoCq2A
X-Gm-Gg: AYBFou25qRQZ0OIpMuKzoCRaXKU5ubXZiTBO+eIWBRy+nzsaJB69wtolvqMVkiJ0eRk
 b2TbtEttJPLGicVTBbhDweH06HPUqT45aK7PsC/4r/UTiLAkYNwqUAk8TSs94rMnZ8K9P65hD5N
 1By6YYiXpExP051T2rf4gMpMJVKpYXNUzBri9Yx+DuRQLSY4xNIX8OrYwkEzkIY4Zcu0m7GCAJ7
 mOU2A7uwqG6Bn0N+1G5wASoISoryix2Y7YAzhT9OWx/F6UgQ9ApA6bUi+syJAKa3vTEYF5XQO+c
 1hfOn2Kr726qVhDIOqLOBGPCipVakEp8b14gzR3ITAMf5aVA0MA1fePWYco7cFgNWX5UMeLkNAI
 J9akGQKlbfNb2oKl2xA8H8TPukeI05DgUnvyGpn9uh6tWZMhou+nj1cGo++yA5bCiwAW9DbztUS
 I20kjH7T3Z2UR4t4XF/5OZ1fkDzBOUHViV0hAJCp8alNZqTh4c3mFhh365DjbASQuvKFoWY5XuE
 RCkraPWUnhSizNNQYMdXYc3muaMplNOtwnvuBDqynaBJQCXJVunQwRJZwK6KGFaHq5zhwFnxxnV
 Ur0+0c2SpsThL+xV53BkeSM8eCR9IwRs6gCtEKuVB0CXF+RWuiF/eyC+DvcWeqFPw3C/luh8H1z
 mnDsHJoOD5xScx1iplZalFyePmMmQ9s1fU4tnGA99IX34sY8=
X-Received: by 2002:a17:903:3d10:b0:2e9:401f:f0f8 with SMTP id
 d9443c01a7336-2ee0dd2c33emr40369315ad.53.1794619091051; 
 Fri, 13 Nov 2026 17:18:11 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee228b2581sm7755715ad.63.2026.11.13.17.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:18:10 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 13 Nov 2026 17:18:07 -0800
Message-ID: <20261114011807.3811774-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xS2PI-000000000wQ-3etv
Subject: [f2fs-dev] [PATCH v3] f2fs: reserve space to be shrunk during
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
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
current_reserved_blocks via sysfs. Otherwise, the reserved blocks can
take the space which is already reserved, and the second check fails.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
This patch depends on "f2fs: avoid underflow in
get_available_block_count()", which is sent separately.

v2: https://lore.kernel.org/linux-f2fs-devel/20261022165526.1539629-1-daeho43@gmail.com/

Changes in v3:
- Rebase on top of the patch above. In the case from the v2 review
  (user_block_count = 1000, root_reserved_blocks = 100, valid = 30, resize
  reserves 500, then 500 is written to reserved_blocks),
  current_reserved_blocks becomes 470. The reservations add up to 1070 for
  a user who cannot use the root reserved blocks, so that user gets 0
  instead of a wrapped value. Root gets 30, which equals the valid blocks,
  so the second check still passes.
- Update the comment in the sysfs hunk: the reservations are excluded so
  that the second check does not fail, not to avoid the underflow.
- Rebase onto the latest dev-test.

Changes in v2:
- Exclude alias/resize reservations from current_reserved_blocks.
- Allow root reserved blocks in the second check, with WARN_ON_ONCE().
- Recheck DISABLE_CHECKPOINT after freeze_super().

 fs/f2fs/f2fs.h  | 19 +++++++++++++----
 fs/f2fs/gc.c    | 54 ++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/super.c |  1 +
 fs/f2fs/sysfs.c | 11 +++++++++-
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 59bc3c2fb70a..d9cf2d4fae21 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1920,6 +1920,7 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 	block_t alias_reserved_blocks;		/* reserved blocks for device alias */
+	block_t resize_reserved_blocks;		/* reserved blocks for resize_fs */
 
 	/* Additional tracking for no checkpoint mode */
 	block_t unusable_block_count;		/* # of blocks saved by last cp */
@@ -2707,13 +2708,14 @@ static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 	return false;
 }
 
-static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
-						struct inode *inode, bool cap)
+static inline unsigned int __get_available_block_count(struct f2fs_sb_info *sbi,
+						       bool allow_root)
 {
 	u64 reserved = (u64)sbi->current_reserved_blocks +
-					sbi->alias_reserved_blocks;
+					sbi->alias_reserved_blocks +
+					sbi->resize_reserved_blocks;
 
-	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !allow_root)
 		reserved += F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
@@ -2726,6 +2728,15 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	return sbi->user_block_count - reserved;
 }
 
+static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
+						     struct inode *inode,
+						     bool cap)
+{
+	bool allow_root = __allow_reserved_root(sbi, inode, cap);
+
+	return __get_available_block_count(sbi, allow_root);
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 337ecf4df945..7609c23ec27b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2420,6 +2420,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	struct f2fs_lock_context glc;
 	struct f2fs_lock_context clc;
 	unsigned int secs, old_tail;
+	bool reserved = false;
 	int err = 0;
 	__u32 rem;
 
@@ -2471,10 +2472,17 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
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
@@ -2488,29 +2496,45 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
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
@@ -2559,5 +2583,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
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
index 78dbf1e92285..f5966ae2d11b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5414,6 +5414,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
 	sbi->alias_reserved_blocks = 0;
+	sbi->resize_reserved_blocks = 0;
 	limit_reserve_root(sbi);
 	adjust_unusable_cap_perc(sbi);
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 430356e500af..8ab9a5098f1c 100644
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
@@ -601,8 +603,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 		}
 		*ui = t;
+		/*
+		 * Exclude the space reserved for device aliasing and resize_fs,
+		 * otherwise the reserved blocks can take it and make them fail.
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

base-commit: b9d7379d10d43386b59082da8c9a0b111e054781
prerequisite-patch-id: 5b947a4267506336d2083e4b20686c7c39a4233e
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
