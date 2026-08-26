Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF60C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yf8YbBx/VTluPrYm07fRUcOWllTiAAg4/laycTeb4qg=; b=Ed+vDKtKptFS15OUfrrAAhPakX
	atDKDqsGhm0HKMVqkiK0vDSvX1jSzJn+Uy5i41xNbD1ZSbkFZZx2fGglJZXkbBGCBVa1KxUTt5fH+
	k0z7PMAi3KWjeEhko8XENlPdDY9khYgq31YWJ9wmC0tkOxBW/xJIG/g7FYthIAfMykcM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzFhb-0000fb-NY;
	Wed, 26 Aug 2026 15:38:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzFha-0000fU-AJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eNt0yaNbWkmDvlN5726CptDGSbQ5oBacQBTHAIzZvf4=; b=enCz3pbq6dTC/1Xfr/eDFqOZEt
 6pFCCh/4Hg4AlYNHCRL87Ayu3UB63algp9uLUsqnIopid4hkrbibCB/AhXXKT4GN8674t0q0XV8zF
 iVGcd04q6jw9BEB9xVStZz6ogselgNJrLopVdBx7Ue51UVuhzjLGXezVrQmEyeOSXDIE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eNt0yaNbWkmDvlN5726CptDGSbQ5oBacQBTHAIzZvf4=; b=kyOAToWnFzE7nGCf4WjIJNFhmg
 RGUTDoIUt++WthxQK01pkCCwg+3m63L5Cnl4q1RawEPtF3AvNCQJ+6DEu1ac7zW845+htuz2iw/CR
 f+6uXLVrcUbhD80Jgq7v8w5Map0hn5MyRVWvfAuYUL7wfjlaJjIvfcDs1LqrxsysgwN8=;
Received: from mail-yw1-f170.google.com ([209.85.128.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFhU-0008Q4-QA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:38:07 +0000
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-836ce5d6e85so17231377b3.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787758679; x=1788363479; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eNt0yaNbWkmDvlN5726CptDGSbQ5oBacQBTHAIzZvf4=;
 b=L0k5Q38EJY5GwDk6tJY5EL1GXs3vmueLNAxjO2NdxKWUdAlqNSig/+htW3IVmX6Atd
 oYbX2sqchH14uS+jz/bvcC/hLgq7ul61fM7B3oCYsxFf9uVnMkpAV9IBPLb2xErNwrd2
 jLXmwHvM8GJU4Qw/hzzcJmhbx6w2nv/W42UEdwhUz9436j0MCHcouPH1zzKcVfOmTzbI
 l78EYzmXkUpWwxAV3B5QlWRLZWpaTqK6rH6X/eIZ6fmJd4S3VwwfwDsZGRNBAIi8WCuY
 Yk2BkKW7as7yNgM4mYXcGaqFe7NbOkO6bCW7N2blObiIIlaipV7ftAyssT3Et9e0+xkQ
 xP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758679; x=1788363479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eNt0yaNbWkmDvlN5726CptDGSbQ5oBacQBTHAIzZvf4=;
 b=AjgNTH+yIjU0zlzCeQma0OUDpK2NC9hi1zdiYmb//s3Jwjx1Vc3hP6U37ecDsaKoJc
 ym4d9OmnJe7OuT8KNKPd0oitaCqRoQTo0TPM/ahyVCTyFdMCM6uIXWHU1i/Cgr7D+Mxo
 lhu2icAROx/PORjdC50l8v8Jf72m0usOfvZFtoyxh14nY+J3S6R/ofHkOkdMwrWb41ZB
 n0ljs1GAuL36AO+F59hyy0AgGo8uDDX3ammKgvP2+4K7TmmpPQGxg+qtkTaTPl1OaK6v
 AStdDNF15o1eWFtfzxha5vEXyK5Dz/yn97BGm3+5rEinhoxt6F8BtuFDcCIbDNy4QFlw
 SXuQ==
X-Gm-Message-State: AFuF++nGyW0gAP9NGeySMU6ehUS5+82c9SqMsS7N9cWPJLhX7J/hp2Vf
 +McRDgxf2W/PPLVL+wK3xFIvsFFjnbnm5Hmsv4zxekLDxHSU6jZ9OTalMIusWlk0
X-Gm-Gg: AR+sD11kqq757MbM1lkELpg/BTtMJM3xlPoRVMH08ZAieY7XChJIryZCK9RwGY786BQ
 v1qQnmb1L20uoQRwD8eeIFs2Tf9nOAuybwGY4OkbHT+0poYeCzN6xR5fLkLAaqWoWMfdZv+CK1+
 hvx/7DB4/iDYfT7JlHl8Y4EAVF4ny5/9ppzHkayLngx1jl5L7YCIU8tnxjzNdGSY8QmWSQpma6B
 fp4qBSZXXSgtV8lGXwUyhNhSpVkeqaRbqk0kNWjSFc/ZUlpHPm1S5XR4gHVAqTeEmWgSzCwaToI
 s4h9/W9CAhwPLwNIimdE1/nAFyudGZEM9PIaIyS0BkbYE3d/UdxjjJ/MprkWkxXBZYH4ZVAjKIU
 VC4ko/UKNcnAUNjIb79nY0rDxkK4PybSHNzXyVZV4Je7w/vyzzKMU/XmAzUCbXwdKlsuCu2WnCH
 eXr+kPtjXHUBebiGOrEM3CsuobU6Fvvac2ZQPHYXEKvCsLVJ+sG1/QLYBKcS2DdJc+G+/GebWRy
 3BdgTPzJpfLIHclFbPV1FQW
X-Received: by 2002:a17:90b:390e:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-3966d5d9a71mr12882557a91.11.1787751702056; 
 Wed, 26 Aug 2026 06:41:42 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d69065sm8906472a91.13.2026.08.26.06.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:41:41 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 26 Aug 2026 21:41:26 +0800
Message-ID: <20260826134126.3729507-3-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
References: <20260826134126.3729507-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wzFhU-0008Q4-QA
Subject: [f2fs-dev] [PATCH 2/2] f2fs: keep released alias devices out of
 pinned allocation
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

Release makes a device alias range free, but a custom alias name prevents
the basename lookup from setting has_alias again after remount. Pinned
allocation can then place immovable blocks on the released device and
prevent a later reserve.

Set has_alias after the persistent inode mapping is committed and before
release frees the range. At mount, restore it from the recorded mapping
and validate the alias inode and any live reserved extent. Keep devices
with suspect mappings blocked from pinned allocation.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/file.c  |  4 ++++
 fs/f2fs/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7f1dc00031ba..10dadde70a13 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3988,6 +3988,10 @@ static int f2fs_ioc_release_dev_alias(struct file *filp)
 	if (err)
 		goto out_inode_unlock;
 
+	spin_lock(&FREE_I(sbi)->segmap_lock);
+	FDEV(devi).has_alias = true;
+	spin_unlock(&FREE_I(sbi)->segmap_lock);
+
 	f2fs_down_write_trace(&sbi->gc_lock, &glc);
 	f2fs_lock_op(sbi, &lc);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c1e315282ec6..3a07d91b41ce 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5035,6 +5035,21 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	sbi->readdir_ra = true;
 }
 
+static bool f2fs_valid_dev_alias_mapping(struct f2fs_sb_info *sbi,
+					 struct inode *inode, int devi)
+{
+	struct extent_info ei;
+
+	if (!IS_DEVICE_ALIASING(inode))
+		return false;
+	if (!F2FS_HAS_BLOCKS(inode))
+		return true;
+	if (!f2fs_lookup_read_extent_cache(inode, 0, &ei))
+		return false;
+	return !ei.fofs && ei.blk == FDEV(devi).start_blk &&
+		ei.len == FDEV(devi).total_segments << sbi->log_blocks_per_seg;
+}
+
 static void f2fs_restore_device_alias(struct f2fs_sb_info *sbi)
 {
 	struct inode *root = d_inode(sbi->sb->s_root);
@@ -5045,6 +5060,39 @@ static void f2fs_restore_device_alias(struct f2fs_sb_info *sbi)
 	if (!f2fs_sb_has_device_alias(sbi))
 		return;
 
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		nid_t ino = le32_to_cpu(sbi->raw_super->dev_alias_ino[i]);
+		struct inode *inode;
+		int j;
+
+		if (!ino)
+			continue;
+		FDEV(i).has_alias = true;
+
+		for (j = 0; j < MAX_DEVICES; j++)
+			if (j != i &&
+			    le32_to_cpu(sbi->raw_super->dev_alias_ino[j]) == ino)
+				break;
+		if (j < MAX_DEVICES)
+			goto invalid_mapping;
+
+		inode = f2fs_iget(sbi->sb, ino);
+		if (IS_ERR(inode))
+			goto invalid_mapping;
+		if (!f2fs_valid_dev_alias_mapping(sbi, inode, i)) {
+			iput(inode);
+			goto invalid_mapping;
+		}
+		iput(inode);
+		continue;
+
+invalid_mapping:
+		f2fs_warn(sbi,
+			  "invalid device alias inode mapping: device=%d, ino=%u",
+			  i, ino);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+	}
+
 	for (i = 1; i < sbi->s_ndevs; i++) {
 		char *name = strrchr(FDEV(i).path, '/');
 		struct inode *inode;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
