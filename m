Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6041606A33D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XUyYp3al;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LmKRX2gn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CwQvOWys;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=b6qTP3dk;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=F8q+j1+y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=V8DI2RtU4f2TbfhwKb+208SmMYmIBOZnY2IvpP4+al8=; b=XUyYp3alMPZlNkhA7qW9FgIdpX
	elzcYBUSRC0B+4qHFyjXU8IgWY6o2QcDs9KWWVkSznz/w8a9h332HnioNhglH5MvS5HClTNxit8zE
	BIgxTsZIHEfHd+DFNu/gfi5/3Fafjn1cwaoMTTwhNHZe9+Nt0LHT/GkUZOvcEo7eXZf4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCE-00000000359-2ErU;
	Fri, 20 Nov 2026 19:22:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCC-00000000351-3ra3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sz+AgvzsdCd6og8stNGh/beXRmr25jM5aRWPCdDQGAE=; b=LmKRX2gnM3xDWcmy+kh8xUB2bC
 COXUWwvzKTw/j4lDh6q42KLhOjlrjdlVH142Cwyy5KxmTP1RUhgGr2xqi6Syy5H9uRyxCxb0aZW0r
 CitJ0JR0gyR0uHPN/bFZ4jGvdJ89zXgMH186ywp/dGJ8jxfwbICqRcTjcdoAVbXmwayc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sz+AgvzsdCd6og8stNGh/beXRmr25jM5aRWPCdDQGAE=; b=CwQvOWyspkC2xJst6GyJr8Iz+s
 ovXGA5yQ5kg9krWV1RxWvGsyk4eldz50lz2eFokPe1edtSSPp69Uz40u8mbjfO0zsyOWXs3l2rMiy
 PYfiNzjJEwHAZEGkYv2hwFvhg5jQY9qVJ1IHeRrm7T3/NV4A5SX3w5AEqlR2RDZ9tFwo=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCB-0000000017E-1VTP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:52 +0000
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuhqB3664429
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=Sz+A
 gvzsdCd6og8stNGh/beXRmr25jM5aRWPCdDQGAE=; b=b6qTP3dk0y3sho1KvHD6
 2zbVwiJwgf+QrxLCUH2IjS5EPclLcnCvTzn3rVdmyyMs1aAX3l1EVXmaNALLjXrx
 fWiDqXvhAMop+pURguNfxjODlF+4ud2M/nHFfN4H+kGOToW0xmn8d+lWrBtwSg7z
 Z4VKpolrr5vhpmvCtgmjhBS8G8CURAHhKme/fJcNSanGbHBRvphRGbwqTNxpa7wG
 /jNt47193tAajooAP3P9niCq+2qn04rSoi/cq5HIbVcV+Rn2yxLQQ9emdTEl6Mvw
 l/pFzXJCLEylkxrXqClkVrhMWIpCVf0oI9mowFQ1O1zOyZDwAu9R1V5pelcOgINe
 bw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2tnu0xev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:45 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-537548d4bc0so29734801cf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202564; x=1795807364;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sz+AgvzsdCd6og8stNGh/beXRmr25jM5aRWPCdDQGAE=;
 b=F8q+j1+yH4Q0ouJFtscwI78Budy5q2BI9Li/zWcrwYnkyBjkPaYTjEgGNLOQBLP+9B
 SIFM5UjY4dEH7ZHKcriyJeIrB7xgLdCI5q2YcmImyXFAspK0AcdNlVjAWRpZiJuBY+hy
 AfE5ZPM98/JAFdmAjef42txVXxDynqqw7uMfpn+DKG9BBtEoX6DNYko901u/ZajOjxVh
 ojMz3X9l+OR+3nLeK+zbmquYeh6HHS8vQw+9FPFK08sDGoeeNgYV73um2L0dWGQsebyL
 2QK7Iw6veyUIIpZxQ9XfQyvZYa66mkj/ci13B9k7QfK89ow83m0ZNk6OhnupyH745nvl
 O1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202564; x=1795807364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sz+AgvzsdCd6og8stNGh/beXRmr25jM5aRWPCdDQGAE=;
 b=j9aCb56DU7PBPTuqz+BF6CdjWoRJ7UcVm/xYT68eOcdoeB5tqMM0UOq+wcygHxayr9
 OkShG9952tSBVkNzbWNk8PoWE2q3oZjz5HJnNDZA6K4Z3SJXISO+plhv5ILkipoDDkbh
 Kqqy39CeJqJOmfXSVVfO90FiOC4/StpalNibqM9skcogkspjgczia3LOKfCyKrp+WApJ
 GSa6bQz6tJ++OrJpIeC05iraoh2Mv+IOntlPtvv7o11ILI2xqoyeb6YyR2gQpr9w69Qz
 f3DNOlZcvVuGZ8Xw64pVaSxMa7aDJBNB+Ho8wDW1pBU+QCvQuB5gU8NgkcXfPcmMejN3
 g7ig==
X-Forwarded-Encrypted: i=1;
 AL+hErGhTZIni1iUqmJW+dGLh3SPJbS5oB6xfSO+3x5V9rtSu/fisMoniaWtL4Y9N3A6bZZth4DhrDH99lz2r9ph4eSp@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ldWlqgClfVpPIZpbyZ2CyUsoIGW65pJIaDhdDZRDaFkjFeQT3
 hnurIXkOpsk++eCGOpSfaosLWBPfuXMdEqjvmeZmPxlRo4RaXASUinyNzokqz2QTB8+v+5iQWbs
 1M3EtPV4/MOJ0I4xmxb0KVlSx+IyjjvE4wKtxcBROrtYgi0xPKryLaDvujSXVI+zST2s934w/dO
 U=
X-Gm-Gg: AYBFou1vf4INdHmD/Xt8OeLgn2xpMgQJjK2m2L0keCpfBsFBjXt1nDRL7rjveLnHSfW
 e1AkeMy+SNoyqVSF51qO76XaArgQRcxDv8HdUW+zCZjK/dTDTn+vq6Qf08g+b2sZj3vdAEs0uYs
 02u8hoRryHOsIizFHPJGZ2WMf1UzWRVrt1cnD1FWYOCXxrsClcKUf5a8vGZaiYIIvkkPDH+uYH9
 NabD0ihq/I5zCVKTMGG1bK8m7kk1s+cKBSI1iA0tEnQFnfxUd+FBB4qXTBhX0FvA+qe5R3IfJ7j
 jFAiNlu/LYiBr9KLDCTEj3Mm1y6dvya1Y30N7Ncd3U7YYp1AWV9rpy/DvoA3xzKvH1YhENBraoA
 njoyDUa63HnmSzFTifXCPmY5A6qRmXJb+P1gntoFjINV9mOGyHR+8U1UX2WIPPt2Jh83VNCOyiP
 74CYL+VhyfqVCT/kWaRz2k
X-Received: by 2002:a05:622a:e2c1:10b0:55d:846f:cae2 with SMTP id
 d75a77b69052e-55d846fd899mr21151831cf.21.1795202563545; 
 Fri, 20 Nov 2026 11:22:43 -0800 (PST)
X-Received: by 2002:a05:622a:e2c1:10b0:55d:846f:cae2 with SMTP id
 d75a77b69052e-55d846fd899mr21151521cf.21.1795202562964; 
 Fri, 20 Nov 2026 11:22:42 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:42 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:04 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-1-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=12967;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6vOXG8IXk4QWST7poMbkLp3wkRFxJ/qrhDdediLlbGA=;
 b=NxVPjptFwFOcqoinUa1TeWIhxXNTnZY6iSL/RkjS0iJBdiaX3bFHOkoXRnpptEJNpjjGc6c74
 ZYxZwwaDiJQBukWVm8dxfxOwgiv79jdRxlqIbHb7Qnytrk9NTFlVTSj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: zc_yETqMXH6PsZNgSryTX6lyR9M70Ivx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX07kw6wFNYqNf
 B3kuWr9aHayA+6cgXI3zGl8UYGYA9Uf7XQShLdo7KTNv1e+ajywmav2qWLhNaamwBmyP8DAWMvK
 6u5v8gV/9ge6n3dlRq6T6JFRJc/+1SxXaXYeDmBO66+5x03W+kbp
X-Authority-Analysis: v=2.4 cv=Dt3Da2/+ c=1 sm=1 tr=0 ts=6b009e05 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=n1Yhf7GGY3Yo8pwr0I8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXyNzObUNOzHqw
 J4M/C7y78h1BXC2ALiyeR/LW1z+NCK33znzJNhLb9TTrmfLZnK3nCy7HdAAOHoVqp7QWRf7EzQo
 Go87NN6BXtq9V8Ez85DXjCyALRl/3EZcs08OURwBxKH20qgBsnUOcTUyzj30pUbKMGcv4SrYPw2
 DgBsN0oxQzV/AnkKwsI0ukNEWK5gh0HLsNMczcXzsX10IAJXb3u1uO8ozfEIsi6kwnxcZbCL+Ld
 F2+EvnsLmDDJWFiYLVnI/Oatr62JbNKCG0jPKcYGVCoShQ89W31oIK0Qj8DwUOMGmzi/V50hJVD
 OXI7CLSRVm0CW+fhyZyfk7EL/Ex7zTDhpN8ZMrWUR+nhRFrOE5o+008MazUzT+o2VpPG1MqW5PA
 hXvzvRVoAgZ7i7Jkcq8AW049cPcqkAeiN5J1zpD+a7cLocz1quOsqv18LzOrgMub6bKBEzb36Pm
 TaPtkqCguBUU7gJmO7A==
X-Proofpoint-ORIG-GUID: zc_yETqMXH6PsZNgSryTX6lyR9M70Ivx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 spamscore=0 phishscore=0 bulkscore=10 impostorscore=10 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCB-0000000017E-1VTP
Subject: [f2fs-dev] [PATCH 01/28] f2fs: remove encrypted_page from struct
 f2fs_io_info
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

Nothing sets fio->encrypted_page anymore. Remove the field, its
initializers, and the dead branches that test it.

encrypted_page was the only thing f2fs_crypt_mergeable_bio() used from
the fio, so drop that parameter too, and update the comment in
f2fs_set_bio_crypt_ctx() to match.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/checkpoint.c |  2 --
 fs/f2fs/compress.c   |  1 -
 fs/f2fs/data.c       | 86 +++++++++++++++-------------------------------------
 fs/f2fs/f2fs.h       |  1 -
 fs/f2fs/gc.c         |  3 --
 fs/f2fs/inline.c     |  1 -
 fs/f2fs/node.c       |  2 --
 fs/f2fs/segment.c    |  1 -
 8 files changed, 25 insertions(+), 72 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c059022413be..ff654da5a64a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -265,7 +265,6 @@ static struct f2fs_cached_block *__get_meta_cache(struct f2fs_sb_info *sbi,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.is_por = !is_meta ? 1 : 0,
 		.is_cache = 1,
 	};
@@ -464,7 +463,6 @@ int f2fs_ra_meta_caches(struct f2fs_sb_info *sbi, block_t start,
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.in_list = 0,
 		.is_por = (type == META_POR) ? 1 : 0,
 		.is_cache = 1,
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d0e989254ffe..3948b3562857 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1438,7 +1438,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.old_blkaddr = NEW_ADDR,
 		.folio = NULL,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.compressed_page = NULL,
 		.io_type = io_type,
 		.io_wbc = wbc,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..21e661673a78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -655,26 +655,18 @@ static void f2fs_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 				  gfp_t gfp_mask)
 {
 	/*
-	 * The f2fs garbage collector sets ->encrypted_page when it wants to
+	 * The f2fs garbage collector sets ->is_cache when it wants to
 	 * read/write raw data without encryption.
 	 */
-	if (!fio || (!fio->encrypted_page && !fio->is_cache))
+	if (!fio || !fio->is_cache)
 		fscrypt_set_bio_crypt_ctx(bio, inode,
 				(loff_t)first_idx << inode->i_blkbits,
 				gfp_mask);
 }
 
 static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-				     pgoff_t next_idx,
-				     const struct f2fs_io_info *fio)
+				     pgoff_t next_idx)
 {
-	/*
-	 * The f2fs garbage collector sets ->encrypted_page when it wants to
-	 * read/write raw data without encryption.
-	 */
-	if (fio && fio->encrypted_page)
-		return !bio_has_crypt_ctx(bio);
-
 	return fscrypt_mergeable_bio(bio, inode,
 			(loff_t)next_idx << inode->i_blkbits);
 }
@@ -935,29 +927,23 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio;
 	struct folio *fio_folio = fio->folio;
-	struct folio *data_folio = fio->encrypted_page ?
-			page_folio(fio->encrypted_page) : fio_folio;
 	pgoff_t fio_lblk = F2FS_FIO_LBLK(fio);
-	size_t bio_offset;
-	size_t bio_len;
-
-	bio_offset = data_folio == fio_folio ? F2FS_FIO_BIO_OFFSET(fio) : 0;
-	bio_len = data_folio == fio_folio ? F2FS_FIO_BIO_SIZE(fio) :
-					    folio_size(data_folio);
+	size_t bio_offset = F2FS_FIO_BIO_OFFSET(fio);
+	size_t bio_len = F2FS_FIO_BIO_SIZE(fio);
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			fio->is_por ? META_POR : (__is_meta_io(fio) ?
 			META_GENERIC : DATA_GENERIC_ENHANCE)))
 		return -EFSCORRUPTED;
 
-	trace_f2fs_submit_folio_bio(data_folio, fio);
+	trace_f2fs_submit_folio_bio(fio_folio, fio);
 
 	/* Allocate a new bio */
 	bio = __bio_alloc(fio, 1);
 
 	f2fs_set_bio_crypt_ctx(bio, fio_folio->mapping->host,
 			fio_lblk, fio, GFP_NOIO);
-	bio_add_folio_nofail(bio, data_folio, bio_len, bio_offset);
+	bio_add_folio_nofail(bio, fio_folio, bio_len, bio_offset);
 
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, bio_len);
@@ -1042,18 +1028,13 @@ static void del_bio_entry(struct bio_entry *be)
 	kmem_cache_free(bio_entry_slab, be);
 }
 
-static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
-							struct folio *folio)
+static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio)
 {
-	struct folio *fio_folio = fio->folio;
+	struct folio *folio = fio->folio;
 	pgoff_t fio_lblk = F2FS_FIO_LBLK(fio);
-	size_t bio_offset;
-	size_t bio_len;
+	size_t bio_offset = F2FS_FIO_BIO_OFFSET(fio);
+	size_t bio_len = F2FS_FIO_BIO_SIZE(fio);
 	struct f2fs_sb_info *sbi = fio->sbi;
-
-	bio_offset = folio == fio_folio ? F2FS_FIO_BIO_OFFSET(fio) : 0;
-	bio_len = folio == fio_folio ? F2FS_FIO_BIO_SIZE(fio) :
-				       folio_size(folio);
 	enum temp_type temp;
 	bool found = false;
 	int ret = -EAGAIN;
@@ -1073,9 +1054,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 			f2fs_bug_on(sbi, !page_is_mergeable(sbi, *bio,
 							    *fio->last_block,
 							    fio->new_blkaddr));
-			if (f2fs_crypt_mergeable_bio(*bio,
-					fio_folio->mapping->host,
-					fio_lblk, fio) &&
+			if (f2fs_crypt_mergeable_bio(*bio, folio->mapping->host,
+						     fio_lblk) &&
 			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
 				ret = 0;
 				break;
@@ -1187,23 +1167,17 @@ void f2fs_submit_all_merged_ipu_writes(struct f2fs_sb_info *sbi)
 int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio = *fio->bio;
-	struct folio *data_folio = fio->encrypted_page ?
-			page_folio(fio->encrypted_page) : fio->folio;
 	struct folio *folio = fio->folio;
 	pgoff_t fio_lblk = F2FS_FIO_LBLK(fio);
 	unsigned int fio_cnt = F2FS_FIO_BLKCNT(fio);
-	size_t bio_offset;
-	size_t bio_len;
-
-	bio_offset = data_folio == folio ? F2FS_FIO_BIO_OFFSET(fio) : 0;
-	bio_len = data_folio == folio ? F2FS_FIO_BIO_SIZE(fio) :
-					folio_size(data_folio);
+	size_t bio_offset = F2FS_FIO_BIO_OFFSET(fio);
+	size_t bio_len = F2FS_FIO_BIO_SIZE(fio);
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
 		return -EFSCORRUPTED;
 
-	trace_f2fs_submit_folio_bio(data_folio, fio);
+	trace_f2fs_submit_folio_bio(folio, fio);
 
 	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
 						fio->new_blkaddr))
@@ -1214,10 +1188,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
 				fio_lblk, fio, GFP_NOIO);
 
-		add_bio_entry(fio->sbi, bio, data_folio, bio_len,
+		add_bio_entry(fio->sbi, bio, folio, bio_len,
 			     bio_offset, fio->temp);
 	} else {
-		if (add_ipu_page(fio, &bio, data_folio))
+		if (add_ipu_page(fio, &bio))
 			goto alloc_new;
 	}
 
@@ -1315,9 +1289,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	verify_fio_blkaddr(fio);
 
-	if (fio->encrypted_page)
-		bio_folio = page_folio(fio->encrypted_page);
-	else if (fio->compressed_page)
+	if (fio->compressed_page)
 		bio_folio = page_folio(fio->compressed_page);
 	else
 		bio_folio = fio->folio;
@@ -1336,7 +1308,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
-				fio_lblk, fio)))
+				fio_lblk)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
@@ -1346,14 +1318,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		io->fio = *fio;
 	}
 
-	/* A compressed page holds several blocks with subpage blocks. */
-	if (bio_folio == fio->folio || fio->compressed_page) {
-		bio_offset = F2FS_FIO_BIO_OFFSET(fio);
-		bio_len = F2FS_FIO_BIO_SIZE(fio);
-	} else {
-		bio_offset = 0;
-		bio_len = folio_size(bio_folio);
-	}
+	bio_offset = F2FS_FIO_BIO_OFFSET(fio);
+	bio_len = F2FS_FIO_BIO_SIZE(fio);
 
 	if (!bio_add_folio(io->bio, bio_folio, bio_len, bio_offset)) {
 		__submit_merged_bio(io);
@@ -2726,7 +2692,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 	 */
 	if (bio && (!page_is_mergeable(F2FS_I_SB(inode), bio,
 				       *last_block_in_bio, block_nr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, index, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, index))) {
 submit_and_realloc:
 		f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
@@ -2881,7 +2847,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (bio && (!page_is_mergeable(sbi, bio,
 					*last_block_in_bio, blkaddr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, start_idx + 1 + i, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, start_idx + 1 + i))) {
 submit_and_realloc:
 			f2fs_submit_read_bio(sbi, bio, DATA);
 			bio = NULL;
@@ -3553,7 +3519,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 */
 		if (bio && (!page_is_mergeable(sbi, bio,
 						last_block_in_bio, block_nr) ||
-			!f2fs_crypt_mergeable_bio(bio, inode, index, NULL))) {
+			!f2fs_crypt_mergeable_bio(bio, inode, index))) {
 submit_and_realloc:
 			f2fs_submit_read_bio(sbi, bio, DATA);
 			bio = NULL;
@@ -4080,7 +4046,6 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 			.folio = folio,
 			.folio_offset = i,
 			.folio_blkcnt = 1,
-			.encrypted_page = NULL,
 			.submitted = 0,
 			.compr_blocks = (i == 0) ? compr_blocks : 0,
 			.need_lock = LOCK_DONE,
@@ -4317,7 +4282,6 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		.old_blkaddr = NULL_ADDR,
 		.folio = folio,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
 		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 882ff2617531..6ec1da5d1c43 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1353,7 +1353,6 @@ struct f2fs_io_info {
 	struct folio *folio;	/* folio to be written */
 	pgoff_t folio_offset;	/* offset in large folio */
 	unsigned int folio_blkcnt;	/* block count in large folio */
-	struct page *encrypted_page;	/* encrypted page */
 	struct page *compressed_page;	/* compressed page */
 	struct list_head list;		/* serialize IOs */
 	unsigned int compr_blocks;	/* # of compressed block addresses */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 47264823b9b7..42b73b263063 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1229,7 +1229,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.in_list = 0,
 		.is_cache = 1,
 	};
@@ -1371,7 +1370,6 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.in_list = 0,
 		.is_cache = 1,
 	};
@@ -1600,7 +1598,6 @@ static int move_data_cache_block(struct inode *inode, block_t bidx, int gc_type,
 			.folio = folio,
 			.folio_offset = f2fs_folio_blk_offset(sbi, folio, bidx),
 			.folio_blkcnt = 1,
-			.encrypted_page = NULL,
 			.need_lock = LOCK_REQ,
 			.io_type = FS_GC_DATA_IO,
 		};
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 032c1cf8c615..5e54feb52e52 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -152,7 +152,6 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 		.op_flags = REQ_SYNC | REQ_PRIO,
 		.folio = folio,
 		.folio_blkcnt = 1,
-		.encrypted_page = NULL,
 		.io_type = FS_DATA_IO,
 	};
 	struct node_info ni;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3ddf5d7adffe..856b1aa834a3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1486,7 +1486,6 @@ static int read_node_cache(struct f2fs_cached_block *entry, blk_opf_t op_flags)
 		.type = NODE,
 		.op = REQ_OP_READ,
 		.op_flags = op_flags,
-		.encrypted_page = NULL,
 		.cache_entry = entry,
 		.is_cache = 1,
 	};
@@ -1784,7 +1783,6 @@ static bool __write_node_cache(struct f2fs_cached_block *entry,
 		.op = REQ_OP_WRITE,
 		.op_flags = sync ? REQ_SYNC : REQ_BACKGROUND,
 		.cache_entry = entry,
-		.encrypted_page = NULL,
 		.submitted = 0,
 		.io_type = io_type,
 		.is_cache = true,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 73dc88aa6dde..fae4926fd7a2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4232,7 +4232,6 @@ void f2fs_do_write_meta_cache(struct f2fs_sb_info *sbi,
 		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
 		.old_blkaddr = entry->index,
 		.new_blkaddr = entry->index,
-		.encrypted_page = NULL,
 		.in_list = 0,
 		.cache_entry = entry,
 		.is_cache = 1,

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
