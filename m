Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74B606A331
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F8ePIFpv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EXES20dV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N7dh4/6K;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aAFRrGS1;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=YYduQOYQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=RnqsLK2vWfAen3xz7YYFrq/X820IKga6O0O7ht+iiLU=; b=F8ePIFpvo1+DLKtVIfPOY1W7Xs
	qmsEWLDqJcMMSCB98FxlCYHck8MbIGIe48TBaeu/z9IXhQc00OqQ8vjprfSHfpu2HF48Jzxde6ISt
	VIink2E0NTsO0zyrr2jSOQQ1+8OX5gO7USgH93AjGiCRdnPXO39Qahx4N0W9T158h4yQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCI-000000000c3-3XTn;
	Fri, 20 Nov 2026 19:22:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCG-000000000bk-3mOJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jt4C6EJAVE9icnkUlEgJqULeHAFMGocZrKZGYcc0cHo=; b=EXES20dVqEvh6rVp+WVLLxTU6X
 k7spVuFrZADo+vYFQ3FOOAKM8pvAcqfloC28OD/QoHBGmuyzNzytplluS6Pd8W5ihLM/VRqt0LN5Z
 UeiWzkzaHJaQ97OHR8M8kC55ovnP7sVJdqnpuosaBNUVDdN8J7gTGy3BB4bQgaPEQijE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jt4C6EJAVE9icnkUlEgJqULeHAFMGocZrKZGYcc0cHo=; b=N7dh4/6Kkad2l6ImPDHBRYzKzM
 OFSBHH+IYWJE1MVhk6+ovI2QctRPQfjwF7Tfo8yCSjzWsKFzC7VlCI0duKgMHJG3bTJAoLYPeJLy4
 k02PtYEgdrjxbY7IquiVE/YfM182XnNL4gLW+fIyfO07YNoSQIhFjSuOekzAulV4LFas=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCF-0000000017J-1kLb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:56 +0000
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIunc52977530
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=Jt4C
 6EJAVE9icnkUlEgJqULeHAFMGocZrKZGYcc0cHo=; b=aAFRrGS1OzIVNf7rQMJD
 qunIb2/Y2N7VVgCZKGLTBbPos2NarOGgMPoZIIdkOF7JCUdCO+z1EibCLc+mGBth
 f03zVDL5uOR7jcKE32YJOnewPIehse1GEmJ1feltgGcxJui3qWxaSTl6XlOhdG6H
 rrd6daoqJ7T1gc9RlNQH8FxC8YZ9LmhiuP+77nXvBkHNsCs/c0u8a2yy5zC9KkzW
 sIP6xDiQxmhEGD+JgFvyzfIm/aIwKCm0wFXgaAG3+m7viGaHLZTVqkGDqvbHI8vS
 10U+fN3YifjVgAJ8IIK1CPZECaiL+n2HaH2KnZFNBqHlMPSE3o68haniVmjV4ZM6
 GQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2r0aaq7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:49 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9212335e257so28549216d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202569; x=1795807369;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jt4C6EJAVE9icnkUlEgJqULeHAFMGocZrKZGYcc0cHo=;
 b=YYduQOYQfoNsNhgiknlUq4OPL0yh+o2weWSzpn+gTjmiNZ+T9HjovpShY67iTRHZIy
 hzovMpc/aqmoNxlOb+T5mTw3tVLuvNe6AZif/FouLmsqV4yrPrC2bbX9G02aYLtTRMcP
 Hq1esCcMcjWx8Xi+z+ivNWrIi+Se+RAWONqMSuNFnUf223LRKnVlnjJTtfxe86F4EYMg
 LVLMuVsBF4q9MNEAmps0NG8Y1yNHaJYndcbtFI63i/1H6WurmJPXSmjWW9LLM/Vg0Sr/
 hvc5V7n8mrzJ9N5eQUjF2SlIwEtrLZIMdCO0izW7gQb+Ln6Z9crWW1nI+l8yFQDPGIAP
 8G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202569; x=1795807369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jt4C6EJAVE9icnkUlEgJqULeHAFMGocZrKZGYcc0cHo=;
 b=jZgMb6fhDBw/xZ9/LXGv/8v3ufy+8GGejrSiWYkQYqHCwrlu1ouN610Hv6lFyk5JoB
 Rb2qjjaZ9v1cjGyhuA0hfCm4/niWYpNQ6iB/x4icHgtzeICpxGNVifXHszF7Z2F1pTvJ
 rPk5X9ZDhVtOivDm3HldA3zOxWa6krGjaZuFNQx8+xZBqYauMV3pnWbpnMjIUR50rh3U
 0kSoVGO6e4tmh1SPaejB5WfrdPkSuFZc1B1Sm4oz3JJYacevCAhrdsv/+OQlegmNY9/H
 2fc3NBiFGa1LcmTux6hsf4AVaWvhsp6tCu+dn8Nch80M3f9X/6nZ7NcYNVJx8rYj5T9f
 bJlA==
X-Forwarded-Encrypted: i=1;
 AL+hErF+hpQpfzn/AzkmhaqcQvWJlRc0osVKsnPwRUsr00kZPWqNSPDeX1vYPps1rUz29f46hPuSXx2ZDfMY78uBPKYg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Gkj89WgMvtm+b1ahQI0qN6N6aF+ifr0Qt6XCHpFKCj7dzfpkz
 6j2o2vv9aktg0e0EJC73WVb+b9b9mnTdQDNwCqkhgqRTq5VhKSPnXLQzdc6aExU0YWv9/o1D9he
 EFs3e3PYsuIWAcGSwCs2s2egkH0mfvAapCgLN1NYrBz2a4VGS54kXDw2q2ugCuS6vIj058HuUQ/
 8=
X-Gm-Gg: AZFdTZdZmTEJF+hoqxVO1XsXMnBr+GKu5AENVzXznfdAxU8QeHHz2odzfW5Xz+q3sHd
 S/efbPkCZkszViaI40yrqvLj1b9sKi/N3+cTOTy3lDTUpzy4+zHXSrcGKVhpmtNLo3WjIuOywLj
 WPd+cFoiOF/wMj/xkrWix1if5vjizztq5OmLfqbUXtSLE8gpNLP9Hsm2D3yP4tN/9VEcfkqYG/V
 jrPhWHk9c3GyGLuH6aqrdybmzI8/cyXpTs5cqqtxJAzP2wNAFPUaQ5znOigCjc78HHLH4rSQruD
 H7d1ltU+hEwip2nCm7dAe/R+fzg2GlE+ewCcws288rIz3Us9ScraonFuzu+mJVJ/3uNOb5Q/MZF
 aPwqbgmjeg548DMh+087j41AqYPJtZUvh+VvEd+0iRc6BGp6Ni/b1nEBE7NpIALPPu0EjlRbP91
 yhg9Ch2PDgqZEk6pSqoanC
X-Received: by 2002:a05:6214:8624:b0:91e:9679:55f with SMTP id
 6a1803df08f44-92134a798c7mr69307796d6.10.1795202568948; 
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
X-Received: by 2002:a05:6214:8624:b0:91e:9679:55f with SMTP id
 6a1803df08f44-92134a798c7mr69307526d6.10.1795202568541; 
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:10 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-7-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=2311;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=djWJgEaMkPm8I0oLKcmkq+XdIoupHaFr49kqGyClWoQ=;
 b=fhyUMzCFKfaaCtG8JYafcASg4KaCQv4I82EXJaTGe6RGCOHO8H4RK2Ztcw9/HiFAGqJi9u50j
 GhE4A2JnLk/BiMsQETOzw7cjS2qgZvrCovwB7Hc9ecNoFdZw8YmnLD2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: gkm-TVc-8P4tU-rUJJtPegmxVRA9qVUD
X-Authority-Analysis: v=2.4 cv=ft9J914f c=1 sm=1 tr=0 ts=6b009e09 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=oBaBbHxf3VN-SogPKfoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXzj1O6iINsOnv
 TuEd62xYJMeJoe0YubapjH23TGACmgoXBJ7T2lBOuP+OcNLlMO/n1EonYDn2kDpHBzZPXBLNFVS
 q5+Cdjt830ykhXZqMnKI4Y9boxBpzqfF9dxF+Dm8mTwgcUF+kVLO
X-Proofpoint-ORIG-GUID: gkm-TVc-8P4tU-rUJJtPegmxVRA9qVUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX7ITKXZ97UDYJ
 +gcsctyBkr9QIlt9ZatmmvcAUS4b7uJjyFLRfkSZvp2DgdSryo65hF+BvAdT9v5IZOg3mf+CVLi
 w50IjAZWaQRWfFJcgubensUp4bM9XPnCvtIHk8Kw+l3vGhWR5KVCu1/yTa7egrM2ECaQA8juyQe
 Es7NEzR8Go8Tz0r8Rsjnm1iIFzQvTsahK/a2zXClAWHgnQNm5Ut/s3lUfSJj1vA+mj/IzT4kDMX
 6gSt7zdWldyzhsITC6XW4fHXyaQVItRlSkO98cyCf8vbAZ7eQzpE8cYz0pC/gqgxpP4KzJPO3sk
 5swn/6nYzOOg9Y2oSN78ZTNfjGTFBJzf+drR5s+2gyRuupWdYCkfV0vTWmbq5FZeeGHKhCM72ay
 oRBH5BDSzE6515h1tsNcfFFaZijyd+v9jqChR4Tea6TXqXT5blDaYuyNuO0XU4fkg8AQZcPQORg
 84bg80BOoLz58w05Alg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=10 impostorscore=10 bulkscore=10
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCF-0000000017J-1kLb
Subject: [f2fs-dev] [PATCH 07/28] f2fs: add rfolios to the compression
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make the rpages arrays in struct compress_ctx, compress_io_ctx, and
decompress_io_ctx unions with an rfolios member, so the users can be
converted one function at a time. The arrays only hold order-0 page
cache folios, so each entry's page and folio pointers are the same.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/f2fs.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e884c58edd2..48f9898af48a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1691,7 +1691,10 @@ struct compress_ctx {
 	pgoff_t cluster_idx;		/* cluster index number */
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
-	struct page **rpages;		/* pages store raw data in cluster */
+	union {
+		struct page **rpages;	/* pages store raw data in cluster */
+		struct folio **rfolios;
+	};
 	unsigned int nr_rpages;		/* total page number in rpages */
 	struct page **cpages;		/* pages store compressed data in cluster */
 	unsigned int nr_cpages;		/* total page number in cpages */
@@ -1709,7 +1712,10 @@ struct compress_ctx {
 struct compress_io_ctx {
 	u32 magic;			/* magic number to indicate page is compressed */
 	struct inode *inode;		/* inode the context belong to */
-	struct page **rpages;		/* pages store raw data in cluster */
+	union {
+		struct page **rpages;	/* pages store raw data in cluster */
+		struct folio **rfolios;
+	};
 	unsigned int nr_rpages;		/* total page number in rpages */
 	atomic_t pending_blocks;	/* in-flight compressed block count */
 	struct page **cpages;		/* bounce pages store compressed data */
@@ -1724,7 +1730,10 @@ struct decompress_io_ctx {
 	pgoff_t cluster_idx;		/* cluster index number */
 	unsigned int cluster_size;	/* page count in cluster */
 	unsigned int log_cluster_size;	/* log of cluster size */
-	struct page **rpages;		/* pages store raw data in cluster */
+	union {
+		struct page **rpages;	/* pages store raw data in cluster */
+		struct folio **rfolios;
+	};
 	unsigned int nr_rpages;		/* total page number in rpages */
 	struct page **cpages;		/* pages store compressed data in cluster */
 	unsigned int nr_cpages;		/* total page number in cpages */

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
