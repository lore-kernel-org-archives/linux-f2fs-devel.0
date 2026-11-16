Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A7606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JYEUT5+C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bjywr6vb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VY9OiSoT;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osn7SkRy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=v/0umE6HIM61u2ha9OVlwIxMJq2cswOAiAJtIQqKawc=; b=JYEUT5+CowqgWhHuMCkfW+LFLN
	JRvTFVVrA56rguwOb8GWpV9HddKhIYf4qZn4RWIHTT1gV1mTEVDavwvXHR70Y5a1l9UDy+kdVbPUy
	Q2x4K6lUhEaKOcpMcZ7NygOoEO3DUXG8EISr2uv1U8MLddsMMZ0QKST4oZ/15oGc/cjY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSk9A-000000000Gd-1e6Z;
	Mon, 16 Nov 2026 00:00:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSk99-000000000GX-37gX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 00:00:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=; b=bjywr6vb4QN8WIePoDzM4fAGSh
 uH7jnWhZO/b/nB9MYONTy8wz2UgMNZJOsoDukFTQec21KmcYSeCFFjQ4ASvbd+bEp55PeVntaUKt2
 9tG1SXEGHatcHnwaTnOzdAVa5TpQwVBy92pM1D+aBWaDqNLN4NH73LhTPuJj4Ae8OzYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=; b=VY9OiSoTEdHwqUmvHOIhLvPVg2
 9YLyd1nv6Rj5WnTYLv2W3NYonqE48Dn+Sx0CdScGhvUmkX5nkQ3UlzueZD625dc4ILzJ7tkQz0hMz
 qVEqvIfw06B14SIirdHf3iwJnTWZb+5INKM4b7bck+okRDLiLHkBav2xrTfEXyaQstPU=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSk98-000000002HW-1MmF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 00:00:31 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so1549344a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794787224; x=1795392024; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=;
 b=osn7SkRyZBID8osONqN4UbxIhowaKHdccO3kN5JM+yAmezCo1svqEV3ciFwYyfBbQ4
 AG5010t6CuMQw/0pKaxvPGkc9GiPoFbp6OMsgZHCVwOY3T1NC5KDu8kKDQ9MQKboeldj
 Bmg9MVdyQxM6vJ04Xd+5prz+1dJjjiNarsxCtnLjkxdm5iDhzoxM30Eh146Ze6IMkKtr
 VToYBVp+V6t8cu3tupFSzEgRKONOS84IWu1mDqaOJzU0+r9esEf33CJTsQAbYFmoPfMx
 AKXLCbZ+9ls4Ge2Kh/MNLhnP7zUzwHfih9p5NQBEJeYoqjmECt29XLFxQCkdVbkxMGTk
 Qlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794787224; x=1795392024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7mrq+jL5aACHNl3ltXcO3fURb6JLvjPGhfwWz9B6vIw=;
 b=NhyNWsbnDLfhcCKIPGQwVU2TO8KtiTJu/pPE8aOGvNpVTvc0+kLrLJ8AhlPEsSLk4w
 9PR3xMeG+Un68U92Xc8GD5FVce5FldvXHTj1Bz/7Ke4+rL5npcv0aVzC1X71Y6MS/Qiy
 7XU5qDF9M84tVrvje2lCttfDz+1RQcjySL1WJitMQxQBn3xiTjbfaxIZSFfuOYmAGCal
 3vxj5WG1/JiS9xEVk9g+sZs9wEybYfiwoAvmrAnDxiJjWPoFTtlSWxN1RNXkhypCeiHk
 RnrSKIdOuAknxcfoJI/dX5H8oyUDVRuTSkbC499ySAydlPpGWTGCb56lnzwqLv47zMxn
 9TEw==
X-Forwarded-Encrypted: i=1;
 AL+hErGL9baQYCaErqrEAXTygbsifD10qufRs8qQaXID0QKR8uNMAcwn2wyRua8TqXRZ30nxJ8bj3Qmj3/jWfsv5R4d6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9KI2+ZbhRCol6BPb1+Fjiy0ImqNpcY6oksrGWORdPDcrr3/nlu
 P9xIq83Y22F3B3XSIemIDl4iplgPayK+gM62RLLxC/x5kamzRMNMQVAr
X-Gm-Gg: AYBFou1IUbodOLrqszCN4ZGHxHVz9b3Icsns21zxkwKIjw9h5ttlG4OiT3qDScn+JpR
 aBU4JninRZTH1SCPPSaRWdtqkw5g8sVMnr53EWELR68FzCzp7SqZyYI9hKNDXyluLBqCKkOhMj7
 PcL6bmZlxOHHeeLaTSQ9KERyjlYfQd24HbmEciD/RRzEghntDOWeMbI0Dl6Hrs4mK48yH5e2nYc
 B9qoBG/Pq8Ye1MzuVAgKRu9g3Lkj/kXyTbIYuLtiDFdVysov8EcJx02z8s9sHTBdPjricIgR4Mw
 pUb24mEL8mbJlKW1TaOiHJvBzzj61TfomlrXqgnHgxdipwaBDTGhWGe7G1gRktz+1HeJ2w9GxZT
 jjK7XmVYxHsvhl7SFmN7W2IHc0j5pS56Z9TeI+KoyDT3+nDG5reINFxMND8rBAn1uUBVrZsuZJp
 8PHXVAZBl6Hr1T5L25Vn2CtlCiPfdpD4ObBJ9aAIPF5yignTjAK7+PARfEQkOaVErg5pzcJos4q
 3IWGzKJXXzF+7fU2gBHGGsk92PSESxeQVpyqt04Gcw95/xUCRjJpgzL4pN5uYnR/Xi6taKer9Ui
 1YqJtyYcutlGDr2AqlF4mQS/thlmxyh/o7CA4HjQjrFhMof+YpkjujyZI6KC+jMS6u9deSLdxJ/
 fZ4n9aRGVxLTaWPkX86MbNN/CK4bJY5QT9qpMrLdSwLbJCw==
X-Received: by 2002:a17:90b:5608:b0:3ac:adce:60a9 with SMTP id
 98e67ed59e1d1-3b1b07ef0camr8541905a91.9.1794787224413; 
 Sun, 15 Nov 2026 16:00:24 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce556dsm19125756a91.6.2026.11.15.16.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 16:00:23 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 16:00:19 -0800
Message-ID: <20261116000019.2299222-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSk98-000000002HW-1MmF
Subject: [f2fs-dev] [PATCH] f2fs: block checkpoint before moving cursegs for
 device aliasing
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

f2fs_ioc_reserve_dev_alias() moves the cursegs out of the range of the
alias device with gc_lock only, before it takes f2fs_lock_op(). gc_lock
does not keep every checkpoint away: f2fs_ioc_reserve_dev_alias() and
f2fs_ioc_release_dev_alias() write the checkpoint at their end after they
released gc_lock. So the cursegs can be moved while a checkpoint of
another alias ioctl is in progress.

do_checkpoint() copies the positions of the cursegs into the checkpoint
first and writes their summaries later. If a curseg is moved in between,
the checkpoint does not match it. Commit b4b10061ef98 ("f2fs: refactor
resize_fs to avoid meta updates in progress") fixed the same problem in
f2fs_resize_fs() by taking f2fs_lock_op() before the cursegs are moved.

Do the same here. Take f2fs_lock_op() first, and then move the cursegs.

Test: two alias files, with a debug patch which makes do_checkpoint()
of the release ioctl sleep after it copied the curseg positions. A
reserve ioctl on the other alias file moved the warm data curseg during
that sleep, and the checkpoint recorded the segment the curseg had left.
With this patch, the curseg is moved after the checkpoint is done.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..75c51b3a4118 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3905,13 +3905,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	/* Reset the victim information to prevent GC from targeting the range */
 	f2fs_reset_gc_victim_resource(sbi, start, end);
 
-	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
-		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
-		if (err)
-			goto out_gc_unlock;
-	}
-
+	/* stop CP before moving cursegs, as f2fs_resize_fs() does */
 	f2fs_lock_op(sbi, &lc);
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -3920,6 +3914,15 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 		goto out_gc_unlock;
 	}
 
+	/* Move out cursegs from the target range */
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
+		if (err) {
+			f2fs_unlock_op(sbi, &lc);
+			goto out_gc_unlock;
+		}
+	}
+
 	/* do GC to move out valid blocks in the range all at once! */
 	err = f2fs_gc_range(sbi, start, end, false, 0, false);
 	if (err) {
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
