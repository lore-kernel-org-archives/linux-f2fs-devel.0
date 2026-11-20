Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763C606A6EE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PhQwuEyA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kxmQbxuG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=grw/U0op;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=d/t9GCyU;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GrrBbnTC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=DWCe8bYDbjI0Q6cooUeQe2ofmoiVqVV4/LxYPhZ3VgM=; b=PhQwuEyAxMPYAK3BsIlHUssRFG
	qks+jxvOCECWfIZAKSyniaTVyNCUwyPbOxHswa4iMVjPAgyKIfdqI+rtv30JeIhVtRnnovTjOwHUY
	LpaJyw4HeX4gb4qHW0TaQbSE97D+CFIK2AeplZuK06ZOTXwlFRjEpI2IHYqPPrQCb9os=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCZ-000000000jh-3tTX;
	Fri, 20 Nov 2026 19:23:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCY-000000000ic-1QDf
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xOKbbwLH36o4sd4TIl3IU+DCG77E2xfID5UJj5G+tS0=; b=kxmQbxuGURT5k3ptJKA1LYud0W
 oOYkAzIn/lDcc5GQEAR5zBuliEvAH9yZ4sPfMOKqS4q0qRzqIlZ8Ey+wQ7Ww/vcSogPFT6hhulCTC
 wo009HMnQAaiy6wn6dBPqUlBt3iQ62tytv3yCam1Ch/BiDomHsU2O7SbEH9bw1oRHY4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xOKbbwLH36o4sd4TIl3IU+DCG77E2xfID5UJj5G+tS0=; b=grw/U0opnW0E1scmf4vCLfMVWG
 CjSlJT4KKIhzUKpQ7vhvMWaYWxQFX8ElF42ugxOQM+DjsfzKKnhctLpo7+YGGl7VhS0llcBHQ8Thv
 r7tXkWVUymJHFbKr1nU+cuHtxux+1xrAX1xq7nDXEu839Sw5ul26Ql9TGKvTrVY9HUpE=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCX-000000007Ef-2U67
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:14 +0000
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuvFo3421321
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=xOKb
 bwLH36o4sd4TIl3IU+DCG77E2xfID5UJj5G+tS0=; b=d/t9GCyU6zfKuobyNtwD
 z+yvUag1RZAPMXITS5dooSSWHxqUGyNwdpxoL6LE9o3z2mw9e0La8G3whm7N54ru
 /YXnGlAvXzoZ5LL15kfwJcigzQJrhldfDYLVpt/NlHtiZyAfabgYFy0Sv0moTuHU
 JoXPhgDBkxIq4wyN5uP4NE3aPbA6K1ofYRQdCD78+syuSd4W9H9ktEt1psrcwMrV
 R+W0yjdlLfEI4YDah84F5x/JanfuR9LkF2pqNApCf9TE5359W3WsRwhZ+KGg1Xu8
 k2Qc5YULavkuE7kwBKDdbGWEEhMGpJ1ZfqeoJUDfwfc9/xp/XWFoyVkdqASof9cw
 6Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rym20tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:07 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d846fd50aso11630351cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202587; x=1795807387;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOKbbwLH36o4sd4TIl3IU+DCG77E2xfID5UJj5G+tS0=;
 b=GrrBbnTCicqi5XFS/KeYFV04sUTXk9TLUbHP1rD4K+VwEuUuw4yngPbVavz36ppxIn
 WvAw3g/hlkQyii1KtO8PYQAxuRGQpYg1GbQzP0IWCLQn2UVuO7jIuC8aVW2IQmE7qPFR
 cuBDiWESQBpuhbD3YpGjlNSA0As93qlM6z/WoDbTpHy5H3r188chbH3F5FKYp/bkUo24
 dVQ2v/vVIOJCOmOEwRRTVzpqeFiPVs5AF042I4Ae3PnIb/1Q09qnGoHErjoLstsGErAT
 zkc7FW/LxuYk2/VUbGSsOrCf5/jpPp+dNtjxGy2uKIQH/KO9nYCoMIN3Ksm3+rj3oaGB
 N9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202587; x=1795807387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xOKbbwLH36o4sd4TIl3IU+DCG77E2xfID5UJj5G+tS0=;
 b=Kd3ZahM2OlHZg45VSJioRjgdETOKAGOyQrEaFMy0gXW7lOfRjwU1K9KbQLm57xPgro
 svLJf93E6BSCQEI7dE1ZvN09iagLUnoZeKVeTHqhPL9+yvD7z4j4OZsdOpswOE/TEkii
 WRuB46prXrGxwoQdIjWEbJfs3B4o0VtptECrVZi7KUMoF5IfbbB2iQjbZIgHw/cNkj6q
 C5ZKurr+oevuH0hXwZZsWuEvWPd2brO/GYJp1aoloMHr5v2qJF21P2zY4EDv346v/m9c
 Mc98v7mvQYmFTM60abxNgGkFqNpuW2fqIcVEzylgPSA0sLtm8R+JKr1VtFccZBTie/OD
 y6BA==
X-Forwarded-Encrypted: i=1;
 AL+hErF1RT8Nr2iZGKuqdHExHTGEBuh82v+zaWoeGe+ZlA5FXLPuFcS81SWaF4Mqek122140TpcPRCFT4ALgdXA3Ws80@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9lywFfPgbUNZOTKJBjVNv9cwb1upf0Vnq5X6XnnEI+iArsElMT
 0+CVntN4s/qc+w9+KdjwkgjjQ/W6Hkk6kBCKtEQXqOKnWcx6kSrYuI59oMR2uDBw3zatLouazel
 T3m8JSpST3EKdC72bGpL+CMaM6dYbsnH5EnOd7kRs6zHgeCvyIGCyMSFAbM3A0Rhq2c+Sd03AS/
 U=
X-Gm-Gg: AYBFou3zXtiuHUjkqs6rKPaqTWvf+i+s0lRHR4Cr1WgBkcY9UrO9DGVKEZ2PAr/eKRi
 8LRv8xlN3y+dYF0VpNSOjkTcoPvoqXecCuBeDH4yhmjPhhcdt9NZj+1dkDqOUvqKGzMDcvKc2BD
 336wlO8lkCXF5ExIxiDm8+gyQaJzN9n0HDfHqZAW1UDOYpbfsvGpa6dWMoxbLFbiNEHccrIYWPZ
 W3FDCjIcFXBcy3kYfBz73Bu1vXAcHv/+HCS1MfxO8lDNh1IecGeb6vB4LH2Zquy0xraxgjNFobN
 p6EZDiSXsZoHfUKHyPYTfpRzd2tyVAyEWoIykbsd96jaEbXEg0yK9Rj9cNNpA+boVHDRsl/qjH0
 C32vuomJ/HBJ35a7QUceNVvRN8QeXr48OZL1OtZY4Sacqwnmy+iFVFp6IlKkSXlsev61kXqclYz
 xkwciObVQZ+JsE3PT8lXza
X-Received: by 2002:a05:622a:58c6:b0:55d:36d3:a949 with SMTP id
 d75a77b69052e-55d769ea509mr76661651cf.27.1795202587165; 
 Fri, 20 Nov 2026 11:23:07 -0800 (PST)
X-Received: by 2002:a05:622a:58c6:b0:55d:36d3:a949 with SMTP id
 d75a77b69052e-55d769ea509mr76661371cf.27.1795202586744; 
 Fri, 20 Nov 2026 11:23:06 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:06 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:26 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-23-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1392;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=V8c1vO0wZxRkVvs9SnL/I29dGYfMbbc5+obiYmiOHmI=;
 b=Du9KkTyZHhsCBwq4eXN+vq2ueod717qIfQ27o8f+UwGfWhX2uBNPZQmKXbBFudfiQ1nAwm1mj
 fLlZzSm3IM6A79dPxawkd25MX/kHf31Eke95Ud9Skhfx9nR4Erw0ZYp
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX3nKHCkGEfdIY
 CArboZA98u/5i6+7i0rw4QZ1jqu26t1yjMiOzHW1QkzE/jVu6gSgvqIw9Mc4NNS+aYjfHIhDCBS
 dMHxiLlJ/qZdgeZdobHnzbM1m/WTzi+Dg1eUUzIHGh/+w0xIbU9mlH6Ntbttk51VjEh8jDxkhSh
 KoasCHXBFhTaktOvBMIJnI7rIiAJxonDUe6GtIG0QuAUjJtXGINfn7ePwGzT0yeyhk8ZU8V9J8A
 eGnouw4G9oDhOW1dZt9QgAH8htxRytIbavk9y5lJrHo+xCJfrdq4L84ee3KkOb3+rZln/kUIGll
 CVVAg4W0quncDkbFdQDC5D4WDzPGsPjoUSuLsbvJrGQfwnkgHMeQKglqTUYXRdzUPxMSiEraitJ
 j2XBHkCJIv+lN3+I72TlaKj20bULZcf/H5Z/GVh/ANxO1R3yDF8pY4FmepFxEFJLACFhYQl3Vn7
 M/gGAmBessp/VKa4jgg==
X-Authority-Analysis: v=2.4 cv=CZydd7rl c=1 sm=1 tr=0 ts=6b009e1b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=0-d-AhO3vQoUB1d0NLoA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXyt2uFQOeLXUu
 xnhZhuCsa7cifz2jW0+W9m3wvVU/QnR4SJC/K1xvbtO6GCgAUBLYji6C8nS51eMKpOftBIzbkH1
 BVlPV5vRD+UdhHWvZIt74+5gm8NgUHs5I2hTUVltati02n+YtYdP
X-Proofpoint-ORIG-GUID: UltqbGdQCCnG6D74DJWOUDRTEdB63JMp
X-Proofpoint-GUID: UltqbGdQCCnG6D74DJWOUDRTEdB63JMp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=10 bulkscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCX-000000007Ef-2U67
Subject: [f2fs-dev] [PATCH 23/28] f2fs: convert f2fs_decompress_end_io() to
 rfolios
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

Read the cluster folios through rfolios and update them with the folio
helpers. This removes a use of unlock_page(), SetPageUptodate(), and
ClearPageUptodate(), and saves six hidden calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4deff5ff5360..db5f11689140 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -2078,20 +2078,20 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 
 	/* Update and unlock the cluster's pagecache pages. */
 	for (i = 0; i < dic->nr_rpages; i++) {
-		struct page *rpage = dic->rpages[i];
+		struct folio *rfolio = dic->rfolios[i];
 
-		if (!rpage)
+		if (!rfolio)
 			continue;
 
 		if (failed) {
-			ClearPageUptodate(rpage);
+			folio_clear_uptodate(rfolio);
 		} else {
-			if (f2fs_is_multiblock_folio(dic->sbi, page_folio(rpage)))
-				f2fs_ffs_mark_subrange_uptodate(page_folio(rpage), 0,
-								folio_size(page_folio(rpage)));
-			SetPageUptodate(rpage);
+			if (f2fs_is_multiblock_folio(dic->sbi, rfolio))
+				f2fs_ffs_mark_subrange_uptodate(rfolio, 0,
+							folio_size(rfolio));
+			folio_mark_uptodate(rfolio);
 		}
-		unlock_page(rpage);
+		folio_unlock(rfolio);
 	}
 
 	/*

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
