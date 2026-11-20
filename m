Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E88606A6DD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y88rMtlz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gkFwI4EA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CqDpmWdW;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=iluOtn3p;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=dL0yVGbU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Ti1F9iQArmtypMiC2nvgDWK2SyeXRbxu3UrA/Ro5D9Q=; b=Y88rMtlzHHqMKWP+CCSBhNcJoD
	uI2E0vQXT06IbHn9Gn25q5Kt/74Fx3qiYpXe6dNi6SOg4arSq4Zm2r+7znFEUyOx+pYMFNQAh8jkK
	v8KJM3TaYFfeZNrmUav9uBfv6EFNAsVsaLWSJZNf26V3DFDsJ2WrUMZ2Mp4awbLZWQaU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCW-000000004fM-0TZy;
	Fri, 20 Nov 2026 19:23:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCT-000000004f0-3X7P
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3BwA5KGpPrqaFyWQWqvi29BRM+RiSRRhdwXHN+FSma0=; b=gkFwI4EAmEgFEfGrjMG6Wy5DQH
 i7zoe/MPD+rzIl4KwQkBtuC1lyc76LGcyofj9eBgCSfwcTiO99PTxkyPAYr5FoLtGDbsJozhYmiXw
 qTBJrKSvFfeD/IIY+KMKPZ8O+0iC0DRo1pwUvRcco8ava9cVKzS4izfDEHRW1pCoTcn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3BwA5KGpPrqaFyWQWqvi29BRM+RiSRRhdwXHN+FSma0=; b=CqDpmWdWXEzT997vqqLQ9uSf57
 9kFj/by1dr37SgflpO6HWqrNtiI58yp2CIn9atmFxKTBAwuQ+u5NTd3WB87LRk4rnH56Vam8ppX34
 J4PPZD3RygC2pEHSppAyW7G2rPdRqeDvt7j8VflBqsYJ1T6DEXJBdjpDh9E/w9vya4bo=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCS-000000007EE-0IIl
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:09 +0000
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuskm1803573
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=3BwA
 5KGpPrqaFyWQWqvi29BRM+RiSRRhdwXHN+FSma0=; b=iluOtn3pCmkX8szBAafQ
 ZlaofokFCGzpKo39yS8U+RbXDT2nHeI8EcxiLH0qXeQwTRk0IzV/me7Oz9w6T4ON
 VlvJj0drKDbroxVXla/JvzuPmr5iY1z/IixHWJbpKa+HPWuJuuOks/oX8cshnwqe
 B+htymIqCMC2Wo93UD6EI54i17SfnDq+X+HzTxDBUMmSobwgUTAfGZtmfFwdxGcn
 za0RNm+ZmWJERW/4qIsBl0DS8dEVF+tekg78EQS47g4+ychvP8vPMqGa4YmldhB/
 D8wkT9z/fPtWVCLNFGusl+seaoE9aVWZpHCzCTtCguaVxHBCbqsTsKESL/gD8Tvf
 jg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rrdj4je-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:02 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-92134f1eb00so19492296d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202581; x=1795807381;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3BwA5KGpPrqaFyWQWqvi29BRM+RiSRRhdwXHN+FSma0=;
 b=dL0yVGbUGMntSEtu0+mC/OBc4drrH4qaPqiPkQJ/KOAvC14GLMqsslIZMkE8I+XpIg
 02M5FOipJ9o4WlEjqcHjkoFuWRDBiKXJlUzMVxBSLFPY+BIFtRmYCTMsy/max9vn83m/
 ZwM5okim9KkEN5n6UbhzOrbkf1q1IKUfjXp/TgWffsL0U/aZ3AIpUE62E4TD1gm1xe+J
 h/h+QwN42/aKiAr1gMUaPTCOlHvalT0BZSOE80zeImLXFugA2CG8gNjpzT2LbnhtDU86
 ZDqzbPw3kopa2ZoM0TYJ0cHSol+kuA8A2M16uFaOo9SGJFZMUKCWEyhLi20jPgFsP70K
 8FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202581; x=1795807381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3BwA5KGpPrqaFyWQWqvi29BRM+RiSRRhdwXHN+FSma0=;
 b=RqBHatkEtBX1f1zU4chf7etEUXxqqBbRxklGInKvEYyw22nbgN6suuYeozInRV4EUN
 JiTSaKFMPz33Chwt+Zg4nGnXKK4Ko0kyXzX6gtE384auefY7ozo1xd9BE6m66B6rForF
 2VgcI5NayJLs4wNzz5AsBmQYpq/UCcy/WDm4MMUmpmU0vqFLbNQje0RQUJ5NiwzKqVxb
 XiVPWBGMCnsSB001u9HDvDRthcbg4BGoIWyGKKbVzvhLWNGO4YFAeepv3h07+NSmb7iG
 xKGaa2h2dH/3moMONXRssOY7GCSStq77eCB9lHMwrzr/PYIW/5K1GxhJw2aC8HcE7iPp
 t6Yw==
X-Forwarded-Encrypted: i=1;
 AL+hErGBCSZTvS4h4KZaPn8wtZCLbEh/Fz/Jtb/dRa4GDS+YkA90LUWlMnCZj9ctZV2tgFpD/EVbErzx5S6gpx0IiWer@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Yo+3aEsdONOlP+n12312KseYWFvLAvKFM7HG5s9DWFM45ebGP
 1rouJrcDoJut++UV6H3dqnuJZD4xvoULtXvKJzvTw3Y9vIlBA1tBE8i0RJCQNwLknC+7ZiMtPQK
 EY+Je+XlC7bNOn88hTH5QO/Y2vLSO5fAAI9xpbJvvEmsQv/A1OpPIFrLsjrW9Oty+s+4T53gk7e
 vZwJLDTZ8=
X-Gm-Gg: AZFdTZeGL/OnmD0gveWTCy2lj7oS9DoZpDqU8/R9f+ppCEd4HNjwQz06NdlTKr9LXHO
 QcFhnE0gadswV/XTnvzpEFXkOznwQpmG9QK73BdL3pkMc/bCXL2XAmnyGyPkC3M53bQa/Ub+WKU
 8Rpmx59Tm/5UAlBTUidbJvn3j2fT5LdJgEB7ZgrB6fY7US/fRelqxWfVD5mt49K3sMVlYLTeDjU
 jhKxysZNMAWFt1294e1iEyNkNap9JhhBRmtrJkJi+S4U7MxkG8DXNjJFKzmLXvGvd2EAZsKmZ6r
 pclcHdkxZQI8kuFSBOyjHsSWONVnXb5XUD1Q8MQJQXPrBlb/lD379jk7uM+vRxCOGg7Q9n79Bqv
 KUPAPss1d5ZxPDIUUdRaGoMSjHVmsP8Nh8gz+Mmz6G7zX1vmyK1cu75Z4c2koGbT9B5kuw/2g6P
 vifEwPgpUBFuxJgy2cluFt
X-Received: by 2002:ad4:574e:0:b0:91c:7da5:2185 with SMTP id
 6a1803df08f44-92134b5aeccmr65557206d6.38.1795202581417; 
 Fri, 20 Nov 2026 11:23:01 -0800 (PST)
X-Received: by 2002:ad4:574e:0:b0:91c:7da5:2185 with SMTP id
 6a1803df08f44-92134b5aeccmr65556886d6.38.1795202580916; 
 Fri, 20 Nov 2026 11:23:00 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:00 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-18-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=665;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=oqdI5hd0bzFDTjmZJhdZgTWlXQUGCv3VczOmoM3OT/E=;
 b=chXX8EgpjLF+tO3jeGRaibckFzVjfNZJR6GG9y0S+dUw5sIZb18JmPRTjSj6gL24cPUsGaayH
 QUMgaHOiZzrCeOKH5a7uBChgdfDsWAF1O/l2OkNGqAm0uo0ePpwEoFC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=IpGL47/g c=1 sm=1 tr=0 ts=6b009e16 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=ecRPoZ5uJhEwXS54YHMA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX5dyWvOfgGYzn
 ZlSyOvLj2/4QGtY1w8KVIJYjbwHUEwZ6TblTP4FxkYn6TSUICmjj5X0fVz/Q8lBtHbWA4+QRx0o
 HaytylgTRB3ZaiwTs0O4nCFAS2/X2YVkclpWo688qtzsQonBwjaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX46DAZuRCPBAh
 ZBYPrBYePQxn3E1o4dhRvo7Ot9xqgXqcu9DMxGsb2apmIebrxpEfmhwLDrVZEVnKlgdv8RmiEYZ
 zY3qbmxG6VxKilqSkMFOJKnuc2Oln7zalWX25TPL0UmiZBpiNbfg2ajxgOfZMPALgR+Q3dgUFpL
 F73PXuo+5AxIaZUARdaiL0nIQGcu3+brfHz1wY9u7JcvkNODYlDHibXUgrjydKACowWgRG1vt9B
 yhHv+XN8Dz7XSwmUdx7poZhA0pN/OB53LwqoDAd18z+X36DAVMmj+7YtcOcy1944Z7UbEFF8bXq
 i9sheUF3w1Xtu/4eVkx+3luUnhpugEXz81F3kTz9CETBIhY8+KA2DlcyxhqEVNmC8JkJ9b6h0X2
 cqmhJa4K8EeICYeT4z6Z2qGg/+fIHW/le1lH3FX4DifVulTqIM6tOVvAmBJsivCoFN4I03cUVSV
 aiPY2rVtJyFJadL1Lyw==
X-Proofpoint-GUID: 76t9e_19ddvnC-1SkLjyi5XSLFYurndC
X-Proofpoint-ORIG-GUID: 76t9e_19ddvnC-1SkLjyi5XSLFYurndC
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 clxscore=1015 lowpriorityscore=10
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCS-000000007EE-0IIl
Subject: [f2fs-dev] [PATCH 18/28] f2fs: convert f2fs_alloc_dic() to rfolios
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

Copy the cluster folios from cc->rfolios to dic->rfolios.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e09465aca859..bd76c59d91b2 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1949,7 +1949,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	dic->vi = cc->vi;
 
 	for (i = 0; i < nr_rfolios; i++)
-		dic->rpages[i] = cc->rpages[i];
+		dic->rfolios[i] = cc->rfolios[i];
 	dic->nr_rpages = nr_rfolios;
 
 	dic->cpages = page_array_alloc(sbi, nr_cpages);

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
