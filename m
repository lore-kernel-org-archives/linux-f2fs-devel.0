Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894FC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Mar 2022 19:10:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nVHra-0004RF-Fd; Fri, 18 Mar 2022 19:10:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <daeho43@gmail.com>) id 1nVHrY-0004R8-LZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Mar 2022 19:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IzmP5X2K1BS5f1i59g5bK2cyyZHxNOqC8TIBy5CRON4=; b=TsBOxjSYxZcMfXqORKp5vIzJHH
 24FQc899nSvq4EyiKh7r0+Zj4JCekCfs7/vEWfBBtvvr0E9ek9holH2hirzOhg2ooV0LVxyZq+ub+
 rkj3Hc7HLrPv1yBmpMsMnnei/Qgww0NErrq9vqScPjQp1bU3gCRVNUZUBPH2NTWZdG7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IzmP5X2K1BS5f1i59g5bK2cyyZHxNOqC8TIBy5CRON4=; b=G
 1RQDYBQv+HPbzBnf8lMpGd+dDCtJJPrP9yoa5DcGE8AScdKmUKkF47upuzlzt1boIzM7vh9SdJQbZ
 qAWDPcZ3+CNIJr3L5aUBV8VMgztTGmcA+LNxpJJHHj/GNFYahYrxWgCOftZW9kxFZ89XdHm77eMnl
 RKYeSkaap+44PtJs=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nVHzS-0008SP-HV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Mar 2022 19:10:24 +0000
Received: by mail-pf1-f176.google.com with SMTP id s42so10335695pfg.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Mar 2022 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IzmP5X2K1BS5f1i59g5bK2cyyZHxNOqC8TIBy5CRON4=;
 b=TL+wPZUOExCQFV7t11tRDwapOCTIkSSbQ3UsI0+BOkK6x2ELC2+xCHZOx1E+I2zUwk
 5NpYAK+IF8/D0YZD5qRYWVHtLBUFliQg23d4ZDDtJFNfQGHFB/xn+rJivIZ011tNWvXn
 ml7a3xOpzyL0ARzIjGrzfZdybZDks/V/ioMucV2XagHr5dimIH4klZ1R2nLiFrawhnKY
 RY9np4SEMrkH6ABb/FjkYc/+HmbXgCxfp7QfLX44cUlTJ374NW1SAgq2Iseqw60HPFPJ
 2B0mFA6XJk9fLzR5/hjmjeYsXHrKlaUnpS3cK0VxeuZSNY4eTdYUDdmqZPOb+aaEhjuh
 7nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IzmP5X2K1BS5f1i59g5bK2cyyZHxNOqC8TIBy5CRON4=;
 b=Lv+V9Fu4mU327l+Pbs9dT2KCd+/KDPOl2rp5aw3r15KYE8YFCvW1jOBBBKNXofJu8K
 3QvOQzzLzh0UKASR7ZlNWeTIvR7CjN0i0YxwfFlfd+eCRhdW0lwB96z7a00JK388/rIb
 AB0L+H9pGzQZhnNX8MQ/RSLfO4KIDWsQ9rKmSLQCA8mBd3SHw5Xkhb9oYMgSlMZ3W/c/
 vL5WTdgshfJZ71vs7SSh51e+tC0x3x2UxKeHsHTZaoUy4uSxFi+e4etNwgNWsKYmyi8l
 Cu0R5huuIjc+HhlolGK5sQTBfhltqQkUbRVmmCYCcerQKy4yXfkevMwW1ivOgObfkOVD
 2Khg==
X-Gm-Message-State: AOAM5307JOB5capT9wlKZ8FvQtfa4Rzxd8369a0c0A1mHdLIT75uF1yn
 EqAYb9BJR5S9JyA8HKBLGqM=
X-Google-Smtp-Source: ABdhPJwTCoFRb4Bt/BtKUBmCoZ3A/qBpEhjsTq9nW8uLy5cCi0mR2bIVa0UIjj6KvHK2VbrNvhrI0Q==
X-Received: by 2002:a62:8308:0:b0:4fa:7bcd:d0e6 with SMTP id
 h8-20020a628308000000b004fa7bcdd0e6mr1672788pfe.35.1647630616872; 
 Fri, 18 Mar 2022 12:10:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:a64c:198c:4e57:caeb])
 by smtp.gmail.com with ESMTPSA id
 16-20020a17090a199000b001bf4b1b268bsm8523113pji.44.2022.03.18.12.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 12:10:16 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 18 Mar 2022 12:10:12 -0700
Message-Id: <20220318191012.4113266-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
X-Headers-End: 1nVHzS-0008SP-HV
Subject: [f2fs-dev] [PATCH] f2fs: make gc_urgent and gc_segment_mode sysfs
 node readable
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

Changed a way of showing values of them to use strings.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/sysfs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fe29bcb70f46..f2613cc83888 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -41,6 +41,16 @@ enum {
 	ATGC_INFO,	/* struct atgc_management */
 };
 
+const char *gc_mode_names[MAX_GC_MODE] = {
+	"GC_NORMAL",
+	"GC_IDLE_CB",
+	"GC_IDLE_GREEDY",
+	"GC_IDLE_AT",
+	"GC_URGENT_HIGH",
+	"GC_URGENT_LOW",
+	"GC_URGENT_MID"
+};
+
 struct f2fs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
@@ -316,8 +326,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
+	if (!strcmp(a->attr.name, "gc_urgent"))
+		return sysfs_emit(buf, "%s\n",
+				gc_mode_names[sbi->gc_mode]);
+
 	if (!strcmp(a->attr.name, "gc_segment_mode"))
-		return sysfs_emit(buf, "%u\n", sbi->gc_segment_mode);
+		return sysfs_emit(buf, "%s\n",
+				gc_mode_names[sbi->gc_segment_mode]);
 
 	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
 		return sysfs_emit(buf, "%u\n",
-- 
2.35.1.894.gb6a874cedc-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
