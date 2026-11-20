Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F44606A6CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I65Y9D7E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F1/t0+hq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OJwW8Kwb;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X26sbEyE;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=PxGNXrtL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=8hkkYAAq8PYk2EVRm15LB4s5vyiSq7j7ceKULbQ09HI=; b=I65Y9D7En1LZOL/z99gNNVpYx0
	a3clbN/7H2wbM+v8FOpvpc0Mf5wMy392Kv9UtWtShvU3wKH4BNAatzgGp2x4Mb/raSEdZ0XeSNpaH
	6agg4RB53GtTJ4LDs6xuDr5q+hjKFkcHFlk7nLrka+TwlXsCrBGqdL3gvOAl0qaAc4sk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCF-000000000PT-2gnj;
	Fri, 20 Nov 2026 19:22:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCD-000000000PM-2zFR
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+wFnH2eWQdcZNy/KpnSadLDrzNFBghsZfF/BvQ4LRb0=; b=F1/t0+hqJdtGbQIaDIqq+TmjDN
 Kb5SH6a1x3ZO3BYmBCkCbzNlY9p6hVDP/qOyUy2vasIP4t6xEeerbjSd5sIlEbX7C26VXt4FQeYFm
 Nn4xLum275qlIKSGroe1yhW3xr1hp2vYJWjhJ/OOZoMcpMKzt/8Xez+AEnuOwOZ4Kiv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+wFnH2eWQdcZNy/KpnSadLDrzNFBghsZfF/BvQ4LRb0=; b=OJwW8Kwb8Z07AxkMh3r9EusBJR
 M06EpqRuLXFz6w2mp3Zz0n70IZTbmhOCM6G7P0mZZgN0guXxNRcEpRUaIKhIr3UOpM/2KZsKEI9IN
 bc7f2KG11FbXGH+xCyZGW8NIp2SaeVTkscKabmr7+gZeeinPChzv77ib0aOnSdBrV2jk=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCC-0000000017G-3gzN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:53 +0000
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIurG73952571
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=+wFn
 H2eWQdcZNy/KpnSadLDrzNFBghsZfF/BvQ4LRb0=; b=X26sbEyEClRaB1uJj9Xw
 K8FS18IsA925mozpk2MDR5OaKoA7swYnG1cJ/ItUOfZ1rgNd+5120B4oqtnMthni
 NGCfsYFmDWxK37a7hk0HyQxKCmUhKHUmw5viLzS1WQClVBqF98mSICGq5DqwsajC
 Y/uNTgMqJDioFv2VO2JXFhmX2CR55ixAcAGTmXn29FSLCVLUwYUcyaUaEA1kAvsZ
 oH/vSlvUU8LhLiqdIEvSOzptwVyO05vRpWqWZ1+6dgSRPlhI7mGlY0knRmzF1I8p
 8w2ynbNndAV2bX97U7Mo/JOSC27NWiEpIWCnpcsiAQW1To9oQpVoAbS4Y4QlDFF/
 2w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2myq42bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:46 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9212d968d19so24558326d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202566; x=1795807366;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+wFnH2eWQdcZNy/KpnSadLDrzNFBghsZfF/BvQ4LRb0=;
 b=PxGNXrtL8FaefDwRyVqEmjKJ7mwQLOQuI1U7ylbPK8c2Vcb0iNBfwYEmxZxSTbFpVm
 mXeYMOXcPMYUFxsAaqzRN9jS5DcDaO4sdJhQUFCDkWcMZoUrOblv+bfZVD5VBuNUaVzQ
 awE17gXRWFFmzbr87jIbwPwR25sTwn/j2BRBxnnzry9PkasHSWhBZnlAg5vdmlLafeHQ
 hooe8348236SCjQrI+oKGvRGLUkX9TzqWNG6jgK4rBYNY0Ypw2xUED+odtV9UGHY1RkP
 PWTBxGZqy0hSeL4Ih7zg2kSg+pko9Tq+Lyu3P0aLeb3FPDJG/OvNy00Q4sH7Zx8cXd11
 io+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202566; x=1795807366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+wFnH2eWQdcZNy/KpnSadLDrzNFBghsZfF/BvQ4LRb0=;
 b=YaG9g2GMjqWQHTzV//O+qsqotej8giKUhfmKzv7t2M2FEHTXHqa5lVgEnoNUsyMWOc
 HP18wR/MNFD81neSQnbDQyJNYrghf3OUE89XuVPTeE7XTzFS5bhvxfHgzTbW8q2HO6mb
 zU7cTmhB/c9IBgzoE8B+tSn6aNzWbrdw01DJQZXQ2bd8UoIzHrbUNxpirBaDxF5fR4fM
 43y+DAs8ueYEU8rR3oe3ysbxTL0rUFoTdIkkfb1tDIOqdW5K5J/BXP5cG23XjVG5hVrC
 qhiVnEWE8Hgp7MWJcuvBbg1bbe/sExMAl+klRKpsUZsmaC8PCqsTjMghDcHVyMpWbo3E
 Q+JA==
X-Forwarded-Encrypted: i=1;
 AL+hErHrJHhFb+A1//tReFufKKB0jxzqsON54UT4FieYxedt+t5Rcrc4NLv5oKKpE18lTqDElxZvY04SzV6Eu3ncMdER@lists.sourceforge.net
X-Gm-Message-State: APuU4Z810HmMUPu6xeRUvOg9cdYxWskaPM0fPyzeVDJLPHre9kVk8+Jz
 aQV7N4i99/IiDhXdgBAmAdxLf09vJ4234xCFMsC+jAVSWB+6zlueXOE04XLHBl9weB5C8aN5qDj
 T33zj504IfTCs25Wj7AKT7OVczjdXbHs+1KsFa9+QxGFgdb+a7Rgapkha6mKKW4VfdPmq80mkaP
 1Ho2ye/7M=
X-Gm-Gg: AYBFou3ufbJr2rUl/hUdivVm6VVTLui4hC8dFJ0+nXoVF5wj/jhcPBmMcxyewvT7rwE
 GqdH9qMjZpVYDPdQB8xnj4zocy8j0m2g96Qv6lf7Av9DDj/E+GPFWV0CLMv1kuJ8V4G5jI2iK39
 C7IfjAai0j4mGukbUzGBVJ9p/iVqizyzgq7PqJem90jXeXpxmeIY4GoLGCPZn/sxQzTgce4XwEb
 tNbs/RKX3TKqSj8RFK1nxCVugSOKasVabkYZXwAtvKtnHzajHdr8GO5D21HbvYJALAY5JoCSKKs
 f3tvO7tWStcghO7SHgyFnE921cv3feZpC1faLDgJE/wP6drlhVP20UqeZz0COLmJ3U44eukElQp
 xXGZ/djZaMDeFkh90CocyV3FiLNOrZ4hKx88ARhPnw32MtWuAF/mB7w1mJNW7LsFEfGbnwuqb/n
 hrBdQ1HH5E6gOaxQan6MmC
X-Received: by 2002:ac8:574e:0:b0:55c:7769:9a0a with SMTP id
 d75a77b69052e-55d769374ecmr79368721cf.5.1795202566351; 
 Fri, 20 Nov 2026 11:22:46 -0800 (PST)
X-Received: by 2002:ac8:574e:0:b0:55c:7769:9a0a with SMTP id
 d75a77b69052e-55d769374ecmr79368401cf.5.1795202565994; 
 Fri, 20 Nov 2026 11:22:45 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:45 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:07 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-4-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=893;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=UYfnw8r4LybZ1hKmOoxonr6eevENMf7sbC1MAa4s5s8=;
 b=xdcUOtph2nHiDfOHQNy1hrM85felV38o1THAnoKYKCMfne8HzWTRXhWWSVDIC4Xe+4zkrBqaU
 ZkVDjR4Ne5RAiuQX15y3QVquRxyjViCNtmBlH9YjLTe0+mWM/YYX7aK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXz+bGhE0PeIi7
 +lbucDjQQbKTC0Kc0zb25JFXz1oubHCKfchw7yk1m/X3J4pl5GtD5vKe9a+BSUvd/m297zI5tIt
 YaI6VKvE/9k1vWiMG53kc07XsZkRIFGjRcw88vUjByQuYlJFhZRv
X-Authority-Analysis: v=2.4 cv=StYFe/O0 c=1 sm=1 tr=0 ts=6b009e06 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=TExhzi3AsQIh8CWwah8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: IBWWMEuhxX6ubJXzhR2TlsqWA-L1kRSe
X-Proofpoint-GUID: IBWWMEuhxX6ubJXzhR2TlsqWA-L1kRSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXzhhzI45MDemW
 DxkiZyWgPHbseyZ/AT5DGIfxbv5N6BQTcG7LMSehAtVJUODMwmNGVlyxWuaqsHEyf+wxp6PpEUA
 X8MgxrYknxj5F6JZfWif2VfFVuQL9SM6+KfVn9ZQxTMUYz/1SCKSucLWQD0H7W8KTh2TVQIbIVd
 mCUqrEyP2HNCK1X2JpT5Kx65JDcvSLthZQcqqPxLmwTO3NZ+iso5PGbSLKxa21cRAqPB8qSk6RJ
 YdeZcmzQGOK7GeGFQB2vCC5osN9w1zofOaFgafCiibeZRNgxk6fxbIz6P05USGsD1qsAa5hdWnF
 MGpftNQTNRTHbAL/UnMf5v4tuTQf02LEw3n/Pd6BcduMjAPnACrWRkFexwM1azmDPXUSSX3LB5j
 isgzBJbAVRYHBVzuu3LzYMZTBFJkiPcXkIA79VMgtxYXu1OpNgvw6LgodVRbl0B5mute9W3lgNO
 xlYUwNjaq+7IgBTnxyw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=10 priorityscore=1501 spamscore=0
 lowpriorityscore=10 clxscore=1015 impostorscore=10 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCC-0000000017G-3gzN
Subject: [f2fs-dev] [PATCH 04/28] f2fs: use fio->compressed_folio in
 f2fs_write_compressed_pages()
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

f2fs_write_compressed_pages() fills fio->compressed_page from
cic->cpages. Set fio->compressed_folio instead. cic->cpages still holds
pages from the compression mempool, so convert its entries with
page_folio().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3948b3562857..7fb46aab2cb6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1564,7 +1564,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		c_folio_idx = blk_idx >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 		c_folio_ofs = blk_idx % F2FS_BLKS_PER_PAGE(sbi);
 
-		fio.compressed_page = cic->cpages[c_folio_idx];
+		fio.compressed_folio = page_folio(cic->cpages[c_folio_idx]);
 		fio.folio_offset = c_folio_ofs;
 
 		fio.submitted = 0;

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
