Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E1606A6E2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YXNDbjR7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hEao2hv8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T+Xq1rrV;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=oBtMTg/q;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=J61CBW2g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=R0gdcv3Qts9w/6aN6zI3qrfxvoO9CtoOEVU213QMxCo=; b=YXNDbjR7Av/awaOoGdAsymuglR
	At3tGFCC6Nu3RLp+RYzgQyBiq23AL63NqZ5PWoKVRXoenO1MbBdZYOBGkjJLPT7igdomjKumjcjBO
	UugXMbPe3J4u/VLuxPOP9K1J4ApBkSdVXOx/PkYpEgbilXbLF8iJBthntltAfgr9JO6k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCf-000000000Yo-2bKA;
	Fri, 20 Nov 2026 19:23:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCc-000000000XP-0bLA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YiPz8Ss+Al7N8SRzKTb79Ol/SIFDIZjlfnYSDlnwO2k=; b=hEao2hv8wzv8iu32i3Py7smoHH
 1HJcTvxUto9Hs+rgHKw/whOYIKjcMjUXLrl16letV3xE5Dn/58PKibD6VxMFGEkY0GRdRkiI9Xux5
 1ihN8B36X/N2xTFRKcLpryeetyB+OXwTMSCKAP4rZVxejQaMT8g7Wgg9QIw9fIN+rtDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YiPz8Ss+Al7N8SRzKTb79Ol/SIFDIZjlfnYSDlnwO2k=; b=T+Xq1rrVLCvb64jtB9PTBDhyKC
 eWO0IsuzOisQdlK07O+dbn+R5I54aGE/37YcRr1le9bSPXt2CTmq4wLEtVUNtV+tU0fGkAGcEOk3+
 uJwpeaxW6cCUxTWeFoqiA3uoM+ZoW6h1V3mBvg422yLFNNFoauvB+X4JrawAG/M7teLw=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCb-000000007F8-1OJ3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:17 +0000
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIujh41802576
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=YiPz
 8Ss+Al7N8SRzKTb79Ol/SIFDIZjlfnYSDlnwO2k=; b=oBtMTg/qUYt3J6JAYnJe
 pyi9O103CUxTOhMB70HJewlJoiTi5FOA1eAUy0dOjoZ8dPAde2FbNn/3JOvQebmG
 VTNrAbBzj/cDXVnHGuI6hzIcdbcL/5AH9tm07EV6Rk/8xeh0hl6FXEbsZd470G5f
 3+FTycY8IRA39UKJMOU4+YJUxADtEzDcJ5GcHmLjJO3abMSqa7WDXEqxEgcii7Vj
 aPQ69i65mEZQox6efeaWsTSBsPZoDU3esv3/jN9JyErrfJAcr1YA3sRyvvHos5YF
 dCuzWV4TjXvq9HOqGb9e7Is4r4EnQSmAAXA7MJlEsO0G5J82Up+u+zU4j4e9hQew
 tQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rrdj4kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:11 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9211d51dcefso27047296d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202590; x=1795807390;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YiPz8Ss+Al7N8SRzKTb79Ol/SIFDIZjlfnYSDlnwO2k=;
 b=J61CBW2gNGXVm8fJv0rtEJaVXXbW9AmsRDaQT/MUJ4BuK1KiCqts123yJkwJdvgXtj
 rOze2T5jR4A0W7mAevCa0BhTcWIWRued2ZGGpKv7+M0LIQdw26gUEgR+fIY+7y8igz4b
 Ti4Tstw0fiB+0M6lZwG4tQbTyhif3tOhyG+SgZmi6yPeq6lqrgWBu6D0Ev9KJNSNDIwM
 GPJFrpCR0JLlOuXtbweyCC9HvBTc3On9qhn5RC16qvNxGvdhQB+jJtA0bsLDrxeEOypF
 PXv2XNGcdi92GSu6GNDXgOl8sMTk82Ok2jJIuvkVN+rl05Q0GlBIEBs5tANyS2C5JuzM
 725Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202590; x=1795807390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YiPz8Ss+Al7N8SRzKTb79Ol/SIFDIZjlfnYSDlnwO2k=;
 b=Up7wSyKZgBpI6h7NWPvBDTatDcVki1kz8e9T5wubFjwGZVRKWDOxZhgDnHL2YZ+6Hj
 2/DxWLZzyzJq5Ohe4oK7booEAKTo7TXKruIEG/+R44kCDJYfqQXCkiLwpVIsxjyYiArX
 K5xtGCuawwSv11dqqRIjEa9QcjRCgZyqA7NlLgMlNQ4nTb955dSfh2A9SEgiyxBhUKPr
 I0TSdIIxinuGAZjb2ITdZwkmtwHqId3JNe5DqjMJi8SGJKeZ44OpPXqgoB74TywAJBIY
 9qj8VfQ5ttnbh2YgkcGtsBixixPKoKvQAED+/6LnRDBmVK7DLGlM1xHywNfGqHC3m7Y8
 2XwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFs6sTdKOthoPmkrTCBHkUH3gZ/53b4D03gHCyToMDFcRkFYT0unombsy2k3/CkdLDixA72yvBRPr1+kYpkDVrN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8DIkw8Dac/zX8snSKyGXsAe1P9pGkjmpflVTIA8/JDcNeZtxDF
 QaNpGNnGxGBR/cXMsTUsIzKh0uhLZrVuleayKrPrYHhOJppWL5jvaX6yi3FE5BmKcpdYmM8lJmJ
 hINTYS2n/NZ2R3PV/F+7BaPLEVrfn6qkQtl0CowDi9TNnPOKBmrMShgHWQxKSouvLRttQjThO9f
 kWAREjkAA=
X-Gm-Gg: AZFdTZc0h+lp/6Xre5qBIs6RMkhkGW5Krk8xc6L60KCMK7NrdLwU0QyJoXsrg4DOURZ
 sEGAlhWAPE6rTWcwzohutE7la2/xOzXUV3qiBr5TIZZPemCEh5DFn6aoFObT/6oDr3PHmbAaRRT
 9eNV/AjNIDcOmOqvzoaH3xQXh7z8dl7LG9KQI8VZdrUQ7Q0ffKiscyTeLdsrLvx26dUSXQGLhID
 JHkmlW5mVvI/oZHCCQmjqXMGHJ+Yii8ukiNDSD1Glwfv9saEr3twiUmTcCyUNhy2MYVHZFqdDeo
 0D15OYh7P3UDkIR5U4+Jngded5BTAttwqF49FkDtF4YZOrHMh3zBhPzwheCoH4qwLq2I/5EC6CZ
 coQXg+hoQVdqe8aLU3R3a5DE3So1pnas7NvBbz4Z2HFibB/dt0N5v8wrisKCw13a/5t3Jv29vCj
 xxzVBM8eR9rvMog+cMb4lV
X-Received: by 2002:a05:6214:5244:b0:915:e5c8:5663 with SMTP id
 6a1803df08f44-92134966e56mr67608276d6.4.1795202590655; 
 Fri, 20 Nov 2026 11:23:10 -0800 (PST)
X-Received: by 2002:a05:6214:5244:b0:915:e5c8:5663 with SMTP id
 6a1803df08f44-92134966e56mr67607866d6.4.1795202590201; 
 Fri, 20 Nov 2026 11:23:10 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:09 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:30 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-27-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=661;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=V3wbS6BabFIdfDwVooX+tOJ6siCIMwB9XzqdluL5p2o=;
 b=o/Q113AiHFFhjT1+YD72I5zjaddbOkW/hkArOCpaFJ69E8NCFRMFDyAPO8UJi9hq14q9dhOVd
 Sx/+hPHhMWrC9X9JnP+LDQjGCmQ6HC+EfixnkAL4DFi2Y69/cVJ4a/6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=IpGL47/g c=1 sm=1 tr=0 ts=6b009e1f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=-npdpQeFeoNLb1joOysA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX3cAyth3r0GxT
 B4Q6cN906m3aI1SCh1ktxoAmR7+CYfxCtV43H96m/7qCpABurTIXFwj/tAS3Dm+uXrmUlVBwnYm
 sU0Wvq2BnLhxZHLsknq+DzyHYWG1GT/uFQwWUWQ6uhKDebiFxDY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXzaIe53/vU8rR
 xfSQFvpgiZZstl5gB1TLqEhyZPl7zS0S1KoWR9NVjAmyybug33lCeHEuGfo0ukhU2nIA9ljNnHM
 wY7d3be+5gzl1Ckf8v65Ao3uJFCLOpTaUh5KdHQDXgfA+4QItEuqA2cIDWnemd4PhAau8L3B5vg
 qE+XeP1nlA+igZ7fw7N4dFxD9ARy6xm2fXODymyBIiXEWIzB06E/HgoQTF30hU6DymhAkJoPck4
 ++T6GybFlACEoEhsOgs6j6H6k2FHmSv34/GMQXp1S9cHcRFzQmQTTMFPwArEnt/k9gac395YzGP
 6YMozTLx3elM+NXTz3LC8+gRXbjjaCXjjxaRv3JMEHWpoYs5VqmZsCVPjLY3ABBZ4dI+93Nlbcu
 YPCCbEhL809chEUzRT5WOdlMYKCJU56sR//gAsxEvUqZ67jDgVvLR9Z0duBpzWJFZZON8Tj0nm4
 jd5mea7Sqwy/I8HFiyw==
X-Proofpoint-GUID: gR1K21LIRZ6iXACTwrgjV1x0xSqo851U
X-Proofpoint-ORIG-GUID: gR1K21LIRZ6iXACTwrgjV1x0xSqo851U
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 clxscore=1015 lowpriorityscore=10
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCb-000000007F8-1OJ3
Subject: [f2fs-dev] [PATCH 27/28] f2fs: remove f2fs_put_page()
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

Nothing calls f2fs_put_page() anymore. Remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/f2fs.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 058ed6386f83..12266616b12c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3344,13 +3344,6 @@ static inline void f2fs_folio_put(struct folio *folio, bool unlock)
 	folio_put(folio);
 }
 
-static inline void f2fs_put_page(struct page *page, bool unlock)
-{
-	if (!page)
-		return;
-	f2fs_folio_put(page_folio(page), unlock);
-}
-
 #define F2FS_DENTRY_TAG_CACHE	1UL
 #define F2FS_DENTRY_TAG_MASK	1UL
 

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
