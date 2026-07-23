Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F34AC531D0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ISRXpLWW+1PW8XdzKukcLEr1m3X76vcqeSrDtqei1cs=; b=GTtrIWf0aRgI6XZZeG8uONmeF5
	7Kf9zB2lWwX3D+nj4Dz70nooqxQp5hjs27uPI/Yv56wD/KJiuNlKjrroVgkKHCfTbmDb6cTWGA0r9
	73nT2+jYlLdyE1KBnt4jy3nJFKSasIpt51Rh4N8YnVmhu9AYerVXw3iPSWOY74a7tD70=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmzcn-0007ig-7A;
	Thu, 23 Jul 2026 20:02:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wmzcj-0007iX-Gd
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9lc8plyt4D7Xg8g/OeFxLjXby4kcNIwZXjBiOq03DlA=; b=kEdm/awr+yV6PRvdEkJ/iZZu1p
 gQ8V8N2WfgDI4N9WqLX0AZVDYncxlPEiQZER0/7oWBHCMVmJgH8IISyz/i1wVccwm/ROawrM1x8BE
 FnntXdzzQUQJMNuD48cGpdsW3TaPWGCm126pNuI2NrybnWHemD99HhD1gwzDt6J7EEaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9lc8plyt4D7Xg8g/OeFxLjXby4kcNIwZXjBiOq03DlA=; b=D
 /JhovYrx41d2z22XSpSb9dnuwZNsP6/WQWCELRVL8HQKLjqADY7Ii57EHwXoOz/PT0BmeSY9UeIX1
 8u2lmSwGl+RWn8QwN3SCPHPabIsaec3iVAIe+P1RTEtfsZr+6PmF4DLY/OlkEusbQcIYo3ilnSTA7
 yKOBYDOtKiwXxc+0=;
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmzci-0002qp-M8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:02:30 +0000
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so820347a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784836943; x=1785441743; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9lc8plyt4D7Xg8g/OeFxLjXby4kcNIwZXjBiOq03DlA=;
 b=UUkORvoQxjT5dZ83UWfCgStZuGMVnxr7lhOLqqMxlqL1ReIr7D9PupmDbcAmJ2bltX
 rwUFl72ClfPQU8SagWL0GzZtcumfaY4lfk9JaHpcYx0paBUKYD4CqDnBjCfQbE4TX4lJ
 VcyHE7cqM81yUTXrzIzvz0MTDCCS799+bNbBfX6FjFInWK9q+BZ0G2C2ZjWhNSAQXXnp
 hVXq7cdUaiFV1T/SH9icw3XOhT2TFYl9ToxmnGySeHiMmgQorqVsA9dYAfdBk08znlpz
 gPdJcDQ7QdROeFTBef6CXnfIyfZ/GMOmtxxnjuigrDAAGamX+ZDIhfbzHljIe8edoWaZ
 AoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784836943; x=1785441743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9lc8plyt4D7Xg8g/OeFxLjXby4kcNIwZXjBiOq03DlA=;
 b=gD+V5n+6zsovAqpW4oLNVu64ZaWeJ0/qalCouFqg3qiUuyuQDuRK/E9LqzxKp6cVkg
 ACb+nvM3NpQaNMxZp3su38+O+p1IFDS87c1FOO2s/GI8p0b4yDqAXMRpNN00MLwrx+Wr
 N6zQE3X0xAIGCAvQ0iE4PBl9M8sNC+kZpLpKRSO5zmfdPdo87BUT6UZNArNvkM4IZMx4
 obxow7UlaXvKfl7WEvAgX6mT5WFcBpfha1n0JElpTIehs78jhL526fJK0o+Zk2ysgVJH
 oMdF875QN5YN8+EE/loFFHIbgm2peL05eEvN/w5UQ/npUYONvpckP3KvxmxUY16t6hGX
 BkHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTzQVO7TpihyIYb5ozQ+vTe9WOy/+xe8C8HBu3eS7lzgIhAnaJ8eAJKLO9lkgEHWVJ52YZtRk5GCnZUfGUGFMs@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy4FZV2H+MOJacsfwduDWWnZX2xwLJwUuNatr81l+5TfQeHMdan
 3RvhkEAbauHxNMmqXRDP+XiUwFJMk+F2mwdb9ennbubjeacCHwWW5O1h
X-Gm-Gg: AR+sD11d61F2SVwqY1bv2659O+JOWXDi/b3cNcIyhIp5Cwjw9Y+A7ckjSdbGZ+bJ2pf
 A9jFOiEXLJbOJzb3rhNkhD0fLjzt34PsR8U5HKGNGRblfTbfB/sEBYdIHMY9uGLFdNlwtt9QFys
 BYnML1ICrf5XDrHbjwiKqCQG/oV3vZFTXHqSqshQilyBl3xFIC85UxIW6y7YnP154bpCAvAyDJi
 bhkHxHYjWD4y8WNV/Q1kIuG+ZtkgwdXwAQGJj92VrlhyTCIl9/Bna10HEkLi7sJ6rHucYeiqBqc
 8cMNdwSXekDBNrG6dabWIcolDY/P+kTYS54+9F9N9Y2PWwkUCJ6kk+qJlbyC62zMznPkTAnX/4K
 XYahkA7UQ2BypyG+YcdbolI06FrCmoC0IHOz4d2Yqt7B/XVCfkyhP+PLgDR3R0Boax9FENylE5a
 bTqU2vcG6B6qfarz8HhMaK14EeSL6DyC48jDP0d1g63N1nEa/kFYtE+BDY+82q+ZwbRS+AalVE9
 wDw3UyzC4IMiC7yEzmrPM99iEgU1A==
X-Received: by 2002:a05:6a21:6b0d:b0:3c3:a140:938a with SMTP id
 adf61e73a8af0-3c44b18de59mr5302478637.45.1784836942868; 
 Thu, 23 Jul 2026 13:02:22 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:8f80:8150:b723:2d96])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm24471496eec.9.2026.07.23.13.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:02:21 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 23 Jul 2026 13:02:18 -0700
Message-ID: <20260723200218.2528887-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
MIME-Version: 1.0
X-Headers-End: 1wmzci-0002qp-M8
Subject: [f2fs-dev] [PATCH] fsck.f2fs: sanitize invalid segment type during
 block update
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

If an invalid segment type (type < 0 || type >= NO_CHECK_TYPE) is read
from SIT during block update, update_block() now validates the type,
reports corruption, and falls back to a valid active curseg type when
fix_on is enabled. find_next_free_block() also validates want_type to
prevent out-of-bounds accesses.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c   |  5 +++++
 fsck/segment.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 85ed404..ce96a44 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3059,6 +3059,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
 	u64 end_blkaddr = (get_sb(segment_count_main) <<
 			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 
+	if (want_type < 0 || want_type >= NO_CHECK_TYPE) {
+		ERR_MSG("Invalid segment type %d for block allocation\n", want_type);
+		return -EINVAL;
+	}
+
 	if (c.zoned_model == F2FS_ZONED_HM && !new_sec) {
 		struct curseg_info *curseg = CURSEG_I(sbi, want_type);
 		unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
diff --git a/fsck/segment.c b/fsck/segment.c
index 46dc747..1ae90bf 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -779,6 +779,20 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
 	se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
 	offset = OFFSET_IN_SEG(sbi, old_blkaddr);
 	type = se->type;
+	if (type < 0 || type >= NO_CHECK_TYPE) {
+		MSG(0, "[FSCK] Invalid SIT segment type %d at blkaddr 0x%"PRIx64"\n",
+				type, old_blkaddr);
+		c.bug_on = 1;
+
+		if (!c.fix_on)
+			return -EINVAL;
+
+		int fixed_type = IS_NODESEG(type) ? CURSEG_HOT_NODE : CURSEG_HOT_DATA;
+
+		FIX_MSG("Correct invalid segment type %d -> %d for blkaddr 0x%"PRIx64"\n",
+				type, fixed_type, old_blkaddr);
+		type = fixed_type;
+	}
 	se->valid_blocks--;
 	f2fs_clear_bit(offset, (char *)se->cur_valid_map);
 	if (need_fsync_data_record(sbi))
-- 
2.55.0.229.g6434b31f56-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
