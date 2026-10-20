Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850A606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l97BfXxF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H+131dSF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ucd5Cj6z;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AcnIT1K1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+lHIgbFry6Qs1j+eWTIU2YhPrmWeAw6Fxq1AwPbfvLs=; b=l97BfXxFcAw9P+P86kPHMpwu80
	4USY6G9w8wuRexfsrDv74v0IvlOyg6EKzVivH7HJxb/l1uUHL3BK+igPzxVeZGTUq9WcQfjrKbASz
	uSeH47HtlI+6SddHezMztx7WgBCRnS6foITlfLOMUwTDxk3xPJY0eA8lSxRkp5XHBuOs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJ3ro-0006mF-Tk;
	Tue, 20 Oct 2026 07:02:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zangyangyang66@gmail.com>) id 1xJ3rn-0006m8-TR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 07:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GydoEVkrj5eOW2opT7oe0D2rO6A3iFvTv9tZaUesAwg=; b=H+131dSFZvNgt25S/oEc2/zdWQ
 OFCI47UbycxcXjbDrN0Ur2E7PiNfwNHeOiXNQan5SNj9bAPNkdHT/lqXCU6cKNmw6cVZbFb3CRQUR
 BAdM/8Y5B8ZFCDU1aEx+/pVHQiO7LsqNYR5p4IYHbFjCvNl52HtzpudavqBGLhEP9ZBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GydoEVkrj5eOW2opT7oe0D2rO6A3iFvTv9tZaUesAwg=; b=U
 cd5Cj6z/H0x2kj6Go4jpe4xRIrz8onhskujd3pHJes3DunrdOwII9kbofRFJka+3+KJQ1PG4+a5ri
 wJloeivR7dKMqSUwhbJQGsl1LKyQIaOoR15Di72D6mvO6L5KHMPAgdw+5knit+y/na198UZjC2PDn
 5eTMAN1tcz9+gcL0=;
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ3rl-0006qI-Ba for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 07:02:35 +0000
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so1580908a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792479748; x=1793084548; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GydoEVkrj5eOW2opT7oe0D2rO6A3iFvTv9tZaUesAwg=;
 b=AcnIT1K1TmePNfHU4uMl3h7SANZ9zmZl4cuIp+fViSRyjfPbpsSEUHIs84DoAoJ6/A
 /2KohBPUp6lI+aFR14NBRFBUVDf7vFJz0d6nfg3Fhd/o1x7UfScp6riKkqJHIiYTPkSO
 Kw/BFK6yaIRflgIn7XVLt+JUY7GpzXXZQa7GVC8j8M3ruZT9D4vZMofOGlLKqdRJe18g
 OJbi7G1eqqMac46lnHi2NPUc7e6ESYKeUJIvGBXWq3+g3k606+9McbEbAEmZI305S8lD
 C19SXpm4P3dnwlPfb1kioIPKZw6N/v07MNtWXogCzadeX5zX/+RzcolBsmJ0rwA49ut7
 1xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479748; x=1793084548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GydoEVkrj5eOW2opT7oe0D2rO6A3iFvTv9tZaUesAwg=;
 b=tvrLUoidmdL11VNqKh+BrmlsEC+mLIEL5HYjm0OUFpLwxFWBK6dAoiixmDIbUZvUfS
 caBiNdQTi1mqLb3N4PZraolGjp8cAF6tAJ5Onq/nXZrx7h/B/QVIVlIzjRfFq9IkaJlj
 NypRr/ovGINwH/bO/Jq+9q9r088v3//81zPhyygsRUC6hjt2ZL449D88sWc1br2o3dVL
 EROXAd5ep5hjBFAmV8P3/YJlaFQyKjWvZ87GFxh25WkIyT+39Cw5zpobTvDTAsQYBl8S
 pRBfBYwQSgHTuXJih3WqEKKgppP40/ODg37XNcJjZ0K9/6aB/D4mm4xux+NPTFQMHLBa
 LKKg==
X-Gm-Message-State: AFq9FYI8jN1GzPYwkBR/Fw3CsAugoeBSLTsv5W+MQ7d5HmY/78/R/k8u
 cPBr+7HOm23ffu8mkap5H/MAJM3KQnmWh5rTpbYvul+7PW+1zKhJJzSc
X-Gm-Gg: AYBFou2EFgx5qUX9gRf+kkl39ri+VYiBC+JpnDDNlbYayUEmQlwKN/uiG3K/ZCEio0r
 LoL0a0Yyrc46sAHxv3CvmJNcKtkOO5QIIKrtqc6dN2biV+OTMnlZDn5mof6Ru3YRB27q/ublUQy
 R8iOa+YHLFkXkNClCZVgxRElpO7HjCoAneboYt4PTyWbgpXva3a3H+YxYGZ7voSQwPsL2wfbBab
 TVIlM69stm8ThaeaCKsAtRKFpLVOw+F2F6z4OP0pjkTfHIX1p6AVyEhrLjKuFajhbMELMQrLu2C
 dIPNJeK/nhm16aO7kZUY0bj724k7Zl2QtdW82ULL+sM1vH4aQfTCBAGLHGyqnl4u1iP5W+NboUF
 vdl6zjW1GlaEwY3J2R6YsRaUfWr9xXAepJM094m3Fy7A2DIims5IVn1GKiBXDduTKycvhb/RpMW
 wZXTc7d+XBLSxSq5ldinVGwwCBTrzd3gPGYbFGk1bcjXDTWWtOkLj8eSPKh1Er7wrhxDktY/gha
 mM3TRF8cVhjfNixuST7hwJj0A9YV8Notc3bGwi0cmenKNq4aKSHNeZTIa3HhElgxs4OQr9a/T8=
X-Received: by 2002:a05:6a20:7f9e:b0:3e1:8563:2a2c with SMTP id
 adf61e73a8af0-3e22606ffb8mr8874757637.40.1792479747523; 
 Tue, 20 Oct 2026 00:02:27 -0700 (PDT)
Received: from zyy-m760t.mioffice.cn ([2408:8607:1b00:8:18fb:e3b4:d8c8:7fc4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd65497df08sm4483343a12.6.2026.10.20.00.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:02:26 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 20 Oct 2026 15:02:15 +0800
Message-ID: <20261020070215.1285307-1-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xJ3rl-0006qI-Ba
Subject: [f2fs-dev] [RFC PATCH] fsck.f2fs: skip roll-forward and block
 kernel fsync recovery on record_fsync_data() failure
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Sheng Yong <shengyong1@xiaomi.com>,
 Yangyang Zang <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When record_fsync_data() fails mid-way, fsck aborts and leaves the
image unrepairable. On the next mount the kernel still runs
f2fs_recover_fsync_data() and walks the very fsync chain fsck could
not traverse, recovering data against a broken chain.

Fix in two parts:

  1. On non--ELOOP failures, skip roll-forward instead of aborting:
     set c.bug_on/c.fix_on so fsck proceeds to repair the image.

  2. Block the kernel from recovering against the broken chain: bump
     checkpoint_ver's low-32 by 1 in fix_checkpoint(), so
     is_recoverable_dnode() no longer matches the fsync dnode footers
     stamped with the pre-bump version. find_fsync_dnodes() returns
     empty, no recovery runs.

Fixes: 057d65c98e7a (fsck.f2fs: Detect and fix looped node chain efficiently)
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 fsck/fsck.c       | 3 +++
 fsck/mount.c      | 9 +++++++--
 include/f2fs_fs.h | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 4fca4dd7eb1b..f7a389c4eab4 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2760,6 +2760,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	flags |= CP_NOCRC_RECOVERY_FLAG;
 	set_cp(ckpt_flags, flags);
 
+	if (c.fsync_record_failed)
+		set_cp(checkpoint_ver, get_cp(checkpoint_ver) + 1);
+
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, fsck->chk.valid_blk_cnt);
 	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
diff --git a/fsck/mount.c b/fsck/mount.c
index 4c63c2d185ba..16daeca7bab3 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -4249,8 +4249,13 @@ out:
 	ret = record_fsync_data(sbi);
 	if (ret) {
 		ERR_MSG("record_fsync_data failed\n");
-		if (ret != -ELOOP)
-			return -1;
+		if (ret != -ELOOP) {
+			ERR_MSG("skip roll-forward\n");
+			c.bug_on = 1;
+			c.roll_forward = 0;
+			c.fix_on = 1;
+			c.fsync_record_failed = 1;
+		}
 	}
 
 	if (!f2fs_should_proceed(sb, get_cp(ckpt_flags)))
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 21310fa6a1af..913c24cdcef2 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1596,6 +1596,7 @@ struct f2fs_configuration {
 	unsigned int quota_bits;	/* quota bits */
 	time_t fixed_time;
 	int roll_forward;
+	int fsync_record_failed;
 	bool need_fsync;
 	bool need_whint;
 	int whint;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
