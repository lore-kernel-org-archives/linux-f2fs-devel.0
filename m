Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9630FC55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9wWFOUOP5XhA0xBTX6oDQqx33+mhYEn8Gp5FomIbias=; b=JNAKCrrofJ0Qr61wh1zvQvB6xx
	GDMv3/gLY0PclTirzRuu3c2vd6Nh1GU7I7XWNITtYOjF8IY8qbKjEBARE26MynwpE0gGFLkHnwBKJ
	p2bFpE7vRd2iLU5JjinG2wGxurDs5VaVKQjvpCHp3qB6pZ1DeMsJyPLT25kPwWg4BPY4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqotJ-0006Lm-T6;
	Mon, 03 Aug 2026 09:23:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqotH-0006Le-GE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=36DfFnaKp7F3VEC3jxfIMLP7qmnl1Un/0oJYybEu4d8=; b=DCeNOFo/56s5OGtRplPFGBwo14
 A71V/eUO5bO+WFHrYayza/K/AQPfIWY7XvA9d6FWuWfYpq1XsLlLH1H99IywIFSQZYJJXSNH4r6rq
 pz+Ok9z5FD7LxkkbiRIwE9QcKY+QumliSzuTOm+Ry5mdDbOujIgYjPQGzweDI7I+OGhI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=36DfFnaKp7F3VEC3jxfIMLP7qmnl1Un/0oJYybEu4d8=; b=l
 iDwQUxIOgLcLbPjkiq1FKoWr+TonUoDB/HcjienRZLH2JUyx6ovha4GBHTc99cx1wkzoq5+Jlej4K
 9gbYuKZhffwqJWOCBTwHvFjee/97QwUzRlhs2P8/abqRyD0jYMfIEToNmDSfFBbL4i43zBm207CVc
 YaxXaN8FFGs/1FUQ=;
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqotD-0003ZO-Jx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:23:20 +0000
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-848d21bbaffso3377269b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785748994; x=1786353794; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=36DfFnaKp7F3VEC3jxfIMLP7qmnl1Un/0oJYybEu4d8=;
 b=fQk/ZMLzDcAG199RK6S5l+v1KVtBMGHa8OFFsHbWTmlSYDDLTjIrGBmz2NPSgupGgF
 syhhmUJ4BdhsICl61w8nyaX1mnclNvrRfkwuAVaQUQ5rFXo76F299v9IVOFbpJzFi4HO
 +7I9sFPidStUFaKMC9vrIKqkVZZ6JAiYHaP053B+/gjGKJoglqG061UaKu533K+8pSph
 JYkYcdAJkE/u/fNKdK3wLZELwRr9o5UExW4QblqQJzoDojMRKkqH77d683QK/PKnQEEG
 uqr7fXHwZ826WAhhyUJt1496gdzyLtrERni8CtPLHw9OXkt3PJ1ixKIcYyumYN2OXUaA
 e08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785748994; x=1786353794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36DfFnaKp7F3VEC3jxfIMLP7qmnl1Un/0oJYybEu4d8=;
 b=k73eiIA8u6pK9vEnKI08QtfzdD5PpJDUUt0eMIxRNfxuePHCfxC9lXnkqCuiSWGAfq
 8hmbDR7SUIJtkq4KCLfEorGBC4qh5rgOELMuyw4A94+LFN52a0XN06n5tIB8Q5KTs1Kv
 22bn8jErcxxBl/u9QmicucpadVzJaNu84kIHHSE5GHe6SZ8vC/qY1FLHHz38vj6Mxp7w
 x9WhUzccpivndIxBinbD7UNwcLu2WumJuR03uXuq3RkqyG2cCu2THY4iPlCm/Uj/MlS3
 VGC8cTDmTAbbeUfa636Q8sgCoxQZF7GFTRotlJuECi8N1yk38ElRqdmdhKJ96orozGB5
 m2BQ==
X-Gm-Message-State: AOJu0YzmCnKNGBqroOopB2dynCy2etKXLnTVxFUufhsjK5HgAPSOPk6C
 fg62qUpJX8DrJ64hAPi00Yl0J+eTjy+aAhxXUT0jwfp3PKR8CDIjUry8
X-Gm-Gg: AR+sD11njxUgH4w/jd8Ce0US1FbSJqUMYeVXFxDRdJNZY7+15un1COccpYIqCrRwsN4
 UPh+F7Q8x8swtanvpimN7BbljyX/h0TzQQJivMHTVlklEP8vf8HpVag7uDiKCagj+UNzrNrVXaX
 GO8rsIF81OahsWvqnOuaYpyitjmIM2w+ywRYIK0nmI1bYTVKh/L0NJRn7EM+CPW0cKh/xE2se9f
 WOu50b2tYpHZ5dE3aCXP2D+6p36q+3QHaboO1sd56sCr6pfszB/CAa1DcItXFNr/2ADRgGKoCCA
 hv2zSKKUdA6Jagtv9/a8Ngs8NdDbaMtHYbrXBT652TMh4YXZgjcYkvIbTKnyCPzLc7OnsIARAUb
 FVAGjNYtpSRmmFgI300ehAmKEM19+k+79ulDr6hAbps7Jf7SC9OIq2Oe3sZGHZ/7L6fAfdwXJJ4
 aaLo95PjMXofYS0+gZ0Kxu5OlWzArTNSuuOQ6UwtiqniLATQD6ffzEUPWPYEKvL+CYEzEWufEPM
 qZlIITCIm2D2rVkIRWfCRtQ
X-Received: by 2002:a05:6a20:db09:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3c92a4c97d7mr8783074637.14.1785748993939; 
 Mon, 03 Aug 2026 02:23:13 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe396eb4cdsm3354553a12.20.2026.08.03.02.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 02:23:13 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  3 Aug 2026 17:23:06 +0800
Message-ID: <20260803092307.1437283-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wqotD-0003ZO-Jx
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: avoid NULL checkpoint thread access
 in sysfs
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

checkpoint_merge can be enabled even when no checkpoint merge thread is
running. A read-only mount is one case: f2fs does not start
f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
sysfs.

The ckpt_thread_ioprio store path updates the saved ioprio value and,
when checkpoint_merge is enabled, calls set_task_ioprio() for the
checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
NULL task pointer.

Keep storing the requested ioprio, but apply it only when the
checkpoint thread exists.

Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index be92c05a5420..070f9807ae81 100644
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
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
