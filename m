Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444F606A6D9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UnFV+dNd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G2U8P6BP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ExYf/pcg;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=n3WLOaxu;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=EajLyNwy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=MQwZFf483iW7Vh+zr/p6RGitscnbe+vvFOK+MGFhuFs=; b=UnFV+dNdysbjzy6F1lgieBeySh
	q7BvIjXhOm0RxrJHMI7G3eWYVbH3rpFmH6wuSQe1KnUYh+iqKQQyEwykfpKaFTiIXNZPmDHMF7Kb1
	djzeLDg4FfeMw+UUriWziIHfcLbYsPTa7xX9oJXy4+iPor4DPjSKxeM3ultzAzLQ6vfE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCM-0000000036j-0N63;
	Fri, 20 Nov 2026 19:23:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCJ-0000000035z-0dmn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kgxtoOh9S1v0UKNpzF/cV6jhiOLjHxRas2ZZ9eqTtpM=; b=G2U8P6BPwllZgCAqTyfOuzaHQ0
 gPBeI7DBT68UnNBwFDkZ5+/wNbB8SFJZNUSSVkJC4OLOHNS0rZADLDp2rLWJq0n3J5WLjuwFmFdRU
 yEbpdy9TbsNVBtbQCq1blze3cGjLKZDZ4Jx9geYwPztTkn295T7nJNgzZFOeBLzxN2CA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kgxtoOh9S1v0UKNpzF/cV6jhiOLjHxRas2ZZ9eqTtpM=; b=ExYf/pcg1jdtLOTKZVYtAQBtE3
 v2XFEWuz5eJBA2067enPKfkzwFITmM6vwqspr0SZWRuqrdYUKVyF3gUjyJrmOCKBpYncDIyvxGCkR
 pAxA0RUEJ8L6iOSznoQ8kO8gW/eBV1gW9c+fjvvFsyzdD/lrbdHiOyHPy6/t1jM+fx68=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCI-000000007DH-2SCI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:59 +0000
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKJ1uGY3343159
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=kgxt
 oOh9S1v0UKNpzF/cV6jhiOLjHxRas2ZZ9eqTtpM=; b=n3WLOaxu9ULfeBG38DBQ
 HpC6PJuR6AGpylTgX11zPB6VQn7nvHn21b7uam7XvNJCn+a6U5uUBx29QlOu8wzU
 cu8TGDk7ZFjM5+UeyqxhSEzHSSIzzqf92V+gBIAdFuohNZFRDmaBfhc67aq83bGJ
 Dt58nRHrfZchIoKRKpz+92C5C6hp/q8e55MxWKhg5H7A5JozyT5I4y4c+UDI1fIF
 pFzgFwFeBjkvs5xyls4O5YAvU1Rc1vTl1FKtNowGu8KIj9KZb8R3iy40QA2/raZh
 7cvnkZ8vAxbKXDgv07st9am4qVV0hZWkZibS8sV4OPK2kPvY7pyOYdjsfZB2NVN+
 gQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2kncm9vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:52 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so19665156d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202572; x=1795807372;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgxtoOh9S1v0UKNpzF/cV6jhiOLjHxRas2ZZ9eqTtpM=;
 b=EajLyNwyDF3+y8sqRR+a5+tXJ7ulrOTR9VJ5zxmBS1mbJYIPnYYQxfbGHfFUFcmKDw
 2m2EvJNR5w389N3ODn3YDETr9pg19f+fpBg47DjkBrxdv9+NXFeqeRHL5Mc87bUG/y4/
 8UrR4e5dY9M+vAPgFZIbVZxRnZt+gdfwriody9ToUWvdcKMDu/hz0fLfKuzCv6/32f0b
 qU3W0P6KyyaKr9xAhU7GAvhKvGe2T0R4Tm430KOeB0OXreGaSzpMXXTb4P/TO8h0jJfd
 zbjxOD9C/CGVzvoe9/XHaCO1UvpSUevfF2mqyuhm8m7IuONDOWv8it6Pfmv+NWYBB44u
 qhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202572; x=1795807372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgxtoOh9S1v0UKNpzF/cV6jhiOLjHxRas2ZZ9eqTtpM=;
 b=X9EWfoXGZiTHy1TPi1uSHLH41R8uTPsM4nstyYAWFjg6Eyo2lUjrdxfUDm1J/50OBD
 3B+nkppfmjTKlYmirU0SDwIxGwxembGA7z9LUb/Vtaxh/kH2yi2m/T3/JRHFs8IitVhD
 1tLJ9i8gKxsoGfxZa3Pg8vvP8BO1wcYWP4IDUSdUEYFysOZsKclNT55eDQkMZuT+3APX
 9YXTmWIUTxV/6ulRxg0Jd9pK+BELeeCO8iTddwT0UO79vIPS+alBn2kvmI5pgtk2ZxmH
 AZ1DfgaV5eq1KeuokpQvyIjnmPJ+y0UVCIOabVJsIXhrVakOnjSxmGaA/D/dray5K19m
 or8w==
X-Forwarded-Encrypted: i=1;
 AL+hErFz93tDIScb2CB5kyG21jm086kfeV3NTCDzBvZeqJIxAaPj72MGQ0nrtgVIUIto5dr/6RnNpFuniz7trd2m60OL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8IpjCY3hug24G9W4e8Evs2LiqS19pnJLaJPPKqIrfW4LNKgkXo
 8kM9q+EsoEHw/COLVIIRXM+QRXscLOyX5iMWRmwrWXSLofN/5vWyaPGJaZydT4Kan7jAtT1enkm
 lLB/x8553g3KRT1yaO9hOUftxRxPCrUkwnC3szlYixF+/bLkaDTunNwBlaeJnGgPsm034bg5h4H
 4=
X-Gm-Gg: AZFdTZeK1W7Ni/T19rmXozZPJS8fEBZ8N4qFm7JtXLUYgUQn/2bXEuUjj0BMxfRXD7N
 lpA3Z5f4dm57A7urueGsR37wSUHymAQlt3+q7R/VsnuwaqHNvqaPtForJQ7mJlqymCzvBmEuwir
 Wy16rmui7OqRWyZ91nwuaxG+YSAvH5g9J6wZMSFgWyiHnn0TyiQ0bW2TFVhE4mu7E7yWKpDwk8t
 WpQ63jEfJR8WNAEDLOk6Zbtckd3pgTRtocUxPmJ2cMDk0JzSlswY7783k22t4sIqVAFLxS38npz
 4ADOYr8ejuv3Rfmio/ExS1Jdcl0+jfm9Kv853TzHdeLP/LA9UrhmKaMiim2LY+enGaCr8Ej2Ojp
 40ouJ8i0/nwPmy7KqzABaAsQb0G6s67YHaaaXVdujzUs7vDmn+4PWFvIOZ2fPHodkz8Ox370VK2
 sL1rWyorD2ZlU46t4NJDH9
X-Received: by 2002:a05:6214:2408:b0:921:2871:6fef with SMTP id
 6a1803df08f44-92134aac30bmr67254606d6.45.1795202572190; 
 Fri, 20 Nov 2026 11:22:52 -0800 (PST)
X-Received: by 2002:a05:6214:2408:b0:921:2871:6fef with SMTP id
 6a1803df08f44-92134aac30bmr67254396d6.45.1795202571845; 
 Fri, 20 Nov 2026 11:22:51 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:50 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-10-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=966;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=f80Gjktt4tzyoqIx4ALSM6iBDPrErNYvWPwyvnNkiio=;
 b=QEJzdq8s8l0mfmhDTSljDiPMepEFhD5AvP5lSSEJF56iGuQ2HmND5rXUeJ2OlxnxrdFO4bO0H
 8JY/BwHpd3SA7PJY11aKTHDD4QQVu/j59iUx4YyivIy3qbZV5THsB8T
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: wyBwpioyMroAEzqNuaswl7SiIttvYwck
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX/SFP5e3ng4AO
 XEul3NL+3Pcr6JfujMYpnb19d2vruTPIgE4m5KizNYLDqlFcX+jrmJX2fTIheDqekXEjCwEmsn+
 6sAAnT3/c/lC0lj65f76X1DmarbtnATAEsDpp/rgKF8Gg2RnjnM5
X-Proofpoint-ORIG-GUID: wyBwpioyMroAEzqNuaswl7SiIttvYwck
X-Authority-Analysis: v=2.4 cv=P9GvFSAu c=1 sm=1 tr=0 ts=6b009e0c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=7KFXWGKlYUrMLOW7qaQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX0AJ06zxf85OJ
 hOouF0MApKg6sPmMHU2KRfGLo1x/Lq5FyY3CBldvEWNf46oUQC4VpInMnzQIERIP5q02A3wgZNq
 4aOqQxOSO66lrgjy/dOygiGsSk0X+jOpRWzfuVM50wPHBOjRfCs47+V0LXh7qihyAENSXwWgKGm
 6yTsS22qeu+hH7MmSkDqAWxCFFy23ovHr7H1flCVJBQ3CE4dJ5LZNAyOfDjRMxfqeZ0u9h0KO8c
 cy8UhY9HWopYlARybPuT30CWW0TYiBfdcMVMJ9Sml6UTpIb/9uz0LgPIJeOtC5ae1qPSgJUA/YI
 SefUwrFJ5W2DDhFbbB7oyz4/DqaxZtAHJKwewyI2XamEqKhQl97rW6rglWFY2oww00oXEfeCcNA
 SbwK36Ai2eYuhNLFW7EIrUxW1exR29Ei4vdCvsDy0LliGg3fizl6Aaq5acHCwoQAvBhxlyuXP/M
 jIIgSPXSJ8UMl955EMA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 adultscore=0 bulkscore=10 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCI-000000007DH-2SCI
Subject: [f2fs-dev] [PATCH 10/28] f2fs: convert cluster_has_invalid_data()
 to rfolios
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

Read the cluster folios through rfolios, and use folio_next_pos() for
the end of each folio. This saves two hidden calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 54fd77aa0a67..2569b5744287 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -962,13 +962,12 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < nr_folios; i++) {
-		struct page *page = cc->rpages[i];
+		struct folio *folio = cc->rfolios[i];
 
-		f2fs_bug_on(sbi, !page);
+		f2fs_bug_on(sbi, !folio);
 
 		/* any block beyond EOF */
-		if (folio_pos(page_folio(page)) +
-		    folio_size(page_folio(page)) - F2FS_BLKSIZE(sbi) >= i_size)
+		if (folio_next_pos(folio) - F2FS_BLKSIZE(sbi) >= i_size)
 			return true;
 	}
 	return false;

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
