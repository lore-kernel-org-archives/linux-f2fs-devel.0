Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453D606A6DC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SpYhkQQX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZJNq+Eg5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A+TYJAYB;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eqsdtbLl;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=N0CAKY50
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ilfQDRkR4lS//3gTzF0VINHXX/OOevpyyAJW9InWqjw=; b=SpYhkQQXE0xYxgVmhwQx0F8eKy
	HSXIGu2H3Cr+V4Au/7FJSmGLErDeYpM5PmTBniatKNmxwBdLdPZ6Jw9rQRgI+HgPwEHrH9qh+A55o
	eDxQdgPUPrnAtr25+6vtZ3ZmFiIc2kukQQP6Ye6+/FyHWVnVsa0qUxUbw3Mq80U0U0Og=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCL-000000004bf-0ET2;
	Fri, 20 Nov 2026 19:23:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCJ-000000004bQ-0F0O
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oip5DHoEn4+zTUDOyHp35x7LIAajtPw4O1uALg6q7ns=; b=ZJNq+Eg5/nwd6DjV094WqVlZ2Z
 SP1xAvEvVjUmJVjGTCytGijehq7WxXWyLFDh/zZ4forVHq2xXLDhrb9zVEAuSPYXgOgqEus3oP2eX
 ZyKq6t9ZkryUFAzEyG3weCQiG7vQs1tp0ew6sjlFD8ReJ807DCc9l8LUcrG3VCokIJCE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oip5DHoEn4+zTUDOyHp35x7LIAajtPw4O1uALg6q7ns=; b=A+TYJAYBg5FcpyZtFmcm41wkMe
 FtDHUAj5tpK6MeRdOsIZFncDcfiPBL91iBKtu8ArW0jPNVIzOpBBFLoF+J70RrPkE/YQSkWdvUJ0u
 C+h+gJP4WbmXnl7UNStvkZlOum7s+j4Svj42u+KvfBeF7IljPINxS4/4YbPYCrPmcVuo=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCH-0000000017P-2FuI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:58 +0000
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuhKN3421055
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=oip5
 DHoEn4+zTUDOyHp35x7LIAajtPw4O1uALg6q7ns=; b=eqsdtbLlhoIBL5ZCAcbS
 v9yTg/ciSeigEm97PwH1AjBwgBOYwSubd6O98CQ2wubdRB/QBjGUaIgu0rgf8TTn
 PqszO8mqHrfIA+Cixm9HXZvoJRUWG96alfvZdJbrlUr/zmyeogCnciIRd7+8KtCb
 DGs/yeNAeSALhgZnnxIVQzcE+XC6t9klbBSyvEkOIKqnoV/BB9UQj6H5/EDsJJc9
 zRTY1ILC7fTZ5U4WRy1PkK7EW5POeUd07PcNm1E1vRDfswZAGVmY6RUqpWMTRpjh
 PGhQPp64RC+FvedI3TtkThLtTzd5mByhhrTM5t1VLULPwuatGc4tuyL3pKfIhfhK
 Xw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rym20ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:51 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-92111028a03so26405946d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202571; x=1795807371;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oip5DHoEn4+zTUDOyHp35x7LIAajtPw4O1uALg6q7ns=;
 b=N0CAKY505MemB4U77xKs9/don2tCzswnA5w5Waw6yV3Ljvl9fHspTb854iDvwo4BA9
 6y75b8PfWqbn7zzJI0f7PxqxifX5eI+wTSmSNpzaA2Inc5v75PA0d7Qr+7ACEKtJM/5U
 hMYkUsjPbBbdS0eqerC+Pcc2fOCwoC5+R49qVGywMZ0x8TMkG0suvaHh3JsrTBZjonM9
 ExylpAa1jpanSwHwSTXzPGNqnO763ysyKyZs3LPY7otIx8kBeJdh5UMwAXcEMMxd2BWt
 45IO74ptKOvYVQeSF7We1XZYw1/Kpbz/o8Iz0QlFxXbBvxZ0oo9f8fVWyh0R8e8c4RHj
 D1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202571; x=1795807371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oip5DHoEn4+zTUDOyHp35x7LIAajtPw4O1uALg6q7ns=;
 b=khbMofsWQhbHZA/e8RbN9erkW6lauA45vXltDgXjxGuP5clMdz2viQrjZ1dm7asjAM
 4OlW01J6TuTqlDqdawPeoGBnB8wx3vrTzPum4Qz4sTZEG0DU8ovZ3dcYWglJANrK6MuT
 xS6MAbXi9xT4av5rHfAF1yl4wZVDEhZ19OD2zn4g7/iBWSA9EIvwkRj2DgawteBl/7VC
 OoCE7szYYo3Gx0jpQ2lsrY60hNbrcSLMN1RA5VaCFrYHrXK7Par53IE23z9PIKBtXUPD
 TsAy3iFlpT9miFs++uKzVzDAXhDocgy53L63boejwE8QwHoevBOMqSViXDzfORx8sagK
 TBFg==
X-Forwarded-Encrypted: i=1;
 AL+hErFfkSej7tgky9A9pjyCPdDIvw5ClrHu0M3YZB2tvKJ4g1IbC8G6iMYP3gfut9STuPZXuwrWmcQ0UW4yJk55AHry@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8oUwB5ozY0DBjPLlHVt73bKSOdY2UcY2yjjlwkAqJQxBedJkZo
 T5YrfAsD5FAwX4gSQIjz7Sk77jptdnUgZA8L3ZaLqFZVny9uz+lB+oLXow4/XTex95kA6WVk+Zm
 VH2OvxbMmhP0zIzCpBPa1aK2te8BYR9e2fJ0rEQkCHjCIPApKo9Q3LC7rlteNBpsyZS9uI0uqK/
 w=
X-Gm-Gg: AZFdTZciTqDU2ZacOX/1CrSMKiMj71KVZVBGVWKgnfoZv5bdGT5Wil97Teqxa+8VkHC
 d4VGVxGdb3x3PE05ETOirHllacv3bCR0VoDqTO6U0c/vrYMqhWjoKTewN47JatbBKtLJHtbcLuq
 a06kdWVJ+c//9ACv2LFVnaqo+KpSb9XodiNcvy8pYP7cb2rNN35qmIjuO9T7cjYo+4p8KaWlnMc
 /gY7abuuet2oJu4MVrmR6LdwZnawPUGmN4KnYyQiOrbfXpP7f9U3epMgd6MRDyLOmitoiE6SpGG
 12KN5Xkz7IlDXuh65940spfoi0nWBnmXPkwS1CbJu+wmECIpE3sr4ZYWX62b0oMBDUWNxSJEB6C
 g5UPl+/ETEezQajWRlCfGtjx9Azz6RAETMun8tNVf0YWSd4oDr0WUsGz/zEL30phcKNaXsjMO3g
 AGZXfETTmQ8SGRxZZf9BON
X-Received: by 2002:a05:6214:6346:10b0:921:317c:89b5 with SMTP id
 6a1803df08f44-92134b11263mr50402276d6.44.1795202571037; 
 Fri, 20 Nov 2026 11:22:51 -0800 (PST)
X-Received: by 2002:a05:6214:6346:10b0:921:317c:89b5 with SMTP id
 6a1803df08f44-92134b11263mr50402026d6.44.1795202570638; 
 Fri, 20 Nov 2026 11:22:50 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:50 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-9-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=4592;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=GuAaabw3ht5/l/1WWivtaZyJQU+meEg/3ovTHSCIOsY=;
 b=QvxfjY3ZStrUY0S67WKRHXCSQcg6so6INrXMdluK3GiLknWqJQmx1FAhf50JfAQMUlQHVu/PU
 dv18wB6vVFLDbh4BpsPMYN6Zuy5WgTALeSD3kBO4SKWows+cYoM03cL
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX9m/TPUTPRNMd
 I9XrqhUUkB7a1CKtgEKayAZmB3IXVkAXmMNZ0ztZ5yJziQ3swld3UR5pP4FqMNG25ePLI08It35
 MlK2B9a+oVSJmedpurCw6IJKxC4IEsjf0qldQUFLcffsigu6Odfj21zQoeA/V8C4EVX38+Dw4wr
 TjwZqdPdgGmX/OehJEn1a9vvLmDDdXYq4Bf1eAqpLRz1oVdyDiviUp9ycYgqhP2fa+hlmzTAXrs
 hgoS+H/ay2XF/kEX7c+EaJWXc1jNsC1ZaZOJEd/6oVbhIID9p8XOjLcbtAG42QlRFOMOiSQVU+d
 vO1SW1g6uwC7NoPG2c0Aea/AW7OqB/HVsnHS5PJKgTStHEd9dKHIvP/sdtWjhJ23mE4PNRk3+3v
 RU7ZSPyQtXngCsCE1lCv8rOQwfvfwUEfTiqs/Zc8ffJOJH3yVhJdnoRok9B4/ihmJwk/ow8StXu
 TwV/WAnWkz4VKcoRSEQ==
X-Authority-Analysis: v=2.4 cv=CZydd7rl c=1 sm=1 tr=0 ts=6b009e0b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=fURn_IAT7vH7sWi_0sMA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX0x5jQYxD71wg
 DxZRSh0Oo3V0a1cp/HaToRiT8MH3g/HUD2zJ8tae+usDnEbs+PQl9P8QJb7DkBPxSc3j8e3D9B0
 lZWhxLTM18D+1tqvBeTPsa/6/Gb7gpF4vYeG/sEIBJU4VeydgyA3
X-Proofpoint-ORIG-GUID: c1hIUCFaE99bRda0a1WI3SVkIrGFBNKR
X-Proofpoint-GUID: c1hIUCFaE99bRda0a1WI3SVkIrGFBNKR
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=10 bulkscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCH-0000000017P-2FuI
Subject: [f2fs-dev] [PATCH 09/28] f2fs: convert the rpages drop and put
 helpers to rfolios
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

Convert f2fs_drop_rpages(), f2fs_put_rpages(), f2fs_unlock_rpages(), and
f2fs_put_rpages_wbc() to rfolios and rename them to match. This removes
the last caller of f2fs_put_page() and a caller of
redirty_page_for_writepage(), and saves four hidden calls to
compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 14e577010e34..54fd77aa0a67 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -99,33 +99,33 @@ static void f2fs_set_compressed_page(struct page *page,
 	folio->mapping = inode->i_mapping;
 }
 
-static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
+static void f2fs_drop_rfolios(struct compress_ctx *cc, int len, bool unlock)
 {
 	int i;
 
 	for (i = 0; i < len; i++) {
-		if (!cc->rpages[i])
+		if (!cc->rfolios[i])
 			continue;
 		if (unlock)
-			unlock_page(cc->rpages[i]);
+			folio_unlock(cc->rfolios[i]);
 		else
-			put_page(cc->rpages[i]);
+			folio_put(cc->rfolios[i]);
 	}
 }
 
-static void f2fs_put_rpages(struct compress_ctx *cc)
+static void f2fs_put_rfolios(struct compress_ctx *cc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 
-	f2fs_drop_rpages(cc, cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi), false);
+	f2fs_drop_rfolios(cc, cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi), false);
 }
 
-static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
+static void f2fs_unlock_rfolios(struct compress_ctx *cc, int len)
 {
-	f2fs_drop_rpages(cc, len, true);
+	f2fs_drop_rfolios(cc, len, true);
 }
 
-static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
+static void f2fs_put_rfolios_wbc(struct compress_ctx *cc,
 		struct writeback_control *wbc, bool redirty, bool unlock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
@@ -133,11 +133,11 @@ static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
 	unsigned int i;
 
 	for (i = 0; i < nr_folios; i++) {
-		if (!cc->rpages[i])
+		if (!cc->rfolios[i])
 			continue;
 		if (redirty)
-			redirty_page_for_writepage(wbc, cc->rpages[i]);
-		f2fs_put_page(cc->rpages[i], unlock);
+			folio_redirty_for_writepage(wbc, cc->rfolios[i]);
+		f2fs_folio_put(cc->rfolios[i], unlock);
 	}
 }
 
@@ -1258,7 +1258,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 					&last_block_in_bio, NULL, true);
-		f2fs_put_rpages(cc);
+		f2fs_put_rfolios(cc);
 		f2fs_destroy_compress_ctx(cc, true);
 		if (ret)
 			goto out;
@@ -1287,8 +1287,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		if (!folio_test_uptodate(folio)) {
 			f2fs_handle_page_eio(sbi, folio->index, DATA);
 release_and_retry:
-			f2fs_put_rpages(cc);
-			f2fs_unlock_rpages(cc, i + 1);
+			f2fs_put_rfolios(cc);
+			f2fs_unlock_rfolios(cc, i + 1);
 			f2fs_destroy_compress_ctx(cc, true);
 			goto retry;
 		}
@@ -1301,8 +1301,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	}
 
 unlock_pages:
-	f2fs_put_rpages(cc);
-	f2fs_unlock_rpages(cc, i);
+	f2fs_put_rfolios(cc);
+	f2fs_unlock_rfolios(cc, i);
 	f2fs_destroy_compress_ctx(cc, true);
 out:
 	return ret;
@@ -1340,7 +1340,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 	if (copied)
 		set_cluster_dirty(&cc);
 
-	f2fs_put_rpages_wbc(&cc, NULL, false, true);
+	f2fs_put_rfolios_wbc(&cc, NULL, false, true);
 	f2fs_destroy_compress_ctx(&cc, false);
 
 	return first_index;
@@ -1603,7 +1603,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		fi->last_disk_size = psize;
 	spin_unlock(&fi->i_size_lock);
 
-	f2fs_put_rpages(cc);
+	f2fs_put_rfolios(cc);
 	f2fs_destroy_compress_ctx(cc, false);
 	return 0;
 
@@ -1815,7 +1815,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 			add_compr_block_stat(cc->inode, cc->cluster_size);
 			goto write;
 		} else if (err) {
-			f2fs_put_rpages_wbc(cc, wbc, true, true);
+			f2fs_put_rfolios_wbc(cc, wbc, true, true);
 			goto destroy_out;
 		}
 
@@ -1829,7 +1829,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	f2fs_bug_on(F2FS_I_SB(cc->inode), *submitted);
 
 	err = f2fs_write_raw_pages(cc, submitted, wbc, io_type);
-	f2fs_put_rpages_wbc(cc, wbc, false, false);
+	f2fs_put_rfolios_wbc(cc, wbc, false, false);
 destroy_out:
 	f2fs_destroy_compress_ctx(cc, false);
 	return err;

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
