Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1A606A6C1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hpUaCFYR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KUdOJIIe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MtjDPF61;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=VkNO1Eak;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=qe3xTAtV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=jWm7x3QVwkb9s0a8wDaycvmXzd+5davB/Gdn8AwyyFY=; b=hpUaCFYRe4tDy9c4I9ctyzJqPQ
	eGbgS1JbkPneVC1IN5uNJApcEoPVvLF6QWMg9XIdKF3VXVKwEnNYd1Ui9u0K5kk8rmIxOSUh1T3/Y
	UOAb7NeOnV2I46dl45Ad7A3H2hjij5SlFJIuadbY0w7lBt4RHY5QwFdcVeJMeakKrDJA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCP-000000004dT-1cT0;
	Fri, 20 Nov 2026 19:23:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCM-000000004ca-0Svw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yh4Wwqih3CX6vwa1iOC+UuwvCyDlasON98i0uYCVIYI=; b=KUdOJIIeYLwuoSjztlL3Wtzgr0
 eSl9ZveCe/+hy1c4LElDfYm8eYatSxNVgjobpWYBXXt4/Gdwg2FsNU4yc45KmNVRHOb1BOqHv5+wB
 mWKsfvDVpXmY2SBjMnUcjFwHYB9J0bnXOnueVGNt+cnvuiNZqGLzkoiJGFLp+u6z1Oo8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yh4Wwqih3CX6vwa1iOC+UuwvCyDlasON98i0uYCVIYI=; b=MtjDPF61uQrXiJU9ylEJNmtUrN
 x0ASGwByYT2d6VSIaEl184CLCiF8tEsUIyqBa4YxyYn0o8ZCJcQ3yfq7dRbwohboyRsnbOmw2R+Ak
 A2KsWsvBHgvw17RwfnlOTQNqOgqMxIj6EXGFBjvGLGX3LFWdm4tnFWBf66pst9GW/Nzs=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCL-0000000017f-1j68
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:02 +0000
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuieh3952354
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=Yh4W
 wqih3CX6vwa1iOC+UuwvCyDlasON98i0uYCVIYI=; b=VkNO1EakMEUGrXYopwp8
 haHuRM9vOAFwGDOZjgsTmyUgJN1IsFndDaPTFzo1DIL61hJBetNvlPKeVY5JlOOI
 7WjhXwOiryWnfgazSDXg4/zJSQwWwh6bdifFu5G3XU57VPToKAP9wuafZLhf8CG0
 QzvQjwDvccivC9yWSkGos4MsbDbwkv1DobN5y4PQGfBTLjGQ6QjVgXl7e/bXcBvm
 v3P4xJA0yLz4pZJi2BSPuRRqcC/4coj+8h1Uhz8/Nah7hHfD824h3O3erf9T28aY
 LkKm7Anjy8e9At0dCy/ShidUkNWxMKlnmwAKV5d913BcDmtBVqVb/hdY/bkSNo/E
 Zw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2myq42cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:55 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9211d51dcefso27040876d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202575; x=1795807375;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yh4Wwqih3CX6vwa1iOC+UuwvCyDlasON98i0uYCVIYI=;
 b=qe3xTAtVbc2dfgyQcc0jPguLfxIlY5uuxKP+sbTt/KZQ8zxufu9YgUKj+O1sjhHkQI
 YIze1NMxjDL4K05OiCIdJp9GahfRCY2Tzd983BJJGQchWGVLohAiF1vz1361PU07l1+8
 vRfjXb8QwF+iJVVXtIdfOj8yMNrGpJJgME5NZAlOSTikiCTB5WtzN7wsqogZEfJ1X6CH
 BvOldav1259Yy7u0EFnq/TYbIFYfj4qXo8m50zCw/JYMaaxvyVvjVEH1aAnalswdWKzr
 DQ7N+EcwWhgwvQf6Czzjq7saWBoZBaw1XuEVuon2FhSMEqDEfymCyeVWzsGF2tf3Wq/m
 BEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202575; x=1795807375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yh4Wwqih3CX6vwa1iOC+UuwvCyDlasON98i0uYCVIYI=;
 b=WlLs6Laf6M5njYhPBBPaJnRI3ofxzYCPTJcSTAvp3pLjxUHTf8kE073EB7t8oEzNVl
 0d2RR7FPI407kGp9AgDunR2q27qOBa6dJ6nmZLqXZuWJSZyNiQYkfV2CJIU+GOrI+eVu
 Tv13EgBqOSnGGnnYPvuZnSh5uL7PZuOI7aPD4P24f9kwhkhRlXOdLBrVHOBMEu8upQga
 9NoVZwtCtahRz3p6Wa1vIH0NRyKbR1agkZY0uqxf9pEOYwm5gnxz7kQEBhHRx5edcE4t
 Swh/yn5UQ5caQ7AcygqSAbQF8KiOqOeXVMhzkc02PMaBUTiVBxPuNdjT1nerKR2esO0V
 biYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGvCFwu4qIIjYX6ZBssW7lCPSe+XeYdLok9XaZM6mzIlXN0GuEOCQGVCQ5EjeYhLzMouCmfFT1Wi8vOw5NgrsPl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+lgbGJRQjQBBf00ni+loh7Jxzkc/8nXSUWhnzoaOBcC6WF5o4+
 SMUhnlxPfHcGljGAnyJ0T6wUXIylT6YT1ROTH9sJByHpZD6sJg4l8qa5ScIUx378Wmw5yLCvIPv
 imv6yOoHKa8E2ghaLCriHuglKcyTRJ5qk4U3lJn2YqV1NpHri33xcn16NcRapy3BH5Fqe+JJ6xk
 g=
X-Gm-Gg: AZFdTZdDKVEpNgzjYCcd6KoogqJN5yz2gViSA3pD1KtKjP0IhZdEa1z1dB84W/PBdHF
 5tKgeDFInH3ZKfRUI/8L9ndMboEep/C+N5KMlny/8vO0TqGF7FRl4FMlKhUW2GAoPrXCIH+sL6W
 +F1Olw6/hiH53usKK7MRuDfNi20VkbV2fc1HjsbSRh/hZJlUOOqgoHc2+BDa5X9NrzTAQdDmCKh
 Xa7UwaHFKauuTQbPi+JsrlQc95CeLzYe724SrOW1Si7JXUciOP4ruypCZIbBOBmVTvUvKUmgyaW
 7Npv6e8QK2whbc/M7Si/9UMzA6SDiHF8aUXGiLV0j8JBXrosS+qY6Gy/Uvr4e/rqdsHeuNky/L1
 N57BeeSLokzvTDfG9uBc0a5ZREBxxnKx3ym1bTaCxY9fk76n83yOXZ6dafkFIRqF06MmzkYj5ap
 EzVfCuaEUunhg/DPx/MO1L
X-Received: by 2002:a05:6214:3288:b0:921:346b:ddbf with SMTP id
 6a1803df08f44-92134a898b9mr68087236d6.26.1795202574870; 
 Fri, 20 Nov 2026 11:22:54 -0800 (PST)
X-Received: by 2002:a05:6214:3288:b0:921:346b:ddbf with SMTP id
 6a1803df08f44-92134a898b9mr68086866d6.26.1795202574511; 
 Fri, 20 Nov 2026 11:22:54 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:53 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:16 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-13-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=2016;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=z7lQAxbMDMwcXX2lutdP9RYhyiWui0eQhKTDCFnYLrQ=;
 b=zJ9Y+nbQIqjuka1B+jxXX6afLUDBduHhdrV6pH27puUVmv1aVcV8S8REXLBuQfa4uicrySid1
 PbfPldSgfruBrh7HaK6c88wyeYIgaJYkKbHhUCZzJaW0BkYwGK6BEn4
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXwAJfR4G4VueL
 HNA5vcf0DSO7zNzjCPbwk0QoMcYnL25zQD18GKm/NLy3L13Yqsq0ShYjBoS4ExOCwX9G2zGLqd2
 MDCk/NKtEzYciuKnXwSFoyYmniYw1/+r3klmKlvpn/LgA/I7Nwnp
X-Authority-Analysis: v=2.4 cv=StYFe/O0 c=1 sm=1 tr=0 ts=6b009e0f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=tXuyVZUDEsSsUpsbj78A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: rNsDSLxKuWMonBpiDqr9fOtOtqHnLkhA
X-Proofpoint-GUID: rNsDSLxKuWMonBpiDqr9fOtOtqHnLkhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX6nBVGj0rAT3P
 9Kdtv+c2fcQA6N4w5cqsZzGjYk2O7BhmSe3dqYratjkCZ5N0oo4HQZ4nhy3TX4gTk73Uyk3AXCi
 dpzrIRqmAFOJrrin32FYXx8+9vEeGh8KgHz1o8RnWbMGKbjhqwnjcg9Zow3nEDqCBvhhQYO1DkW
 Nbru8G7aWh8hASwhhFUXkwDSqY1tjKsWecrOXelUFqsv3LsBtOkGncCLxw1dcG89niXM4d/aTRB
 PAeWLYRlw0WkZY/OK3mh5NPQ6/0H+eh4L3W0llwt/UEHIvn01hEBsuKjkko/TAlu2enPjvEt5sM
 Qa2rCMKBwMPRo3d5guiotHgh/EHmkgnhX1bQIsKgWxp2DMpMYro1A3XBhPPluh8bjeZ3KK66C6G
 5rjkDckeU0/UDC1eFVaWtect8iWt1ALZOs5AYZy30G8KmQckjEfyinAlPbIQFvNgcWScZIm3k1b
 USkCcKbgt6+uUlXIsUw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=10 priorityscore=1501 spamscore=0
 lowpriorityscore=10 clxscore=1015 impostorscore=10 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCL-0000000017f-1j68
Subject: [f2fs-dev] [PATCH 13/28] f2fs: convert f2fs_write_raw_pages() to
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

Convert the raw cluster writeback loops to rfolios and rename
f2fs_write_raw_pages() to f2fs_write_raw_folios(). This removes the last
caller of redirty_page_for_writepage() and saves three hidden calls to
compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6b44516c92a1..253d6b3f57d5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1679,7 +1679,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
 	sub_cache_counts(sbi, type, nr_blocks);
 }
 
-static int f2fs_write_raw_pages(struct compress_ctx *cc,
+static int f2fs_write_raw_folios(struct compress_ctx *cc,
 					int *submitted_p,
 					struct writeback_control *wbc,
 					enum iostat_type io_type)
@@ -1695,11 +1695,11 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	compr_blocks = f2fs_compressed_blocks(cc);
 
 	for (i = 0; i < nr_folios; i++) {
-		if (!cc->rpages[i])
+		if (!cc->rfolios[i])
 			continue;
 
-		redirty_page_for_writepage(wbc, cc->rpages[i]);
-		unlock_page(cc->rpages[i]);
+		folio_redirty_for_writepage(wbc, cc->rfolios[i]);
+		folio_unlock(cc->rfolios[i]);
 	}
 
 	if (compr_blocks < 0)
@@ -1712,9 +1712,9 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	for (i = 0; i < nr_folios; i++) {
 		struct folio *folio;
 
-		if (!cc->rpages[i])
+		if (!cc->rfolios[i])
 			continue;
-		folio = page_folio(cc->rpages[i]);
+		folio = cc->rfolios[i];
 retry_write:
 		folio_lock(folio);
 
@@ -1826,7 +1826,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 write:
 	f2fs_bug_on(F2FS_I_SB(cc->inode), *submitted);
 
-	err = f2fs_write_raw_pages(cc, submitted, wbc, io_type);
+	err = f2fs_write_raw_folios(cc, submitted, wbc, io_type);
 	f2fs_put_rfolios_wbc(cc, wbc, false, false);
 destroy_out:
 	f2fs_destroy_compress_ctx(cc, false);

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
