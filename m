Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BC606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Nov 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O1OzWkXH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=esni9OTE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=akZni/+r;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/XZ3hCC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Dt50jz3Yxsfx3G5AZoucq/PQQEVXzkSsZx1n3EDXzbU=; b=O1OzWkXH41sMm1gqc+ww6tYbtQ
	v/PNwOBWV2ut8u1fYBaFinzbzV9qT2sowzAUBvVN/W3ytbb5pLgeilbZ6sE+AdmSbx7T2BpUcZR6C
	xNtDTWECYatUo1mc9ADnMczTKb7WG3qvvJLwl+9ZStOVGUsXGgCEY2FCFW61IS7sXTH0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xShtE-000000001kl-2V1V;
	Sun, 15 Nov 2026 21:35:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xShtB-000000001kN-2e1p
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+bEaKhMDCZtV/jlBILoWtbmCL9qsyLUohE1CagS/qY=; b=esni9OTEUoVzC/K33sCacGDA+J
 ywXNAYSomumipzElLGSidUvgzgLEienbAvmjTa+COqJdkamXad8KoEJB7PIhRoMkNMb1L2hpOaOPC
 +uR0rER+EETjPaFLb41rqYoMJAM2qJpJgRDvPnU5gmkFY4AgEECj3m6GT3rdaMrcL+Ow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+bEaKhMDCZtV/jlBILoWtbmCL9qsyLUohE1CagS/qY=; b=akZni/+rfoccMFxa9bvugaUjIB
 JIq8vzyq6BSkGCVS7guo13EpAlS0U+SVGwTl5PdlSaYZE+Hhrg4sGsUnYnpbefshNPIHN9NFr09pD
 Zg9RK4LeAZ6XrCUkFECSoMMclpeaGK6MyUPZ+5QrO42mX+rTJbCUk8S4ncL1cB0jHQzU=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xShtA-000000000Ex-4C1H
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:35:53 +0000
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso995954a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794778547; x=1795383347; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v+bEaKhMDCZtV/jlBILoWtbmCL9qsyLUohE1CagS/qY=;
 b=d/XZ3hCC1jw7ILBpTJjwr1KyB6sgigzU5MpjfqU4G0o5JfzX8TmoR33lTzRUsnrKkY
 BtwBh7DQcRXUL4CgCZOgQAstzX7FHlXbZfladnrny2dqbsSx7LguoZlQhXu84xaE9dZz
 UYMAS6JzKkdeNKq2KxFn267PH7uxLsfrZmYMdbj2CqbtCW5j2ZoMRY5Oj+eYd1JKZ+xK
 iIDiD27KxljGJNOBPrS4/mTEt+tGQnsNFdYBVr+moEr1Qj/a+tfx23b5tVVUVXwwg3wL
 LeHM7oZK/ojF1UkmJD0TUizjFwH02cLrhmGrmx+UAyuXRys7e5ssnuzjtpXO/4TmFjTC
 UtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794778547; x=1795383347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v+bEaKhMDCZtV/jlBILoWtbmCL9qsyLUohE1CagS/qY=;
 b=PZKkeHAda3Lm72XDiqI81dO8ofotUW/pAQPRPJrMks960ScZCiisw/7+8hgrQrz/x7
 AEsizDQYJ6d2YD7sg4k0iwplceBDobOKwPZmVX4bllnoA2s5J1L0WLRr4Ml5/mX8IxKf
 5QCXPxw/KbQiTk91zM1q7SGMcmxqsCYhPsravhWcDROCXXZwSyWiipNDIvKMW6F1rVtZ
 uhu9ZsPRsbt19GhHlNfor1x96QejoiIEW5h52WBwDM8dVa82JGBiGhlHow70qCi31Eqb
 5SbQka/3hMO3VsII0pp6K/1FZJ87JE+lIe4DIZRwDjlLS6uQu5UDG7+ajgQGZCJ8cotM
 ivwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE93A0LItuolXFCLE4wO0nu7WkjfhD+z9MkWP8PU1hHlGpWPWLCs/+iDR7o7YsNM4+9EOxOy+UoM4s1ZWeXr9kR@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vlpzw4YzQqUa86ciJCbIkGh417wUbur34zhK/alChHhUHEG7W
 mprqpX9hzKz1v5bqBUVrK34XN/mVeYdkkaOi2w1nn1cqxIgeLtfXBuL/RdcNPw==
X-Gm-Gg: AYBFou1VtPW15RxpsrYieR8FKwOg7xHmZV1Ib0Z14e57j3swGUPMH5SokaNBYLoB7Oq
 DAZcTX4ZeEPAyOjVpFNdsVcD5UqWyAt26PKf8TIBcQypTnYdTLfanA5Bh/sb7hC4jbcdC+wXw7+
 /QQb8QtWxpfQo94JjKUI8pqWL0FUzVnmQYAUJr5ePvEcNeBSTkHUrGWJC+ajJ+XBgZeQlxmyEqA
 8rOxfGm631zti4Har5IDxm4tn129tNoB8XhMVgLjku+vT/JKPgntwCDnP285lmZwsje8Wro4FEe
 ZXzrV0ORCUSpC6tyfMvScA4/AeFefNQ2boE37FAyuOxVU2WOMxzMJqwaPtxd8d/MkcwCfufVEGN
 NetHP2RjIojo21tE8b69ejEhuHKqJ1hb0ADp2op8d4y7zflhzVVFGu25EB+PPWbbAqYSAfFF1op
 mihrUS5mYhmcPWGEupR5ZoPCKsSMnONTdtNFzItfstDUBYBgZMw3VT0e7pXuPEQFwUIzQVO2+BP
 PdXIoo3Pxhzi5+03BgtGylKFYr81UOciAJQ+JEDNJFJeHGA/OHgj2Kiat8LXc3gDJ1fWnHqwg7a
 zeCnANaMWx2Mq/HhiLYbiRmdxkF++InP/2Yis5+9CSNQByPLFyqPit6rvudtr3e4Wr4vdWezC3R
 4BcIkgR5bY/GpqCQ2TJDLFhsD1BCMXZpkO8RpH4SBAanZ5XA=
X-Received: by 2002:a17:90b:554e:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-3b1b07ef11bmr8709233a91.3.1794778546907; 
 Sun, 15 Nov 2026 13:35:46 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce556dsm18831394a91.6.2026.11.15.13.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:35:45 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 13:35:40 -0800
Message-ID: <20261115213540.2100311-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xShtA-000000000Ex-4C1H
Subject: [f2fs-dev] [PATCH] f2fs: write a checkpoint in fsync after the warm
 node log is moved
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

Roll-forward recovery finds fsynced node blocks by following the chain in
the warm node log. It starts from the next free block of the log recorded
in the last checkpoint, and each node block has the address of the next
one in its footer. f2fs_allocate_data_block() fills the footer after it
moves the log to a new segment, so the chain is kept when a segment is
full.

f2fs_allocate_segment_for_resize() moves the log out of the range to be
removed in the middle of a segment. No node block is allocated there, so
the last node block in the old segment still points to the next block of
the old segment, and nothing points to the new one. The node blocks
written after that cannot be found by recovery until the next checkpoint.

For example, with F2FS_IOC_RESIZE_FS:

  - fsync(A) writes a node block to segment X, which is in the range.
  - resize moves the warm node log from segment X to segment Y.
  - fsync(B) writes a node block to segment Y and returns 0.
  - after a sudden power-off, recovery follows the chain in segment X,
    recovers A and stops there. B is lost.

Checkpoint is blocked during the first GC pass of resize, so this lasts
until the pass is done. f2fs_ioc_reserve_dev_alias() moves the logs in
the same way.

Set SBI_NEED_CP when the warm node log is moved, so that fsync writes a
checkpoint instead of relying on the chain. The next checkpoint clears
the flag and starts a new chain from the new segment. Such an fsync waits
for the first GC pass of resize, since checkpoint is blocked until then.

An fsync which has already passed need_do_checkpoint() can still write
its node blocks after the log is moved. So check the flag again after
the node blocks are written, and write a checkpoint in that case, too.

Test: four tasks create and fsync files while F2FS_IOC_RESIZE_FS shrinks
the filesystem, and the machine is rebooted by sysrq-b 1.5 seconds after
the log is moved. Without this patch, all the files whose fsync returned
after the move were lost (454 and 437 files in two runs). With this
patch, no fsync returned in that window and no file with a returned
fsync was lost. The second check was tested with a debug patch which
delays an fsync between need_do_checkpoint() and its node writes.

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c    |  8 ++++++++
 fs/f2fs/segment.c | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..61ed0ad5d29d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -466,6 +466,14 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto sync_nodes;
 	}
 
+	/*
+	 * The warm node log can be moved after need_do_checkpoint() above.
+	 * Then the node blocks written here are out of the chain, so write
+	 * a checkpoint.
+	 */
+	if (unlikely(is_sbi_flag_set(sbi, SBI_NEED_CP)))
+		goto go_write;
+
 	/*
 	 * If it's atomic_write, it's just fine to keep write ordering. So
 	 * here we don't need to wait for node write completion, since we use
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 31ac93a93021..e77a01376288 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3488,9 +3488,17 @@ int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 unlock:
 	up_write(&SIT_I(sbi)->sentry_lock);
 
-	if (segno != curseg->segno)
+	if (segno != curseg->segno) {
 		f2fs_notice(sbi, "For resize: curseg of type %d: %u ==> %u",
 			    type, segno, curseg->segno);
+		/*
+		 * The chain of fsynced node blocks is cut here, so roll-forward
+		 * recovery cannot find what is fsynced from now on. Let fsync
+		 * write a checkpoint until the next checkpoint is done.
+		 */
+		if (type == CURSEG_WARM_NODE)
+			set_sbi_flag(sbi, SBI_NEED_CP);
+	}
 
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
