Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B277C624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IUdNQqNUZ/JeK5gVob3ocRx3NoY4p+wjyNhU9W2tgi4=; b=Dq8cXv/CF+BB+iG9rWF8QbKFOB
	hLsx+qdRAnYwgbxy8H7IBzn3Wh7C8ZP2YOL8XnLUgFyYpkFJ0yNvAXqXECndZrPb78ivrMGQ1Dbnm
	0HSHUQtuLCEH1DS763LVw0dz6BhUihaqU2VFYhV1fWBdgq56Xbk8wHqEvy87fBmHWggQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2A1Y-0005Oq-LX;
	Thu, 03 Sep 2026 16:10:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x2A1X-0005Ok-UM
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6jXanvf9fn64ahqaOzPNe+rDqChzGMSkELygw9RPMno=; b=KVrZc0QIkeTD0m6UVbXosWws9W
 S01RJ4RcnRy76ZVAetMiZZjM2HUZc1lkp0dF9054IWdDx5u+lXNrjtvwxnpEA9BVQ5SMsmlCOZstf
 MYK+tCIUJTqG31pf4ruEmYo9cEsqAtw+TDG1EQfr8vkRtfyzYmva5zTqMIoBVrGxOSIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6jXanvf9fn64ahqaOzPNe+rDqChzGMSkELygw9RPMno=; b=I
 uC9iRtqVQoBmbTDxZ7y/51V/o9WW4jOQV2pEC28BD2brAw7p+ltqiotzxIrwf8tBBiPM9PsD5MM8n
 ShyCMKQyE7sSGtlFbIQcluQBJ4qjgsZhzg2i0iA/Ju4S05w8BSu5AYVecpTt4/etGVWy4GiYsraNf
 o0ph5YHqKhZ0Ei4Q=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2A1S-0004ZW-QK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:10:45 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so3483102a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451837; x=1789056637; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6jXanvf9fn64ahqaOzPNe+rDqChzGMSkELygw9RPMno=;
 b=DVOPRMNWdvYykp6ajnchIDb7sttdUU16PxNCdTwiIQnYf4lVNfrfmuY2/orB53vLa6
 jDYB7ZAUPbX60mGBVzyYHJDMSqPBRJ7ch1ElluqTHmvkEKPh1Dm0VTXEP62azGRLU+ZK
 AfUK3X9m/TtRa/HQM5z0xWMkPTbLua4IQJY7ruElaIPsTKuMM6A3F9hloK3FaL0E9uUy
 nHJn1JMtVq2URhuLCz/IDNoQRYBwUASZxnX0oJmHMv2jv5qj/PaKNAJ7jYZkYiAmqusL
 +KwPhSh2XlQd0Xa94I/FAC/Pd+w8uxD2nDqfgzZvFRa6iRxUjpnsdGOS0FbLC08DMUPy
 abTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451837; x=1789056637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6jXanvf9fn64ahqaOzPNe+rDqChzGMSkELygw9RPMno=;
 b=IVtRsmJb0LtawW7+1lfeFdBWvYV3SxEXl6pdvWw7fcA/X2jFo+CxvmzX9X/1zeL8t5
 zeeO3qVA2mgEKoXDKryp4wbGUM/3QYx/ru0CvRz4uXCw2e0pzT68dQzGzfh0z4EpVjeK
 pbC/mc/6Jp2iaXewHvuxXVu6BLrV/3c8oewgUStqZQ54LWF8t6NWjkCzlLpB/LGQYe1y
 GXnhltEANi71Min1FkZMgio7c036OguuJt1eYOftZWH4WcRRm2bQVvn58z9TCkfumXEQ
 X2R2jTfZEoQZa+doLXBV3EQsFzlfQOLixSFMhYHZYCrtvZP3kkHCva6tl0Pnc1St570h
 SxcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDWdgA1+YrxLAZQBcXvtpSpfErND/mlPKZmHTEIsIubIK7mWGX9ovkZn2A91FMaUOox28jwn7p3gD9fNaAwTFQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++lEZMS6xrqJqcRY1rbU81ZW84WOpRe4zLTIr4P24rWKCyVNCXWn
 zXaGaavyNNjg/OTsVtwNF/njDK2aqm8AbDWEiDmAtUVmrsqzRpe+B0mq
X-Gm-Gg: AYBFou0TvOVBSm2JhuHcL1JJagLXvc8aIw2cpVUrl5tT+mrFKDxXP9TrscFYw9LnEcJ
 NCVij/IEZInLWMxb0F40PWfqfMDGvdPWBPjnwkkQpS7aWPbP9wOEBJ5XDzLWDXtm2hY0WHdS1Kd
 VZwaXvSTIXhPdxPAvyNIZ88yvNYUiabhBSWVRf2/ELrz8y5du43P4hKiha04jkHL2nCAlBV6WaT
 sRvccEfo6Wll5inFOm9RCgAeJkWK1nqTji3HC5qMoRvxAkbOAeu+jPBqZqycy4pRfjFhDVvvYs5
 9FMovngk7RFFIwYra8WPeg9jEtmHE5Zi3txH09Ukxj8v/UlmXQTrOJx3O7DWnM3156NUAEQPPnz
 MXMV9aR6yHtrWie6kd9BR73BLUY4956ReFHhT6omwNRhZfA3TpgdoKtcOnUUajMJdTbwcHCmi0E
 eoKws70pAfoG2tfTp1EByVRR7ZNq5cvfqfwE31uW9n5hPr6GiMRhxMEMWR8qbi9A2v0cUB6wJ13
 PCXKEzlBAFnDAGzcGgMaJ+JDKjp7SEWJyRCcglxHfOsc2A8yIBWY8JYRYxY2UDnf3QV0k5s9uI1
 yW8ztEgtB0I=
X-Received: by 2002:a17:90b:1c07:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-39b232e2f86mr997833a91.25.1788451836896; 
 Thu, 03 Sep 2026 09:10:36 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:21b:5fca:ed1b:b798])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae9087d3dsm2865695a91.3.2026.09.03.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 09:10:35 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu,  3 Sep 2026 09:10:31 -0700
Message-ID: <20260903161031.1280195-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
MIME-Version: 1.0
X-Headers-End: 1x2A1S-0004ZW-QK
Subject: [f2fs-dev] [PATCH v4] f2fs: drop pending discard commands before
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
v4: limit discard commands to drop per lock round and call cond_resched().
v3: introduce cur to prevent 32-bit overflow.
v2: fix use-after-free and 32-bit overflow issues.
---
 fs/f2fs/f2fs.h    |  3 +++
 fs/f2fs/file.c    |  1 +
 fs/f2fs/segment.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511286432483..dda70234bf2d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -466,6 +466,7 @@ struct discard_entry {
 #define MAX_PLIST_NUM		512
 #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
 					(MAX_PLIST_NUM - 1) : ((blk_num) - 1))
+#define MAX_DISCARD_DROP_COUNT	512
 
 enum {
 	D_PREP,			/* initial */
@@ -4122,6 +4123,8 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
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
index ac0ed8609c1f..50b2f8465595 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1873,6 +1873,60 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
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
+	int count;
+
+	if (!f2fs_realtime_discard_enable(sbi))
+		return;
+
+next:
+	count = 0;
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
+			if (++count >= MAX_DISCARD_DROP_COUNT)
+				break;
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
+
+	if (count >= MAX_DISCARD_DROP_COUNT) {
+		cond_resched();
+		goto next;
+	}
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-- 
2.55.0.970.g62bdec98f9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
