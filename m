Return-Path: <SRS0=d7d2=J2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9AC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Apr 2021 06:20:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C601561446
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Apr 2021 06:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C601561446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lc02J-0001M1-RW; Thu, 29 Apr 2021 06:20:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daejun7.park@samsung.com>) id 1lc02G-0001Le-T5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Apr 2021 06:20:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:To:From:Sender:Reply-To:Subject:Mime-Version:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=evdDv/wF3+Vhn2ZW2v+vhX2J8hbBZ8flU0eoahtAteI=; b=ZY41D1WGvCDikvct7q48NG5mKR
 L5uEhPPdRJfiKYCzneogZf5ac1MedVdVGeMblNnHDiaDyBIb5ra2ZrSN+E34A2Hb+frkchwFxa5OR
 qBR2v3/+OeYLHPNHPKj/U51hjRUHXlpNcGa6ygCg+HOYZGWwOMiMRicgegacFjDlGb6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:To:From
 :Sender:Reply-To:Subject:Mime-Version:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=evdDv/wF3+Vhn2ZW2v+vhX2J8hbBZ8flU0eoahtAteI=; b=D
 0/oQfotoL9Wy9NK+ghx99E0VXZq6MyHxzlEhB1gDjErhUHY+Df2Ms45UJMIpg9y1vOMEAgr6FO3qm
 eLRakoxdkXsghCDebCOgBXavoAn9ANFuPJTOdomTU8kWdH/BAObzVevSiulTkNJx2/nn2RjEzJ/fn
 vLd5gSz9Eojdu+J8=;
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lc029-0001N1-OT
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Apr 2021 06:20:28 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210429062009epoutp02c895a42c0ef46c9627966d4dee40f0cd~6P9c0miTd2300923009epoutp02P
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Apr 2021 06:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210429062009epoutp02c895a42c0ef46c9627966d4dee40f0cd~6P9c0miTd2300923009epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619677209;
 bh=evdDv/wF3+Vhn2ZW2v+vhX2J8hbBZ8flU0eoahtAteI=;
 h=Subject:Reply-To:From:To:Date:References:From;
 b=tofInGT/8w78bG/zq1J+DtoSI3RcU5ewSWgU8sNg51OZGZcuWGyjXmr4PVT93nPPu
 Dnwq46c+W0zZFTOq2CUuHSFumSScuhJfLYZumlXcnUWRXqcnATUiY/yH6HTCYIrtKZ
 j1IG2oYQE2lWwsuvgoCyEKvvbUZx3thHoM+8o46A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20210429062007epcas2p1dfdf264071cdbf9d6285bfff10b56bbb~6P9a5ErBK3259432594epcas2p1g;
 Thu, 29 Apr 2021 06:20:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.181]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4FW52Z2Hjjz4x9Pq; Thu, 29 Apr
 2021 06:20:06 +0000 (GMT)
X-AuditID: b6c32a47-f4bff700000024d9-cc-608a501695ac
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 68.4E.09433.6105A806; Thu, 29 Apr 2021 15:20:06 +0900 (KST)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Chao Yu <yuchao0@huawei.com>,
 Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
Date: Thu, 29 Apr 2021 15:20:05 +0900
X-CMS-MailID: 20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQlcsoCvB4M0lQYvTU88yWbw8pGmx
 6kG4xZP1s5gtLi1yt7i8aw6bxdTHa1kd2D1ajrxl9di0qpPNY/eCz0wefVtWMXp83iQXwBqV
 Y5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
 TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQsECvODG3uDQvXS85P9fK0MDAyBSoMiEn
 4+MJpYJpbBW3pvWyNTA2snYxcnJICJhIXH/+n7GLkYtDSGAHo8TPiQeZuxg5OHgFBCX+7hAG
 qREWcJTonX2bDcQWElCSWH9xFjtEXE/i1sM1jCA2m4COxPQT99lB5ogIbGKSWLJkMzPEAl6J
 Ge1PWSBsaYnty7cyQtgaEj+W9ULViErcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktKHNv9
 gQnCrpfYeucX2AMSAj2MEod33oL6TF/iWsdGsMW8Ar4SE1pms4M8xiKgKrGgyR6ixEXiXFs/
 WAmzgLzE9rdzwH5nFtCUWL9LH8SUEFCWOHKLBeaTho2/2dHZzAJ8Eh2H/8LFd8x7AnWZmsS6
 n+uZIMbISNyaB3W8h0T37+nMExgVZyHCeRaSE2YhnLCAkXkVo1hqQXFuemqxUYExcsxuYgQn
 Ri33HYwz3n7QO8TIxMF4iFGCg1lJhPf3us4EId6UxMqq1KL8+KLSnNTiQ4ymQL9PZJYSTc4H
 pua8knhDUyMzMwNLUwtTMyMLJXHen6l1CUIC6YklqdmpqQWpRTB9TBycUg1McW0CWewWN4/s
 uv5QzvV248b/Cx+Y7Vt/S1P75rnm3x0H102U+h1q8+nrc+cq9j4f620eU261LS2zn2FiXdu8
 VN3qmofuism7cy8z/l5df6BvcVDwZhlum6lmkypvt83N3Lhf8VDXgoc9MTrTpJXmr/KTdt0v
 OUnO5I5709r/r2vf1MWfePhRaa/KpKXxU1Jvn1A4sHWXcb3Nx+J1ge1BAlsX/d7zsG5F9jMV
 WSXt2lomFjb3I63sSxKWBMjlXPu6Za+mLEvuo/YlmfWaa2x+ZLf4LvZzKrhc0iYgffmlQMCc
 BNnHm1OXpV98wXv64l9nj4N2zUXBqcKqXif3pnOKBEstk7fMZVy97ohp5dmtSizFGYmGWsxF
 xYkAx/qomxUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a
References: <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
X-Headers-End: 1lc029-0001N1-OT
Subject: [f2fs-dev] [PATCH] f2fs: set file as cold when file defragmentation
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
Reply-To: daejun7.park@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In file defragmentation by ioctl, all data blocks in the file are
re-written out-of-place. File defragmentation implies user will not update
and mostly read the file. So before the defragmentation, we set file
temperature as cold for better block allocation.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d697c8900fa7..dcac965a05fe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	map.m_len = pg_end - pg_start;
 	total = 0;
 
+	if (!file_is_cold(inode))
+		file_set_cold(inode);
+
 	while (map.m_lblk < pg_end) {
 		pgoff_t idx;
 		int cnt = 0;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
