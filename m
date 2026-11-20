Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665F606A6D9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TlWASAP/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gx6Z71Xk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jnmA1j3M;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WVSF6QWb;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=knsJ11pt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=edS/aghGDH15yb0xMU5Gd5xpT9FLGAdJ4Sa8dwoHpC4=; b=TlWASAP/XkZGDsmz6TUBtYK1Dy
	0hxAAvNMH0BlAg7D82AacfROiJIidW6x07m2bHgM9oM5YrgCztSIKwtMOkw018CSvj2FatFb++RLn
	InM3bh7butqBgB6cCU0Hn7fvAdE1t2YkxvHX2rTYC3IgKfWwyWUJQrKE6b1G3dMfCV5M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCO-0000000037u-1Lxd;
	Fri, 20 Nov 2026 19:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCM-0000000037B-2we0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mbGnKAp+/uoEUYFsbhBhKsHA4EuYUn3ARkcgmcWp3y8=; b=Gx6Z71XkBZdIIu/7hY2V7xOWho
 QZJ1oImOPHrYNZDbcg1etI5CWxBY53STN6AIBI6sz2ZyTehBhqg1BcI8RyYx0qdbh23+S+EPqaYgk
 SD5pYs1Kr37QgVELVgW7pR5iwrq5ERyA2cv4AJwvBco6nIZV6mJQv50q/yUDa2FyhWaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mbGnKAp+/uoEUYFsbhBhKsHA4EuYUn3ARkcgmcWp3y8=; b=jnmA1j3M14qt7Xsra+7YKGDjGi
 Pw9Q1UdCWQODNsO7W6hg/B/lm2usFFwITCEmyhgTGhE0JHPrp2zBwpJGLVia07EL1mtk8ZBqoFu32
 nsGYMbH5tqgHPImiCtpmYO+RPr6HtMPDQOmUZQAz/y5QkK0wDEcvqbpxhA9SSGolHPqw=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCM-0000000017g-0OV2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:02 +0000
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuum1499240
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=mbGn
 KAp+/uoEUYFsbhBhKsHA4EuYUn3ARkcgmcWp3y8=; b=WVSF6QWbuRsara/+2OAQ
 ObT8cxnvTZj7tX9d2rXvkhPnjHNnn63sGlayQ9j8Yhy4JJ/QT+EUbJ3gQEW7vxuF
 IIEMXzUStBlzGMkKNXTzjCNYcad2YZ1bNeuVZll00CMEH5bpdOrwoPEiKvEqRZoL
 8Wg7oDw7d2hjXpbz2VDIsdfAgojYUryPEUN2U/so3WmGG/xtIFBHdTdEkW9A/paW
 aRWdu8tB/toZRyTiNqdSKiAgolcvCl1k/Dr8opuo8GetdWXu+GATWzQQMIAMD0vy
 MhdT6sUbirx+SGKMx8SWBofbenc0PtPzn8tcDT6h8wtcoMHfzez299OZM99ql9Fi
 XQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2se8hr1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:56 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92111028a03so26407406d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202575; x=1795807375;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mbGnKAp+/uoEUYFsbhBhKsHA4EuYUn3ARkcgmcWp3y8=;
 b=knsJ11ptjEPfsFpzRRDe71LZ3Wjchzt3GzEjV2aEx8Ux8G1D46dXxsbsjF6GLeMbFE
 trJRX3TY0MivltB9NUtMo6anoSlCOIg/TZjrdbrnLxrcubzbeG0GJ/gWD3y35GRkxHyw
 q24kFvZSdRwhZzZgo1w93zXR4grqesLT9qTeX8s+4kge2O1nK5o7bU8KryOsg0sQ9ihm
 9u5f2ABhQFeCdaf9m/ODISVO2UYRJNOoAA84VVlzqXdetIsnuMnYli/IFMpaUPrdTK4e
 2hVJhunDi99aLi4FGGCVWH2cfTj5rXfFlDwgxL+dJ5bNIiUD39+b0BRLi/Ot97FE+gQH
 kUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202575; x=1795807375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mbGnKAp+/uoEUYFsbhBhKsHA4EuYUn3ARkcgmcWp3y8=;
 b=0qvEvzijng5olFmZkcljVP2E4r6lq9xJ6MkMbaZ5Nd1XrEwfO7OooCSG98tthq92Em
 SbzVkfkJat/PIDIM6+i5vzf2TINyWg2FaFbiZCdLDYp1v5OrIkbTFw/VpXarhzjvzxt1
 4yWo4rvJmPWkmvD2GkkhGQ/ZmKZPbGqGE/7yUtYWIWbFc+6DdwY5t+VfM1unNJ81a1nH
 grbfjWO1uy1+j9rkUJ2JD08fMUToo7QI07RHtK7XXfMPepJzsiTsw++D5Rd74l7bHRjU
 lEDKUwTqs3T1N2SFaOhOOZTDO/e4TXnYziVwjhu8rZDHRitvle3it0JooZ71Drd+0U9H
 6itQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHASV8wdViM3oP1MP3vimaY33u4i6vPZoa4cak0omQTKwx60NPd+eR4gG/JihRvkXV3I5bZohyLOuEHj6VJAKmn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/C4A/nC5mNALN6mo3i/ZTj2jcCf3Oh1Dks5TKRNBXYMr53rTtB
 SSGmGhZ3fiZFfXcQlzz1JUGTM4Onb0o1EK4497fO1favhiWUcOPfAcWx9idWjnKNOvjERM/H9Pc
 eOxLPK5kAkD32TfY4rqcZE1cO9TeZSfxTmUsY8NVkqAcYhrYrQ3YCjGVTQXeqvZyNAZb5EFyTIU
 Q=
X-Gm-Gg: AZFdTZcnML011L1p1n+ALUvunRt11xWJyhAYfYawdTltLNb8v4bYWxlIV7ttaBS2vX5
 22eyjnN2B56GOKJuWNFX9wsF0T/KG2c7S5sRk0MTKEaeOBTNrA+7fFX4XFrC8gQ6qnKcyMZu1ru
 eMuZWZznLINuL+0MCpzoZVYyC+uND2gNJG4Jn9QF3uiNnUNALsAF70599qCE8e4aTGZT+9m5hc0
 DklOkFH71WIWCTbMaZHxex8B76n9zUD9M03pY1tY80QNBgQ/UkPTzdxNh7NHMpkzoVTDw5CVA5I
 h3V87p6ca4GxQQumyLIIAE2QnOnXL53CCuOQvo+PnZchK/LQbXoFAeqaWhQzr92Jl303ZGUkhM4
 DfFgm70XtkqEZ1HAKYv73l52cXS5gXrjwj/0IvpHMW/a5Ld+fdRuaL+8AYaqmqOPCT9Grb1WLST
 w0XejSSca/XXTq/sjVHoAo
X-Received: by 2002:a05:6214:61c4:10b0:91c:50af:f6ad with SMTP id
 6a1803df08f44-92134b3e3d0mr55526926d6.50.1795202575748; 
 Fri, 20 Nov 2026 11:22:55 -0800 (PST)
X-Received: by 2002:a05:6214:61c4:10b0:91c:50af:f6ad with SMTP id
 6a1803df08f44-92134b3e3d0mr55526606d6.50.1795202575332; 
 Fri, 20 Nov 2026 11:22:55 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:54 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:17 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-14-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1289;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=gDRc60RbMU3GfK9nQbx7uuiYbALuxJwjCg7TukCV3MM=;
 b=PG41Eq2Hpy8CDIPGbgD/MFcx17hbxWKAi8HrRdIMrmZDeeloQz0o7nCDY6fPin10gC6K+O1w6
 T8unSfiwqhvAlSgCIIbcO4Bv3W0tJwXI4XDjcn8BI+SPNh+FkRGnk5R
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: hcquHmFFvuYFQENQZKvGfxd1suZ9Et6g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX38yE3zKG1WFq
 AQcSYX48tpuYuDXqRfyvpzRVlvP4Hy+I9dwlJmNHyvDcIO4SNOxFNKbkeTX3mxysxdk1nUrT2xu
 3KwjS84jRK8a8G552oY83wiX6AmvSKGXfGNA63ZakK/VXJvjIusM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX/qmX9WA++oI5
 FO9HscSOvc/ImHimpuhKaBBK8oscZu/4nIVHSbk0mQSRg1e3aMqmLGyeHuCdQRq1LIwPln6okuv
 l5Ouzoiko9WuzepC3F7AIjzDfXQMCI4IjJF5xa0onUwROycU8q5/AGPfergxJq0OACZCuigjKEe
 ZXHADmUFwYAdg1mczusFL5K7J0FG2hNqb2IRAt/HJYrzPHSh8l3ap/zvoh9VN7mzRAUZHfoqnNH
 nN3l95ouZ58EragewTn+JIbo94fE+0tOYgs+230v28xuoUTp5+Vm2qrHY7wW6C/0akyPAevhCO0
 DerL/oJ8m6kPAj+Sr0h7ZUKXQZexh8ioa5guS5YRfLmqCmYA6oS/o++T0v84liOveo98CeQtXLk
 7GnK3fFrHEaacz5hag9RSBkqyBN8rmfbz5mmBrZE5D51xRx/+RwmjVPC1SgU8uPpLtuZf1Cg7Xi
 uHIXz0QhxYWDHBXg3Vg==
X-Proofpoint-ORIG-GUID: hcquHmFFvuYFQENQZKvGfxd1suZ9Et6g
X-Authority-Analysis: v=2.4 cv=VsS2kO2n c=1 sm=1 tr=0 ts=6b009e10 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=hodrbmYOMPYYx68H5-EA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=10 bulkscore=10 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=10 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCM-0000000017g-0OV2
Subject: [f2fs-dev] [PATCH 14/28] f2fs: convert
 f2fs_write_compressed_pages() to rfolios
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

Read the cluster folios in f2fs_write_compressed_pages() through
rfolios. This saves two hidden calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 253d6b3f57d5..3484ffde8f88 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1481,7 +1481,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			goto out_put_dnode;
 	}
 
-	folio = page_folio(cc->rpages[nr_rfolios - 1]);
+	folio = cc->rfolios[nr_rfolios - 1];
 	psize = folio_next_pos(folio);
 
 	err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
@@ -1525,14 +1525,14 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	set_cluster_writeback(cc);
 
 	for (i = 0; i < nr_rfolios; i++)
-		cic->rpages[i] = cc->rpages[i];
+		cic->rfolios[i] = cc->rfolios[i];
 
 	for (i = 0; i < cc->cluster_size; i++, dn.ofs_in_node++) {
 		block_t blkaddr;
 		unsigned int r_idx = i >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 
 		blkaddr = f2fs_data_blkaddr(&dn);
-		fio.folio = page_folio(cc->rpages[r_idx]);
+		fio.folio = cc->rfolios[r_idx];
 		fio.old_blkaddr = blkaddr;
 
 		/* cluster header */

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
