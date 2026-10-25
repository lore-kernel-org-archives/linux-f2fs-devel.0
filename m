Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC7606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W0PwsBHW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YIRN65ih;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V7hq/3Qg;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrlzhTxx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=OZB8kNz1TwOsRQyzDNn25L/U0cG81Ds929uFL0NHjTM=; b=W0PwsBHWvP7Ljx7nlhhOlolEvb
	OIrlZ291DtxYmpGPzcaskkdMHmwK7bcUwhMQc46zoAgoanFK0BeZKR5F+7MefdpCIrutvqzWIeMVY
	kc1Aaao3+q3NeIW4cpfKZcwINL15ngASgql56RzuwsxOBIb3leebQbCJAyOEIv3VcIyc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xL2YD-000000005Z2-48YB;
	Sun, 25 Oct 2026 18:02:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xL2YC-000000005Ym-10QS
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HG6p2VhYaveHd2iyf+ain0rK/+tVMy3ciGMFej9wyxE=; b=YIRN65ihZo/8M/OZvBWpn0bO9v
 lDthMd3HlBNHuB30QgrqQ5XZsSEjQRjiuLXiXlYjmWdZhTCMzhXP4iaP6UVglxpL3jrDBjtSJAo5F
 brXXWqiOEUDauOJCrLeesgOZl1b4XOxndQfjPtxHqVc24xghzhsOl4TUZ1//0nldJTLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HG6p2VhYaveHd2iyf+ain0rK/+tVMy3ciGMFej9wyxE=; b=V7hq/3Qg9p4jFrGs3JP5Xu8z0+
 XTT3MQ4dpmYYTMbtWuLQ8RQwGM5jTyOMUoVdDSmZJVVlwYi3qnPQj1Fe4KoWvY/3c25jrkBkxGvKM
 bBmaIM5HmtJBaN3uPWMALWza5N+94e1b2XO0NtHlGH0dFGs6vRrZyI/dCezWbgICS6BE=;
Received: from mail-dl1-f52.google.com ([74.125.82.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL2YB-000000001WK-3bql
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:32 +0000
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-185fd3a4ca3so1615871c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792951346; x=1793556146; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HG6p2VhYaveHd2iyf+ain0rK/+tVMy3ciGMFej9wyxE=;
 b=UrlzhTxx4XByceB+fsh9EVq2EkzPzEuXUE3/gmRqjaAmuMxNS9y9K/UQx+cdgEzpYP
 1h594l8+VVEYFkXXG0WZSBCN1KELueTmHAlplRTFbBJVfrMAfBR2Nm+ouPhJIuW+SmBN
 IK/IzYe0KyWBdDXrzTO/F1nI5sUt+kiUmGUSdOWPWqEEpgsrv68JD8AhgQf7+JzArR2J
 E5CIHohd8VpTQ3uZp6BcTqvSJbg+Ixs1ozHFqtHPc8DVyQ8063qhdU5/z6MFLuA41jUD
 ZfsvPg4A/RP5ps9+86wkflZQVwPKOpZsz+UOIzHssAmMMah0eWn2ywftZ2b+RO662y4t
 5ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792951346; x=1793556146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HG6p2VhYaveHd2iyf+ain0rK/+tVMy3ciGMFej9wyxE=;
 b=QiUhzo/5LTzUL1BP4tvPoBm2NpWS4KrBgHE5qvsFLpicQbWEb2C84ZA/iJn50cGDCN
 On66tK+vfYn7bk1KztFe6oU3tYJJmumrAQortHVyn5UT/uTU5Qyl2+88asCJy7nQX8Mj
 wfr/ZK5Qhv5Bp2OsprHHkqDjR2C/IblZ2SAJAdb3c4krGmySkfo6ahg19XNCOL8MlBrR
 a2nbPjfLupio4DFwBmI0bf5xlKLAv8XyRMOMcTBgk0CsyP34FtFjja1SzcGJn8Dq0PdO
 WHbIoPdl1cXXlNi2JIovnP19TYaK9OMYk86Mnt1rfP8d5ZqkLbPKP5GbchgxF+NzN9sp
 Mjkg==
X-Gm-Message-State: AFq9FYJYMC0dFgcyq1mod+QV82uxTcIs0US3BS3X/7fNtORlazewBNqP
 s6sVTeqVatw1+fo+MV7SidVRN6HnF6GMhIkZr9DICSzre4Tdmt6FHQom
X-Gm-Gg: AYBFou1TWzJFWYGk3hIpVFB7bDF58OLjD8gwOjvK6SsNm66+Y+Li7eg/rx7TWYt/XA1
 WVUZ+ook2jzNa6DPHP2iKVajRPmiQ1NdR55mUJ4OVo0uQO+wXGlVBFdfDtaHDUmdWuSWJE8uVwu
 ScFYWzdNHjANYZ27Q2AagQrJXweKLiw0Mkd1qanBTMFTQ2PAuaJpCF9bhPR4IOWsPlhPGI1Xc31
 9yKDCkcG0pqI+33a9ReXMHCxMzJ1aNTlAvh75NY5veoSPZqDIMUFO4guqtgEt1PX/2qb8ZQDtEo
 AARRigyyS2zXDDT3h/HDbQSGYNSdr0I38whEgOUkFZDkyfVwwjG6iz4dYKLiM96WrYb0iN89lyN
 9vovIUsRxbvyw1u+xdTG/DWmsexTbwVBL+W7ZV6rQrWiKeMi4Azjb8kVWYR23Jh2I/b32dfZtCj
 KP5jICyf2NhKobdxfWh4b9qsxEXlPD5m8iHGQ9au8jxnvNpKxDq5blmHiLn6MZAR7nPC9PtkfZq
 A/6GtsvpYwNKW0bvatMQb65Qyk2EpjT9JdwL8b+c2XsCvPaw6WOMPELLS6QKfdDSEIlTt+KMDs3
 vs87DvRpimV10Ja0kDYgrpQ+y2NqENAfLR+dPToq
X-Received: by 2002:a05:701b:42c9:10b0:185:4ad4:3d15 with SMTP id
 a92af1059eb24-199290fe3f9mr6829045c88.1.1792951346125; 
 Sun, 25 Oct 2026 11:02:26 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5a515sm16099227c88.19.2026.10.25.11.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:02:25 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sun, 25 Oct 2026 11:02:06 -0700
Message-Id: <20261025180207.348498-3-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025180207.348498-1-teel4res@gmail.com>
References: <20261025180207.348498-1-teel4res@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xL2YB-000000001WK-3bql
Subject: [f2fs-dev] [PATCH 2/3] f2fs: reject MAIN_AREA boundary underflow
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Cheng Yongkang <teel4res@gmail.com>, linux-kernel@vger.kernel.org,
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
reproduced image) and the next mount rejects the filesystem.  The
same path can also leave the error workqueue dereferencing freed
superblock state:

  BUG: KASAN: slab-use-after-free in f2fs_commit_super

Reject the underflowing geometry before the subtraction.

The underflow was reproduced 3/3 times; the patched kernel rejects
it with "Wrong MAIN_AREA boundary", leaves segment_count unchanged,
and does not trigger the KASAN report.

Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
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
