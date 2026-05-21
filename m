Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0961CD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k7uIMOWTQjQRUkcXwSG4fXYMrkit0CP7sPMeLtw0dfY=; b=J5hV7Ne9GoQkHSpl58JcDUzpwf
	8QNj1+E8pl7CqYB+1/fE4IbmTrj6iKEWJtw5n53LnQj+LWxv5dAkayoNxad55M8ApCL0u7MK9CvVq
	ZXBkXMC2I61jn5YHyKw/rk03SdVg1qDiFtWizAXFM9Wq97faSOz3slroPoFZwhEJvNoM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPsZf-0008D3-7r;
	Thu, 21 May 2026 01:51:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wPsZd-0008Cw-33
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 01:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rybzgIgzvHGYiQF9jRUihAcDFOY5JFL5Nz+b/9q97sQ=; b=CzGB0HR7qcNOH1K7vWX7ZP1Jfr
 FVT3YaClKvfRAX2f9UeZ/TujZ9DGQ5n6vgOmuKjdhU2+y9W1/ImcKUqX7bCRNgk6OS8uHp2QxBdHw
 FPBlePN9dsSVPrLFF/kd9UX5keQyVcPTXR3+rHPXkjmiizQ0iis7H0g1vhKJzpVFWPnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rybzgIgzvHGYiQF9jRUihAcDFOY5JFL5Nz+b/9q97sQ=; b=a
 EAXsDUTHeQqAKmg7FjIYkPmMG4q06wvu39w/3T9KF4QDtE0sD5n1iKD97LDcJzu8INPucdsfjaLgo
 z3DkeTEg/iM5r9s3psyTThwcN0Gu/Lr/MzQSxHA23bpL5n6+zuMoxMMFgVS7gTC10YoWB+/7BuHas
 h3ouJn7hSgNlPlIQ=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPsZb-0001jp-Um for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 01:51:45 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2bcd730e090so42358345ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779328294; x=1779933094; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rybzgIgzvHGYiQF9jRUihAcDFOY5JFL5Nz+b/9q97sQ=;
 b=EVisZWPrPtmTpt0+0NKdVhJIH75IbwByAsZIdgwZ5CPm/HJ1I5Xd8OBPI2vRcx6oX1
 R00gM74FRUniit72dPPmaDjgJN2MlpCOHycVHuwRnc4u4MzHziuLeBqrXJ6loq4qI534
 SRgmTpOO18sy45kEt6I0A0U4uQuOyNHlipsxJHbWjnNtsf9yTuIBHpTP0CY79jTcgI/W
 mhngRmxn/ZA8s9nNzWMOyfwHXnqyvEHwacyIhKVqQ+A5XBNpIsmAu9sVRoFl6MJXY4BR
 L4ZLbFMPHVPUgzU7C+NCjC31DlvwvgldRuFXIYmyX9c9f7y6rUn6awmWsF15qkJFykLm
 elnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779328294; x=1779933094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rybzgIgzvHGYiQF9jRUihAcDFOY5JFL5Nz+b/9q97sQ=;
 b=LCCnPSR9uRQpnD1AfZjlkFOz/4v8AN6hwP/GjY8ed72u6I9IfhVrtHRsOdf2YrKJxv
 cOe/IE43OulPyd/dEmZ0PB0bAailPqJFTDbmsWCpyFkETH4OI0JyG7OOreSQk86R9rDp
 hoIDsMPUBLMt7kMZ5dVhBU9SOzOZnv9HACBH4XEc6LoOI0wk6mhWpXv1/ejnHqmgrE+W
 9iN5uXHSl77e7TzAt1HxMTAdgZU0W3l/iUSl7bAT1wqgryyOKNJ9biogVHDTt/Js7QR0
 AAuTpOYCWQWKIFryPNyo3N31vAMz0iJknC0kA1GlNpXTyJfpuhsAt4Tyz+nMTVuAwxJt
 ZZBw==
X-Gm-Message-State: AOJu0Yxk+D+Gh0zm0p6DV42TstgLxic1nH4WaSDYxhgAWQXTHCYaZNYq
 vCvkQO7ivzMhR/lNse0xYP8EgVDIt8FJEQfc29cVmU9N+LDMCxQry/RX
X-Gm-Gg: Acq92OE1n0zPjZXbueRcLzmdHqwY+0SV0wXzJIS2pC0F9VygjBuWDifo6n899BOVrN6
 sn9OIWmOB6BljXO5JhzhobeBnQONbDjqnfeMUOqmwfMTVAOs0a6FiwsFQlSfqgGw6lqrbOMBRWR
 lOnNH5AA++r0DqL4+EGaaXeQtGMKBon4GIfohPW+ApRzHSCim8GKut/mzlE4Z1XPcd2JQejgoNr
 yNr5+ONuJLbeiYzdlj1mpy3J6rmPymO1SJqnwea7vhV3Skvs2DN4v4Cs1hN28iZV/LZxLohFvlC
 yhpnDBDJ/FFFDbjbwGdMIU0KLnB4CVcRyTeAKRvTFPslsh0OhmATBOdJeI07IZRvoFU9aD3/RT2
 xalvCpQONBQmtafSqEAXz3TXwfmgVKkUyn0VmhKjxMdr1tdMgggorDfD3WGrvQuXfEOfnTayPxj
 rp+rqi43AGrvgVImlLrlrIHWgjsr0OR2GNoORdM+AVqbhWn+IcTcF4hCaC1dYKoZ/7NHdDXfIwb
 tGQLJ9t
X-Received: by 2002:a17:902:db04:b0:2b9:87e0:1f80 with SMTP id
 d9443c01a7336-2bea3386598mr5807845ad.24.1779328293659; 
 Wed, 20 May 2026 18:51:33 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bdc4c2cda4sm144600225ad.58.2026.05.20.18.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 18:51:33 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 21 May 2026 09:51:26 +0800
Message-ID: <20260521015126.1663277-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wPsZb-0001jp-Um
Subject: [f2fs-dev] [PATCH] f2fs: avoid false shutdown fserror reports
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
Cc: qwjhust@gmail.com, djwong@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS records image errors and checkpoint-stop reasons through the same
s_error_work worker.  The ordinary f2fs_handle_error() path only updates
s_errors, but the worker still calls fserror_report_shutdown()
unconditionally after committing the superblock.

As a result, a metadata corruption report can be followed by a synthetic
FAN_FS_ERROR event with ESHUTDOWN and an invalid superblock file handle,
even though no stop reason was recorded.

Track whether save_stop_reason() actually changed the stop_reason array
and only report the shutdown fserror for that case.  Pure s_errors updates
still commit the superblock, but no longer generate a false shutdown event.

Fixes: 50faed607d32 ("f2fs: support to report fserror")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/super.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0a54883b88..fffb516b78f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1990,6 +1990,7 @@ struct f2fs_sb_info {
 	unsigned char stop_reason[MAX_STOP_REASON];	/* stop reason */
 	spinlock_t error_lock;			/* protect errors/stop_reason array */
 	bool error_dirty;			/* errors of sb is dirty */
+	bool stop_reason_dirty;			/* stop reason of sb is dirty */
 
 	/* For reclaimed segs statistics per each GC mode */
 	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ada8098f8b3..718feb854b1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4616,6 +4616,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
 	spin_lock_irqsave(&sbi->error_lock, flags);
 	if (sbi->stop_reason[reason] < GENMASK(BITS_PER_BYTE - 1, 0))
 		sbi->stop_reason[reason]++;
+	sbi->stop_reason_dirty = true;
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 }
 
@@ -4623,6 +4624,7 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	unsigned long flags;
+	bool report_shutdown = false;
 	int err;
 
 	f2fs_down_write(&sbi->sb_lock);
@@ -4634,6 +4636,10 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 		sbi->error_dirty = false;
 	}
 	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
+	if (sbi->stop_reason_dirty) {
+		report_shutdown = true;
+		sbi->stop_reason_dirty = false;
+	}
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 
 	err = f2fs_commit_super(sbi, false);
@@ -4644,7 +4650,8 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 			"f2fs_commit_super fails to record stop_reason, err:%d",
 			err);
 
-	fserror_report_shutdown(sbi->sb, GFP_NOFS);
+	if (report_shutdown)
+		fserror_report_shutdown(sbi->sb, GFP_NOFS);
 }
 
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
