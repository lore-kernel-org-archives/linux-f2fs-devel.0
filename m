Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4D606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aS8BtdAp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EDNpZFLK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UxCGgra6;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gddlRW1k;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=JfLDf+00
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4H2FkrRJ4hltbmuTOk7ZbBc2dqcuTLzhY+wo4SQh2AM=; b=aS8BtdApJbB/6lOoUMqMdu/POn
	4U74/ci8Ei2KBoDJXfwZEr7wDrdndlDfFgrqpuCNaUxyqDdQQ4vRzc7m88R6dT0oZEiW/5ahkqy8D
	xGGStIcDw9gFlOIqqGHZ8DcyS1TszaCE9tzpuDA4ecvWxMFYtSzSOC2RwDVNx+QubHAw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCf-000000000ll-0PAL;
	Fri, 20 Nov 2026 19:23:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCb-000000000kl-2fZb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MGiq4zqjCQNF3bgckmpTpb8O7J+xepr1cwtVQkQfgzo=; b=EDNpZFLKQ+5UB9bY8j8NICDuzE
 gHq9pTqTwlHlX26ubRpO2ftEhj1ON8XLDZgs3EIQQ/WUyXFYiNEvc2Dl9CFWcBLl1xaToRanBrAsg
 8Ook0EamrtPNv05jMRvVHOOpBAtbmEPbx1cg2Ea7UXdLAm5+SkSagaQQ259FPbZoA61Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MGiq4zqjCQNF3bgckmpTpb8O7J+xepr1cwtVQkQfgzo=; b=UxCGgra6/VAjVcgnzEay+Aao+V
 oYRChOvjXNy1Du72brT911Ylugsbdt06P78EjRaAJ7veA5DCwqLKo1nB51I/f87+rqNICkikRzlCJ
 CpqLbkTdxRUalYV08yRi4RizFPDKoAKMnIjhVCes1v0C/yYQiPq5EBWO2Wy9T17FgYt0=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCa-000000007Er-2KD4
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:17 +0000
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuok91085396
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=MGiq
 4zqjCQNF3bgckmpTpb8O7J+xepr1cwtVQkQfgzo=; b=gddlRW1kgxM/56h2Koq+
 HCxDfPnjVR4xcBA0XVJBY/1UeqCxZNoRaWaDj1Ra4a7WedVZ9SZJnVDvrWZcjMB7
 nFhri5A2S0yIh0WY63Pp7JVhD158/PBrrHVWRDacIAedwNJt1t2OhYLPvLXJE76m
 WZ88c/liIuGamZRMbEmCZRSUX0n7AU9y9dhvWTgingQ7kNOkDlNMOMJXPSHRK1mp
 N2O1oHuFUbwAWPahR5Gu1lTO2sJEiuxejqU5U2UCEjTnX1Cc00pp/0r9O7eNA0dd
 +GqOzAvxczN5ANMLCuqCX7Yyuo6l5P3RNS/3Wndgfw23IfK+9eCSgqAz9uewGWls
 Rg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2ss59fjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:10 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961511b61so225458785a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202590; x=1795807390;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGiq4zqjCQNF3bgckmpTpb8O7J+xepr1cwtVQkQfgzo=;
 b=JfLDf+00l5xVmd7i3QLGeo531hBK0d4tCw/BSLZUhiya6ODpRtCAIytkcBb/HNwTqb
 pmuyjw7xFA8vrqa54jPvy5oH6QbcpD88ZST6HIM+0hSXqcY4KRqv+fJBnICgpXvxvIhC
 WCIIesl8YBJRdIUP2+agFYDsRpLwtD0ZGDzhLeio4+qpq1AQaKFoC0OlnP38mnne6+jd
 OpaxroRlCVQgAjyuOml5IBgAmMtTQEWk05wvkDNs91Em/2hLm8zNQcdGEudKv4dmmkEz
 MUWw2/tysA74FHAfNVGLSO9USUNuYrYR28c9JiFum+v+zaC7MPWMOaUEMC8oRR37l0jS
 rDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202590; x=1795807390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MGiq4zqjCQNF3bgckmpTpb8O7J+xepr1cwtVQkQfgzo=;
 b=EPhpPdEqwDUaFBP7n5jqXd4b2znhq3xbZQRW0C81SVfPy7FKzeagrjt4DVARbiE08g
 Ta6TeEKXomQdm4gJhV3pv3oMreuY1K489w1x9/vUU+/TymeWmPjo5Cb53zm24oaNk0k8
 kCYmHw36XDNCHQGgLnXSO2dEsEKAkdyRX4zEwP3mXnQ4VeY5ijac+BF5uGx5IRQR4gCM
 DLiTNwUbbzFmzylJDRlz09lEBCx/+HDD0fLdgayoINSNFpwr0197T99zWjwLTwOmdtGs
 F4ud50yCeKZb1D6h49wLV+mQbcM757jkgOO7RSNziyb4VgLNlYtCQTvm/B7Ukc3VWpfo
 /AGw==
X-Forwarded-Encrypted: i=1;
 AL+hErFclosezdZcgs18GAYW3HnjtNBZnDRFHkVSpZHoKfUyqeEMwHKlw2djG1SZuWgO2gWYKB61vlEu4B4DY+tL4Ns0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z98cYa9wTVzdIidx5HVrlwJ/EffQKXdv6NMGlw8c/Emgq8op2Ha
 C6z0rv6NBYznMaN0grBfWVLKrxM62Z7avOt6B6Sv7zfl5fXZFs0s6wau5/PG6f7wJdpjXroavpf
 Azcj2hHl/XYb5akDgWrjdAIoeOfBDrn0OeVMcglKzWC+ZHMi1Mj+RlHCFS2PH2ANM08BJwzmwdC
 uRJZgYAn4=
X-Gm-Gg: AYBFou2A8lOHcdfkF//XEGRmBFxpsVTkF+Z/ms9/Gtkx8Sik1yHWUe4kyQNGVumNE0m
 16LQyfVUT9ey+LgReifDPRgcmosubbgFNWd/qMu2osyCsCXdV2uIcNPF4TeykHWCu0iPSVOPZV4
 h2/ffpvNAiY5UhBeADHEu0S+fmQdaA3g3dJZlE3at4dfQc0mzPpvss3KTYkNPRgRtMW26qgyHJR
 CKuhkONCw6k5UlhNuOoB9oYhhUoNzz473OxLt92f3T3o1ZmnQOoj/Cwdm+fcf18FGU8I9hMjJvv
 fg6aU+jaLoEthXmaTfnl5jU3RZdOHYRGFFVMBHnhewYsSmewcRu2pBWaCiw8j59OpI1Z2guWQvh
 W5iIx2LRZ/Fq1SE8R5zJ94JnOHmhtqqhmBALkZcfqCMUseAT4wc2g5qOYtllBWREUIoURsBnh3s
 8d4S8a6rRPPFDMPXd7MCvJ
X-Received: by 2002:a05:620a:3901:b0:93e:6068:7e8d with SMTP id
 af79cd13be357-949ba7cd06amr694617385a.10.1795202589764; 
 Fri, 20 Nov 2026 11:23:09 -0800 (PST)
X-Received: by 2002:a05:620a:3901:b0:93e:6068:7e8d with SMTP id
 af79cd13be357-949ba7cd06amr694613585a.10.1795202589251; 
 Fri, 20 Nov 2026 11:23:09 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:08 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:29 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-26-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=10802;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bSLiu4lK1HWhmZIlXuoM4aH7ZPk0+CrYLCombu8GzHY=;
 b=PLeSy4D0jqkObXooXvi7zVLElSdnRPlAgAoH0eysO0FIjwyeFcdP8x597VmyXidrZoflHRKq8
 ZqZGpU14zRECh+ujSAJVIgUfmUQE1f9iW7Jp1Bt1yQnasz9TEfPwQvR
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX+YsnR/PaK451
 ai8UC1jkagxJTFD1MJirSIdbDdUcoR34ep4igvZkoQJuN9SWYF0ODyrownBmOzh6sq4q+yYqMeI
 K/4qEDDgRpGGUWXuIppIWcuSkchy0Xz/umcxPLOBGZtNtr8+1buWPjxHTSSok86/4/L//z4QlRt
 awB1n20a4N2wwYa7lBDJpwKcv6LevSqo0e5MIP/rW1C7kZugAMyjHXBRh1Fg2BNqW1cmznasjBj
 cV/BsG5zU5RgowQoM8gldTcoAk7ce80B+ffmDKTKdkcQENmbhGSYi5jYbM0IGVLDNIbfUx5bJiv
 gFchIaOjPe9Hvqd/T2tF7pBQVlG6j1LieiJ3cpaVvEEQw7TU3NMhbWc2kOX+asGZAw6ex5Utwy/
 SPX0DItXy0PG+AO8EXH4kE1cDlP/nHk1TAclWEglLyN7ArVDCGtksko20SjOJsrP5ekn9CZPJwm
 IvFoGuW2VXtBZV2BdJg==
X-Authority-Analysis: v=2.4 cv=fJasTpae c=1 sm=1 tr=0 ts=6b009e1e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=plXCYznmzlwfMO5HfjAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: hY4njsagJI2VlN92hhTf6foAeVubY-0i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXzkfpmW+Y2yuw
 agUyGF0LFvITP9C0/PpV4Rw/HDco96WLPKRrhmfQmI9e3ivf1eMhogJYkH25ZIbu0PP55zXVJjo
 8VWpwzFM4/i7B9qHeCA2Oeon5Wi7v/dgHj4+pQh11H/0hR1Bhg8r
X-Proofpoint-ORIG-GUID: hY4njsagJI2VlN92hhTf6foAeVubY-0i
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=10 suspectscore=0 bulkscore=10
 priorityscore=1501 spamscore=0 impostorscore=10 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCa-000000007Er-2KD4
Subject: [f2fs-dev] [PATCH 26/28] f2fs: remove rpages from the compression
 cluster contexts
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

Nothing uses the rpages members anymore. Remove them from the unions,
rename nr_rpages to nr_rfolios, and switch the remaining allocation,
free, and initializer sites to the folio names.

The rbuf comment in struct decompress_io_ctx said it maps rpages, but it
maps tpages. Correct it while updating the comments.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 50 +++++++++++++++++++++++++-------------------------
 fs/f2fs/data.c     | 10 +++++-----
 fs/f2fs/f2fs.h     | 25 ++++++++-----------------
 3 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e5fa4c01d3d4..72fc5ed84937 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -150,18 +150,18 @@ struct folio *f2fs_compress_control_folio(struct folio *folio)
 
 int f2fs_init_compress_ctx(struct compress_ctx *cc)
 {
-	if (cc->rpages)
+	if (cc->rfolios)
 		return 0;
 
-	cc->rpages = page_array_alloc(F2FS_I_SB(cc->inode), cc->cluster_size);
-	return cc->rpages ? 0 : -ENOMEM;
+	cc->rfolios = page_array_alloc(F2FS_I_SB(cc->inode), cc->cluster_size);
+	return cc->rfolios ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 {
-	page_array_free(F2FS_I_SB(cc->inode), cc->rpages, cc->cluster_size);
-	cc->rpages = NULL;
-	cc->nr_rpages = 0;
+	page_array_free(F2FS_I_SB(cc->inode), cc->rfolios, cc->cluster_size);
+	cc->rfolios = NULL;
+	cc->nr_rfolios = 0;
 	cc->nr_cpages = 0;
 	cc->valid_nr_cblocks = 0;
 	if (!reuse)
@@ -179,7 +179,7 @@ void f2fs_compress_ctx_add_folio(struct compress_ctx *cc, struct folio *folio)
 
 	cluster_ofs = offset_in_cluster(cc, lblk);
 	cc->rfolios[cluster_ofs] = folio;
-	cc->nr_rpages++;
+	cc->nr_rfolios++;
 	cc->cluster_idx = cluster_idx(cc, lblk);
 }
 
@@ -842,7 +842,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 	 * Copy only the blocks that are not uptodate, so that newer data in
 	 * the uptodate (possibly dirty) blocks is kept.
 	 */
-	for (i = 0; !ret && i < dic->nr_rpages; i++) {
+	for (i = 0; !ret && i < dic->nr_rfolios; i++) {
 		struct folio *folio = dic->rfolios[i];
 		pgoff_t lblk;
 		unsigned int b;
@@ -912,7 +912,7 @@ static bool is_block_in_cluster(struct compress_ctx *cc, pgoff_t lblk)
 
 bool f2fs_cluster_is_empty(struct compress_ctx *cc)
 {
-	return cc->nr_rpages == 0;
+	return cc->nr_rfolios == 0;
 }
 
 static bool f2fs_cluster_is_full(struct compress_ctx *cc)
@@ -921,7 +921,7 @@ static bool f2fs_cluster_is_full(struct compress_ctx *cc)
 	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 
-	if (cc->nr_rpages != nr_folios)
+	if (cc->nr_rfolios != nr_folios)
 		return false;
 
 	/* PG_dirty is cleared for writeback; without ffs it covered every block */
@@ -1335,8 +1335,8 @@ int f2fs_prepare_compress_overwrite(struct inode *inode,
 		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
 		.cluster_size = F2FS_I(inode)->i_cluster_size,
 		.cluster_idx = lblk >> F2FS_I(inode)->i_log_cluster_size,
-		.rpages = NULL,
-		.nr_rpages = 0,
+		.rfolios = NULL,
+		.nr_rfolios = 0,
 		.vi = NULL, /* can't write to fsverity files */
 	};
 
@@ -1518,11 +1518,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
 	atomic_set(&cic->pending_blocks, cc->valid_nr_cblocks);
-	cic->rpages = page_array_alloc(sbi, nr_rfolios);
-	if (!cic->rpages)
+	cic->rfolios = page_array_alloc(sbi, nr_rfolios);
+	if (!cic->rfolios)
 		goto out_put_cic;
 
-	cic->nr_rpages = nr_rfolios;
+	cic->nr_rfolios = nr_rfolios;
 	cic->cpages = cc->cpages;
 	cic->nr_cpages = cc->nr_cpages;
 	cc->cpages = NULL;
@@ -1627,7 +1627,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	return 0;
 
 out_free_page_array:
-	page_array_free(sbi, cic->rpages, nr_rfolios);
+	page_array_free(sbi, cic->rfolios, nr_rfolios);
 
 	for (i = 0; i < cic->nr_cpages; i++) {
 		if (!cic->cpages[i])
@@ -1679,7 +1679,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
 	}
 	page_array_free(sbi, cic->cpages, cic->nr_cpages);
 
-	for (i = 0; i < cic->nr_rpages; i++) {
+	for (i = 0; i < cic->nr_rfolios; i++) {
 		struct folio *rfolio = cic->rfolios[i];
 
 		WARN_ON(!rfolio);
@@ -1687,7 +1687,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
 		folio_end_writeback(rfolio);
 	}
 
-	page_array_free(sbi, cic->rpages, cic->nr_rpages);
+	page_array_free(sbi, cic->rfolios, cic->nr_rfolios);
 	kmem_cache_free(cic_entry_slab, cic);
 
 	/*
@@ -1800,7 +1800,7 @@ static void dirty_partial_compressed_cluster(struct compress_ctx *cc)
 	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 
-	if (cc->nr_rpages != nr_folios || f2fs_cluster_is_full(cc))
+	if (cc->nr_rfolios != nr_folios || f2fs_cluster_is_full(cc))
 		return;
 	for (i = 0; i < nr_folios; i++)
 		if (!folio_test_uptodate(cc->rfolios[i]))
@@ -1947,8 +1947,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
-	dic->rpages = page_array_alloc(sbi, nr_rfolios);
-	if (!dic->rpages) {
+	dic->rfolios = page_array_alloc(sbi, nr_rfolios);
+	if (!dic->rfolios) {
 		kmem_cache_free(dic_entry_slab, dic);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -1969,7 +1969,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 
 	for (i = 0; i < nr_rfolios; i++)
 		dic->rfolios[i] = cc->rfolios[i];
-	dic->nr_rpages = nr_rfolios;
+	dic->nr_rfolios = nr_rfolios;
 
 	dic->cpages = page_array_alloc(sbi, nr_cpages);
 	if (!dic->cpages) {
@@ -2028,7 +2028,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 		page_array_free(sbi, dic->cpages, dic->nr_cpages);
 	}
 
-	page_array_free(sbi, dic->rpages, dic->nr_rpages);
+	page_array_free(sbi, dic->rfolios, dic->nr_rfolios);
 	kmem_cache_free(dic_entry_slab, dic);
 }
 
@@ -2059,7 +2059,7 @@ static void f2fs_verify_cluster(struct work_struct *work)
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
-	for (i = 0; i < dic->nr_rpages; i++) {
+	for (i = 0; i < dic->nr_rfolios; i++) {
 		struct folio *rfolio = dic->rfolios[i];
 
 		if (!rfolio)
@@ -2098,7 +2098,7 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 	}
 
 	/* Update and unlock the cluster's pagecache pages. */
-	for (i = 0; i < dic->nr_rpages; i++) {
+	for (i = 0; i < dic->nr_rfolios; i++) {
 		struct folio *rfolio = dic->rfolios[i];
 
 		if (!rfolio)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4153ffad9e32..5fd27b4a5153 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2767,7 +2767,7 @@ int f2fs_read_multi_folios(struct compress_ctx *cc, struct bio **bio_ret,
 		if (for_write)
 			folio_put(folio);
 		cc->rfolios[i] = NULL;
-		cc->nr_rpages--;
+		cc->nr_rfolios--;
 	}
 
 	/* we are done since all pages are beyond EOF */
@@ -3584,9 +3584,9 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
 		.cluster_size = F2FS_I(inode)->i_cluster_size,
 		.cluster_idx = NULL_CLUSTER,
-		.rpages = NULL,
+		.rfolios = NULL,
 		.cpages = NULL,
-		.nr_rpages = 0,
+		.nr_rfolios = 0,
 		.valid_nr_cblocks = 0,
 	};
 	pgoff_t nc_cluster_idx = NULL_CLUSTER;
@@ -4469,8 +4469,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
 		.cluster_size = F2FS_I(inode)->i_cluster_size,
 		.cluster_idx = NULL_CLUSTER,
-		.rpages = NULL,
-		.nr_rpages = 0,
+		.rfolios = NULL,
+		.nr_rfolios = 0,
 		.cpages = NULL,
 		.valid_nr_cblocks = 0,
 		.rbuf = NULL,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f17f44ffcb6d..058ed6386f83 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1691,15 +1691,12 @@ struct compress_ctx {
 	pgoff_t cluster_idx;		/* cluster index number */
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
-	union {
-		struct page **rpages;	/* pages store raw data in cluster */
-		struct folio **rfolios;
-	};
-	unsigned int nr_rpages;		/* total page number in rpages */
+	struct folio **rfolios;		/* folios store raw data in cluster */
+	unsigned int nr_rfolios;	/* total folio number in rfolios */
 	struct page **cpages;		/* pages store compressed data in cluster */
 	unsigned int nr_cpages;		/* total page number in cpages */
 	unsigned int valid_nr_cblocks;	/* valid block number in cpages */
-	void *rbuf;			/* virtual mapped address on rpages */
+	void *rbuf;			/* virtual mapped address on rfolios */
 	struct compress_data *cbuf;	/* virtual mapped address on cpages */
 	size_t rlen;			/* valid data length in rbuf */
 	size_t clen;			/* valid data length in cbuf */
@@ -1712,11 +1709,8 @@ struct compress_ctx {
 struct compress_io_ctx {
 	u32 magic;			/* magic number to indicate page is compressed */
 	struct inode *inode;		/* inode the context belong to */
-	union {
-		struct page **rpages;	/* pages store raw data in cluster */
-		struct folio **rfolios;
-	};
-	unsigned int nr_rpages;		/* total page number in rpages */
+	struct folio **rfolios;		/* folios store raw data in cluster */
+	unsigned int nr_rfolios;	/* total folio number in rfolios */
 	atomic_t pending_blocks;	/* in-flight compressed block count */
 	struct page **cpages;		/* bounce pages store compressed data */
 	unsigned int nr_cpages;		/* total page number in cpages */
@@ -1730,16 +1724,13 @@ struct decompress_io_ctx {
 	pgoff_t cluster_idx;		/* cluster index number */
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
-	union {
-		struct page **rpages;	/* pages store raw data in cluster */
-		struct folio **rfolios;
-	};
-	unsigned int nr_rpages;		/* total page number in rpages */
+	struct folio **rfolios;		/* folios store raw data in cluster */
+	unsigned int nr_rfolios;	/* total folio number in rfolios */
 	struct page **cpages;		/* pages store compressed data in cluster */
 	unsigned int nr_cpages;		/* total page number in cpages */
 	unsigned int valid_nr_cblocks;	/* valid compressed block number */
 	struct page **tpages;		/* temp pages to pad holes in cluster */
-	void *rbuf;			/* virtual mapped address on rpages */
+	void *rbuf;			/* virtual mapped address on tpages */
 	struct compress_data *cbuf;	/* virtual mapped address on cpages */
 	size_t rlen;			/* valid data length in rbuf */
 	size_t clen;			/* valid data length in cbuf */

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
