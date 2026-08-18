Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D45DC5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3IpHIxhGnQVMwbMk1TTRlAvJ3DD+3jBkN2MrPoM4nTA=; b=VwFEjNXoLNPGzdHOPB/pJG/TBQ
	gXH08ornBCrJ681LM2ATaaS3zyd2gyZfCnRbS0Y+8A49aQWdydG6pQiH+2VZBVcRiXzOKxUl8BMJ9
	OcWR8zR+QqusZwrBY4NVUIzeWi7zYBxi7IcBUZtklLFsxqBt8goZ/2WLxIJpEPPK3kgA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwNG4-0001fM-Fu;
	Tue, 18 Aug 2026 17:05:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wwNG3-0001fG-5q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 17:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rx68bqDUVVVTQB5wmRY5hHoQzrY6WoPdWafYNYcX7x4=; b=aIqlk1CP4z/7CxjnC7W0PTgHu/
 /U0AOcMhdq+FCaGqCLxHLHGQIECrHfm4+H2KX5W4nafLuLG3ZjTjPYTFoB6Js4VyayDJw4aD+eCRr
 LTAnnOlnuZQ5u+DDuSPAboVOKatPjQ17ux1Ln1leA9x/xt/+4eIgpSHDqNFYTOtrGx5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rx68bqDUVVVTQB5wmRY5hHoQzrY6WoPdWafYNYcX7x4=; b=J
 REffBRmjPcuLX7jWZp1lt60Andy0E2TUJ9phSc68xzSNE6N+sH1XC47/LbkCfrgYSxq5Yzjw1KiUR
 Fj8PBMGEm6VgE0xdgB77qIRP7oTRePg5CGxuaWrrET5kK+fNZli6wnLH24k07n4FfoFpssiUmc0s9
 Duf1sZYbCODPom7s=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwNFx-0006NL-QF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 17:05:48 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso236058a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787072740; x=1787677540; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rx68bqDUVVVTQB5wmRY5hHoQzrY6WoPdWafYNYcX7x4=;
 b=bAxApvXqptlnYlS/XeR6IYbxk8s4kxDIvIWHQA64TW5VDEf2KUTZKW1JmFV9dZfnbM
 NgSQZ/3wld0PlOuPeCobqb+OQxZVdwxQmpWHyZxtO85FoBmSFK+qiv6+dN15/5aj0Bvr
 6xvHchND2mWKbkM/N0ZFp4uNCjVV0mrqZoqatzH3+L7BkJTI+mvgZFk7Ns3eHbw8c9ah
 cTNcgHjrKzbyCCLE2U6yevOKXD0NAPEBaegNp+KW9AEbLlrnn6h0HRl9gXlItkeWfVmK
 MzqDfnQAGC6mIITTGmo0iZKOnAxBuM0iqSC0z5vpdwYm1vbO5v165VlSWqyjzL5O2TYi
 m5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072740; x=1787677540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rx68bqDUVVVTQB5wmRY5hHoQzrY6WoPdWafYNYcX7x4=;
 b=XG5ZdLoz7CBFW7bSu4ZKs2S9CFWv3+fiQN7/TK1xRXhLF4Ps1dmg6evPlkLGJqls0D
 +sr2naEz4tYfOVv5ol8FQ4tix3nQxPct9ikxiA85UrXHk8p/Wg2eErxLl1UlF3mkA9Fd
 j2ujj92If+zRoxvarP+j+tQ5MOVMjjauqtQZyndUY9X6hW+p0ocfpEEQqUMDIqdNpXeG
 3GoFbjM84Bk65EyQ6V5dI6FKsdY9AU+JIt6kg9xOAdwkZhf9wdGmY5UrGDgv8c0u8AI4
 AvvdszT4mdD4rCo7Y0owyBcQcoM6KQyTRwkT2ZsBiG3w1gTNav5rrk2neaU4mg359xWy
 EKoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQ7bk256vH3Sdgm/8Okdmfm6Di+mCIHOyzXxRTEB4PWUOuJBfLr/CEaWVVIqgqOimMF1+iaD5PsPcrzl1DlCjD@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyNvdQ/Ode5Q2gxGmcSKQl3XXuuMpa8Q8+y58QNURPvabtSLB0i
 M3a4/K9VwbAHy+QOifGcPvvv1gEfakH4aOhoWQkWxBGhqURq7sxmJhpW
X-Gm-Gg: AR+sD13gLDLtiyHfgECdT9nKFsaSezTJot51oBRJ8YHH8BNEb/W7StLxV47zTpsKDdy
 kQM0D6oZvbbzu0be0SBKP46puS8RoiGknKdMLhIRDRqthulqRZxYQuupA1Fp/ybm6zNukZXPDYW
 x44bqoFx5KobgwOTkw1QoDiSoyHAG4MY+Ylqd7IgivlReS8dYkt0HeonuG1k3pmO8OA11rp6O2L
 Vav62X+d4j9CNPwjOwp6SqpQba4dbdSArK1axUMXolNNHRX7R8Gk3kKo5wT2sgRMGTUzdQu4kKV
 OGewRP3BrmBCefsXAOU8/4WbY2JZmNEv5W/0ebMP1GUc4A29E0+AhheTT42gGUin0hMAno6NH6D
 uUIcY23eoIyTemoHJPR41kKu1IFy3IYRo1PVCWgd7aOVC2v812zlxLfV6o0jBqEhoLFgFFGNN91
 VJqCO5cmz9pLWVPTLFUoDBvF3Qjr2La+5v4qXy/udIUzoWEla3U5VOMnMh77OpdNb3Y40AhtoHf
 4l/ZvV2tIlZORhxpipXvG6CB2nOrknzJpqhK8x2QCOfK5RyTY7DzQ4B1BQAg2cvGtrtRM0jARJ3
 /CN8GH9Ov3Pk
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3933b8c1041mr40405564a91.16.1787072739811; 
 Tue, 18 Aug 2026 10:05:39 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:50d9:e296:7754:dc83])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326761d3539sm17447167eec.0.2026.08.18.10.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:05:38 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 18 Aug 2026 10:05:35 -0700
Message-ID: <20260818170535.3190869-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wwNFx-0006NL-QF
Subject: [f2fs-dev] [PATCH] f2fs: avoid setting SBI_NEED_FSCK on transient
 resize failure with -EAGAIN
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

When f2fs_resize_fs() fails due to transient lock contention or retryable
GC failure in free_segment_range() returning -EAGAIN, no filesystem
metadata has been modified on-disk yet. The filesystem remains completely
consistent and clean.

However, the current error recovery path unconditionally sets the
SBI_NEED_FSCK flag on any error, forcing an unnecessary and time-consuming
fsck.f2fs repair on the subsequent mount/reboot.

Fix this by guarding set_sbi_flag(sbi, SBI_NEED_FSCK) with
`if (err != -EAGAIN)`, avoiding false-positive filesystem corruption
flags on transient resize retries.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 192b16ac02f8..787133ee2eb2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2446,8 +2446,10 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 recover_out:
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	if (err) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
+		if (err != -EAGAIN) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
+		}
 
 		spin_lock(&sbi->stat_lock);
 		sbi->user_block_count += shrunk_blocks;
-- 
2.55.0.691.gc56d675ccc-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
