Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C73C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q9c2PMFTXBeS3PcLxC1Gczo1GWk12Tl3b8v8gRmgds4=; b=l3eAeRMsddFAm6och0uQetFq3q
	nghItQm11Fm/43zItRDsKtZJgHIof3khKM+/z+0cR86CXgVd7iuf3HHw4sJilOBRVGjmSv+kLj/aG
	vieuEQbc9PkDyrKvcVOg2TpRh7M7LSCLRnZ1RLKZg0UfX4IuC4IgOh2qk2/4sS8BvCXI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnBqo-0006Yu-QK;
	Fri, 24 Jul 2026 09:05:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wnBqm-0006YY-Fy
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 09:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+dNk6QVT3h2ncm7bXUtKEg64oe4EQaGNEhvbfYPZlM=; b=jo57Ld6LS41WYfjAHTbPsQOPxL
 hu74AJvKygZ7bBX9YOObksekp/Zic+tpA6SsDDcEZ4Bek82z4fbALe4a+QonqbdniHoeMY+vC+Iw4
 j8FWOdJRLpVGpdLiAIrt0WZFGvreDLDipxIXtbl7oeXK7WhP6/cCGiZqp5fZTmxBfLf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w+dNk6QVT3h2ncm7bXUtKEg64oe4EQaGNEhvbfYPZlM=; b=N
 uqtDevEnjw18NkLFKfNzPk5GgXgzJ7s44xvx/wN4mU/+vq4IO56XTOMXHVrItpLxOjgDImrg7jUYJ
 jYLxau115MxrnA4tSZG6h/KJ0ngTuI0W7/ZMjsTu5Pfygwa6WDuYudkHwTM7YixF0UxjKKhAM/uAC
 XmV5lvo4P2mdyfmk=;
Received: from mail-oa1-f41.google.com ([209.85.160.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnBqq-0000dP-CK for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 09:05:49 +0000
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-4560d6f82edso64220fac.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784883943; x=1785488743; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w+dNk6QVT3h2ncm7bXUtKEg64oe4EQaGNEhvbfYPZlM=;
 b=tFJ0cEnexlcYGPUjZ8OmScTJ1iRA9WGzYh+B5pm4rGHXoGbYIN6JF6j27QFrcZ2yzy
 buSlnXxUGesLK88vIXrMMNrLRbMEEgQJPl+MwxOd95va2ubH4ZpLFLr/hvIXDJ/CuoxA
 pMqDFYUHXQGfM73vczDCLgrJhUjYn7V8bvSxZf6XWUuSxUyUAhsDifHlSLaw5Px+AM17
 QewPiLgcq3AWx/0zOWRaKHRbGAH8FyR92wiPtP6D8+PDPIMoqv4gM6P6r3SUf8h3UfQv
 DE+THnzG0V1RL6JWBDgbM0OJ6/9M2Vwwp9+U7JJPLrV7WE2S2JkwWIitNJsaPS9x76Cm
 Z0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883943; x=1785488743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w+dNk6QVT3h2ncm7bXUtKEg64oe4EQaGNEhvbfYPZlM=;
 b=cYuPOtfp0Htj9PXL2y6MEVZmWi033l0WyfIZO6ZX3FtdpWPSCDNhV7t7bQv/9q4Ntk
 TPDWgR1iaBSwHu/JGI0l6Yz8xpDwfI5f6jgGusSV/U/feEC/tujfLNTR3oHzHRd/75kv
 9hfHoJHVxrS0T1buynK4ewhw39klfilFWjz0ZjmTKkjEMiLV2+cI8XQEaj03FU/I+MOY
 RUwwEcL2HMEp6uGoNMmUa4HwgbgLJj9YaLQOH4FR5FSPbGPcBdtv1y/TQYMRLyAn+LsC
 gw7HLSx9qO6lNQmMJiXZRrApbSQCL8Zb3ptIy3Fa0KJwV7ij/BOpeq5XQvuYMcRGqx7k
 NejQ==
X-Gm-Message-State: AOJu0YxzxhNOs1U80Fh6WHjku9HoREfD7i6eaM0yIz758GjMaV3p4+kH
 bQEOsCWY5uTUI/q09VZ9FWr8aMpGCNCTIgloYpBxm36sAKz6pj5uTE2x
X-Gm-Gg: AR+sD1224ThpPnnBARk9R3ohsG4Yqre3mZS/K9Lrx955rqxRMLKs2yA5CrkDUdJP69A
 duiM8zAG2hHAd0NdHVAdr1bA25vPkZjnINysSaeqR4q6/c2PdJuhAfz4S43w4/Df5FTNkuTqH4L
 kl2u2nUc3ErklC9iN+YsxSKPn4dJ1bOVF0U3WevGXQky+RLWEHCVGBMbruPBqYhNy9nZC0yogWp
 voTBemImFP2idwDfOaDsQ+t+ct0EFeTP+8ysghkxh90lTegiddasp6+vc27J9/CrRZWKKBMelGS
 2573+BTdKpIehPPfCsyyb4tXLj57tgMkaGHYiN3x3lJyc0zsK7xWIuS2MlAstJ8RYRwgNoE15RZ
 YFZHd2oZGHk6n6sJ3Qcr0l+APt03VYEh0dyvEvWwdg/9kqMhLbjixIvTP7s0kghHJVdSTmbXniu
 iajgO88MME9NSv4PYMnG43JJ0T9VyAS+WlAJ5hZw==
X-Received: by 2002:a05:6870:51a:b0:43d:1473:b568 with SMTP id
 586e51a60fabf-457a0c17d13mr3578698fac.10.1784883943061; 
 Fri, 24 Jul 2026 02:05:43 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766e7c9d7sm6701436fac.2.2026.07.24.02.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:05:41 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 24 Jul 2026 17:05:32 +0800
Message-ID: <20260724090532.351989-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wnBqq-0000dP-CK
Subject: [f2fs-dev] [PATCH] f2fs: avoid NULL checkpoint thread access in
 sysfs
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

checkpoint_merge is set by default, but the checkpoint merge thread is not
created for read-only mounts. The ckpt_thread_ioprio sysfs store path uses
the mount option to decide whether to update the task ioprio. On such
mounts, writing the node passes a NULL task to set_task_ioprio().

Keep storing the requested ioprio, but apply it only when the checkpoint
thread exists. Take s_umount for ckpt_thread_ioprio and
critical_task_priority too, matching the existing protection for GC thread
entries.

Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Reproducer:
  mount -o ro -t f2fs /dev/vdb /mnt/f2fs
  echo be,4 > /sys/fs/f2fs/vdb/ckpt_thread_ioprio

Baseline dmesg:
  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x00000000000007b0-0x00000000000007b7]
  RIP: set_task_ioprio+0x8b/0x360
  Call Trace:
   f2fs_sbi_store+0x2af/0x2580
   kernfs_fop_write_iter+0x360/0x620
   vfs_write+0x5f8/0xf50
   ksys_write+0xf9/0x1d0
   do_syscall_64+0x5f/0x550

 fs/f2fs/sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index be92c05a5420..0294544d3d34 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -557,7 +557,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
-		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+		if (cprc->f2fs_issue_ckpt) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
 			if (ret)
@@ -1007,13 +1007,16 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
+	bool thread_entry = gc_entry ||
+			!strcmp(a->attr.name, "ckpt_thread_ioprio") ||
+			!strcmp(a->attr.name, "critical_task_priority");
 
-	if (gc_entry) {
+	if (thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
 			return -EAGAIN;
 	}
 	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (thread_entry)
 		up_read(&sbi->sb->s_umount);
 
 	return ret;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
