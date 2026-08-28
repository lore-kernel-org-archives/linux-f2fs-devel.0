Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2E5C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2Y8viitU03T9PZkI72lYQLJbL28u3vT1goGozOhc74=; b=TglzKYGA6CIJ/lhTJ8r/o6o0Hb
	HelTwhJ6Nz8EA6Eg9mBMruMk2yLXRRXVJKhK31IFUTBgmxmeLvjGVHxDRZAR0aC83yrlQrRh/Ju1n
	MlDve7Wlj2TryXym4jyA91VS7pJrWAjFe/hoGjP5VAk4AOOCBvTBzqNoSvd2KJhqNk4o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzqtL-00026f-3g;
	Fri, 28 Aug 2026 07:20:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jeuk20.kim@gmail.com>) id 1wzqtI-00026Q-68
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpJQdL71fncq3A1DKuUk0L7Wkeu7zNdyUOmsnNXN+mE=; b=K/7ojFG5Uw5mwQBjAWNJwbDgGF
 qAGFoT1aLhehlkgNrxQsi8n5nWYCwnJTsGKInNBIMBIxzW73JfNToHR6n7GG7VzQQKyNGCnjmGbrE
 8BcuxGPIZbdiYZDvblovd+SH+MnfeNIj9WbGBTB/Vc/3gxB3tbth2rWnAFwxyr76heG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vpJQdL71fncq3A1DKuUk0L7Wkeu7zNdyUOmsnNXN+mE=; b=YiyeBeXR+mRFs3u48HbcF1S/nw
 ES9Kf+39b4kjd7wT0nJ7Xq5906/VAekoxYe9WxOJpIgfeWM7grJhRFqL/zeqjDwcs9NkFNQd5vCY4
 3Q8FZQ0+XCxBBMeWPV+9t3CKeFxidfLob9ZG5+MKP0fqOwXw3R0FO2l2VFynMvo3D0l0=;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzqtI-000317-5B for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:44 +0000
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d6f55a7089so5729615ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787901638; x=1788506438; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vpJQdL71fncq3A1DKuUk0L7Wkeu7zNdyUOmsnNXN+mE=;
 b=mQScVVwombnjOLKkMxo4y/FhFw3tyuzIgKvQj9e7tvQrV6yNf2CN/W9WxqiphgODtE
 tKhKciMV3KyS+DlaepCL+GDGrWjzJCXfRtpCSZCB/j+k0nmbWSgf5cljgvrX1ZNnE8WC
 oignXXbhCikwV56ZaG2ANwxFx1x6yh7iHx6xNa94bNWokZYZi9FieAHRDyLybokK4KAk
 8D0UTjib7fsbDbZ8p5WqdAHQC6fnMBgpxM1TD3rVpE5apIscSlk4Tngrfb7/vrQ/zxff
 XJ8Ey3tPDYgL0rHLy5kHXchvhkQHFRVfSRSlQegbIoK/W5OQLmKJuTLWYtq+/8ihGrZW
 ewnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901638; x=1788506438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vpJQdL71fncq3A1DKuUk0L7Wkeu7zNdyUOmsnNXN+mE=;
 b=IggeQ7ZmXsqzPazZ/T7lmwm8P1ZEC+Y8444mkWZcBXl6+9xDg+7qOFDVawk1VIUcI0
 C+laPCXIqAwmfLl6CqSReXLcts98mOtJD0IGcECA4MIAbK3cW1PIcI3+H0SIEtmS0nxt
 V9Ejppf5//itQAIeC4rcad/5A9bR21804P9NFeUUOcKrdgSWRTMh3c+pIxbcCZebi3OG
 5K9NcKSp+vU6hnTcC8Z9FKgcZ50O2/nFTBFycVNjyioW2uZVICJbWrj8Q7yEUF4xqud7
 YcNuXPzz5xyKNzXqdPE2eytL0Wqe+i0qjUVc1vdpniHGpDrMTc5cMQvpSBzhoa/wMWuz
 FysQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6kD4QCjQ09+gEaDgbL0IQvu/4w/SMPPTg3jt3PtyGhbzlI4pFFFUGFjvu7wXT9LCYsJqRyEpQvtnuTqgSo+PG@lists.sourceforge.net
X-Gm-Message-State: AFuF++mFlUOSP+GtDQL1oWVE5tXdXZf+o0lHZNtWt+1FuqaBaQkUHBvX
 Ou/KFi6gCsuQqXQlk97XrKVPB+eUGYdt6tfyAEhOBvrGJDD9zyIgsckj
X-Gm-Gg: AR+sD10uFEv3Oh5lOeGlSh/ph0iDjd9RXptPXXIU+pWXVDx5WydZ2HnGPQPeFfBiogj
 9B7wL9UvPiEV8BYfIoPolevZ50h6ayQDF8f8gbXyvK/Uk0fKLH6q2hirrhKbII1387OIOZPiB18
 f807gUQ8ecvap2uKsIUCeUmUhm8u7vAq4Qxz155lEKlxDmmQnhc9U19e7VOBrkWXn9e2g3gkRy8
 YURzHZG0TLoPpY0SebKoaprBmTNhDr+rhh0hhQD1EOOWoiVgC19AzK0KEINAQN70xR/16si8Wio
 6oZulwf1ZbrTzovY+HoG2cyquPmIbM8tBZuprNX7OaNvJ6lsJeBghkKDIkkV7g4QtgT6bPTuh18
 5RAmyMpJRgJZPoM0PQeSn8Qw42fmzpZxPevBLzHhWXaNSfN0G/OSLfg+a58IWUbmpIRelAIBgsc
 sKqURbIJgSIP/8YTJTtAPDrHb6T2RpEs6gIauFyYTK695u8jTNk/se6FEYMJZtC9W/Zc2kcvm2N
 ew5jg==
X-Received: by 2002:a17:90b:380a:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-396d0daf810mr9330220a91.5.1787901638253; 
 Fri, 28 Aug 2026 00:20:38 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm6123731a91.4.2026.08.28.00.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:20:37 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 28 Aug 2026 16:20:17 +0900
Message-ID: <20260828072017.44569-4-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828072017.44569-1-jeuk20.kim@samsung.com>
References: <20260828072017.44569-1-jeuk20.kim@samsung.com>
MIME-Version: 1.0
X-Headers-End: 1wzqtI-000317-5B
Subject: [f2fs-dev] [PATCH 3/3] f2fs: add ioctl to force out-place-update
 per file
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
Cc: yunjae00.jo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Yohan Joung <jyh429@gmail.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Out-place-update can only be enabled for an entire filesystem, via the
"mode=lfs" mount option or the ipu_policy sysfs entry. There is no way
to force OPU on a single file. Add F2FS_OPU_FL and
F2FS_IOC_{SET,GET}_OPU_FILE to control OPU on a per-file basis.

Reject OPU for pinned, swap, and device-alias files because they require
stable block addresses. The flag forces OPU without enabling LFS mode,
so block allocation may still use SSR.

The flag is kept in the on-disk i_flags word, so it survives umount and
inode eviction. An older kernel preserves the bit but ignores it and
applies its normal update policy to the file.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 fs/f2fs/data.c            | 25 ++++++++++----
 fs/f2fs/f2fs.h            |  9 ++++-
 fs/f2fs/file.c            | 69 +++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/f2fs.h |  2 ++
 4 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 618e6fc2da0c..2babfcf1dae5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1639,12 +1639,13 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	unsigned int start_pgofs;
 	int bidx = 0;
 	bool is_hole;
-	bool lfs_dio_write;
+	bool opu_dio_write;
 
 	if (!maxblocks)
 		return 0;
 
-	lfs_dio_write = (flag == F2FS_GET_BLOCK_DIO && f2fs_should_opu(inode) &&
+	opu_dio_write = (flag == F2FS_GET_BLOCK_DIO &&
+				f2fs_should_opu(inode) &&
 				map->m_may_create);
 
 	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag)) {
@@ -1685,7 +1686,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 next_dnode:
 	if (map->m_may_create) {
-		if (f2fs_lfs_mode(sbi))
+		if (f2fs_lfs_mode(sbi) || f2fs_is_opu_file(inode))
 			f2fs_balance_fs(sbi, true);
 		f2fs_map_lock(sbi, &lc, flag);
 	}
@@ -1715,9 +1716,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		goto sync_out;
 	}
 
-	/* use out-place-update for direct IO under LFS mode */
+	/* use out-place-update for direct IO under LFS mode or on OPU files */
 	if (map->m_may_create && (is_hole ||
-		(flag == F2FS_GET_BLOCK_DIO && f2fs_should_opu(inode) &&
+		(flag == F2FS_GET_BLOCK_DIO &&
+		f2fs_should_opu(inode) &&
 		map->m_last_pblk != blkaddr))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
@@ -1804,13 +1806,13 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		if (map->m_multidev_dio)
 			map->m_bdev = FDEV(bidx).bdev;
 
-		if (lfs_dio_write)
+		if (opu_dio_write)
 			map->m_last_pblk = NULL_ADDR;
 	} else if (map_is_mergeable(sbi, map, blkaddr, flag, bidx, ofs)) {
 		ofs++;
 		map->m_len++;
 	} else {
-		if (lfs_dio_write)
+		if (opu_dio_write)
 			map->m_last_pblk = blkaddr;
 		goto sync_out;
 	}
@@ -2862,6 +2864,9 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
 	if (f2fs_is_pinned_file(inode))
 		return true;
 
+	if (f2fs_is_opu_file(inode))
+		return false;
+
 	/* if this is cold file, we should overwrite to avoid fragmentation */
 	if (file_is_cold(inode) && !is_inode_flag_set(inode, FI_OPU_WRITE))
 		return true;
@@ -2899,6 +2904,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	if (is_inode_flag_set(inode, FI_OPU_WRITE))
 		return true;
 
+	if (f2fs_is_opu_file(inode))
+		return true;
+
 	if (fio) {
 		if (page_private_gcing(fio->page))
 			return true;
@@ -4357,6 +4365,9 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (f2fs_is_opu_file(inode))
+		return -EINVAL;
+
 	if (f2fs_lfs_mode(sbi) && !f2fs_sb_has_blkzoned(sbi)) {
 		f2fs_err(sbi, "Swapfile not supported in LFS mode");
 		return -EINVAL;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e85d4db3a401..79f3f365432a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3322,6 +3322,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define F2FS_OPU_FL			0x01000000 /* File always uses out-place-update */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 #define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */
@@ -3598,6 +3599,11 @@ static inline bool f2fs_is_pinned_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_PIN_FILE);
 }
 
+static inline bool f2fs_is_opu_file(struct inode *inode)
+{
+	return F2FS_I(inode)->i_flags & F2FS_OPU_FL;
+}
+
 static inline bool f2fs_is_atomic_file(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
@@ -4944,7 +4950,8 @@ static inline bool f2fs_should_opu(struct inode *inode)
 	if (f2fs_is_pinned_file(inode))
 		return false;
 
-	return f2fs_lfs_mode(F2FS_I_SB(inode));
+	return f2fs_lfs_mode(F2FS_I_SB(inode)) ||
+		f2fs_is_opu_file(inode);
 }
 
 static inline bool f2fs_is_sequential_zone_area(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 37d4e5c8dbcb..09731ad05d70 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3558,6 +3558,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto done;
 	} else if (f2fs_is_pinned_file(inode)) {
 		goto done;
+	} else if (f2fs_is_opu_file(inode)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (F2FS_HAS_BLOCKS(inode)) {
@@ -3606,6 +3609,62 @@ static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
 	return put_user(pin, (u32 __user *)arg);
 }
 
+static int f2fs_ioc_set_opu_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	__u32 opu;
+	int ret;
+
+	if (get_user(opu, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+
+	if (!opu) {
+		/*
+		 * Direct writes issued while the flag was set may still be in
+		 * flight with their blocks unwritten, so drain them before
+		 * f2fs_file_read_iter() stops serializing against them.
+		 */
+		if (f2fs_is_opu_file(inode))
+			inode_dio_wait(inode);
+		fi->i_flags &= ~F2FS_OPU_FL;
+		goto done;
+	}
+
+	if (f2fs_is_pinned_file(inode) || IS_DEVICE_ALIASING(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fi->i_flags |= F2FS_OPU_FL;
+done:
+	f2fs_mark_inode_dirty_sync(inode, true);
+	f2fs_update_time(sbi, REQ_TIME);
+out:
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+	return ret;
+}
+
+static int f2fs_ioc_get_opu_file(struct file *filp, unsigned long arg)
+{
+	return put_user(f2fs_is_opu_file(file_inode(filp)) ? 1 : 0,
+			(__u32 __user *)arg);
+}
+
 static int f2fs_ioc_get_dev_alias_file(struct file *filp, unsigned long arg)
 {
 	return put_user(IS_DEVICE_ALIASING(file_inode(filp)) ? 1 : 0,
@@ -4740,6 +4799,10 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_dev_alias_file(filp, arg);
 	case F2FS_IOC_IO_PRIO:
 		return f2fs_ioc_io_prio(filp, arg);
+	case F2FS_IOC_SET_OPU_FILE:
+		return f2fs_ioc_set_opu_file(filp, arg);
+	case F2FS_IOC_GET_OPU_FILE:
+		return f2fs_ioc_get_opu_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4936,8 +4999,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	dio = f2fs_should_use_dio(inode, iocb, to);
 
-	/* In LFS mode, if there is inflight dio, wait for its completion */
-	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
+	/* For OPU direct writes, wait for any inflight dio to complete */
+	if ((f2fs_lfs_mode(F2FS_I_SB(inode)) || f2fs_is_opu_file(inode)) &&
 	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
 		(!f2fs_is_pinned_file(inode) || !dio))
 		inode_dio_wait(inode);
@@ -5522,6 +5585,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_COMPRESS_FILE:
 	case F2FS_IOC_GET_DEV_ALIAS_FILE:
 	case F2FS_IOC_IO_PRIO:
+	case F2FS_IOC_SET_OPU_FILE:
+	case F2FS_IOC_GET_OPU_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 795e26258355..ebfef7e88bcb 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -45,6 +45,8 @@
 #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
 #define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
+#define F2FS_IOC_SET_OPU_FILE		_IOW(F2FS_IOCTL_MAGIC, 28, __u32)
+#define F2FS_IOC_GET_OPU_FILE		_IOR(F2FS_IOCTL_MAGIC, 29, __u32)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
