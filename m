Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D52606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iYlaJ0c2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E6bgLt1c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N6Rv1sPa;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NaD+HooS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=CqVRbbndMQGVLchnKU9zMW+xHvnlLDso9/tpsHC2dJM=; b=iYlaJ0c2+lxCZl9QqFXV1xcsv8
	4+iVn9herjXjF5/UR8eLYJaF+hBoaManjuf/bDZtAW+Ot2PUCYF8dlziR3BNj+J6aY9ReJUEKj2D6
	hi/pwQ5lF8whsLyKkvJZhVKGRy0M5cSJErlXAc5EpdIyq2sFB8TpBkQ3ruv6rodV2C7w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLIIF-000000003Qh-0rzU;
	Mon, 26 Oct 2026 10:51:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xLIIE-000000003QY-2jXN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=; b=E6bgLt1cmKHXhKgDu6/xe89izy
 PHZ5sNWOQpHHgTyFa1M8qKVHpExLuvIcb4SLE4em5V061zLeT39CbcuZ5m294jK8jQCy0LbfCjlp8
 uqdzLFAEVgFA877NEinMRHZM8hrfpLmvBYzMO4JtMprYGXgizVqrJPiDJw/FkfiTWlEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=; b=N6Rv1sPaQTnmw2xzVlQe2I/u+u
 xPgzddYraqf1nPC8GnRHSd4kXizGO0Xm5OpU63qglBS+71DQ/6cD4CV0QQmXaQQNUAxfRGz4KmOBP
 Zf1WuaReCZuW+n241xJ/FXyY9KquYV05w7Qk/CLFeYZTFTHOB6RqAbjSHMgMj2yQkcbE=;
Received: from mail-dl1-f52.google.com ([74.125.82.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIIC-000000006De-0ZQ0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:51:06 +0000
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1846bc43c28so2805563c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793011858; x=1793616658; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=;
 b=NaD+HooStiPQUDr90tG9E7IUJ4qWqoU6Za6M8JnRUDOllHIo6rZLYP97ov/V7WiqeE
 QpSJOzGM9jjOOwiZMIqHqcJdV1QNBVS/EKaZfaVVifWlBqJnrv5GorEsghamIO6zxL+V
 cNxCkdYEMyqk/4BWXdDGqYoizz0Tak8ZsxDdLYQ7U8Svip+B0BrgAzsROZrJsSmQ7qlK
 wrCHmBH29HEdAPvdwySgQ5RuStsLspyctipfhBvD3xm1J6i6L2bqJgaoGCS1O4G5eCKa
 RX7LYXXUpxQXlHoKNY8cokEE2rNDE/vORMn/B18ATfcIz64gTUsNqt+wDKrrK2fpYZ4W
 WzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793011858; x=1793616658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=io9R/T28rLxuixHyPNzGTDg5gzAwHn6Z3f+jZaKGnbg=;
 b=qujDltF50I8fuZVPXqZ2KZdXSfhL7ciODN627xBOQGc6Q/ORoV41JDoqVOaNp0+hKc
 +nbwzpMWK6ALAh2/KcaOW7Z6aZUbCi/MMgamtb0AYXlSTf39XCVgQgjjvqcCzmHA++GK
 KG9I36fdGne3Szs2oX/YUT3lGEt30tFj6O1UWoympgTqhSXLZkNfMjoH0eW9P1sLHefu
 ULYacIiNvjPEzdHncdmGMq5/oqjT3qSIEEBnJ8MkNva4vOHpeBgkODyAwpU8e9GCQ502
 j7kGdmtOjE+mgoZHL9HEO+M+dwHFdwReXX9qmSEiKPjztbVPnuik0ji4kJjEDAwwfraQ
 qvDg==
X-Gm-Message-State: AFq9FYKcIDf1czrHDSgUZ5MkIz6gEn0ps1h8vjaxhwd8HFtDJVL7T6ec
 7nDKTxauwvnREfnLLXciROQYEMoilhvOoPngvVD1og9q0HgiGaVbDHwi
X-Gm-Gg: AYBFou1bERLF4aEAGxOgfjftGxUnXI0jdxxxXZ8kzAoVLnBnIcwMgU8yU6Fcv8AwGjo
 yXJvtbHrdi9P9oYfrdZMf2wm2ab2p7Nw3Mol40tKCcsSA7htDC77U0sdOWyCQOwc9cN9WdkAgLi
 1oIF4gu3ViqJSzIM11zdf+uwEp6H6JF7ihktcJkYzVup5DCsBFoSqYVyCTNllzSCc7VGqW45y+W
 neldmd5bKR7RIdE3so+dPNUYBkRw5OafVC/mK6J5u8rda51fOjUs5laV6k8PpYbhf1KpE9thtE+
 r0B58ZQWwppR+iP5JE9o+aacMZM088ZXsy/d3Iq1eaIYK2sXV8HFPB3Pm+kCUZzpQ/ZDh03P3a0
 QmrwyEaztk8JPh8KTfniUzcMmqNvE6ZFPOuyxMuGKzAbGCanWkmJ2/fHNFeEeCHyblpzXh/57KF
 IesOgSr6c1oqWR79AIjXgYL4g9Y85QuKe/sN2+ZaSj3cBIdBQNrtDXkNDUZnhoRFD4wUwU71trv
 ojd3IiwpOb5BnQjB1w09sn0Apf10c1xEX1hLl3G6RwRlVA9ieJhAegIj/v9gcK1zMl5aBuBV6y3
 nDwgRniRXMXe01wACBk=
X-Received: by 2002:a05:701b:428d:10b0:16a:f5cd:365 with SMTP id
 a92af1059eb24-199292eea46mr9977300c88.5.1793011858226; 
 Mon, 26 Oct 2026 03:50:58 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:50:57 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 03:50:40 -0700
Message-Id: <20261026105042.1148554-3-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026105042.1148554-1-teel4res@gmail.com>
References: <20261026105042.1148554-1-teel4res@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLIIC-000000006De-0ZQ0
Subject: [f2fs-dev] [PATCH v3 2/3] f2fs: reject MAIN_AREA boundary underflow
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

sanity_check_area_boundary() computes

	main_end_blkaddr - segment0_blkaddr

as u64 when main_end_blkaddr < seg_end_blkaddr.  A crafted superblock
can make main_end_blkaddr smaller than segment0_blkaddr, so the
subtraction underflows and cpu_to_le32() truncates the result; the
function persists a wrapped segment_count (0xfffffffd in the
crafted image) and the next mount rejects the filesystem.  The
same path can also leave the error workqueue dereferencing freed
superblock state:

  BUG: KASAN: slab-use-after-free in f2fs_commit_super

Reject the underflowing geometry before the subtraction.

Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ea2d218..b90831e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4004,6 +4004,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		return true;
 	}
 
+	if (main_end_blkaddr < segment0_blkaddr) {
+		f2fs_info(sbi, "Wrong MAIN_AREA boundary, start(%u) end(%llu)",
+			  main_blkaddr, main_end_blkaddr);
+		return true;
+	}
+
 	if (main_end_blkaddr > seg_end_blkaddr) {
 		f2fs_info(sbi, "Wrong MAIN_AREA boundary, start(%u) end(%llu) block(%u)",
 			  main_blkaddr, seg_end_blkaddr,
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
