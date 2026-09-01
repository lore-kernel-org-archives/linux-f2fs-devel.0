Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8A3C624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=teDKrCim8K+q0gxyjV+5LxrkXZyE0o8zqvsTdgCQdyk=; b=dxbwGUW06Fw0cCqABkTvnO6tFP
	HQBnqg8bUjfD+0ayoxypeOpEnSvdwXiS3q53ZGjlMcpjC+XM7SBeevKtWHz1Zoke5NFVsx+IH4hAt
	PjvHZefT6P+YVJVm0yM54739F160Sx7Eb0ZNC/LBGHLrrqJqX/P4XCUGnFyiyU/pS4rw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Et3-0004yn-JL;
	Tue, 01 Sep 2026 03:10:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x1Et1-0004yS-HX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 03:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S2rSlvlJ6/XqKt2WEd0a/Wwq0kiDGRS7GpjIC1W/pmU=; b=cdclWrTWx6bWo4w8jtlO2ApeNz
 xV0l3t76mkECfOvrhtPsR/xuHu+10VM3I8ICQZ+xMlyiftnxCzi4kXcOpYN6AfL6vi6XNUUz3GcHo
 +5owtel8jZ3UDfGyMPB43MS4E/23HMWvdQJysnj7yL3bBI8ttp5s9qz1U0EKXqZPuU38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S2rSlvlJ6/XqKt2WEd0a/Wwq0kiDGRS7GpjIC1W/pmU=; b=L
 2L21wZ0RKej/edTeae4RFTZbKLRs05zm2I6IUJBrMTJP4GnLCegTudSqIQ1Gc1Ke4ohnI5DYkl7Tw
 XimJSMHeWCIM702lWM8nasDEfH1VtteXV/uT2oe8ue9MpOZAXoKshT4kgFU+3GktMTKShYssa26yW
 fhQYvQKYcJoXCbXU=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Et1-0001Y1-1m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 03:10:12 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso4612620a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788232205; x=1788837005; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S2rSlvlJ6/XqKt2WEd0a/Wwq0kiDGRS7GpjIC1W/pmU=;
 b=BJ+hhNZgbAUL3jfpuev1XhCM9j4tIgCGNJbPABUv2nDIUnjq4XnsGG0nxC6mqdw6QX
 aWvHMOgmCiKfmMZP4Oi8dz74MoE35epc/+oitP9Ha3sYMbh5DTdHjp4fHqKffr1tMzFW
 rXQ5VLjhkG1mj9C8FElMu7yDrQZ5mkK4Rz7IyIEk3g6cdU/qL3eo3ToHR81ca3EFRDG9
 C+s0fgFc0SwyzhhSEMq93EsU9I0+athWyupSMc8VUbQ6YCNHXOKHXroaf3XZlKJZOurj
 gZiFfTHJ3h4mCI9xq40RdqOu9fGJ7Fd75gSXX0bHRI5r8BMCoBapzv1pGkdGOmiht8UN
 bfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788232205; x=1788837005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S2rSlvlJ6/XqKt2WEd0a/Wwq0kiDGRS7GpjIC1W/pmU=;
 b=KX+WAGzmqgj8tXMhLkYs4k+J/4H0jogyPUfcn7+jOlJIcmfONJ2pQsEA7ZpsNRG0RF
 tjHyEluGSrUspKu8GGkkV/R7sEVn5UEsVmunea61liHtnJfdJ8vNVAE9k9raocpUpajG
 TaPtjT8moMfl9tkISc/Ojoj07F/UVVZDsQukeWC5fD79ymwnbZ97JPGWN8rQkXwEToka
 9xKmLhBC+nZ8IOPL8/QpGxPJR9ykGmNgtYtuGXWer0TqYXCbWsgMxuqGhrquzJz6WckV
 tS5hIm/6h5afuv4tZiIG76PQ1oGfCAsMqGpZumXPGuMtkRd9lOwQT/GS5aPjQWMn0jVa
 MtYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxf+LYGrCFI3v5Dnx4WtMiawnFr/q29KeGmWgVERVuxGmPNTdtbBASpujz4zDdyoUaFFAK+A1NuLyiTp224Vbij@lists.sourceforge.net
X-Gm-Message-State: AFuF++nNRcoyYLRYR1a/FCBkseWiRahWpqf9s49HZXD8QfS6iTcZMq3D
 YxEduDhYUx6CqeIyK0e8xQlLxfMovoRp5a4wQdfmjEeiAIPZGPtC/ZwE
X-Gm-Gg: AYBFou2A9jcOz3Maj00Zq+MboEacfUpOTbcHgEjP32vusSn0k3CQvmI4kmRxzQbM+Pi
 SW/kjF2TOu913ubotOOoO0t+A+vG2xU+8MJdb36J8tTKE6AjLbfYd3LAlJwXA/+jAwYlXx9fw7X
 k7Lc5aNPUWcr/39JryzHGRXKLAesfJa40vdx2ctbIqBuAXdCM8OR4/AbzFlJ5ou012Mqjd3L/8z
 FUr9D7fBM33VOUZsd84/W5vxewhV3SMSXZGEJkK/6DxLi/lxGCtOW4jVPe91MvRjqRGpTpOeVDt
 7HBHCXX5Zarw54DCLq2WHuEldJaI0dSUVPKRYfvXEBdKnGZOHUZv/dzv7eF/d07tD091etRPymg
 5mVkNxNmeoa0/HD54BRhz+oQ1hK50AIwhL2ZyeBxQhnYH0Ht7NEz36VeuG1bjucvvynPrfTT34E
 f/QcIkVGKmIBIfCOne0f0JPd5g9iqhXz19nJ4ARrg1x5DVVftD1FP1HLf94zfIudRgZIvrqRJ8G
 ho4pUxGzI1jyV/GXmQ7iKwNd2xiDjk4Waqsj4CDRNgtG5t3XKvXlLf4RccR7CZosbgXgYOpW1JC
 5I+d7duPgFhK
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-396d0ff519cmr47226275a91.14.1788232205233; 
 Mon, 31 Aug 2026 20:10:05 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:94f2:e160:f659:7f83])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0df264csm55297430c88.14.2026.08.31.20.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:10:04 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 31 Aug 2026 20:10:00 -0700
Message-ID: <20260901031000.786214-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
MIME-Version: 1.0
X-Headers-End: 1x1Et1-0001Y1-1m
Subject: [f2fs-dev] [PATCH] f2fs: drop pending discard commands before
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
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/file.c    |  1 +
 fs/f2fs/segment.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

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
index ac0ed8609c1f..bc36af1a4247 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1873,6 +1873,51 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 	return discard_blks;
 }
 
+void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
+					block_t start, block_t len)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct discard_cmd *dc;
+	block_t end = start + len;
+
+	if (!f2fs_realtime_discard_enable(sbi))
+		return;
+
+next:
+	dc = NULL;
+
+	mutex_lock(&dcc->cmd_lock);
+	while (start < end) {
+		dc = __lookup_discard_cmd_ret(&dcc->root, start,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
+		if (!dc)
+			dc = next_dc;
+
+		if (!dc || dc->di.lstart >= end) {
+			dc = NULL;
+			break;
+		}
+
+		if (dc->state == D_PREP) {
+			start = dc->di.lstart + dc->di.len;
+			__remove_discard_cmd(sbi, dc);
+			continue;
+		}
+
+		dc->ref++;
+		start = dc->di.lstart + dc->di.len;
+		break;
+	}
+	mutex_unlock(&dcc->cmd_lock);
+
+	if (dc) {
+		__wait_one_discard_bio(sbi, dc);
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
