Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABFFCDB466
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=dcTbi6y8JCIVF+Nq0GZmUM9UwjdlF5UmmkcCuWTq1CE=; b=gfSGETXdHFZAr8X0+Ij69Qu5LJ
	Vl5oUe2qbl398pXG46G/LNLX9tJEfWN/1WcETwrM5jlpMzbVkoopSjH+dWCxMEU1KeK7BoUBl7S7l
	sN79HdSx9JFMB/g4IsW9PcNy/g3q4SKk0bMqq5NlJipTACIdIf+geFeJICHGiAPvUMNI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbUYz-0000ww-Go;
	Mon, 22 Jun 2026 02:39:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <s_min.jeong@samsung.com>) id 1wbUYx-0000wo-DX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 02:39:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xRBYtPt4GacALwQvCYdpFOdgqKfhmzTawnXTgPBaL6o=; b=Ed0jG22QkqVnUnjgIi1RWYN57U
 PAIf0PvdqsUgmQsKaMgOxnUtD/XsTp8jxdWPXxLq1Thb6xhDh1kcssb7QXl5osTfVfBkFaKwg434w
 T4Ta64hgsuyhS2T+Ez+jaZv2RkFUamwspiAkHO5yZH0ttBlJ/xCvExv6UJXAMVUrR0Mk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id
 :Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xRBYtPt4GacALwQvCYdpFOdgqKfhmzTawnXTgPBaL6o=; b=E
 358uAdNhLHlIDrQnXaZ21g6e0aD3WdNu6NrTQBvzyJffJKwSZfOzkDcBMpZy2cNa1pm9qVrSn5p+7
 Y75rC8CTiF/c/1oD/+72rV2Wwfj4Q6VmBLHRY6SQvVnGCihg/YBbhzM+7ZSBV5NB6ZJtOGuAz6tzL
 YZ2R/185kmvAa5Ms=;
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbUYw-0006Zl-BI for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 02:39:04 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260622023855epoutp021b2078f4167a9885197ef5a55deefb25~7Rs-Cv1On1673516735epoutp02m
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 02:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260622023855epoutp021b2078f4167a9885197ef5a55deefb25~7Rs-Cv1On1673516735epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782095935;
 bh=xRBYtPt4GacALwQvCYdpFOdgqKfhmzTawnXTgPBaL6o=;
 h=From:To:Cc:Subject:Date:References:From;
 b=KmMZDl/Sy31BNNi7st7VD7cVEk0Qj/xYaVnZUyQLHNS2QBnrrHnHmLsNsRMr7uNJj
 XLhbAOCRaZYoGOI5t2b0E7QymfxfCJlORdrcalvFJhFk3jXcqbSHJPbQ3zt7R9cmsi
 gNzVHRyUyGiiqF2DQsGPUIz9f8KPltRNEK6NvMsU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
 20260622023854epcas1p295295fe069023eb259f5f2a5e751ac29~7Rs98li4K1320613206epcas1p2I;
 Mon, 22 Jun 2026 02:38:54 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.115]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4gkC7f23Y5z2SSKX; Mon, 22 Jun
 2026 02:38:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f~7Rs9Mt_O52963129631epcas1p3c;
 Mon, 22 Jun 2026 02:38:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260622023853epsmtip29a3630d09b4f18b07c2f040058adfd5e~7Rs9KF_W70692606926epsmtip2M;
 Mon, 22 Jun 2026 02:38:53 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Date: Mon, 22 Jun 2026 11:38:05 +0900
Message-Id: <20260622023805.3620189-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CMS-MailID: 20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f
X-Msg-Generator: CA
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f
References: <CGME20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f@epcas1p3.samsung.com>
X-Headers-End: 1wbUYw-0006Zl-BI
Subject: [f2fs-dev] [PATCH] f2fs: fix to round down start offset of
 fallocate for pin file
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Currently, the length of fallocate for pin file is section-aligned to
keep allocated sections from being selected as victims of GC. However,
for the case that the start offset of fallocate is not aligned in
section, the allocated sections can't be fully utilized. It's because a
new section is allocated by f2fs_allocate_pinning_section() after using
blks_per_sec blocks regardless of the start offset. As a result, several
unexpected dirty segments may be created, including blocks assigned to
the pinned file.

To address this issue, let's round down the start offset of fallocate
to the length of section.

The reproducing scenario is as below

chunk=$(((2<<20)+4096)) # 2MB + 4KB
touch test
f2fs_io pinfile set test
f2fs_io fallocate 0 0 $chunk test
f2fs_io fallocate 0 $chunk $chunk test
f2fs_io fallocate 0 $((chunk*2)) $chunk test
f2fs_io fiemap 0 $((chunk*3)) test

Fiemap: offset = 0 len = 12288
    logical addr.    physical addr.   length           flags
0   0000000000000000 000000068c600000 0000000000400000 00001088
1   0000000000400000 000000003d400000 0000000000001000 00001088
2   0000000000401000 00000003eb200000 0000000000200000 00001088
3   0000000000601000 00000005e4200000 0000000000001000 00001088
4   0000000000602000 0000000605400000 0000000000200000 00001089

Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c4880f24b54..3954aea43bd9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1906,8 +1906,13 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 	if (f2fs_is_pinned_file(inode)) {
 		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
-		block_t sec_len = roundup(map.m_len, sec_blks);
+		block_t sec_len;
 
+		if (map.m_lblk % sec_blks) {
+			map.m_lblk = rounddown(map.m_lblk, sec_blks);
+			map.m_len = pg_end - map.m_lblk;
+		}
+		sec_len = roundup(map.m_len, sec_blks);
 		map.m_len = sec_blks;
 next_alloc:
 		f2fs_down_write(&sbi->pin_sem);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
