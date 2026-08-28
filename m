Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514D7C61DD9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qHiA58nejTkI2o5H6v52kj4tWzWHSR0DYod1eRZiy8k=; b=NOLLF+SDl18Xy0g7WC29pJyjXH
	vk7RmF5zCsopEHSjU/GX3G1JY62pNnsJ3J1wbMxnTUNPdaLEkI2zBESKdWD4/DoAk9g8OC8/QxzrG
	1Idsuvw/WxvSN4tpF70Pnl70oUKLVs8Z2BN625pyPytHdITb+MFu+Wtq4VVWvgdWAmHc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzuxo-00085y-5A;
	Fri, 28 Aug 2026 11:41:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzuxm-00085s-DN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:41:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zYlvfP1aWzjYvT/xolEYx3UQdxCu1UNNLVMYIqVN0H0=; b=NLtKwWrmemtSE49nY9DbU9pWx5
 w0cfqm6ZR0a82xtBSVsPZej640fIyqa5Pqd4gN4KzXeS723Txiab+Ux2SCVZJy/zPSvAVEXhPSrlt
 HQ20OF3g+7lG7wWSAEP0EtkYWfZqM8HemZ4NzsQOFYaM6HPbJ1LuyMcCB+O1WoQb+6lo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zYlvfP1aWzjYvT/xolEYx3UQdxCu1UNNLVMYIqVN0H0=; b=T
 LeuzP6ooGznrgc6MG0RPOxpej0c4/hpAvfXf0ASKeXouFxMb6AjTCgAz3H7sW1ZbEqC/VdaZZOeI9
 XaOr0EVCFSTwWitgalRhDaN+DEqHAjbVCHZ1YD5G3SGkYc6fV2LbGebsa3yuxQ6reGryr8JSzQhYG
 Ybxfg4cnTJLq1aAg=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzuxl-0001XH-Py for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:41:39 +0000
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso859611a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917292; x=1788522092; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zYlvfP1aWzjYvT/xolEYx3UQdxCu1UNNLVMYIqVN0H0=;
 b=HNyw+YnzTumUaKQ5UKXvb+BleTh9hIAbsfRANPKAJ114cf9n9eOB4Y9R9J1BcJiYf6
 v6Pm0PI8WUH2Pxpmn/2ChacSWxiwt0u/W0+9uu2IA44nFKS5Jm9XAg8Y25uwFVWLkCPa
 glkIn7vD18Q+JbtRJXmcXFML3WS0BhP6ZobWSI3QpNfL1lTgah+Wpgn2Ze0IegREWSmw
 UsQ8i/JACfSbZxHgFfmD3Ba2OJfw3IeynaLV6+tQ3a/QZ4BYrbL7tvFkKxI/+c2+qaOl
 nnIuOsamgJrB1/oHeoBAxzfMtRVoCQ7GcYSvkJHY6k3Hnr02bEVjcYZbLenpmfJEDwnL
 Iifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917292; x=1788522092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYlvfP1aWzjYvT/xolEYx3UQdxCu1UNNLVMYIqVN0H0=;
 b=YDlwB2Oyj3FJ6f/OAPjES5L5v9zFJPOYiL60qRlfelOGrVf6d50qNZXedRBfmcyATr
 XgMwJngC5GPIBp+TNruh9QgtyMDF9pvj2OOOtbjP3YJIPgj9hEZ+fnXa59UByv1B/KIz
 1sD56NgTFw+CewtdLaKFy686qmZYdDUPI4yP6Vwhhc1Lo26fzqDYn8fsYsNr1+pcAGdV
 SkmBuWcTfCFSyjDcZXJlv4IT2bcq0BpnHLz1U9zqwFtqFyHUnRO2Fy/eT3Fn1NWCwGgH
 2xtREBn5J9LehUNpmpI7cKIRr9DJNTgvbtwlIc41PjTIh8gVdmtZ1TIeI64PQTS8tgd6
 dcOw==
X-Gm-Message-State: AFuF++nsm+fH5ZE1CiUPKSIZoWhbzwenXaPzrXmrvv7KLPBbh3q1GMBG
 jm/bdY4vzPTdCRAJD+uaIzxOUuPSWvPv4rEVX6rWnhBT7Mf4V0+jGpc/
X-Gm-Gg: AR+sD11C5LW1kHzXy/PxPdSvsSNKDfY/uf/UDAFDwlm18W4s4aq3w0hPXlLtjQT7AKi
 ndDZDumWyKRCRLbgBHUMpj/ALp93R8PTzlcUvezssFnaBGNB9eeu2MsW3au0TCdvLdqdV8cl9Ij
 bUtUigynVIjVO9OhREC/kge0kzoBkczl6Kq4KJXTtQu1/t4h84Capcdne5U6V7TIkeV0wbXo+0s
 AvRKG6TaDQOhEqgtBUzCgXchaUFEdmY866Ae/flpQfAd2c/qskKNX6G7RZ31YvW2QEaH8M1skUr
 fPqaVCQRRibJobfdJDqh0Lp1joAMKrP/gBTJlrwiOWrUjR5Kgi9pFD58UmfVAL/RjiQvw2YzIBd
 f191BHXn2I81RrjfbpmyBRofbbXwZEodyIYPl7m806LG36GpI3e4RHs18I5XuGCcvrFwP0F/g4L
 +2jnIEbZ+OXWt/IFyNzip1g2pJz3QHCIDEoaBkMRb2o+/JI8SNVOhVA81ijfIsPkKnytEHeCir+
 hlqDKQB/soadXxyX+XnfSo8
X-Received: by 2002:a17:90b:4fc7:b0:395:bbfe:fc6f with SMTP id
 98e67ed59e1d1-396d0e26cb3mr13722493a91.3.1787917292018; 
 Fri, 28 Aug 2026 04:41:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fcfa3asm6888747a91.6.2026.08.28.04.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 28 Aug 2026 19:41:25 +0800
Message-ID: <20260828114125.637513-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wzuxl-0001XH-Py
Subject: [f2fs-dev] [PATCH] f2fs: sync pending discards before reserving
 device alias
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A released device-alias range can accumulate pending discard
commands. The reserve path then marks the same range valid again
through f2fs_reserve_device_alias() without first synchronizing
those discards.

If the discard thread later submits one of the stale commands,
__check_sit_bitmap() can still see valid blocks in that range and
trigger a BUG.

Synchronize pending discard commands in the alias range before
making it valid again.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
  kernel BUG at fs/f2fs/segment.c:1228!
  Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
  CPU: 1 UID: 0 PID: 79 Comm: f2fs_discard-25
  RIP: 0010:__check_sit_bitmap+0x2e1/0x4e0
  Call Trace:
   __submit_discard_cmd+0x921/0x1140
   __issue_discard_cmd+0x524/0x12f0
   issue_discard_thread+0x686/0xe20

 fs/f2fs/f2fs.h    | 2 ++
 fs/f2fs/file.c    | 1 +
 fs/f2fs/segment.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16720f1f0a9..2b9c6bf310b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4067,6 +4067,8 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi,
+			    block_t blkaddr, unsigned int len);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d440231b8cb..58cea2aa314 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3847,6 +3847,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	write_unlock(&et->lock);
 	clear_inode_flag(inode, FI_NO_EXTENT);
 
+	f2fs_wait_discard_bios(sbi, ei.blk, ei.len);
 	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
 
 	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71..7f4fe8c34c2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1916,6 +1916,15 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi,
+			    block_t blkaddr, unsigned int len)
+{
+	block_t end = blkaddr + len;
+
+	while (blkaddr < end)
+		f2fs_wait_discard_bio(sbi, blkaddr++);
+}
+
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
