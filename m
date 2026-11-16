Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965D606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QxN3WaFr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gEAWNmcM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aA0YKmiS;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpkPldwf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=BYyvcJLNREf5CjQOfKn+ULNYS5LUKJzAA+8ZW0WAaRg=; b=QxN3WaFrLZVo8HOOyZTXlM2WyN
	aiu3zs6/v02b83m1n5C0HCd+nZfDqHljlZH73kkHU1Km4VpJVdgVeKsrNtRwvad8VKI855GCAhF/2
	VkmGnmtN/mvs4ctFN149xWmRwmau9EgtTADD+X+MZ8YpSm7rSBnq0/+6r76u8yGswrxE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT2Uc-000000000P3-3PLy;
	Mon, 16 Nov 2026 19:35:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xT2Uc-000000000Ox-1iSg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=; b=gEAWNmcMBM98eIAB3+Q7eXK5m3
 vI2U1M3Qb/nADed/i1FOXGM9G8RlI6bU/Cstfg6jGXgTpf8LjPg5QiLmmKGUpGuPVpVrv7jB5+1OL
 E/MIaFIVfGNizH9xfLPzEy2PHNkpjK1rqqoEY8+U6rFLhATMDvBOitfnoYVxPIToAenM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=; b=aA0YKmiSZ/Q3WY2f9di0c4oF9Z
 o0qujrpbyDxfxHxYiwwkl5ZQh74nq4sZP3tENjOVJZNZznCSYiyoZE1NF/X1G+sZ6tUTkc+QNCRKj
 OiuvMJ4SUs3mEMMFugLRZ69AzJ2izKPihQBUp3SSMYhD2ENnfHLU8ge7oKTH6z6S9bvQ=;
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT2Ub-000000007fQ-3Nik
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:35:54 +0000
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8b32bc605d9so1731485b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794857748; x=1795462548; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=;
 b=tpkPldwfg8eqY8pJqcYV8QhZYs/uW6NnMS9rb+cCaA3XGaRPpejqG08geUt/QP/T0m
 IXVY7vhoqB60JJRRNoxfNjPP5PTD/Q3dB/6flmhpKQCPRcF+hwetpvBvC6npFwLtkgn0
 AuJZy93QZYS6Fr/HQqeVEP4XC1VgVPlDFrsY0ZzSjIhh0uzw1X5AJropexZZNQ9wH5f7
 ZYmsFTg1uWPAuAwMh/tqMMQA7LldCDNLsHTxucfaJl4/1yasSlZV9AH/mhKlDFMQ1Hd1
 OgHtbbr44mFTBq29vg1SF7n4tlQRdfd1BfNWVDsjfHOANeahnzi9ZS0ImtIyTa8Hkhwo
 ggRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794857748; x=1795462548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PmGZ16/zfSQ9Ll8HZ0cBD3IqbhfI94AYi4t6hcRv9IQ=;
 b=Uih4Mjhzx2FLhrfQy0SVRIKVngx2vhwnx5Unj9sRF0epGzgasjdDWFsUjwSNc62+9r
 VgOX7m89p742iq4zbYfl6WLPzwYLcZiCz+T67ge1YYG6au8HBMXOLipO+h5a56vzt49+
 Nh8O2HhzMGD1p/x96j3eVqNjS+0pLEshmH3C6rRCgZVH6JGQULaE19I0vRePIAKugDdF
 afZhvDmXNm38kqGrdLWONUS/ubQQytz4/HW7e0pYW7AlSbXRyLCLXyHX3IfAEGk+96AI
 O20c9x+BvNc7CaP49fZb7rosAfXh6zHv1m96DG1nZResBJi6LEM2/kw0sk+6InSGKC52
 bllg==
X-Forwarded-Encrypted: i=1;
 AL+hErH7TnT4oHWE/Cie0TVQkOp4TXvaLwtjs9hT66cWy6gFbARdEu5rlFKMKcouZsz3vE2f7tvow93qe5UN0c6j7j+K@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9nJDf4Gw6rAiPJRsHCqieJYRT6S9ynk9jfZUhhHDPK6v6v1G0V
 BRtdueDrEW0f/Nf7P6JRvHEmq9t92r/l3D6WpkP3pC+fOv91LPTQngFA
X-Gm-Gg: AYBFou0DJYg2oN7E02qoK6Ov/Yvww/5Zf4F5bIV9cBvlZGMGSSo0/lLjW8KzYVq4Syu
 ovndxB0kywQK6y6tOYvPgrXAptQ6jsrPR+q9696+3AyW086yHmMKuWZmZlGpJ4Zcz9mH0mnEbb/
 yySVGFSEwUgpAE1RbCcIXGknRE5BQOFy0IPGpKZDaf1CLifjQQqs7G61pTDyjr4bJRCdUViPpI1
 pf6tHGDaQxMD0BN69ssrOuyXJS/WLjhvXopQV5/rbgvpTGZux4pK2jRdhZfeCGRX6HW5BSU67X5
 s7dDt2HfSIzTii0rHcuOlQa+S6oH6laF2oraJBHSyUfJIVq6RfaA+RBw+xuaGJ71lgFqzQ3UtTR
 rjgmahlG6RDAeJVnXK5R2ttVt1YFgVm8OJhZLjnz11o4aknbj1RQKnaZ5gqw11aDoSma0Pi+Nrf
 UdF2g3Z5lpoQJfcBGuOUMPwqkYDcdCvUwHVQbw5uIonH4j368IDkx30s7w7kD+QntHoiHHcY0qX
 bQ1xHzsDVdxhgV4fSEUmYF3BiKtpE9oIVxE7te/OVgRSUeX/0UmPrCgaeVyzm4i9EyqIZQAiSla
 Vn1nfc6IpW7TqSEPtcBZVkrLYbwdQMqFfTVvQpMGe0UCYnvqc+E5Q5bvR3lptXvx3cNRfs4awZn
 nCPYOPugJT8XFcT5jSI8dUYUnoxd0Gp6EAmy2GWikiponYYg=
X-Received: by 2002:a05:6300:8055:b0:3e2:83d5:191b with SMTP id
 adf61e73a8af0-3f7a88cfb61mr7749185637.63.1794857747962; 
 Mon, 16 Nov 2026 11:35:47 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18c09fesm4704933a12.26.2026.11.16.11.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 11:35:47 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 16 Nov 2026 11:35:42 -0800
Message-ID: <20261116193542.111825-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xT2Ub-000000007fQ-3Nik
Subject: [f2fs-dev] [PATCH] f2fs: don't run out of free sections in the dry
 run of resize_fs
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

f2fs_resize_fs() migrates the blocks in the range to be shrunk in a dry
run before freeze_super(). Checkpoint is blocked there to protect
MAIN_SECS, so the space freed in the meantime can't be reused, while GC
and other writers keep using free sections in the remaining area. On a
busy filesystem, free sections can run out and we hit the below.

 kernel BUG at fs/f2fs/segment.c:3020!
 Call trace:
  new_curseg+0x9dc/0xa50
  f2fs_allocate_data_block+0xa2c/0xcb8
  do_write_block+0xd4/0x2b4
  f2fs_outplace_write_data+0x78/0xcc
  f2fs_do_write_data_page+0x564/0x69c
  do_garbage_collect+0x1668/0x21ec
  f2fs_gc_range+0x274/0x41c
  free_segment_range+0x290/0x33c
  f2fs_resize_fs+0x200/0x530

Without CONFIG_F2FS_CHECK_FS, checkpoint is stopped by
STOP_CP_REASON_NO_SEGMENT instead, and writes fail with -EIO.

Stop the dry run before free sections run out. To migrate as much as
possible before freeze_super(), write a checkpoint before the dry run,
and repeat them as long as the valid blocks in the range decrease. The
rest, if any, is migrated after freeze_super() as before, where no one
else allocates blocks.

Shrinking a 4GB filesystem down to 4MB of free space with two writers
running hit the BUG in 3 of 4 runs on a 4KB page kernel, and in none of
4 runs with this patch.

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
This applies on top of "f2fs: reserve space to be shrunk during resize_fs"
(v3), which changes the same function.
https://lore.kernel.org/linux-f2fs-devel/20261114011807.3811774-1-daeho43@gmail.com/

 fs/f2fs/gc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7609c23ec27b..2d2cc3417c36 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2241,6 +2241,14 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
 			goto next;
 
+		/*
+		 * Checkpoint is blocked in the dry run of resize, so the space
+		 * freed in the meantime can't be reused. Stop before free
+		 * sections run out, and let the caller migrate the rest later.
+		 */
+		if (dry_run && !lock && has_not_enough_free_secs(sbi, 0, 0))
+			break;
+
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
@@ -2411,15 +2419,30 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
+/* Count the valid blocks in the last @secs sections. */
+static block_t f2fs_valid_blocks_in_tail(struct f2fs_sb_info *sbi,
+					 unsigned int secs)
+{
+	unsigned int secno;
+	block_t valid = 0;
+
+	for (secno = MAIN_SECS(sbi) - secs; secno < MAIN_SECS(sbi); secno++)
+		valid += get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno),
+					  true);
+	return valid;
+}
+
 int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	struct cp_control sync_cpc = { __get_cp_reason(sbi), 0, 0, 0 };
 	struct f2fs_lock_context lc;
 	struct f2fs_lock_context glc;
 	struct f2fs_lock_context clc;
 	unsigned int secs, old_tail;
+	block_t valid, prev_valid;
 	bool reserved = false;
 	int err = 0;
 	__u32 rem;
@@ -2468,9 +2491,6 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		goto out_drop_write;
 	}
 
-	/* stop CP to protect MAIN_SEC in free_segment_range */
-	f2fs_lock_op(sbi, &lc);
-
 	spin_lock(&sbi->stat_lock);
 	if (shrunk_blocks + valid_user_blocks(sbi) >
 			__get_available_block_count(sbi, false)) {
@@ -2488,10 +2508,31 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	if (err)
 		goto out_unlock;
 
-	err = free_segment_range(sbi, secs, true);
+	/*
+	 * Migrate the blocks in the range to be shrunk before freeze_super().
+	 * Checkpoint is blocked in the dry run, so the dry run stops before
+	 * free sections run out. A checkpoint makes the space freed so far
+	 * reusable: write one first, and repeat as long as the range gets
+	 * emptier. The rest is migrated after freeze_super().
+	 */
+	valid = f2fs_valid_blocks_in_tail(sbi, secs);
+	do {
+		prev_valid = valid;
+
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
+		err = f2fs_write_checkpoint(sbi, &sync_cpc);
+		if (err)
+			break;
+
+		/* stop CP to protect MAIN_SEC in free_segment_range */
+		f2fs_lock_op(sbi, &lc);
+		err = free_segment_range(sbi, secs, true);
+		f2fs_unlock_op(sbi, &lc);
+
+		valid = f2fs_valid_blocks_in_tail(sbi, secs);
+	} while (!err && valid && valid < prev_valid);
 
 out_unlock:
-	f2fs_unlock_op(sbi, &lc);
 	f2fs_up_write_trace(&sbi->gc_lock, &glc);
 out_drop_write:
 	mnt_drop_write_file(filp);
-- 
2.56.0.679.gc527c65306-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
