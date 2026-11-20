Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53815606A33B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MyY3k8KD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gGG8FY6+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jV7eDTW8;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=D5ofbxnu;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=yxnVGS0u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=O3BE6TmZP62awx/Lm6LmMFampynAQ6TvZftiC6V8bFA=; b=MyY3k8KDquJk6yUhJJhEbcSOiU
	I3W3F5G2dtWXbY2LdcQSo3TbGUwtLuChf5az2bj/MhRLcHaH2Wi8Obd6ByjkWT7ANcP2Q2qG77wvW
	D+4c+dWnP+bOEFI84pbQfdzoNXfikHCuwbUjTyuNzv7kVUlJT0GvAZx32Yy1yLvyZPI0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCN-000000000RV-49PF;
	Fri, 20 Nov 2026 19:23:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCL-000000000Ql-4Ajo
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9rM+Ydgd1cibzMAuqCIpTMjidtMRKME0310mm5L8/Ng=; b=gGG8FY6+7jzL6FJ1DheWD5gGFF
 F7a7NzrJe1LTZVmBCUp/Qek7OpULfjtOzNASj03+szRTF1QKL8Su8jshyhc9gTmjl1nV3ENVj1LUW
 RYJLDtdjflsXPZP7E4DNq0b9WRkZpYTWscpd2Sqi+w3AJJAgbkRvk1g1oeEzjdN2c98k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9rM+Ydgd1cibzMAuqCIpTMjidtMRKME0310mm5L8/Ng=; b=jV7eDTW8S090MhpXffe3fIPTbH
 N5dUZ5Npu/RekTcjN2n4kW9arBJHbwcEGGZ5midt07YK0oBeYNKcLVV55NrQ58EAK+W2+0tB5Oz6v
 pbZKYM+kg6H2Thxv12z8gWfxMCvtbgBuCmCkg611Kze3qzisC80GH54hmFvc8slcUA4Q=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCK-000000007DL-23LF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:01 +0000
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIvB7c3665759
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=9rM+
 Ydgd1cibzMAuqCIpTMjidtMRKME0310mm5L8/Ng=; b=D5ofbxnuCinWTL2JVtlO
 IMZWpcYx57v7jQoqiOhXMfzCiQsC/ZBmIMk+v28uNNyK/xkke4CnXxQOUKie7NGS
 IwNrVmz0t2ehF8Sh/QRLfuWolSKcWgogaoZ1pOfAxvWHToAFSIq3Aect4j7P25cv
 VeSRa8+S+R2HjE9BafS8o0OYAnXWCa2rxjWfqi7bT066x9DQ3M8UAHUdnOa4fVAa
 06ASk/tsT/0uJZMR/F0Zla8fkIyUPryXxnbQioE3lmhBBDtf2LdXIGietQ2dKoXg
 Hg6BB7ywtRS62yGsEuzbfVCBt42tuAmyqgtGddSBAvqY7kFp0rG7ef/7rUc2aI2l
 GQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2tnu0xgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:54 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso431932385a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202574; x=1795807374;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9rM+Ydgd1cibzMAuqCIpTMjidtMRKME0310mm5L8/Ng=;
 b=yxnVGS0udvbYi5qgJD3v/gobAmSymoM/zV9kgGdPWL2VvmZgez2IK/2VUUZoKHM+7Y
 yE4BbaihY2k/6Yp88AnJAEsXUykVg3hL27Y6L5u+xzPg8nqJoeX5X9JZctPWcw1K6x1J
 X6YzPsIv2SAlDRFYHJZ/Wiy3UIxwF0kAFVUIXesVtdime4axBTxVtB2jAkSVmnvUioY9
 KquOdI9UCO78n2qJ0zxFHHGjHxBsEH4th77NSln6omD+TCrleps2+l1sqclCFRQirD9s
 /VRzmFC1zDIptEyIqmMywlpVHNFaXhDOXfkLF4Che38xgo7GuFlYfqp+EhI6XrrU+oV8
 e/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202574; x=1795807374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9rM+Ydgd1cibzMAuqCIpTMjidtMRKME0310mm5L8/Ng=;
 b=m+UaVt956kjCAbvATJno/BgmVeez9RKKtghCIno6c9BM5FNyWksnZ0iDKsq70kGaFc
 a6saIfw2eI9qHJ8Vpaw5Te8a9H3DvrLIu3O1s4VfpCyj2Y7HlXTJj3a6gJEL8YiMUAkr
 S2BTyUqBIy26y3qF5TdfqF8pV/ocdhSoEZmax8t3OoSYkqTbdsHeMJtQ40NvYAOl43XU
 jtg6uF+0nfs9JDPvxZuh3tTwZvcwsdWzeP9Ql5xWawHnHOb/gFHpdC3GiJeUvFOO6s1B
 s8FuX43GhYv+Xhbo+vTC0RSRVDmyPQ5lyK7kaP8tphvy4RvkUZ4+QtR33oCZ21AusVEz
 boPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFvyR3SbgHDC/1+pBywxLwXodcbF7bhF8hfP2MAk5/RbKZGgX8hlToAdxcCdmS4THyakRxvLWTSRMPxvnY2DpRb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/n1FHGNmv/lXNFLPRl3xiSIqKbRzCzzA/dp58zv4Z6YWagm9Gj
 LrakS+JKvId05Yg/aspk9LK54Df6R6tLPyDp94braUEO11sIru5e296S2vHwBBtgRFiz/xRNUsO
 15GQklBvmWp0WTpmj/wxB34c1YXKJ+sA9LEBv0hzJDCS6PJvLVRyvgPsPcVroP0xF7O/w7jodfi
 Y=
X-Gm-Gg: AZFdTZc3lHIii37YcdUNllQR5BcMf6qnZmz8N04ByF+311mNDTRKqmHNrnuTZu/IAnL
 IVm2BWqERcGaFbXUjaa3s9C7d9/AutlRScEIWAXs+OQBySKktZFZThTn9klN9ubk3xwxWcgm+vB
 ldzOSFHgfkDVekSQmED4HzFpMM1n/z2ztbvpW3s89YpLAYTbObaBBrS4Piq0Rk3PGsxMuIrr+ui
 ZotGl5qLT6Ypk0boPKI+bXVdRF2MCoaIPT6Y1V52VyeAxGQbGh+OPNAKpAgZVAE4nKX3ToRkvmu
 ZJcZukYmAGzfsZXLYjODFnLoNwlJt9RXnZNQ9aAN5tqMWKO6pQFAJVksMeB41BVx+5xJbZceYP1
 CvLPuM3DcyxCcF3iljOFBpeVWkNB1+V6d1HiKs7jyGTiqib0rSa038fhnwJS4GnUL3As5sIz8cl
 SrLsxN9LD/Ihd7g7x0GFZd
X-Received: by 2002:a05:6214:498b:b0:91e:b592:ee15 with SMTP id
 6a1803df08f44-9212e0a7090mr88032266d6.15.1795202574008; 
 Fri, 20 Nov 2026 11:22:54 -0800 (PST)
X-Received: by 2002:a05:6214:498b:b0:91e:b592:ee15 with SMTP id
 6a1803df08f44-9212e0a7090mr88031986d6.15.1795202573577; 
 Fri, 20 Nov 2026 11:22:53 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:52 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:15 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-12-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1085;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=P0lUvHeDhmUW/sTmx95AQM+3yJazGus36KJJp8xsSSs=;
 b=HtbI2R5+xgPNEs4qoNiGyer0k0L8sXKegZ4WRKKj243H2Riy+Acpfi2gRJDhCx0Dv7uNPy5FK
 cNUytLkQQ9BAEceIgu3Z6hhIYE8YFodaQM2Zb1K6SiHfcn6yjFTZV0a
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: RZra2CG4CVwSeRA2PS6O1jxe9N-RPx9U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX6Zz84p1Ms2ii
 kzyW6mCESWXC8lNzngmddI992tX59Q13AeUNdADBkEt2UiSn588oTgZb/UXgHCmrMtOmJFKQwOG
 CVhmj+7Y9869rY0M5tDkOuyQTEk3yNRbfhbxQzP1A5H1aEwv4shx
X-Authority-Analysis: v=2.4 cv=Dt3Da2/+ c=1 sm=1 tr=0 ts=6b009e0e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=KdVhn_xSWJ0zN6q1QWEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX1UHPIQNPWFyi
 BCtKC131ovR55ptQaX1MkS2HlcjuGkev4V20b2ns36A+PL7i0tdwic1AP4lAR2PeT8L9zQOd4m8
 4W4EDmSWkSFCkCBVWN1/uYDeoWQ3wK7xVY6bUgDjKK5tiZgjByZZnfRM+6e7TnunFV1Gvm/8I24
 Trz50rGal1HoEEyzN1lkAgylgnwF/B0c2lGzyn5nRCKlHIo/peRSu4H4huTL2NyhYarEW5EL57r
 Ydt5IBcFQad3tDq/R0s/UtwjX63lJfVZI3blmy4AbFsdrmmjBiRWnKEGx9JZ8yLb1zMGIBKcupM
 t5hbj209Yqio42dWvbztmwhkk1tLMqnyIPupNsDIiwg9iwqQX4wqSU8RZ+WWeSbHvZCjdycT3AE
 qfUYwQzPnEA1fhG7zU18WpNSmWQHiwu5ykurImj8PiEwTKqMP/aKPN6mQXX5luGxaCnPfvsKKHT
 0RiTDy11vlQJy01eRjg==
X-Proofpoint-ORIG-GUID: RZra2CG4CVwSeRA2PS6O1jxe9N-RPx9U
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 spamscore=0 phishscore=0 bulkscore=10 impostorscore=10 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCK-000000007DL-23LF
Subject: [f2fs-dev] [PATCH 12/28] f2fs: use rfolios in the remaining cluster
 helpers
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

Convert f2fs_compress_control_folio() and f2fs_cluster_is_full() to
rfolios. This saves two hidden calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 39b157b4d3ba..6b44516c92a1 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -145,7 +145,7 @@ struct folio *f2fs_compress_control_folio(struct folio *folio)
 {
 	struct compress_io_ctx *ctx = folio->private;
 
-	return page_folio(ctx->rpages[0]);
+	return ctx->rfolios[0];
 }
 
 int f2fs_init_compress_ctx(struct compress_ctx *cc)
@@ -904,7 +904,7 @@ static bool f2fs_cluster_is_full(struct compress_ctx *cc)
 
 	/* PG_dirty is cleared for writeback; without ffs it covered every block */
 	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = page_folio(cc->rpages[i]);
+		struct folio *folio = cc->rfolios[i];
 		unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
 		unsigned int start, count;
 

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
