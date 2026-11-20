Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19C606A333
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Br3ewYqm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mbHOPv7M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RkcxAhsy;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=W9uemPzC;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ayPzLgCL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=7zTKxIHNffCgEpA+rMPUzgxahPuIxUAULxkP8JUWhFE=; b=Br3ewYqmmi66K2afZ/tPJVCwX9
	AormPlO1ZOyzr0mn50J/u9HMbl9uYODyYCl+UHtml8LjvYpi2oJ24I2KNPx2K5qrt2qe9/qv00+CI
	MvhS+zWj1dI6WfgzG+3+wPKa+4RqWGrkphAnj+rgkydKnHPahT9B10mTq3gLUfEhGYmY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCY-000000000Vk-0uya;
	Fri, 20 Nov 2026 19:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCW-000000000Uv-0yxF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C2eFT1IkSjE1kJKV7GB2Vlk4HriZnM/EJ3MXh8L/MR8=; b=mbHOPv7M9aSH69Cj7ytoaxbIAA
 6lDLW66bPSuSzVg8pNN+AHIqYMhkdHg+rimZcHW8iWFrT2/cqxTKNU4PHWOh2OEAKNUzH2BwMtNT4
 YucTnuxrgMfLhMKjOkIEBVVP6zBzMEANVrwIpWinhAn97MyriH1/d8aJsLtNDvLtvPxA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C2eFT1IkSjE1kJKV7GB2Vlk4HriZnM/EJ3MXh8L/MR8=; b=RkcxAhsys/trzfaQA6OeVG4NRS
 b3l0LUn3lbJjvZKgLdNrr0qKu/H+Km+nxQ7NvBqAxfyZJGw+y5AsUgMVtzQLjXPdHuEMMPb4piFf+
 aJ8CK6Lz+FXsRTX4ot8dxNelKYPATQ2HVhCovJLFu9rm4G5eQw2RKBiDUAgFx3sAGsgI=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCV-000000007Ec-346Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:12 +0000
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIulon1802827
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=C2eF
 T1IkSjE1kJKV7GB2Vlk4HriZnM/EJ3MXh8L/MR8=; b=W9uemPzCgbqMjkyN3FIX
 Q018GEzVoEqyDZU5ekRQgisgSGdzdE8AnydDA+Ebv3U40icu64Bb+cGkW/Qz9m2q
 VZudJyK34TRmhxaAVtS8rD1HrSIH6/AYEjAXBD49RJwww9SrQ//5BIXQ5JedS0DQ
 3HJscyvdAIIYeCjWl671QYI3riCiJ7/6+TLtcwVLKzniPudW2OXuTjqhQLPyGiaU
 qIOj/TmQhqa4QswabhKr7h7O49lWqlSdLXmcSojuz+e1qOC3hHgp05Mxr8frl7Gn
 pwVk47+313FudNF9yEVQ2FVYmlZ6fCtOqjFQ6zHF03vQTjDcZ2xNZp2Tda7fdAim
 TA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rrdj4jw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:06 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9212b76b1f9so18615206d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202585; x=1795807385;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2eFT1IkSjE1kJKV7GB2Vlk4HriZnM/EJ3MXh8L/MR8=;
 b=ayPzLgCLcWfKjD8Cs4wYsLmizFF2xtS5UzJdtfmesepmJUZIxH8wBzaT7658tBu6w+
 UTJI0EX/+HRa5egPKpnXFeHZTEj656w8psz2A95AIyYJ3OsvlF/Fd46z56IIT0L0Imuy
 RifTOSg26oJGZMP1WuM1tsqwBcyABGmux6XgRLApieinIdkEi0Kl6IqLP3bSBfsOAS8x
 8fMoQaiviFMENQjXopK5qtgNG3HSFrRWmyQ9K500WQZsyaEXuavv0g4wXIgpHxCCwURb
 Y42Z1LU1FHISpt7yvAzyxf09bs+c80LUgq7uz4C0EjQNUyYZ/FeMmdIvrZbMobTYxFtW
 cfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202585; x=1795807385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C2eFT1IkSjE1kJKV7GB2Vlk4HriZnM/EJ3MXh8L/MR8=;
 b=LfOdSF89Y59jH+Fwj6TyLXRT49c/1x+sxcsIK89poRG2ef5b+uZ6HiRWe2+G42OK6P
 SLeOwWD/CFA/E/uziAhjaEEQl3nf9jAvl/+5LSoec8y8BC+FdeAKZjlPtTDWZVOhp9/T
 +M//xpb8axT2wn5CoE6Vdg5BhKj0J12zBRH9W7KnMCGohqa2g5KzpSZj/+BwFCK81wB8
 OSkXyQCCEHI+MBamAa8kgz9cK3JxgvkH1i/m96VKFyFjJ4ukAvvK4OZTUNIa1mBIkvSu
 80MBgMuulCLX/FBjzON8plnkH1PCKw07uKhweFLAOvd7tU2ng0cbn3ZoCNzxyuPIr7JU
 w5SA==
X-Forwarded-Encrypted: i=1;
 AL+hErFvUBGosWQKHRS5BHkBij4adMTCkslv7snLV3wj23YJ5Hnyd4eIu7Mt2UyV7la9StBsyy82HeiKCDYscMj0W/zI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/jFHcPtbee1JCS1xhUxAm+qQUM4KCpV80YJd2tbL1wLTe4NWUd
 EkAWcUDdbH1k5hzylLF4EplYFSEzwJKVsZXzP3QSM6tHOmNRCJxyTAg+nwVqOGWxddMxkfz1/nA
 Wr0n8TpLNiqgT16eu9SRzYi1g0hf1xrhnuYPrnWKHfD0677y3SDyqml6St37tvGtAnRkw2M9hnU
 k=
X-Gm-Gg: AZFdTZeU6f8wJlYexGxApC2vBNYDc4Fr070UEJcdq4Tpr0IS8n21wqrJCc7nxCHfCUx
 jkwV5xEjZb2iAMolxtmMblVL/7P+XOo8bTGBLczTT7A6BGTiUksQYuo8CJgDdbFm+8qITuRmD4w
 IkipzXzp0SV2utAQIZI9/UEKQKbvWXeWJVzo3JZOTt+XSV25EhDObl5u4h4jgSAqyDu00s4h+2P
 5XdF1QESKVcBk+yUGiRm2bWfQ+jkS81Gc9K070gljUP+T/b23OaDSLtITdGBxlZ9lVQfx49WvY0
 iCAkAzYOiVcFf0hPJsBNm7Y/hBLbcPIA/DCQoeWnpIaprgfQbqyttb0FXz+YS9OSVYxtbMWbndp
 xdoqt8j74ZmA2g4dFJHCYsCUjVeaSQA5jX3ylsK+Ckv68VclzcCf2/1ar3Jao80Xtv3DSZiDfGM
 t8+coHRjPtsfCOhT1w5VQQ
X-Received: by 2002:a05:6214:20aa:b0:91f:3c0c:50a6 with SMTP id
 6a1803df08f44-9213497c813mr72673426d6.6.1795202585294; 
 Fri, 20 Nov 2026 11:23:05 -0800 (PST)
X-Received: by 2002:a05:6214:20aa:b0:91f:3c0c:50a6 with SMTP id
 6a1803df08f44-9213497c813mr72672896d6.6.1795202584811; 
 Fri, 20 Nov 2026 11:23:04 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:03 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:24 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-21-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=738;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=HiBFa2fAsM5ZqAT/IB7dtWdl0JD5gsTMelJbR+rQdZQ=;
 b=4HlRMFJ6NCGxnEjuLD3bFW2PSRI7Y/C7bR5kGNHFeGEUlwutuyzXIOZJeMxq6ISlklj4gWhbn
 32paRGPfTk0BcTiHAST8riSedyT5Q2delmzdgOtLuM1yPLiudoWPBTk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=IpGL47/g c=1 sm=1 tr=0 ts=6b009e1a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=cIxKlqNTalfCB6H3wmYA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX0oadT8MYyFdK
 pVpVyWatz7qpVaU31g6HceklnZlLBlyIG3EJqH56J3NkryWJbv2wtq4Gn0TnnJ9+y+f8VkqjOne
 lG67wK7+HX9BoH48xDMKUtTydBBvardJtp49jDymrP191xHB6ces
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXwJnT3srMZYrd
 1KZ7lKIluEcHk5qo+Mo+AQuhbxnyiuKkcTKs2zBL5F+GN+M2XpeWq68yA/bG+5Haq4GANp/r4Dy
 rLlvjvOehsbx148EuTToC2/gsIJtFiFMH2J8ERAJnxSyX03CbU+mGFhKXIf0aO1t1G686oM1I+U
 7y1y7TZWatCM1NPqnpMBtZ9DihmGwZu6gw7vAa804LU27DKTMxM7kUOw17snRqgD+K8UYKOg7TM
 4bcOI4Z9Poozg4jK+4h/5YIUNyuNWgRWxfKten9zGpy/MsVLcx8RoIe27SB4NXTbTHbjWPfu00U
 YSFRgGYFy7oIH50NEdJkCeBwRsVScIr0KQrN62E+eE0Q0AD/qcMOmZef0aG5hJQfP8QeS5EQMkH
 g9LRW5N+EUlDPKDrBVXoV9AiAxILi4ehZWnjym+de1eL4YgP6XD+koTK/2p8Lh5pGOcQiCqfNAv
 v1yrFx+5VBdcrRR1u4w==
X-Proofpoint-GUID: q2g0EIvlZu_qkmMPriCn89kSHfJpocXJ
X-Proofpoint-ORIG-GUID: q2g0EIvlZu_qkmMPriCn89kSHfJpocXJ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 clxscore=1015 lowpriorityscore=10
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCV-000000007Ec-346Y
Subject: [f2fs-dev] [PATCH 21/28] f2fs: convert f2fs_free_dic() to rfolios
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

Compare each tpages entry against the cluster folio's page to tell
whether it aliases the cluster folio.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index edc8d4833692..ed5096dabe3b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1988,7 +1988,8 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 
 	if (dic->tpages) {
 		for (i = 0; i < nr_rfolios; i++) {
-			if (dic->tpages[i] == dic->rpages[i])
+			if (dic->rfolios[i] &&
+			    dic->tpages[i] == folio_page(dic->rfolios[i], 0))
 				continue;
 			if (!dic->tpages[i])
 				continue;

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
