Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC729606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fmYVKqVt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W5cwaLjp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=btQHN2cp;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ssb87+q3;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zhLDWPEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ROcixrLViIrYMhEA+nMeo7g+WY+D1lYj+/TUs9x3mGM=; b=fmYVKqVtDMUxA3hXWcGO2oTqew
	MGu0AOBa7dq/50pAIi3wfph4YIqmzLaWWrMPDiLTCgZnILjbNWgA0eio0GJhE7S/hVTnusLTzROLU
	7u3mGFkuRPQv53naCBCSlBZj0l5vZagLjs/PVMSqelbs9UjEAT7B5mV5YAICjZml8be4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCU-000000000U3-2YVv;
	Fri, 20 Nov 2026 19:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCR-000000000T0-2sPr
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XRA3l0T12ZXrkBJQdoFSuXkWp9M7PEfpMuGqeYw3oKs=; b=W5cwaLjpx9hnxx5FQI5wMlvs6b
 NG1zw5rksrYaRhKsIZ4KLElB79WbIFIvC6evPdn8ltQ+Vxz+aiEwZH/WMjZOqBx4FHQOBkFAiK8L3
 nvUi77FMBzjNlfp2a8SZXzgMXhf/qy95PTqb8mfawx7fdKZjtd2hbCL8QKoE/zaH5/XM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XRA3l0T12ZXrkBJQdoFSuXkWp9M7PEfpMuGqeYw3oKs=; b=btQHN2cpz98atWNhCkX9Tdjy41
 HhkmPGwIFZYIauNAYVTygx4mgSJ8jRoSikyLvXlr9bBlEH6waHB/tThvuSAE4Jbbc0dsvk7FeRp4G
 K3/qpBVD9k+JIEoZt28m6eFGqbmMvAkcuCx1ZpeYe9K3I7YgdgfkbECju2/mZs1lluW8=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCQ-00000000182-4AHt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:07 +0000
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIukAR3367196
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=XRA3
 l0T12ZXrkBJQdoFSuXkWp9M7PEfpMuGqeYw3oKs=; b=ssb87+q3cN4YIC08HXhY
 5JIZ0gvuTPaSS9hSJW+aTY2r2JyiYgZdEZxyo2M9wcTTy+6yCzRt6HK63f2mhz3l
 WTVMLAu8oYXiSVH/ZTinBn1mxVTQx6O1YPJCvDKLtcqsJi8IcizWJ+Yi6BISfMgv
 yOOy1rnZMfi7cyTWdhs9DT78bLs6ehgdqjZurF5xwlYwVseyVkRxOlKk/+FzUwgY
 mB+6LzbJTNDaMzZkrRjJj+/ZB6n3yaMg1YP2T8kz5uAjNk+mSS7L2bmAHVQoenrb
 CpxaU3OjFVYE3fYwBuhNpfni+ihM8VA8cQnd5QGz8Ds36PJJ0PxY00rLBie0+4XJ
 EQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2s2y9xse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:01 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9213730b07eso21289776d6.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202580; x=1795807380;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRA3l0T12ZXrkBJQdoFSuXkWp9M7PEfpMuGqeYw3oKs=;
 b=zhLDWPEMGL2ckn8/ZgUqsZGQZAaAbmrNvPUXMLSMvSf9cLJdtG+oxcXIRmPiUOkgzI
 XZPHmKXx6WVUOR0Av4vbG36RuN4GwZ29bwZNaSliT/4AdLHVShBkbefeOsDuEB+cudqO
 rtarXykmg2PNi/tsAyRitKpWupNnsGvl6PBhRCeHOQ/d7r7Cfn2wkDuIimKl8PpHWkQp
 Wynj1zH1FkAHC8+OwACKvE/ypNKso+S4yP58gGvvA4encKm0g/xYE43v2ilqIHdHCZ/Y
 AlxguyBKAc5K2zAlU7+Ul6C4hV9xgmpFc2ua6q5IeRUNesc2us3r57q4/pl0fY1Oqy9Y
 Z/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202580; x=1795807380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XRA3l0T12ZXrkBJQdoFSuXkWp9M7PEfpMuGqeYw3oKs=;
 b=C45C2Eb6+ktNRzxVrP+Kqbgo8XszwgH0DrXgunzinGzeqPPuXlHZwofIacVDpz/xSP
 Bb/PT0YIzrDB2tWC/F/OhSFHAAclTBA5gFPcro1pLo3Bn5QBdoWTJgkguUPUbgdCeMeP
 WNWyoI7yNENboWM890N8Z2kh0mLA/OE1qMfyecYX9tZO6QgT1bkWOaImRJEb/MjXdd5i
 pNz69jDUiDaFRfthIRAyW7UTQeX1DIcdVoV2eMYhPVN1TKVEZAdrGH61SkM3DjzR9bHo
 Vy+RJl1RhX8pX7bRMSycMcDUllMs3iDMyE9HA+PR97JZxJZgJXus0GA7Ip+EazSGsMnY
 xXuQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFkgblEMoSoDGN/qGZXyBX8HhKgSAEpp4orBma3QfIHAQ7iUKpoY/jfdfKa3+D1cnr4jENEYrnsEI9tANP+D7KF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+IbD3RM9GF3F0ZHCWpbcolSG1hTwvm9Oz1tMjLH3K95N42HHck
 sN8tv/agxntNYzltKE33dGWCOgNkYdzSa6IkseTM5jRfj/sYVVx+qtiINwawbYxmrqrzwA1NPqj
 eQ2WzCcpo6E7Gl9kbBZYULwTj9euk9xxHZsUvyI5Da4IHrx0XYU7dznXwlxeEDMS/UZf5Rd8PWV
 U=
X-Gm-Gg: AZFdTZdTbMfVakc1fqunvPYe+QaNlrwQsAHfSxQvzwbJZMX370FeT0iKND7mW7JZK1W
 CFnUB4Q/WL9EV8RoMrCfGg9AI/tSVEQgs8PgaJxtKzIJIlt7rU8pIiSldEMJLEvjVMQh6BwuPv7
 9eMdutWwvaEEqnAiWyebsVKx1n9udlS/YbnzCP674DxYkrUgLjwNx3MKEUw6d4WiJihyxTXHZu6
 RKWKFfkWukZ6MoyREHt/4Hwl0QcocWRC0Sr8r3N0hdIiKZ9+AeK6cGh93qDPwEAspW42YL8KKOF
 ersMWxWgAjr3Hs/SBC/4ba8pwLEvOBFdSlylHHvSCxrW5GiGIhFxT50jLHhZvTDPuS9LezgXYUi
 D4Nl+80lAaf5ZIAwd4m3wJDZmV7spcfenqVzpfpsZ+qDU96zcr/KEN6QrVBHrv7vDNgqyEX10td
 BDSrGoeWkmJ5Z7IEby+H+7
X-Received: by 2002:ad4:5dce:0:b0:920:fc19:1215 with SMTP id
 6a1803df08f44-92134a39e70mr70728056d6.15.1795202580239; 
 Fri, 20 Nov 2026 11:23:00 -0800 (PST)
X-Received: by 2002:ad4:5dce:0:b0:920:fc19:1215 with SMTP id
 6a1803df08f44-92134a39e70mr70727746d6.15.1795202579834; 
 Fri, 20 Nov 2026 11:22:59 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:57 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:20 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-17-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=4189;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=NNZW5oIoFcNi4sFwlHoWJ6aTULHdaQwYPguVegnKCT0=;
 b=1XCBvUT7xRQRhcdIvIZmmNhF6ElWOeJ4siLrbfBNQ2ifzBcUgVN1TbSIUbGMqr1uUjkAVMhET
 CzMTuQrsR/UC8GF3mTG1a6WDDrhxyfFGY9yWA/7ud9+z5rL327Wb1F8
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=B+osQ+tM c=1 sm=1 tr=0 ts=6b009e15 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=Rwh1rUehVya5EMLlRqsA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: E85prde3CLvi4N4fSmbSuIJBrpRxw7kE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX9m9zYMLNRje9
 41WL2QFHs+y431FJIL2tDOa70/KzfcvJovOU4kNbQ4Mp9o/DgHtM4CBhavJ45FSj8QHPwrQAoj0
 /U43G62JzGNlxCNKoomcifwK5+Y0JdziJ5ZO99jKWBbNNfU89RV8
X-Proofpoint-ORIG-GUID: E85prde3CLvi4N4fSmbSuIJBrpRxw7kE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXyy1X8THF2qd3
 MwqKwN/7MBgdJEwkd/xPKWjI7UJAJRwkoQ0edSK0L+ELEBoibVh2K1HERhl8CMPoeCOiETOTHBC
 Rm5oIYCBiQNjTXKEeIZJqq8wXIsspDjW007DhHOUCZSkEBF80RFDcuJwD5/mB2jKNfSIZCG5bIF
 G2XkEp2h/v451WToyTS8q3qxGBvYOvNGcUVlX/1luFOZ0tyDzK42gJSFoGcirJJrsotcjOhwBqQ
 WKheI5QB5E79i0gA3IXcuSTyPz6wvpLvfyb7wVHjjx0T6YTxDxjVYzoJBMmIPJ1N4RFvJLMQzky
 5+xaSd4LGxoLuNxt0nXnyB6YQl7Nr/H6m2dEVY/RLIcVXconbMnQRuB1EMsZNciFzAbyWWe4caN
 U0yPvU6xx/3NBT0FiEhxKKnv3uX4LIxqkHg1bX9Lfch4FYWaRUhNLOGoXSu7G3oXIVEAfCTSTte
 Vc21qlbghlofZPvZ0fg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 impostorscore=10
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCQ-00000000182-4AHt
Subject: [f2fs-dev] [PATCH 17/28] f2fs: convert f2fs_read_multi_pages() to
 rfolios
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert the cluster loops in f2fs_read_multi_pages() to rfolios and
rename it to f2fs_read_multi_folios(). This saves three hidden calls to
compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     | 20 +++++++++-----------
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3a7b72c7cc72..e09465aca859 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1254,7 +1254,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	if (!f2fs_cluster_is_empty(cc)) {
 		struct bio *bio = NULL;
 
-		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
+		ret = f2fs_read_multi_folios(cc, &bio, cc->cluster_size,
 					&last_block_in_bio, NULL, true);
 		f2fs_put_rfolios(cc);
 		f2fs_destroy_compress_ctx(cc, true);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 74a5ef7681c7..4153ffad9e32 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2720,7 +2720,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
+int f2fs_read_multi_folios(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned int nr_blocks, sector_t *last_block_in_bio,
 				struct readahead_control *rac, bool for_write)
 {
@@ -2752,13 +2752,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 	/* get rid of pages beyond EOF */
 	for (i = 0; i < nr_rfolios; i++) {
-		struct page *page = cc->rpages[i];
-		struct folio *folio;
+		struct folio *folio = cc->rfolios[i];
 
-		if (!page)
+		if (!folio)
 			continue;
 
-		folio = page_folio(page);
 		if ((sector_t)f2fs_folio_lblk(sbi, folio) >= last_block_in_file) {
 			folio_zero_segment(folio, 0, folio_size(folio));
 			f2fs_ffs_mark_subrange_uptodate(folio, 0, folio_size(folio));
@@ -2768,7 +2766,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		folio_unlock(folio);
 		if (for_write)
 			folio_put(folio);
-		cc->rpages[i] = NULL;
+		cc->rfolios[i] = NULL;
 		cc->nr_rpages--;
 	}
 
@@ -2883,9 +2881,9 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		f2fs_put_dnode(&dn);
 out:
 	for (i = 0; i < nr_rfolios; i++) {
-		if (cc->rpages[i]) {
-			ClearPageUptodate(cc->rpages[i]);
-			unlock_page(cc->rpages[i]);
+		if (cc->rfolios[i]) {
+			folio_clear_uptodate(cc->rfolios[i]);
+			folio_unlock(cc->rfolios[i]);
 		}
 	}
 	*bio_ret = bio;
@@ -3641,7 +3639,7 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		/* there are remained compressed pages, submit them */
 		if (!f2fs_cluster_can_merge_block(&cc, f_lblk)) {
 			cc.vi = vi;
-			ret = f2fs_read_multi_pages(&cc, &bio,
+			ret = f2fs_read_multi_folios(&cc, &bio,
 						max_nr_pages <<
 							F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode)),
 						&last_block_in_bio,
@@ -3703,7 +3701,7 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 			/* last page */
 			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
 				cc.vi = vi;
-				ret = f2fs_read_multi_pages(&cc, &bio,
+				ret = f2fs_read_multi_folios(&cc, &bio,
 							max_nr_pages <<
 							F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode)),
 							&last_block_in_bio,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b7d13cb6e78..f17f44ffcb6d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5037,7 +5037,7 @@ bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t lblk);
 void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
 				unsigned int llen, unsigned int c_len);
-int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
+int f2fs_read_multi_folios(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned int nr_blocks, sector_t *last_block_in_bio,
 				struct readahead_control *rac, bool for_write);
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
