Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E8C61DC6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UDHOvYedG9buPoOmgHb41vp6a1JnYv/zkmHAO3CFh4=; b=bWVY7TyyHP6Ls0W50VW4AfWRaq
	xVDAZqC8XojqYRxC2Z9I93uppel2iQZ+fBOXhZEJyiJtkYp//5ItIzzU42NRPVNa+6XiitfKy3d+G
	91eN0GnTvi4In/Z80KL8yJ5RxoJXEQbGNW9QzFZoPzSPtZRKYLQqdyUe25y7tUq8tApk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzFbL-0002FS-LH;
	Wed, 26 Aug 2026 15:31:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzFbK-0002FJ-HM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NFQ51HJ7fyE1u0r/xRDp9ewL6yDSIMejUbH85HRUqXg=; b=bW8nYQJakxCM0fu6MWWaT4VJfF
 IZUekH0Ok0olTksW9DDS17LAcCV4ntpNiRIf4KWrn3OggitnSXsjcHsn5Qh8KRLbGEJAtJTR2DVxR
 k9oPPAGFb3PLIvWi2f7NVvpqRBIKMvG/r5cOyIFbS7Scgvb5E2g1ROzgU6NT5IC5D14c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NFQ51HJ7fyE1u0r/xRDp9ewL6yDSIMejUbH85HRUqXg=; b=ZJmHFi9b+tRCZJxfvmA3gmLZm0
 rEoTjuu1r2lGve92aYkfX+mRVqY+Z4wqcVjjO9jC9ZtUpqBYL12fTvMEHYTHtK5ejW4QCOhobYgtz
 7MK455UCZKTRSCo4WShBuGlAZJQIv2T1PV/Up0d/G511iukjWtze2m7FfckKJF5p5rfE=;
Received: from mail-oa1-f50.google.com ([209.85.160.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFbJ-0007T5-79 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:31:42 +0000
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-43bf9548df4so1376253fac.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787758295; x=1788363095; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NFQ51HJ7fyE1u0r/xRDp9ewL6yDSIMejUbH85HRUqXg=;
 b=PHThkFGlXeE5mJsgBR8DJfSLYXmWkG0aRIMDQEvDsR73OTfguY763qYABFVURqPz0s
 N6+ktoZfvZZEvKgbHH6NwHDlcVjti4a78P2EV7GC23fAOoDXVyihZnMXEuDTc4QSzWUW
 oKu/zt0aHhb14MbQYQSlExi8DTEyY8Gph8WtjtZLbpk4qn7uz11m/bO4vaQipJBhPxL5
 tFbwTNAdyrXrmxDAFan1hHXPy7j21nYpo/hQ5t+9dBkoBZVu/6bRZbjXmycwqFY1n5Z8
 Q3s/kEQ7YuVnxAHLsgbDnYl5RKrPETn0ZNkBjRElX5bt6WdtvKlaY6pXXHJ+lf+xVEyh
 U5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758295; x=1788363095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NFQ51HJ7fyE1u0r/xRDp9ewL6yDSIMejUbH85HRUqXg=;
 b=nYLGV7MIrq/KDl3IBDJ8kGlEZqckpJYzJy6PD8ma35gMdLfeIaBizmvcm4/6T0B32C
 eJDfPopJF4qKWZYdq0Dg+Ile1m9hz93oROCbsR5qmQ4uRFA/U2IyhLOFaXXyGicHx0p6
 XgrDrIwhgX715K4Cyw7krfdO8toF9KrrxfXgjmQDgTgKR8x8J16Xno4FiDXnlylLS/Mu
 Dx1qhLL1q+nIRis47KtbngtaM6xe1idAlK4xomHRxhw1itbzgQoWj6U0k1IAollixhlx
 hSrxE7oNNlisBBDHwSn7nczWbUJ8NwMEZ5Dhp6oQk63/wxy291DSvaZ8cXnLtpQs+fak
 DS9A==
X-Gm-Message-State: AFuF++mJgIz00fUKMXDWBQ+M53cSuSJuQw6WjuR42f7bFM7MfW39kT6o
 8RYNBo10P7f4ZNlKFK6UkPFCLV11XzOYBxbFCceCBgsHbAL8qdelCx6PyoC1SANw
X-Gm-Gg: AR+sD13BHcXMcBaXUBOPYpnuX+JlBMq4iFbLs13jgxSvgZIGOj3PJ/RasjlL5RgP/bi
 EjKmNpccpSM5qDUtRrHdSsBTCgCzBe8rinUGgmb4+BLJ1xS8+PZbKcLsEsMqH+hoLy55FQD0Xpd
 Ik1fcQbQ1N9GKK3cL+GRR/m587JyaQ5Pbe/bOr8s8bwV24YRrhCc5jh1ZWFfvv54TSWuUg/hBx0
 XUSCbM5UaoAi7x+DIHTnqjWfOTxEI/1j7ldashyc72VPC/2lGoXLSVIJpFFAynGrlUIqzQruqoG
 1eCTNoWQYMwAc3+oXpgEOvOoBlO1IYmb3weQwmZG/goFHtU0ld1GO0nN45h7+4x8ZUIy3zUcvqG
 4cNFG+nyUdVD1xN4m2kJLSh1BVS5InQu6+k3URwpPTHpTNRmeVPp78isk5me9TJDvnwrr4I/QFb
 HxfSjFxKsGyYwqqhCo8nIq3kcE0nwL0DVAtx/Rb+GQXq8Ouo7E3d/6pkRJw8USZXnwbhtjb49DQ
 WSwVt9CvFSSUvdCERHpARAChKT6apRuGgo=
X-Received: by 2002:a17:90a:d2ce:b0:393:1d92:db5 with SMTP id
 98e67ed59e1d1-3966d3dc5ecmr15674934a91.10.1787751697387; 
 Wed, 26 Aug 2026 06:41:37 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d69065sm8906472a91.13.2026.08.26.06.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:41:36 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 26 Aug 2026 21:41:25 +0800
Message-ID: <20260826134126.3729507-2-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
References: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wzFbJ-0007T5-79
Subject: [f2fs-dev] [PATCH 1/2] f2fs: persist device alias inode across
 remount
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A released device alias loses its extent. Reserve then identifies the
target device by matching the alias filename against the device basename,
which fails when mkfs used a custom alias name.

Store each alias inode number at its device index in the superblock
reserved area. Record the mapping before releasing blocks and use it to
identify the device during reserve. Reject conflicting mappings and keep
the basename lookup for images without a recorded mapping.

Leave released alias inodes without an extent so existing fsck does not
account the freed device range as live blocks.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/file.c          | 96 +++++++++++++++++++++++++++++++++++------
 include/linux/f2fs_fs.h |  3 +-
 2 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d440231b8cb9..7f1dc00031ba 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3725,25 +3725,44 @@ static int f2fs_ioc_get_dev_alias_file(struct file *filp, unsigned long arg)
 			(u32 __user *)arg);
 }
 
-static bool f2fs_get_dev_alias_extent(struct f2fs_sb_info *sbi,
-				       struct dentry *dentry,
-				       struct extent_info *ei)
+static int f2fs_get_dev_alias_index(struct f2fs_sb_info *sbi,
+				    struct inode *inode,
+				    struct dentry *dentry)
 {
+	int devi = -ENOENT;
 	int i;
 
+	f2fs_down_read(&sbi->sb_lock);
+	for (i = 0; i < MAX_DEVICES; i++) {
+		if (le32_to_cpu(sbi->raw_super->dev_alias_ino[i]) !=
+							inode->i_ino)
+			continue;
+		if (!i || i >= sbi->s_ndevs) {
+			devi = -EFSCORRUPTED;
+			goto out;
+		}
+		if (devi >= 0) {
+			devi = -EFSCORRUPTED;
+			goto out;
+		}
+		devi = i;
+	}
+	if (devi >= 0)
+		goto out;
+
 	for (i = 1; i < sbi->s_ndevs; i++) {
 		char *name = strrchr(FDEV(i).path, '/');
 
 		name = name ? name + 1 : FDEV(i).path;
 		if (strcmp(name, dentry->d_name.name))
 			continue;
-
-		ei->blk = FDEV(i).start_blk;
-		ei->len = FDEV(i).total_segments << sbi->log_blocks_per_seg;
-		ei->fofs = 0;
-		return true;
+		devi = sbi->raw_super->dev_alias_ino[i] ?
+						-EFSCORRUPTED : i;
+		break;
 	}
-	return false;
+out:
+	f2fs_up_read(&sbi->sb_lock);
+	return devi;
 }
 
 static int f2fs_ioc_reserve_dev_alias(struct file *filp)
@@ -3756,7 +3775,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	struct f2fs_lock_context lc, glc;
 	blkcnt_t count;
 	unsigned int start, end;
-	int type, err;
+	int devi, type, err;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3780,7 +3799,8 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 		goto out_inode_unlock;
 	}
 
-	if (!f2fs_get_dev_alias_extent(sbi, filp->f_path.dentry, &ei)) {
+	devi = f2fs_get_dev_alias_index(sbi, inode, filp->f_path.dentry);
+	if (devi < 0) {
 		f2fs_warn(sbi, "device alias file (%s, ino=%llu) has no matching device",
 			  filp->f_path.dentry->d_name.name,
 			  (unsigned long long)inode->i_ino);
@@ -3790,6 +3810,10 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 		goto out_inode_unlock;
 	}
 
+	ei.blk = FDEV(devi).start_blk;
+	ei.len = FDEV(devi).total_segments << sbi->log_blocks_per_seg;
+	ei.fofs = 0;
+
 	spin_lock(&sbi->stat_lock);
 	if (sbi->total_valid_block_count + ei.len >
 			get_available_block_count(sbi, inode, true)) {
@@ -3801,7 +3825,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	spin_unlock(&sbi->stat_lock);
 
 	spin_lock(&FREE_I(sbi)->segmap_lock);
-	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = true;
+	FDEV(devi).is_reserving = true;
 	spin_unlock(&FREE_I(sbi)->segmap_lock);
 
 	start = GET_SEGNO(sbi, ei.blk);
@@ -3853,7 +3877,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	f2fs_update_inode_page(inode);
 
 	spin_lock(&FREE_I(sbi)->segmap_lock);
-	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = false;
+	FDEV(devi).is_reserving = false;
 	spin_unlock(&FREE_I(sbi)->segmap_lock);
 
 	f2fs_unlock_op(sbi, &lc);
@@ -3870,7 +3894,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	spin_unlock(&sbi->stat_lock);
 
 	spin_lock(&FREE_I(sbi)->segmap_lock);
-	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = false;
+	FDEV(devi).is_reserving = false;
 	spin_unlock(&FREE_I(sbi)->segmap_lock);
 	f2fs_up_write_trace(&sbi->gc_lock, &glc);
 
@@ -3880,6 +3904,44 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	return err;
 }
 
+static int f2fs_record_dev_alias_inode(struct f2fs_sb_info *sbi,
+				       struct inode *inode, int devi)
+{
+	__le32 old_ino;
+	int err = 0;
+	int i;
+
+	f2fs_down_write(&sbi->sb_lock);
+	old_ino = sbi->raw_super->dev_alias_ino[devi];
+	if (old_ino && le32_to_cpu(old_ino) != inode->i_ino)
+		goto conflict;
+
+	for (i = 0; i < MAX_DEVICES; i++) {
+		if (i != devi &&
+		    le32_to_cpu(sbi->raw_super->dev_alias_ino[i]) ==
+							inode->i_ino)
+			goto conflict;
+	}
+
+	if (!old_ino) {
+		sbi->raw_super->dev_alias_ino[devi] =
+						cpu_to_le32(inode->i_ino);
+		err = f2fs_commit_super(sbi, false);
+		if (err)
+			sbi->raw_super->dev_alias_ino[devi] = old_ino;
+	}
+	goto out;
+
+conflict:
+	f2fs_warn(sbi, "conflicting device alias inode mapping for device %d",
+		  devi);
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	err = -EFSCORRUPTED;
+out:
+	f2fs_up_write(&sbi->sb_lock);
+	return err;
+}
+
 static int f2fs_ioc_release_dev_alias(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
@@ -3888,6 +3950,7 @@ static int f2fs_ioc_release_dev_alias(struct file *filp)
 	struct extent_info ei = {0, };
 	struct cp_control cpc = { CP_SYNC, 0, 0, 0 };
 	struct f2fs_lock_context lc, glc;
+	int devi;
 	int err;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -3920,6 +3983,11 @@ static int f2fs_ioc_release_dev_alias(struct file *filp)
 	ei = et->largest;
 	read_unlock(&et->lock);
 
+	devi = f2fs_target_device_index(sbi, ei.blk);
+	err = f2fs_record_dev_alias_inode(sbi, inode, devi);
+	if (err)
+		goto out_inode_unlock;
+
 	f2fs_down_write_trace(&sbi->gc_lock, &glc);
 	f2fs_lock_op(sbi, &lc);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bb2b6cd5d507..2130bacdbe93 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -158,7 +158,8 @@ struct f2fs_super_block {
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
 	__u8 s_stop_reason[MAX_STOP_REASON];	/* stop checkpoint reason */
 	__u8 s_errors[MAX_F2FS_ERRORS];		/* reason of image corrupts */
-	__u8 reserved[258];		/* valid reserved region */
+	__le32 dev_alias_ino[MAX_DEVICES]; /* device alias inode numbers */
+	__u8 reserved[226];		/* valid reserved region */
 	__le32 crc;			/* checksum of superblock */
 } __packed;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
