Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D50606A6CD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XnbQYW3h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E8FS/uKH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WxmS4dMD;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qv+QCLOb;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=hIzFNBlU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=o69smB3rV1ZT1HnP444KHR5rWsSHuKuv3uQ0CklyXHI=; b=XnbQYW3h5y9w9ruwEqntCknkaM
	/20byaC3k/Zq3fxuyZD7yAjj759sz/EyJYK7/UT7hZ1eg9ysUc/L8fKkW7vj7BOYyuLd6FsIQ/CNV
	TIjOoGKq54rG9Gb983exXICzpRpQDoUvIi6bPpv63Tq4GbKtxv88xsrvjrU66zb6fY+0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCI-0000000035m-3qd5;
	Fri, 20 Nov 2026 19:22:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCF-0000000035Q-2LJQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VLm4UR688EKcNkxM888o7vfBdrp77RSePcNuWdj7QKI=; b=E8FS/uKHXxsPymcPQTtXgwFX2S
 fYL+VJKLESGAicYE/JxPWPSlXp0u+Zmm6nbfYqzrsuweukXMDJBRaSKKtBD8x68sRSTANsZCo/kWp
 LBQTB7eCq2I4IFuNn/7+a9nJm1jA66O+rA0pLTn4qpGXsTAv2uTu2mgykvZE/vjo1skc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VLm4UR688EKcNkxM888o7vfBdrp77RSePcNuWdj7QKI=; b=WxmS4dMD7g0S0wBxnso4XLb2/R
 0DC5DR05CAwZ3vRSxzSCoL99alnfZJL1s1Zu+6vTMEVQBYnynBVJkRwQ3k2YYo3gyfScmjdqgugXJ
 mzQnhAubv8EjnW/frHMrb3YfycQYYFFtrodZeFSpKpRuq+Y2etTF7GnvojoJJa9f71Fc=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCE-000000007CT-3Dlz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:55 +0000
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuvFk3421321
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=VLm4
 UR688EKcNkxM888o7vfBdrp77RSePcNuWdj7QKI=; b=qv+QCLObJgk2T7AX7VE4
 DrXd/TF+GznqyCr9lpKRXnkuVgK9JEnpquoJmAjtlKWHXi0bbYDZeMkjnY+CIp2c
 BhKurMMtgeLnsVMObBms04dmPNB3Y4g0+txhc3CnyzwcHEGv1OMnmq77StJntnAJ
 74ti40h8nR6J7mbsuP0Hk/NG9JQ/jwAkxBk0I2riHepKrVCCDsa/PrTz/XwFomXO
 DuJP3IJjzNYfTmtHUr05S/uJxG7l8HCJXHf5EL/TJgdfdO5vuX/tydzK94rCrDE3
 iDsDxSlKzR1KnmW2tm2HRb6NbMedJhuxu6TOMCr50g9fffMd/vFICEQ7Jk5PX1dM
 HQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rym20rf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:48 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5364605e74bso33210721cf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202568; x=1795807368;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VLm4UR688EKcNkxM888o7vfBdrp77RSePcNuWdj7QKI=;
 b=hIzFNBlU/09f/4ik27a+JpbqjeoVlXsUXqYWRHFv+xeJleuY4g03yxWG8+hiTiAarh
 vOdo+8Jfcb4dG7ktY74pPsj5EdURd6RVyQH38pvf6YMINozOlwAEv9M24+CRulISW21h
 uuLUVV6lc/e2HeGgaHY7f1/DuythkID6EnsDcH6Ghy9+DnCZOvaRaQP7Co98RIRwZcAl
 gzwSHZR+JI4hZo5kpvOr35XpUve41A4qJof7HnODWmWtGm+Js+E5haUiTaCKwEDwLT1e
 O1NYOtliHBSpBLYjerfq0sLwTmo/W8pH8OsvnzmPfCcQwRT7d1Y2brTdcn1Twlb+ckkD
 1JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202568; x=1795807368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLm4UR688EKcNkxM888o7vfBdrp77RSePcNuWdj7QKI=;
 b=aUFqjpLJCMBzSeb6ENwalsywLvjwKf7EC+LeecEWANy9SOiA8ol4sKxFoz0dkEoplb
 n8cjYwQ5E1Ul3cLDh8KzJUfghY1deOWHyj1Z/hCoU0fX47+KUgaeCAmPs2jyGSEj39g7
 fsXRmrP/HiRih/nsoQRhmp/TjDMPSgMF7wRtDZUCy3vwLi7VVyCRGg6ei8O1IwqpKsYW
 Pnrb4g3tV3VH6Lk/uUMEHJngt1qT3q56Y8q+6s3YodKOkrFXTv0LHCd2pHQQOqAK6Eu0
 AsSyu1s678jbpIokMQsVw7i4l2btJjWC9L3un1Cjd7SyYEx7KJxRL26XbZwlKxmD6Nvc
 0fpg==
X-Forwarded-Encrypted: i=1;
 AL+hErG/0d4SxKEOGCZYhzmJv2STEICr8SYD8mi4fzE0ONw9kzdFnIUq+cvKiamtEGxSjwwKf4lY1eImf+V84ox5fN6F@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Y0aYIrg1FKPvTVOi96VQl2PhK0yTK2VHdN1jmI4/nabkIDbLq
 0T6M+UgJaPvwBqhxD1tQOsAnr+GSzDIDCcWshd1apd9ZrL4oOQ1y7ulhfws+2y+XjMxfJAJ+97o
 V5nRUd3Hem5gL6aVDYWdptxftFFe+LSe6h+MyM8Xc2Dbv0vebZmsTbNhk/rncKM18v4/WTGMHPZ
 s=
X-Gm-Gg: AYBFou2WvfUzGmCWLh6l5EUJzQUSfRnZOe0Y6MZxDktMhpOfmcoBGB7esgliQF9eK2z
 VRrkQCjmkL2d7rMLDi/wRgY3+y2Ra9eaq+1gegboJKZQWrUoecXiYXcpKAGImIesjj9yfzGiojP
 29/HpCWgfLXTESUCfayqpkMLE/SNpi+H+cUwlLhka96ybZRLX/1AHyYJ/jQaRjYzv8qM6uKR8sn
 Rc/D8rgncWWbXFd7orUzIEMjNVVu99poMyRmEH+SbdMCRVjpgoGLn4MQd2zZH3wkD3I+vddNf7e
 mEwNwHZNeKmoTnrPOeCM0HXBpSgvN2D1ynXOOPnIBC0LOMNgB5eZsVKtay6AFxxA2arr0Hp+xia
 8k8v2yYpKUDuCk2QhaYgInD3hMmZSh4yGJ+lxzybfkzEaQbEzoADRvCPpJauvhSysLfpv6KgvMz
 ODA4gX2ZHftx/XTsB0if+a
X-Received: by 2002:ac8:5d90:0:b0:55d:1944:a2b2 with SMTP id
 d75a77b69052e-55d76a5add7mr70943011cf.50.1795202568181; 
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
X-Received: by 2002:ac8:5d90:0:b0:55d:1944:a2b2 with SMTP id
 d75a77b69052e-55d76a5add7mr70942631cf.50.1795202567807; 
 Fri, 20 Nov 2026 11:22:47 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:47 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:09 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-6-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=5430;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=a1ViXz/EQ85MJVA2Jq1mr0ks40/tYMP6nsRH7qRrilA=;
 b=oawTVLA/d7WeVpCF3fI8nrQ0kGLJHeroURk064vbxkp6td1b8xh7cn4KhVhshldhaiLKIEy6l
 tyPyosO/O5fAMgISULert4Gg+BSAlU1pc/u52IzPvU8b+Gz31epJ0AN
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX5oOj3Z2qHih5
 zEld2Fo97VJMn3e3qh3fSJz0xEMSFoHAmeBUhHzALKzjbibGlMYoKVEsPKhXZQ3dtwNReAu2zJC
 JhHT7BZXNSsPyrC3OnPJyrWnmrR6Bmo3mO7HimqdGtqTPk/2tRMSNMdDDzRNUPBg2j2cPx7Yu/W
 E7lXiQJngl1bov2QJVJaSE4G9JvXM3PPM68STbyYp1OP1XMko5+kfxux0FBaZwcSoV8ycy2y70l
 k1dZhSvVyvlGBaMcTMmf8AmIKuDG/dYQIp7XcTYBOvVuY+AIn7CnvaLOAn5xA9Shg/bCAEoiOjM
 i2PbfjnpzpViID4h1whNvt15sHN4wQWJr+bSw/ocCuSaynEoG9NF7VDCNISEmd4FEHlfvumbKgg
 +AnH0TQC7Po683qC161FUgc8469rvZfWx8Z65GLmp72YP6KohBndwutyfvbLK0pelVy/QhVHLlY
 48zowWNm8xsWz0Cn+rA==
X-Authority-Analysis: v=2.4 cv=CZydd7rl c=1 sm=1 tr=0 ts=6b009e08 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=5kXoDD1LmtzOE4HRNOgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX5OM6t6Gz/MHD
 iF3HsGLmTBpJyznC5NDcJ3k7kzy779yG85hO+boTKbhOn+tPb/NaoKrkF3651o7Bo4MGtEDOEAD
 8ZAsnGD+Q94XzsdejR70OZu8RWX3IEgqvqqGo8pA2bKwtCYTGC+n
X-Proofpoint-ORIG-GUID: jPNaFVov5GnOFTPhzSDbeYd9DzdPtO36
X-Proofpoint-GUID: jPNaFVov5GnOFTPhzSDbeYd9DzdPtO36
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=10 bulkscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCE-000000007CT-3Dlz
Subject: [f2fs-dev] [PATCH 06/28] f2fs: use a folio array in
 f2fs_write_cache_pages()
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

f2fs_write_cache_pages() gathers folios, splits them into a struct page
array, and converts each entry straight back with page_folio(). Store
the folios instead.

Convert f2fs_all_cluster_page_ready() to take the folio array and rename
it to f2fs_all_cluster_folio_ready(). This saves a hidden call to
compound_head() per page written back, plus two in
f2fs_all_cluster_folio_ready().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c |  6 +++---
 fs/f2fs/data.c     | 25 ++++++++++++-------------
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index dfa78f5268a6..d9fbf1d75bb8 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -924,12 +924,12 @@ bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk)
 	return is_block_in_cluster(cc, lblk);
 }
 
-bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
+bool f2fs_all_cluster_folio_ready(struct compress_ctx *cc, struct folio **folios,
 				int index, int nr_pages, bool uptodate)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
-	unsigned long pgidx = page_folio(pages[index])->index;
+	unsigned long pgidx = folios[index]->index;
 	int i = uptodate ? 0 : 1;
 
 	/*
@@ -943,7 +943,7 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 		return false;
 
 	for (; i < nr_folios; i++) {
-		struct folio *folio = page_folio(pages[index + i]);
+		struct folio *folio = folios[index + i];
 
 		if (folio->index != pgidx + i)
 			return false;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a82a8d9f9d63..1a6803835957 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4458,8 +4458,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 {
 	int ret = 0;
 	int done = 0, retry = 0;
-	struct page *pages_local[F2FS_ONSTACK_PAGES];
-	struct page **pages = pages_local;
+	struct folio *folios_local[F2FS_ONSTACK_PAGES];
+	struct folio **folios = folios_local;
 	struct folio_batch fbatch;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct bio *bio = NULL;
@@ -4496,7 +4496,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode) &&
 		1 << cc.log_cluster_size > F2FS_ONSTACK_PAGES) {
-		pages = f2fs_kzalloc(sbi, sizeof(struct page *) <<
+		folios = f2fs_kzalloc(sbi, sizeof(struct folio *) <<
 				cc.log_cluster_size, GFP_NOFS | __GFP_NOFAIL);
 		max_pages = 1 << cc.log_cluster_size;
 	}
@@ -4542,7 +4542,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			idx = 0;
 			p = folio_nr_pages(folio);
 add_more:
-			pages[nr_pages] = folio_page(folio, idx);
+			folios[nr_pages] = folio;
 			folio_get(folio);
 			if (++nr_pages == max_pages) {
 				index = folio->index + idx + 1;
@@ -4556,8 +4556,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		goto again;
 write:
 		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pages[i];
-			struct folio *folio = page_folio(page);
+			struct folio *folio = folios[i];
 			bool need_readd;
 readd:
 			need_readd = false;
@@ -4588,8 +4587,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				if (!f2fs_cluster_is_empty(&cc))
 					goto lock_folio;
 
-				if (f2fs_all_cluster_page_ready(&cc,
-					pages, i, nr_pages, true))
+				if (f2fs_all_cluster_folio_ready(&cc,
+					folios, i, nr_pages, true))
 					goto lock_folio;
 
 				ret2 = f2fs_prepare_compress_overwrite(
@@ -4602,8 +4601,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
 						fsdata, f_lblk, 1) ||
-					 !f2fs_all_cluster_page_ready(&cc,
-						pages, i, nr_pages,
+					 !f2fs_all_cluster_folio_ready(&cc,
+						folios, i, nr_pages,
 						false))) {
 					retry = 1;
 					break;
@@ -4691,7 +4690,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (need_readd)
 				goto readd;
 		}
-		release_pages(pages, nr_pages);
+		release_pages(folios, nr_pages);
 		cond_resched();
 	}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -4726,8 +4725,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		f2fs_submit_merged_ipu_write(sbi, &bio, NULL);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (pages != pages_local)
-		kfree(pages);
+	if (folios != folios_local)
+		kfree(folios);
 #endif
 
 	return ret;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1090bcf1c776..8e884c58edd2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5015,7 +5015,7 @@ void f2fs_end_read_compressed_page(struct folio *folio, size_t offset,
 				unsigned int nr_blocks, bool in_task);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk);
-bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
+bool f2fs_all_cluster_folio_ready(struct compress_ctx *cc, struct folio **folios,
 				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio);

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
