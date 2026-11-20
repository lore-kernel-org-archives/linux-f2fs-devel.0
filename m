Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78D606A6D6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XfxZcfHE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NYNR8PIc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c+ccTQNE;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=KKF/C60s;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=2ldbqiWR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Caqy4vAYztR2P28Ev9BvaMXctg8citLwphcuEjW+/hI=; b=XfxZcfHEcOC2b2N0Xz9XoKmtdF
	GX+6PeAp5Sy0P1vSYMhAV4cXdhsAWppHHqf/8uCBsVrMSL5/j3jeVA9hjrr9kgrZtyyoANgqbBC63
	rsXWN2A6aT9vR+PizaVp5nqbjwMVA0L8tROG9uf76ZMdBPYMPLyMBhDgbauD/LyMOYOA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCb-000000004hz-22wk;
	Fri, 20 Nov 2026 19:23:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCa-000000004hR-0Rp3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2Xet71RZ/Qrr/nCfJCH9jz+PAp5wsXV4CXjUQ6M5Qg=; b=NYNR8PIcvZXpIHmj01zXPgxvBN
 gWBQ48/30Xx4Tpt82kT5Zm6EQnbHStpJdpim7g/eLEU3n3JJstaA5w5gvPKN+MDW48A8U/E8yAqvi
 5Vgu8LTRW8Gvk9JlbKTGDhlZklHJdyCTCIGTlp2vgmwtqjZbPxaS/jTvtLT6Wu3qK4Vo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2Xet71RZ/Qrr/nCfJCH9jz+PAp5wsXV4CXjUQ6M5Qg=; b=c+ccTQNElZvqRREiICwkYK1gWf
 gRAQY0QXtqbsbfw8R4aqj7hzklHlaOEQ5tQn7MeB+iu7PWTAC3sK1FHvpQt//DQTeQSnIrr0OFlrk
 yiGZYrtnHjFd2M0wJPTdvL4ohRQcQuI2RSoS4SPDlmUjAGFEPxkgW262KkrhdwYHB/To=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCZ-000000007El-1ogm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:16 +0000
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKJ1v8M3343179
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=K2Xe
 t71RZ/Qrr/nCfJCH9jz+PAp5wsXV4CXjUQ6M5Qg=; b=KKF/C60sMWIwGUkepjGP
 5ONMVzKUEyOCMEq16shSELu6xupKdZyTzAJZgg/j6rY2q6HBf3W/1qt18bAp2BZ8
 wCgKcQAuefBEdCRPvwSjMmP9J4YKtI93o5r68sWsX0XC5CWM2BmVyfjtSpg1JIy8
 6WtCmUUre7uCqbreKKngD0isIRvH0A8Qowm5UIhmMHRS1zDJl9tk2XeJ3ZnpGFMr
 C9QwbfqTqIqtfmwDcsB9Gv9FEGV+SBMmZTvgQjNTsrnHN/Epfp7VfvTEPGAQesWz
 t175q8ct87o9S4w61bPxzcgiND7IDQZOBUp3tutI1ZtUhqoGCi7xriC2NU55RErD
 yw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2kncm9y3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:09 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5364605e74bso33220501cf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202589; x=1795807389;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K2Xet71RZ/Qrr/nCfJCH9jz+PAp5wsXV4CXjUQ6M5Qg=;
 b=2ldbqiWRWfcLCaHpP3PUuUaoH9885ylK1GmEWkqWqvd7WF+ee9WOJkU/TqWBgRrh+V
 088qJLvSN7gJJpY0PHLB8+OlzIqfufuljM5mmu0dmEruMNOxp9m7V27t0v4dYKAs/G7P
 as64fq5OS5fZwG+fBSu5Wmqw12D23meatKzYTsvR1qJS0ILa0YoVu+65rI5JM+abUbJ9
 JWtftb9Ne3Yr5AN0CUOoJfx+l9wG6PKAKsgATD4dms8wKsOgbU4eAhtbDThzqsYAsIct
 j7CSQvW5SYbER2QDbpUpakQ53BQyBZTUuPd4DEmU66BTSNjHbH3AspcCyxC4PZ8nVcZr
 rv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202589; x=1795807389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K2Xet71RZ/Qrr/nCfJCH9jz+PAp5wsXV4CXjUQ6M5Qg=;
 b=1rT2ykvsH9mCbM/nqmfuN3UITMBcZH/aF2UTzawScublMolhshL3nyoURElBk+xpb+
 6Tu12cOxvebSatynrooBFFc/6b9R3XxGIIsivKH4Q+98StM0okCydD5OefzY+wyp0zjJ
 OakOVHz2Fb3oQxmFHSYRMUSCy3i5AMZm/veVTaPZj0hzyoOD4XCqOgA6dtKBwpvM9pCK
 /rS96cRhfQqWfxXDNYDzWW5SACo5eWHtWqjOiVMy9z23quGLXQFJWnf9XzSrDDZqy0gM
 V8JHpJ0W1CG8jvhD9nl4DOs2RqwPCSmDvsGM5mle1aDVxRPJVI/Vye9faDdL8JigwyJ7
 M7Fw==
X-Forwarded-Encrypted: i=1;
 AL+hErFoXxfyv7OHtAHrGXHIIwu13lU/CfMZaYiiHXpoIutFgmNc2UnsLxW/0Zzi9yoh4HM4dzr1m/Qi5Z7b/oxRoG/j@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+HsEqH1XjzVXsly+BVwb/hb9CSAIpkfq96/RXe/ckTSEWz29ad
 +wHBlAjnlkZX6z+d9i+rGcyyz/6eaJtQDwDJ1JV6HdGbK2WBlTqkj68OU8bKD5SnysBsyojonGi
 v+kR7fRYKYN3kgcP7rsElU6aVk6EOUvQlLaSYnQiqNqJfU/s6a5YrL4Kl+PIbBYnvcwgqZABISd
 8=
X-Gm-Gg: AYBFou31GgkRH8Fz/rC+q9h+JXi5YlybM6JckmjrOzq+cbEBWX0gz5vmm4ukwyQI2Kf
 WD9ddOwbcwk/Js/d2pY7XyvCBd00b4tjvITOeIqVfp8jaYTzlBY/aOH3kETO700SCTFk9iRg5By
 VR9aGxJV4mOY1w5G31ULotMCOU6zKex5fpJGwK6a2aePk/AiRbFU/r3GAQH9NpQ49bgeO+VaKKP
 y3FaQBRGAxXZB01f5G+gP2mbgAqIG5jRz4o+n/+BBrmOmdXOGP8zOvM0UxtF9gWoEf3MQRNWSj1
 ZC5e787sbSzjTRzC0usVG27ORR3xJpCVazlXgi0b5IVKzHh34CappCinkDwoUZre2fi5UGykAST
 Q9mvwIAst+zfOZt+NPFtLFj5jQGsdMWb0ln65J022pb4/sD3fBvK+1KR96AZ2mTFBd3gN1pnSiI
 IUtCdzjFMP+XQ4TUqK9/v/
X-Received: by 2002:ac8:5e07:0:b0:535:25db:17b1 with SMTP id
 d75a77b69052e-55d769e8170mr75280601cf.17.1795202588754; 
 Fri, 20 Nov 2026 11:23:08 -0800 (PST)
X-Received: by 2002:ac8:5e07:0:b0:535:25db:17b1 with SMTP id
 d75a77b69052e-55d769e8170mr75280321cf.17.1795202588396; 
 Fri, 20 Nov 2026 11:23:08 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:08 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:28 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-25-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1739;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6FOi3sQy0q38ReXAKE+VmWXioxgqSUo5DLvA6yn47hA=;
 b=9fL1HBeEewXhKVObkSrlo8M5wXLIG/kHSjmjYs+OYPfrBa+4AmfNVZ8kqVYA+skf48RDktbyD
 HOdVh0eMOGkDFcJp2H63Ftdbx2E8N4x0/igQ/oM97BgCHMkQr9+MC6M
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: IZFEX2V-3xoFM83steHqBQmNdvwVWIcC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX1lQS4KRmczI5
 JeK4srG1TzdI4u7u+/NV0H1R7g+IEgGAgjrxfVHDrEq3RKfoW7ekIkEULEwyyyAoyOy/5x+AN3/
 f8HrbaoZ2IQvLsA7c/St4BqNaJThkSb6hRjTOVTpaUeYMiQwIGcj
X-Proofpoint-ORIG-GUID: IZFEX2V-3xoFM83steHqBQmNdvwVWIcC
X-Authority-Analysis: v=2.4 cv=P9GvFSAu c=1 sm=1 tr=0 ts=6b009e1d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=pKenR_sKghO3cmOQMTwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX9zUt5TVc8zNq
 FkWQlr/ncGK9JUf7SIbTrA7S3KQGBMty/iR+YQbIExOT89bU74M+FQS/yO4IDANPCKKC/pNW6X+
 z9YUaIIYaE3kF2iCZvd7Vr8k9N5sTlaQ/v5/77/zT32mldjbCcbzc6wzp3SeiX6ALc76AiJKrzm
 aMofwGDuxwKEqgDiabNpbHKJH3m+GqlMY8CGVgoL1vDQpdAXmpotkrsYKl7bVvZq3h3Y0w70LM4
 wMoCQ2zty9btczhzEYAfNAzUBRM4rJfi8spploR6yhgdffH+pKSVwBdbMrlvCQ2KZQVIr+FZuQl
 /5cpJ3aokJ0glnhaVhHWuczlTLtIIbyZOfmaK7TS5d5cYwKOZToNaJf5s4IP+pNJ8NfAHI02i/u
 Dx5aIZfvKHzdQNUu0U3xL9l6GYy4VqWThSjA3GUrZ/B7nke/bomnnRxUqZYQOjNXCTPl6VlJSL0
 BaiDOvERGzkU4W8RIkA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 adultscore=0 bulkscore=10 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCZ-000000007El-1ogm
Subject: [f2fs-dev] [PATCH 25/28] f2fs: add f2fs_vmap_folios()
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

vm_map_ram() takes an array of pages, but the cluster is about to be
tracked only as folios. Add f2fs_vmap_folios(), which collects each
folio's page in a temporary array and maps that, as the decompress side
already does with dic->tpages. Use it for rbuf in f2fs_compress_pages().
The cluster folios are always order-0.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e7a0f66b7a89..e5fa4c01d3d4 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -632,6 +632,29 @@ static void *f2fs_vmap(struct page **pages, unsigned int count)
 	return buf;
 }
 
+/*
+ * Map @count order-0 folios to a contiguous virtual range. vm_map_ram()
+ * takes pages, so collect each folio's page in a temporary array.
+ */
+static void *f2fs_vmap_folios(struct f2fs_sb_info *sbi, struct folio **folios,
+		unsigned int count)
+{
+	struct page **pages;
+	void *buf;
+	int i;
+
+	pages = page_array_alloc(sbi, count);
+	if (!pages)
+		return NULL;
+
+	for (i = 0; i < count; i++)
+		pages[i] = folio_page(folios[i], 0);
+
+	buf = f2fs_vmap(pages, count);
+	page_array_free(sbi, pages, count);
+	return buf;
+}
+
 static void f2fs_vunmap(void *vaddr, unsigned int count)
 {
 	if (!vaddr)
@@ -677,7 +700,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	for (i = 0; i < cc->nr_cpages; i++)
 		cc->cpages[i] = f2fs_compress_alloc_page();
 
-	cc->rbuf = f2fs_vmap(cc->rpages, nr_rfolios);
+	cc->rbuf = f2fs_vmap_folios(sbi, cc->rfolios, nr_rfolios);
 	if (!cc->rbuf) {
 		ret = -ENOMEM;
 		goto out_free_cpages;

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
