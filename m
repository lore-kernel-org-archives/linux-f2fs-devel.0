Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D632AC61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JiHoNo+dsZdf1n2kUYZ+0Aks4K3mLlHTnhGIQ53yZuI=; b=mz3t8Tm6373UdKLdzTI8FyhQjJ
	FhLy/z8OZakEfxuNRiQ/Mo6Ig0WzOhaIfUFXcefVanpgfdcg/Csxnsy8HbsYKlqG8xcwFvq2ZNkla
	pR7njZO2cc19KhRZCWmpQllL0M6eyEFzywDAAFxQ8LTL/HpCceerJ5rtZDcB7rAi2w+M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Uva-0006km-As;
	Tue, 01 Sep 2026 20:17:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x1UvY-0006kY-SG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iCHdjulyHGSeG6kfdMtjlvttn40PrSMapdL4xPEQrl8=; b=BcqLYT4E4GI+6kKWPv8fJTTNgc
 hphE6+P8AkO+q2MYFrTwS6OWVZ6Q6e1kICRDCGPwP5vMFCgwbWjKf8EHxkXv05R8DAOsO/dq1Gi8W
 tB0l/64VpmiHRydIEwBri5ZVLJwJnOcLIS0Qf5D9p9HkjtTM4Oj0TG97dwYHqCEyqoxA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iCHdjulyHGSeG6kfdMtjlvttn40PrSMapdL4xPEQrl8=; b=C
 i9jvzKSNhOa1iJBfhmh61RXhCeP85pk8vbZLbQ0Qg7JkGf9fnkR3A0Q0CDq1TexWaEzUrry9nuyMy
 RLxBkfty4mEASSA7HN364G3PvcxAox6JN8hyyl1xL+N6DGvUhWbiEiWFiXz1wgw+s9CO1FOo3+X+Y
 T3yN0ZznNGlYV5Cs=;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1UvY-0003lX-N4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:17:53 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so334829a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788293867; x=1788898667; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCHdjulyHGSeG6kfdMtjlvttn40PrSMapdL4xPEQrl8=;
 b=XmyYrtyB8/AfllLQ0Hmr5/jXyFmPY0NtEYYyjNyGcSHi+NSxaIXdUcQO5iY842wNqS
 q/s/AynxYTGU76J+Pzxs42r/ruKs3N6nOQnDsnPJgnPTzR9pUZKHbGP57IBfNUjMl7FE
 YFneBfLkgG5SiT6mlIIMFVYMN7gvvXJSdORcvC6b3fX70pU3Irr2iqES6TCydUv/4EDs
 hVh+osT8Y1csD3OSiN039dL/3OhSwLb+n3iuhKRY+PgWjjzhrROXyyk268un+U1dzgTI
 oWpaFYSKGIRPrG/2QO/MBhQ2dLZEm5HOQ8oeF+fih+iz4BoOKxoh4Teoi57Q2N8GQoEA
 YOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788293867; x=1788898667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iCHdjulyHGSeG6kfdMtjlvttn40PrSMapdL4xPEQrl8=;
 b=MEbiYmBnrejArNZemB8W5pryhCHdZlUDcGk2THPNL1DVG0lZoKfnGOupMYN9XtPSPR
 VpthK4w6AjqnO6moNi+nozqKLqSn8OEBiTPurd0Iz387X0PSe7F52zfK//Ky+P/Q6zxs
 YwPL7ibYose8UH/y4C75PM6x2OwazXhfFv0NO+ym9Y7F2gWUxnG6s/lKzvLyhyxTPi6Z
 x1UGN7ATvdJubSz0S+mbpwapPLnSMmkWn7Y43TlVD07+bLMPWjex/miJ4H6w9zenYDVA
 jvee2feP+Kzcu2BZl3007WDg+dKG6pz1mjh/Zxvo8nKDAzeFzO0TSqKwwXsQGmKBl+Dr
 E4eA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz78/K6TeLPkjUGOwPLqaDWmr9yGaCIzCpaMQG8av4jTGcwDxqaxFpy/ueFhQJ/gUQenss7aMBiV9hhu8FyEUt6@lists.sourceforge.net
X-Gm-Message-State: AFuF++n78mbC32mtAgGvd5XgwSrFZAjo4iqYW5KI6XwW5lOq1UXhwAxs
 sVZcsBQVPWd9+u8EWQzUfcUS8imK+iSMBEOF0TarbGVlLgRJvPjPy+Uo
X-Gm-Gg: AYBFou2tMBCfQFUsERCj0SAWtJq23wYT/BhsFvJVmwPrqgV8gNHVYpD53e196Dl4oI0
 DJCURuDrr4djwvKOZo8jlyxmr4NZx+RV5WPm1P+IAjV8KYtLoXek/ZFfY5/FVkh1UwZBY2GJCBa
 iWuibzA52WFx7bGEVps2Fdkc3wdoIEdIEw16kotcfxweV6nzmx4W0d1jtlSmIKDhF0t/vi/HjSi
 QtVBhVpeiI7okqq41R3rYynn7dI73GuyPpkm4OI1l7gBR+WAjov4cwEykf35Wbm1wmOROQqGfbs
 UGP6k6I56tWYm91rEhHr7iLbPuykO2F/Tin1uT3eu6J9d63kmkpooUur1Fmp35Z20Zb4gtmQNd+
 gXQvWiJkRNpUI0+q7bKFTrPaLVxXv3FDHjTGksrDXNWJaFlo1GIpJ+lJIj/MAQUGvWpAzQxIMiI
 bOuyqIrJkbWLPe2sAG2SWUNaY4bmz4erq4ddks0VDw1DpKHIAm5wvmxc+TPOzB7YHDwoRm9w7lW
 a0bk3dR2J4WUNJp7D9lOLEv8pVLy5px3XAz3lgu3vj8H2mXQaD3UOy9kVhv90A8fsOI5xa3Vm1S
 /wuup4Zq0NY4
X-Received: by 2002:a17:90b:2f0f:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-396d0fd2a75mr57572694a91.13.1788293866915; 
 Tue, 01 Sep 2026 13:17:46 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:4b8f:b403:e030:fcca])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07bdb15bsm430330eec.26.2026.09.01.13.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:17:46 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  1 Sep 2026 13:17:40 -0700
Message-ID: <20260901201740.4040807-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
MIME-Version: 1.0
X-Headers-End: 1x1UvY-0003lX-N4
Subject: [f2fs-dev] [PATCH v3] f2fs: drop pending discard commands before
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
v3: introduce cur to prevent 32-bit overflow.
v2: fix use-after-free and 32-bit overflow issues.
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
index ac0ed8609c1f..6826cb7ab34d 100644
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
+	struct discard_cmd *dc, *wait_dc;
+	u64 cur = start;
+	u64 end = (u64)start + len;
+
+	if (!f2fs_realtime_discard_enable(sbi))
+		return;
+
+next:
+	wait_dc = NULL;
+
+	mutex_lock(&dcc->cmd_lock);
+	while (cur < end) {
+		dc = __lookup_discard_cmd_ret(&dcc->root, cur,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
+		if (!dc)
+			dc = next_dc;
+
+		if (!dc || (u64)dc->di.lstart >= end)
+			break;
+
+		if (dc->state == D_PREP) {
+			cur = (u64)dc->di.lstart + dc->di.len;
+			__remove_discard_cmd(sbi, dc);
+			continue;
+		}
+
+		dc->ref++;
+		cur = (u64)dc->di.lstart + dc->di.len;
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
2.55.0.966.g6673acef38-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
