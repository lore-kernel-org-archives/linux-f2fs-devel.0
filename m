Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7D606A6D8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GG7Uzps9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MplCz9nx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Prql1bLZ;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=F4dPKew1;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=E7YMXrSc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=agR3X6wLVzfBl30WAmsXytwC9oVs36wTizPxE69Iakc=; b=GG7Uzps9RE3obRhWDqa6c7T0ii
	Nvp/AJLg25AWOuEBD0r3lxPqYSpzD1ur80Y0zYP6dAsyh//ZshlQSYqC1APyBk/uLORK4HBdFDHGD
	sfjEtO4gD8TbhdLpAH18RinOv5/05oN70jGOLA7j8A07vQ8EDRUMAYau73AHMvAsoC1c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCE-000000000b6-2u1e;
	Fri, 20 Nov 2026 19:22:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCD-000000000aV-00SR
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3M6Pbypu4eYA2iMIdSbUGddqg7qZdiJ9uHVXA8008TQ=; b=MplCz9nxoAjisQzNsOjZbSF8c5
 FFrTYHd3MFvQlj9tsiM2gADJ0zGCjQtiwe3E6TXyeydPq8GzyZoLNmxb/i5O/YA/FiPznIAv1ZFha
 yk9oR26iy0EwUlq7cO3oRGcdHQwqmcE+grV9YrxD0brOyqB7d16Vsf1x/tfLI0YXqreM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3M6Pbypu4eYA2iMIdSbUGddqg7qZdiJ9uHVXA8008TQ=; b=Prql1bLZj9iypRNYe50Ei78d0G
 OiHn5/NZQXCp49JfqDL+g6N00sZ6ZI/mrlSwobi+meKUbw6WwrthG5m8N/IgkKrnLtbc3wVLq2GjI
 HeCfDiVqeiG7wRwUX/9QrCxEUNAszZGuEJB00inoc34FVsmYndEuBWKZoQFM3UG3qFkU=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCB-000000007CP-3sgl
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:52 +0000
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKJ1vDZ3343182
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=3M6P
 bypu4eYA2iMIdSbUGddqg7qZdiJ9uHVXA8008TQ=; b=F4dPKew11XxwWLyvcHg9
 CFsxCDZEn2KLnaFZygbi7uVHz63EU2q0ID/X7TMAlzRW2m/jnb0WjCMEEkQONoSa
 KHvQPCeQDJ89i2gWl0NfP+luJv0Wgc6HLgJv8rEC4ZN85ChKB6d47Ah/reyxuhtn
 5qbJJto0CM9hsRIhMYNLf8NKXMWewQH3NXfCNjD434XUVcVGIwVu7JUycawr7VhD
 yHCJjNlBTPByft5WW/rAOKeYxbVwMCoQvY/mGTeLN10kQfy2/5lYhk7n4MQCpUxR
 whpX1+ROBO93FIedPMW0xhHRuLDHdCFK6jSeAjwCVTOqdCxt9WaAafw0r8/NG5/y
 WA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2kncm9v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:45 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-92134f1eb00so19488626d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202565; x=1795807365;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3M6Pbypu4eYA2iMIdSbUGddqg7qZdiJ9uHVXA8008TQ=;
 b=E7YMXrSckLEVPVO3bmV1RjelrmbA8L8pPSV1QMdAFAOIUklfXSO12ziM5xIyDJMFmQ
 +U5sUq+er4UwMsLI4JIP+DHoGYon8RRoBFlplKxoAmUitBmcJzF/OoKdl/n+J+yIZmll
 7rirRlq2lGlQdrVt7cl/YD27+PvXU9jFaXuRELYhleVj9WqQ7SkAkA1YtBfGyTy8YEa8
 fTSy4XAAOV+0b2hRg9unT3e7xtJGRNpxmOUwrgmfGu7MkPvCkmDNicNIcIrF6dAB5dHd
 nWtzBEp2GDbR/3sG3QoV+6inn2a00FZoYD3XZm3Z3i8eTUdJvPy72vhMly2Fzkk97/ZL
 0eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202565; x=1795807365;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3M6Pbypu4eYA2iMIdSbUGddqg7qZdiJ9uHVXA8008TQ=;
 b=AwR9vO5UGfX2jDZ1VCIM0tx9o2759AUdmSpV4dm1oqhe8YZgk2tPgloislukLIIXGF
 CHhJvdBrEPiialvBoW1wrNr3VfDy4Rewlpbl2OfjTpq/hJAQlk3zZ9gLHAJpXGCs248R
 VmmYl1IkekOpgSXql8sU6xSKEKjkqU4gRKN3XHQ0Qjann6tBtkVlztaC7v8ic/kbcrbK
 CU7qD8YN/S6ix2EX6V8HEYKCy2qI1g2LIvTbqTKomn1hFoSxE8bdmQYprl7XGqjEzQr8
 eRoyKjH6yJ+9Am6/5B85I3Lg495biADtiSZ0BIFd/VLhksxlK5dj7mqOLchbyIciAnUX
 T1Pw==
X-Forwarded-Encrypted: i=1;
 AL+hErE9hMlpob7SFetLUvjOMjrNkRVdcRh4qgQ3T3C72HuJNHkai6hFhTldHrdcBWcp/Yry2l8rdyi8AXd+La2E/TU7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/tqNeTelQj5rx07klGiLyebATQy1P+n8yLojXQBAJyVjpvRApv
 I5ByneNuIV4bYloCfhZHeXV2nFrkkK0JA3TTTULgkBPkTwsdOSpnNoV3410O2lOUkIUdy+/f527
 i2AVSTSqeymowAVriQEYW13I4L2dFgazKulL5jNJKO7bP4HROjYW/C1zC7W+TxFmA8DupR+MsRG
 s=
X-Gm-Gg: AZFdTZf7O0jFDwY7Mdxlv7yWMYGQbUIeCtvVYgY/w8mO54SbgZnTv6SzHNVKOowc2bp
 fDiU75fBdPXMDoTHEKlWnY4PjTt5ydD2F4Lj5uv5VC4WRKtRm1j2SxyRuwMmJqCksrpyUvIVcnV
 SIJlFw42Nlucw7JZ0w/nbExP0nFtqgbn9ghl/HwOaMXMHuBzG3uaCDB/MAKVSNoHW7mk3llO9Wh
 XmI5+OvHCTjBonHLSLMkGeoHjesyKy2MOIQgj8NMAUbmZq6SIObGEzi+n78k40Sg7EXjqHftxmC
 sdpXHD75Wn9S38V5+Bxs+Uv96hnTPLaPpL40vrMzr8CtRHsMJLeNbtaTLwepC9uxQt9up5NEtsV
 CKb7PBNbZsHRPdMBCqvgk1dDfNCH5j0kjGM8c6mOP9BCaiVjVspfjxLBoHfRf1AnEtT6tWFDg0V
 rFS9u5JHaJUkJ2qWbu+wMO
X-Received: by 2002:a05:6214:6206:b0:91c:52f2:b469 with SMTP id
 6a1803df08f44-92134aae832mr48833616d6.15.1795202565427; 
 Fri, 20 Nov 2026 11:22:45 -0800 (PST)
X-Received: by 2002:a05:6214:6206:b0:91c:52f2:b469 with SMTP id
 6a1803df08f44-92134aae832mr48833306d6.15.1795202564974; 
 Fri, 20 Nov 2026 11:22:44 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:44 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:06 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-3-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1103;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=CcKTyDysF44JJJ89eLqpJ+635yCH2kfLr6cZqRvf+VQ=;
 b=EjAVUPIg+wmPQaSFwCV3BYFEAuzv4ZWGb1oIlcCCmm2pTmGG43LX2d8mhlapHYZP39plM5CNH
 c+JjW7Bl+5MA4O/qandDexdKullCMrgTsH371wAJOX0Wc8grmyrr/v6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: H1dAFSBUSrtu7dKwQCr1QUa7I_eOhWaw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX7bWa+RMqMv/N
 5wr9ZcE/8DIYxzL+lbJvc2PUecjvQ4isutKIy7RM+sBU3Q6mEPxMvpnnSV0hbYyXvKw1njdvDfw
 OZEB9vmPtgVbpJ9fq0fUKOm23fV8EHrdqetz7u4uJNYgdybSuxwR
X-Proofpoint-ORIG-GUID: H1dAFSBUSrtu7dKwQCr1QUa7I_eOhWaw
X-Authority-Analysis: v=2.4 cv=P9GvFSAu c=1 sm=1 tr=0 ts=6b009e05 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=qGnrrUt8f5b3H2gddzsA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX0MhhKMvfJA7x
 SjQy20oRWkXFiWUoX2eG1iojuXKP6XUxzJJEC0kp41dGc4cZ7iVtoojA95qa8wyBrq1kPT1HUrX
 cMUwWGpiOSJFPZdseiajhMhmzMoE+AQPBluIPQpZIpEL5QMHya9z8bXUBiXsiQB1YI686da1xHC
 XMLe8WdxOo/YutUNl2Y285MBwj4SJTMd8R+nIC0U6fU5rKfAaTHwu0RKQmbKqjLRQSJuY8xroty
 KyjEQ2JA1Ux6ryQeR1v8PpbbtZ+SJnGwu89FqorBLZp5OTeYHOShf7KX5qa1wueNJ1Sj4H2GlKa
 DjWCmAO3nnjNauTmNzk7OQWSleLCcyLOaCNU2Ufykm6btdlKDcC6znYc+7ejLWyCdHbFLpNef7B
 3xkZ+VibK2f0bxKqAumnjPgXszVO1A4siDoY77dfRVUQSBwJ9EDcJ2xyJQqblxH8TpoGEThhXN9
 0u7LJIIb2LceZYPBGjw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 adultscore=0 bulkscore=10 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCB-000000007CP-3sgl
Subject: [f2fs-dev] [PATCH 03/28] f2fs: use fio->compressed_folio in
 f2fs_submit_page_write()
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

f2fs_submit_page_write() gets the compressed folio back with
page_folio(). Use fio->compressed_folio instead, which saves a hidden
call to compound_head() on the write path.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21e661673a78..a82a8d9f9d63 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1289,8 +1289,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	verify_fio_blkaddr(fio);
 
-	if (fio->compressed_page)
-		bio_folio = page_folio(fio->compressed_page);
+	if (fio->compressed_folio)
+		bio_folio = fio->compressed_folio;
 	else
 		bio_folio = fio->folio;
 
@@ -1300,7 +1300,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	fio_lblk = F2FS_FIO_LBLK(fio);
 	fio_cnt = F2FS_FIO_BLKCNT(fio);
 
-	type = WB_DATA_TYPE(bio_folio, fio->compressed_page);
+	type = WB_DATA_TYPE(bio_folio, fio->compressed_folio);
 	for (unsigned int i = 0; i < fio_cnt; i++)
 		inc_cache_count(sbi, type);
 

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
