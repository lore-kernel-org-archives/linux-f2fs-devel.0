Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97880606A6E4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CCGDLe2X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dGmiiCMT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E+tZo1gi;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mUcsROo5;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=R/IClzyP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=9LLgc31NJJfSzAzdHktCr79/GjqS7CiKElNM3spgqIY=; b=CCGDLe2X3bXsk88Zf+Usdy5fL8
	Y46NB8YmSQeGHhbDvgbl/DlvQ7n3z23eAHaCbPLEF3ZI9qUnXyn0N9wsU6ykBjNf1USeuFqKm5M3d
	Qofed0jMZ6eHZLt8eX62/E+J2Rzb1cIo+M60vCsK39zo1vNO5uTqhoHLAHHLasjp3buY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCi-000000000nb-1KMX;
	Fri, 20 Nov 2026 19:23:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCf-000000000mX-47Ri
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wFT30atfGW023CH1Irf0Uv+lV7zu7mGT0sGtcKNn6dY=; b=dGmiiCMTOimLb9CiyKgxNsNS7n
 UkqzMXAVUMGQrvtfcJ7t+v9H8F5EX6xF0P6F0Ohna/DArCyyc4ArOfW25KoKZasHRajQInj5YsQQG
 juaEWMooBf+dnA7oiev6V1iJHXUqSW8f3+DI2kzKGO8XTe8KjkwG7U8lYrj7SRTzgON8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wFT30atfGW023CH1Irf0Uv+lV7zu7mGT0sGtcKNn6dY=; b=E+tZo1giaV9/OVSLyTers4jhj6
 0V+9I6bsy2zLceNNfPCctSIGzgIXUwDBTZHQbIZDYqgxqM3NILXrKLg8BRDa+xjscz0+OvyQ/B7Z9
 DIwLsIRjwfHPrcZa8EE1uQurqRIOO/zsPexzxiIKEX9xe2EF4qjrNYDFtqjp9y0ruLGM=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCb-0000000018r-3rUD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:21 +0000
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIustB3367420
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=wFT3
 0atfGW023CH1Irf0Uv+lV7zu7mGT0sGtcKNn6dY=; b=mUcsROo5mO3jFKT173y/
 e6gctJo9xYOpr+gKSAnFIDd9VIkagzJFeePkdgM8aq5a5RCOp08jYNoP4C894lqs
 Ker6lYymUIIxQxDwNm5jWLrOpxD8/EKXLHaxHiXsQ9QZxe0DtsgkbgVnwWXyTFfd
 4Il+fKxewDNdHunrtKgZxtBaMBm6izbgExfOMGe7cXXSRhhYLMhimEO/5uhczlfZ
 Ct7g43avce85PYxvG7fghEBH8/w7WHUGtJyM1i6iNCBOoKVbx+MxNczeXDpRgJQb
 Rz9QfM9FAoH4t+3iDYXFEEam5uIgndtBbG8qp0l19frFUaLS+DXMFoX8NhaPyJ5Z
 NA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2s2y9xtu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:12 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-921273a6cacso19416706d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202591; x=1795807391;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wFT30atfGW023CH1Irf0Uv+lV7zu7mGT0sGtcKNn6dY=;
 b=R/IClzyPBf1KIjCf9uxUstAjuwI6on/8p1L8gJa5BUJCgdNNPLbXXloq6UtTcXBWo+
 rXlfcdrnws4b3buS9X4UziF2RwS10ZwQLeSQdY2ch9/KsaUz0zItJoo0nyYRqk/WlTek
 /Nfa84MuyiNK1Lr+/iibz93WicA3uaKqgpAw57frSpeSmfR8niOQkgg4cb3CBipgpE1O
 Du4TurjLdbNcIwIuZLB27vMUG1xcX9BT1JTCfBbdi9Onq3nDE9ok9abK1twJLVFOZ6DL
 xMxsHQYzmuXH1oF2Y2tq53EbFuV+q96QSEeJZy5ZhKogx96+947UDXzo6w7NctshfvVS
 LCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202591; x=1795807391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFT30atfGW023CH1Irf0Uv+lV7zu7mGT0sGtcKNn6dY=;
 b=hzlI6rpYzR8lQnqaCojN+mGuu1LTVvDZIQKKtsbCObMC96flvspPZg5CBQIJYHEUhi
 O7mMraM04tsgVA23ZnHZxMwWhV16MDA6x4KZpwlI7bpMUP4XhJXMw/NbGIbYhFegmuMK
 E++d0Ra8B2mpi/Hjy5eQn/IbeOwcYMtg8XFk1QbF9l0ZAfyy0vxMinEI+EwN1gUcxUMr
 Gyk0xdsAuKHZC5CvTnsma57WuIdQKN9CHRSJgZ/obb6nEWSeimpwPc/QAmaQq6sr+Yn9
 J7B1zne1Zmrl1GgBcmR+yFgY7B3BJdlWUNsyavd7tOpCbmk3b1T1bF6Vaf3NXGWh031q
 TQNA==
X-Forwarded-Encrypted: i=1;
 AL+hErFy2QmvBCOF2JDLP3BA+c0Mj6+KvtQB3xikQ6epCNy4ZFjr64sfrFUa++l41Vg6EzrlSl3mGJTxz9wQRIi9P7vJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9ZpTVVofSu3a0DdvpGn85FsKJ4LqSG/ED/5/ta/4ET+ETMEidd
 YOxegHcreKfKgW1dSZtKiJnffdK46okWEVvanjRUztgsHu22htaNof3F7iYzfLv8x1fDTz1sGAK
 6pFn+Co8/PdrNlEidJHyFlnRB7nEIkEgPH+HNsBG+04/aQT2T1i9kSSq4kECfSig1rKfVcCep78
 s=
X-Gm-Gg: AZFdTZcrMjQYdQXA7AUVKAslx6iDYhPeLzM0Qyy3+3yraGw2BaEvXGNTSBvAyXE/O4T
 3YWOUNE2VqnCKQGJvSLlM2gdG7Ow26gDIR7mEnCijx6EOQHbR9WOv/MkGqZjLJuLRswhRTx/Jdf
 SHeS5GfhtUvP2RLXUZZ+pZaQAVlaNU8Dj5ZL4DH9wpeHKBgBtK2b0+6t6VMqET2SE6Q8SCFDb3a
 r0AIrzDQTFw9PHeihtO405nezoqhN4dEs29BPxFGUt5QEjhj/brgoqLnFgQlzyHibnkUKBclCkN
 p86AxqOH5R21stdkSOS7EmxH4vOKSQ/Ffbp8RqOAn7qrDB0aAruSB1kBAimH3QcvIdDws++/yO+
 wYeUAhfIdz9kB2joJ9DKJJBqz9pADnETL7CEDsFlE7djIMADk3x6cehdDqRHIv2EoLvbjOyxMP3
 eyCF+e3jPX4Ij9D09elKuj
X-Received: by 2002:a05:6214:5294:b0:921:3766:8307 with SMTP id
 6a1803df08f44-92137668410mr49092506d6.10.1795202591270; 
 Fri, 20 Nov 2026 11:23:11 -0800 (PST)
X-Received: by 2002:a05:6214:5294:b0:921:3766:8307 with SMTP id
 6a1803df08f44-92137668410mr49092216d6.10.1795202590831; 
 Fri, 20 Nov 2026 11:23:10 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:10 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:31 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-28-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1105;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ivz0I811MENZ6SG9j0Z1uL4Fm6G9QDzqz5Mnqumi1ho=;
 b=l1hyYH06J76WHQ/qsqiF1wcLjD1ptMgkTIlAdN1vYhoCRf2Te1jw8BL26j7Pqts9hzFXjJBOe
 HDm+gZKp6+HCoIyM9WqUPql2r34gzouTGmT5OZUzCserSee2MXGztTb
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=B+osQ+tM c=1 sm=1 tr=0 ts=6b009e20 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=69Nsgg44elhYMWrvRsEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 8dzPvkUOiOpPXX_QDLGKRddip5_DkKRT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX2JksWUC8b8Wo
 kQTaxFvqf30YOqM2tl5EMM4gvttR53m300pC8aRoIzlgFMddbrbtyXb3QOXmrqQ2DBENN8uEi8G
 Ac3dGzJbMaMjO53qVorf9HYRsaoxNIXXgVF6g0Sr+K4tYMO0jKO/
X-Proofpoint-ORIG-GUID: 8dzPvkUOiOpPXX_QDLGKRddip5_DkKRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXytUqExe1dZbB
 LL0CGnXxCq+sNe50vz3C6QZ+6kzsX40myfJlcc6AlAg74JVgYKhdfy/l00ddoY9cbmTKe8jvzaO
 HJRB4qrRF/bzd+vKLY2GREz70JF+ooH3jD10BpXhMeWlQyCeDCmVfDfa44dz0GBvxao1/2LPcMM
 pZzt0yqUohXp9g0y6/2PThw8ctzVXnec3EbhbMmX0k/sbWAn6yrhNj6vDnEiF/Tn1ax0awOTDGw
 pyxdbCrfbROwMuX1OHfyo31patOUuebBHyrmiFDdUAZSiXTnOaiTR2cCCHW0MOj8T9pOQltPMxq
 wgqaC1pNWTdXJvOF3tcKDtrKMZOFjRlLz3Of1b2IIoc/rduI5Y6OPi+tivQubEC1VW8N60UdjEA
 eSIsLLKOaOU9h+5NIFyBY3N6KdGDH9L5de6Q2xy/Hk19BEB54vfBpcD3Pt4zmpHIF6NZe04QdCH
 f2ev/IH1BohvraB46sA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 impostorscore=10
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCb-0000000018r-3rUD
Subject: [f2fs-dev] [PATCH 28/28] f2fs: use folio_next_pos() in
 f2fs_vm_page_mkwrite()
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

f2fs_vm_page_mkwrite() open-codes folio_next_pos() in two places as
folio_start + folio_size(folio). Use the helper instead.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3caa6ceea554..190798c2e0a5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -214,7 +214,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	folio_lock(folio);
 	isize = i_size_read(inode);
 	folio_start = folio_pos(folio);
-	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
+	valid_end = min_t(loff_t, folio_next_pos(folio), isize);
 	dirty_len = valid_end - folio_start;
 
 	/*
@@ -288,7 +288,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 zero_tail:
 	/* page is wholly or partially inside EOF */
-	if (folio_start + folio_size(folio) > isize) {
+	if (folio_next_pos(folio) > isize) {
 		size_t offset = offset_in_folio(folio, isize);
 
 		folio_zero_segment(folio, offset, folio_size(folio));

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
