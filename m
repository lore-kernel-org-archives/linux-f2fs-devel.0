Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACE9C624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kwbu2u/RdeTWv94HdjXN4wszewl+TLwydu9yenh2a2E=; b=Zj5lruBZtae+RG541DxBw1vAmt
	DI9IUhB1AD1QPHQXVkmktLzClAEF/DePfJ+hmMcEMYOtS9/GnwPXIaqd6EuNuQ6Pgy8Wn1eyolC/J
	Ia3Azojp2wrkQk8EELPalA+fEweh+IQre4E93mmDAaB4XJ4lgNORloJAxkGZT2iYlVto=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1QnL-0002Hi-HK;
	Tue, 01 Sep 2026 15:53:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x1QnK-0002HZ-L5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Jo2uC7uDlmBwKEsPN4k4PRcGubFpOSoa8lkLopgm0c=; b=UNr1Z10TLnozNlTexGt70LGo6M
 p8ZFiMcjd7L6FGA5mxZPJJexa2jrofbW3j1NEPFU9L65p7kUZ8eZTIiVSGjmAzHS2M0L0DnsoACeO
 w4tbOZUtNeQv68h1YvvVpAEeg/sBxKI62cWzNzjartSRJQYa/nNrdRdOuOPXPc3TLSts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2Jo2uC7uDlmBwKEsPN4k4PRcGubFpOSoa8lkLopgm0c=; b=a
 dh0G4sQiZzXabz8Y3JQOAG2XkcIJ0Ld4vx/+CfxWYFyDzqkZ9rU6985hS9a3g2iDBd/XnX9Idet8s
 bBBzG+QnVPJvWm1pMieu6J5zLvERicJKMPqNHOpiuxRld9p+GGlqzba52TemotkgiDvzXXxzm/W6v
 xEWz7FSDUD5z/TX0=;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1QnK-0004cI-Ln for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:53:07 +0000
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so8139b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788277981; x=1788882781; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Jo2uC7uDlmBwKEsPN4k4PRcGubFpOSoa8lkLopgm0c=;
 b=rjAw8w6cByHG8jYymQl1eQpRQMbIObXTLJufFQe9CidvgzgxnyTBhBZlzNwsJpwe9S
 9KTttBvKYtVPft+cHR6MzYyAi9dv4tvrY0xeOIxFynS81AReU/XldjGTPHBBmuqPCrUh
 J6OdznDg96+hN55SShn78l8k1b0lekAjP5u/pb/hyg5yIqMLgu0UpPqF1D/YbOSwpYCP
 /P8cH2Xexb1fktH8mMy+CSiphSlacJkxhpx2290WXp9CPJNfGcPzAAQ+a8fCCsM20fkr
 1d0KB8qDySebNN73n4hYn6f0u0She6AncpX9uQ/YzZrmcrcwJwGf+qU8r8xlMm+S7PzS
 yVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788277981; x=1788882781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Jo2uC7uDlmBwKEsPN4k4PRcGubFpOSoa8lkLopgm0c=;
 b=Q4hEQbOw4VKf8SQ9HQbLkjJEqnd8d6x7gl1TGETzpdo/VfmKPTqw8uA7gGftZUGCZx
 5kgFK8XeJMbWDVAl6s1Num88G5+Qf8F5cXJTHC9QtM5Hd9fbjY6NLFIjRRorIT2RFyBP
 jPYp4ElBQ8iM6hzw04sKiOTvF6V0yVXJBWJ6u5mPaE2lnSa1LOtt4GB50SLkET/GkKfn
 Vos4JJZxPWVItRx6cwjHWnuE+h6v+jD6miMaDOqbJNGwOiaGGQ8E49GQO9FFHsF1c3Yg
 w4utsUyV0QD6tCtsI9Sdxxql6UHWkSW1Td6N2QmEdtlJjF4rlbZp8Hf92yE5TIFnFwMh
 kYFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSaHVaH2AUHYB7Y+hTChaBke03qjTj8NPI6VbEmrortli8/cYj1TlfMLPsawvkQCtT7dDwLNoDyWVH1NKJ1LU5@lists.sourceforge.net
X-Gm-Message-State: AFuF++mRvqtOQ3Dek1sYSG21EhC7/8uGSxlw+T4NSQTR0wL7IuNC3T8a
 kJPqC1pWP4crKL7iWxZHt3/INyb6iBY5DQ4V7BRKvVa1HIxTBLadEHcnswAfhA==
X-Gm-Gg: AR+sD115WNWvA5b+kbipr6c2CqDYAxsVbrJ/ZE8mqS26i+OZYuxAbS7D+AsV4fDGZLS
 9Qmq3bYZqqQgl8W0wDLiSzjJ8TTgapRbhwdlrhBbwA6OG2khzEzsMEoZ7fm/P0ER5rVcWN50Y5/
 46aknE0Ov27UqFbInODVDP2yjklhQ9Tih2AExq0dVL+JE47gKp/ty7nalyMHJfxhxR1kZuonMoD
 TeZd6ETMBekVlyD0YM/D6mEpoSZlNXMOLCvIMW5KWbwRJXfmyx2lwTeYJ/cN7cWnJ5mAjyaW0iy
 aNqnL539YDbgqj4/7MxN5XDXAWmfqQA058P4dUyYN78LnCkBOKrn1BTU2y9YChJADGaeOtLnHBh
 JMomdC+lKBABbtbdhwignYuoX8/ryLt8lh2FD2sKbqrTjZHwUAjcWkBzUfwNFqin0PRtjuV/b12
 7pgtACug1fr7lPL4QLubYJy6Y9SsiAArowewOpDJurz6beelvJWWoVdM9wRKz9Mkaw9graByZix
 46yoDSrXEynatw97YF0exrrr9sY1659X5luaELf1DsCVu1IVFV2+5vQMlqKcuLVxj0uHZ93RD9N
 Opscp1PgW0Xz
X-Received: by 2002:a05:6a20:c793:b0:3bf:b182:94e with SMTP id
 adf61e73a8af0-3d7ad7825fbmr15538475637.5.1788277980739; 
 Tue, 01 Sep 2026 08:53:00 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:94f2:e160:f659:7f83])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0df264csm63853707c88.14.2026.09.01.08.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 08:52:59 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  1 Sep 2026 08:52:56 -0700
Message-ID: <20260901155256.1212298-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
MIME-Version: 1.0
X-Headers-End: 1x1QnK-0004cI-Ln
Subject: [f2fs-dev] [PATCH v2] f2fs: drop pending discard commands before
 reserving device alias
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
f2fs_reserve_device_alias() bulk-marks all blocks in the target device
range as valid in SIT.

However, if the device was previously in the released state, stale
pending discard commands covering that range may still exist in dcc->root.
When f2fs_issue_discard_thread later processes those commands,
__check_sit_bitmap() detects valid blocks in the discard range and
triggers a kernel BUG().

To fix this:
1. Introduce f2fs_drop_discard_cmd_range() to traverse the discard rbtree,
   drop all pending D_PREP discard commands in the range,
   and wait for any in-flight discard bios under dcc->cmd_lock.
2. Call f2fs_drop_discard_cmd_range() in f2fs_ioc_reserve_dev_alias()
   before f2fs_reserve_device_alias().

Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: fix use-after-free and 32-bit overflow issues.
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/file.c    |  1 +
 fs/f2fs/segment.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511286432483..ae109d3ae571 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4122,6 +4122,8 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
+void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
+					block_t start, block_t len);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29cf82d02c77..0b2d173d9597 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3855,6 +3855,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	write_unlock(&et->lock);
 	clear_inode_flag(inode, FI_NO_EXTENT);
 
+	f2fs_drop_discard_cmd_range(sbi, ei.blk, ei.len);
 	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
 
 	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ac0ed8609c1f..54bc0c64e158 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1873,6 +1873,50 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 	return discard_blks;
 }
 
+void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
+					block_t start, block_t len)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct discard_cmd *dc, *wait_dc;
+	u64 end = (u64)start + len;
+
+	if (!f2fs_realtime_discard_enable(sbi))
+		return;
+
+next:
+	wait_dc = NULL;
+
+	mutex_lock(&dcc->cmd_lock);
+	while ((u64)start < end) {
+		dc = __lookup_discard_cmd_ret(&dcc->root, start,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
+		if (!dc)
+			dc = next_dc;
+
+		if (!dc || (u64)dc->di.lstart >= end)
+			break;
+
+		if (dc->state == D_PREP) {
+			start = dc->di.lstart + dc->di.len;
+			__remove_discard_cmd(sbi, dc);
+			continue;
+		}
+
+		dc->ref++;
+		start = dc->di.lstart + dc->di.len;
+		wait_dc = dc;
+		break;
+	}
+	mutex_unlock(&dcc->cmd_lock);
+
+	if (wait_dc) {
+		__wait_one_discard_bio(sbi, wait_dc);
+		goto next;
+	}
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-- 
2.55.0.897.gb25b4bd76c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
