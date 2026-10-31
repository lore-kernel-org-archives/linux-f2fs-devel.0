Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993D606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Oct 2026 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J8tMU08y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AUlzJ5xZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CcHpQkua;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8StP/RA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=wMiznzfCb5ZAh/WOtMoTKnb8iAAFbPJEE7HqZWfOxFg=; b=J8tMU08yo0GRmiYdtl4i10lBhi
	/6iBVW3ENWTXtrEeT6/MxK08XZwGONL+55ermsvYkUED/VojRoTIitvGtVCMGIesgkGiQVT6CWAhT
	Log1zL5ER+4KPIXjQTCImIGINMM/QBptGqTVCylCmoi/2GX9gNXDNYE85TvVCbVgK11Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNIfy-000000008Mp-01Ez;
	Sat, 31 Oct 2026 23:39:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xNIfw-000000008Mj-0tKO
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 23:39:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=34cB3uC2AMmxA4aiV16zEHx0bet8w40xYeWOvwX1TF4=; b=AUlzJ5xZnotuAV7Q+n+RGCdYJW
 pXvSyDtzAa79XTVJjNHZywUS4BjAs4AysOgS+nYjR+YQQHxk8BnIxK809RowXO4EE5MiMv65dEYdf
 i43CENtbyNt//Liwu63USFWX81h0IVAhuKaOK9qVbCCb0ACZFQdJ+riLWXHNS9gto8LY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=34cB3uC2AMmxA4aiV16zEHx0bet8w40xYeWOvwX1TF4=; b=CcHpQkualOlDfsMEDzqVH4rjMM
 VR2rPembdXpGrhs+Bug6I+bM5qMI1T8wUC707oxOQeA21nCkDcjJccfjDqHuPLUQR5Kze+yNzQ+Nw
 B7UDeb3Q/za2I7bQicXWvneuhM3FbWKN9itywJq7k8gbsTuZwY6d7t3kGnceUtyunAzQ=;
Received: from mail-dy2-f5.google.com ([74.125.229.5])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNIfv-000000003Dz-3ZhN
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 23:39:52 +0000
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-3535a54c09bso1815502eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793489986; x=1794094786; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=34cB3uC2AMmxA4aiV16zEHx0bet8w40xYeWOvwX1TF4=;
 b=e8StP/RAZV1lxnsQ0GpsoW59jpIoOVbViO6rAJrgRBwrPr2Bbm1y3oLzZfS6t3V0cQ
 dW5nzXfmUu/srD6tDnNZ7OQqSU0CYLscf9iQGi8hVlbx6jKVxYQaTFpLKF6WxaQLkuvj
 A51ylUty5kJ5kTUJqpVftJpSASUAltlk9A4LqiGCUxvSV8BEJPtngA5X2IjETxKxsdQ3
 d7tMH12Okpz0ZWzTHgvVT5D2gyR/Xxg+4IGGWUKzD34DWhcyQpl6519gCgNk6k9QAFFE
 znj2Hifsz3YCns4NYzavC9d19NNR28IuutUuZ5CyxF8MCIqhpd4RtFMDZ2+wCWeotubT
 /0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793489986; x=1794094786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=34cB3uC2AMmxA4aiV16zEHx0bet8w40xYeWOvwX1TF4=;
 b=s4x5Sb6l3sRuC4ztnwwXFFuUZ29yGPLg27E0VV9lFIvkdgagqarjwyEJq7Vo6lU4S2
 J9louH2ol08Yr9Rft9Z+9IBe2UquCX9JDRHO/tnR8eIw7HW4aGYCiyDZbO9e71BkSyQJ
 YrIYmQNOXzhQ4Dh0LJAm8tYjc6kCBxIV5z61enR/CO4jD5sKllmCG0JRiVpUvIfeiHnM
 gz608kt3HLkGViidAz3iXD9Mu3mkkzYgpVHXSckez+lyttAVXauSobbj0KwfJBB6X6mb
 AJc/60NbehPjeGytZS1UgX6toUWP7UtywpbCp7Rr4CkEWbtYtELbMJ1alLfZqA0o8qSX
 PQ0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrTG1tODWG+HRl5oe7d+hSLsa2XGeV+e3dY2k/rsVSj6Tn6khLQ8kzZ9454ZG0AHZq7HkIaXp7yk11kwMisQvW@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI26myBsk1rBjLduvuGRiIbbl6qlt+XePvdNEQlDntWWHbWKz+y
 icj276YVBls1WibLuepaVozUrLgss1AEIDP8eSqgdfEnKcRiYJQS4iIF
X-Gm-Gg: AYBFou1hDB+5UtQSIvSPgw7S/L5RzqpjWLaEIQ75qqfnm056CXg9OXmTfdwmH/LBTK1
 t1YaBTOwUbhICIzf62p0HiNRusLVympj4pfjxlL7H4B153ICWUl5u/jC4hzDG/ssdapPxBYLhu0
 4ai/p1/RjyPpX18qTbWMXR8FNuAH1hwkxAzQDOuqi3gJr27uWPKg17TiqHYI0+giqfnAibGPcXy
 tLM5edJXenP2kt413cQ08bY6HoPQuutYskmNGDUxzqNQh+ziIH2ojGUGjDQO3vSosmG7FLgucnm
 RA1cL8kVS168EUUeFjI2B9KHtvwc4e4oxHOVEHuGA9cPb0iRXtI2aV4kFRConL7PobmqwTOtPaw
 ZsUZdiaqi8jwmjYwdeixSIOboe4wuIG6FG3mPv3R9w0NDKOCaZfymcqVyL/P/9ENTKQ2Nq7rKK0
 U8XiJMWH0R/5OuzYOY/yp/RaKFPDR1tPd6VsGBtAGki1uTR942bNUVfyGWntraaawzlY4IFSWHq
 1iSLwS38VwHH9FVuwlgzjVsd8KuDhOz/2MyRVsP+eV/c7DjbpOpoDTi/n7WnO2uZCkMWJ/A8QDL
 nvG1kVWtHYIBr35qVHR+/vTg80qIdWDWAMQsdaM4RquS6+86+BuzbaCp
X-Received: by 2002:a05:7301:6193:10b0:369:a162:af96 with SMTP id
 5a478bee46e88-36a4238974bmr9155351eec.17.1793489986095; 
 Sat, 31 Oct 2026 16:39:46 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428ecb61sm18318233eec.10.2026.10.31.16.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 16:39:45 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sat, 31 Oct 2026 23:39:35 +0000
Message-ID: <20261031233935.9600-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xNIfv-000000003Dz-3ZhN
Subject: [f2fs-dev] [PATCH] f2fs: preserve 64-bit FITRIM minimum lengths
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-kernel@vger.kernel.org,
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

The FITRIM minimum length is a 64-bit byte count. f2fs_ioc_fitrim()
narrows it to unsigned int while applying the device granularity, so a
minimum of 4 GiB becomes the device granularity. fstrim can consequently
discard free extents smaller than the requested minimum.

Use u64 when applying the device granularity. The checkpoint's
trim_minlen already retains the 64-bit block count; also widen the
discard policy field and its initializer argument so larger minimums
are not truncated when passed to the issue and wait paths.

Fixes: 4b2fecc84655 ("f2fs: introduce FITRIM in f2fs_ioctl")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/file.c    | 4 ++--
 fs/f2fs/segment.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7423b3f6e4a..94ff3852bd1c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -522,7 +522,7 @@ struct discard_policy {
 	bool sync;			/* submit discard with REQ_SYNC flag */
 	bool ordered;			/* issue discard by lba order */
 	bool timeout;			/* discard timeout for put_super */
-	unsigned int granularity;	/* discard granularity */
+	u64 granularity;		/* discard granularity */
 };
 
 struct discard_cmd_control {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..93a9c04bca0f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2729,8 +2729,8 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	range.minlen = max_t(unsigned int, range.minlen,
-			f2fs_hw_discard_granularity(sbi));
+	range.minlen = max_t(u64, range.minlen,
+			     f2fs_hw_discard_granularity(sbi));
 	ret = f2fs_trim_fs(sbi, &range);
 	mnt_drop_write_file(filp);
 	if (ret < 0)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 43f400715766..384e0cd5e5b9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1241,7 +1241,7 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 
 static void __init_discard_policy(struct f2fs_sb_info *sbi,
 				struct discard_policy *dpolicy,
-				int discard_type, unsigned int granularity)
+				int discard_type, u64 granularity)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
