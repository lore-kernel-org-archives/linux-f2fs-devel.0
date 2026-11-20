Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD14606A6D4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aqXqdrX2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D5ELswc/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kfrfT9YC;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=cyftsDRE;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ZyV88sJw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=y/klUBmtPB03p+BUvWQBMrDP/HjTY8qLFdGwtts4gnM=; b=aqXqdrX2dyfxATmih75yfoSv3q
	DvNxvoFIRJYhjSeyXM8pBWKZicvLYZhG/+yI/pQbOLS8YFXOZEbzfFYdyhwgMTlF5RNwmGQRnBXdh
	zZjiu6+SMGWYUyVexC8gTsWXtf6q+CG/lfvxw2l4np/+ic4j53DwmvdzjcyXI8rvxHXA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCY-000000000im-2spo;
	Fri, 20 Nov 2026 19:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCV-000000000hS-0FE5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=68w5jazgBUeiD/VeJC5dZhTrtiiRDpyOwu3XddHl/Bg=; b=D5ELswc/hgRzjv3t+DXsBFh/6H
 nLB1TgsSd/+xoWkj31SEvNvCJdaBHU+5YW5A5nPDdM4QWaJ6NG9kKe8x0aibr5C8R/abQ1pNTCRcH
 f4muVPWpAY5SV+G8KuYcuVFRbZWxe3vdlaPmGKdHH3Hh4JpmwUuZYqx0bILI3CctBkjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=68w5jazgBUeiD/VeJC5dZhTrtiiRDpyOwu3XddHl/Bg=; b=kfrfT9YCBLt8ilsJ00FdTVvpoG
 yKwR217eGPVaHeAwxB7T0L2haNHlUgDgvnkL9yGbxlEKqr69liw+c5m8p2aQ0+0UXwhqsIcyPzBJu
 g32IP9bvt+qF5U+l9utlH05NTB/Vyay+NHHPl+V6+dwyj4PqnzZBj91Atjz4ikPbSrYM=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCU-0000000018J-1ttv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:10 +0000
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuvFn3421321
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=68w5
 jazgBUeiD/VeJC5dZhTrtiiRDpyOwu3XddHl/Bg=; b=cyftsDREJdlu+xdvplpr
 qXz5CXql1yJ1IHaWKA4cKzyVg/rkLmkrGfoV5M20RP5MCuQB7SAtCCs0+tpjdA9R
 oSXILEM16V+MDpNaW65sKQvAQwooytvWGxosmZaYh2mJzDH7wZzdZUZsEV4UNAL9
 KDX3Lt8ABUs5Vy/bJPYK/rUcPjOfAM1uZussV9UOn+KY5L+PSmMEL5BlodeWloLX
 Wrqpb9uyuDMe8blFug+8oKv1i/xc4I5sMHSQ7H0RB4Kup4QVqKVkyHj4hbjeuqxD
 rc+7D+E8USPxW3UV2DMAEvdMLYZ5kGzga/1mUSlpEopPn9AnzdhqraQR8mhAUxrI
 6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rym20tj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:04 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d33f412b1so25028001cf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202584; x=1795807384;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68w5jazgBUeiD/VeJC5dZhTrtiiRDpyOwu3XddHl/Bg=;
 b=ZyV88sJwOwLpGQodxLKZTWPKSjRWJkIYN/7VD/vIzVbqccRau4D77b/0De0zmlXBuy
 QDnDW0KS4e5UIaPFRkGzsp1Et9MZ/2lOQNKAEnbv63ZeLSGmivfbWTxbDSSNWAadHHeh
 zPHolpggh//oejATyEKgod0HrZlhqb6xs/gnBt3+X5mZyVqDD27dz50LcaboZpqANmo4
 lRo+G1ufaaRKWS+Mf0BAEiTnvztiXWoGUzr0Hv4oDFKbcZ/nUrMjWRj0TDqc3OU0ndS8
 QfM6PwIBINCdW9y3pjx6Lsl44avvpcRd29lK6pKm9H7LJWGWhUoTdSe2FDvsM6npgRGd
 yaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202584; x=1795807384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=68w5jazgBUeiD/VeJC5dZhTrtiiRDpyOwu3XddHl/Bg=;
 b=gptyieqSki+O/0P/QuzD+/EKWUGPmGN1k8Om5va47Hi94U3MhnyTkskQ2PYl1uiQq/
 /A1T4+LT/WUq5Qi3R7suRES8M+UeT+Qxi0vx3MDpPxXckYkYTw9HZCBLZQJyJlkUrBTX
 kgiIexwGk5W3+6FkneKVMBy4JwYbMQUXdQUxMPxC5Lu0T8N0pdhzW3K0ANwc0dFNDgMj
 36IddqVhvPGwIhclZNJoE+V9zNq0vnfI03COLPsQhQkKdFG4a5TS8yEmNKHwGL8KEKWY
 lKz/7v24tZ3JF8tt+ANaHWUmnIOGw5LJWc8WpnoqJ8Ghr20q7pcLXyraGQB1xW1UGCRG
 zTug==
X-Forwarded-Encrypted: i=1;
 AL+hErFMBKrV+Y8kuUpXXZhdZM8viX5iRdOrV1CXktUQGZYNphj1BQUg27qaCFRlYTbi36wn4V+SsSF9V3nK0ufEUqrI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8UaGZi/CcazKFDUd6gGFjCWvR8YyAlUC7zUhtpK+MC7F9UzpGM
 gCRMEzVSEnnW9HiIO7DFaDiWeg0nunPiCEJOR2mTy1tTUCpxFa5HYgBoYwXUM88K3rJTI2WlA/n
 iPjqyjo2FpGDa08A1o4HVYTo+rdGzauYb1wtogDdH8qVx7Sn/RdFGamrlMO3alknH5a+LK8Wd/K
 c=
X-Gm-Gg: AYBFou3AEvxspmLWw3/vtNDloN1Ua9Q4WZkWOtyBmVeXv5LuZ42AbYmDhNQVo8H8i7b
 05ipOoApDJ20CyldqjDqC36XwjDHaJbxGygS32RgsKHbW3gYKpX2+6KUD3lY7bDr+YYjNA8gQu5
 R+/ToIfy8yIhPVDcL456vxIjE0HL4CcyUINTpS8/8ElKx5AZH0jiIE6iBoCTXRuUcpns126qNYg
 s9nRPfkULqwrJpV1C6wlP/foKJpIKt3IbnNxV9G1/5Yn1RGkbgV+luoPZoELyHEL+behHqSZRJg
 X9XTOa9XHjpo4mjYpDCqdcnM1mAgyUcqpDOse1kp+yfvPrmqjuDK32AVxcyjt7qvivN/6muXZmn
 XgtvhwRa1tuWlxZyoKtW4/fKv1KcQgmQCWXj4GPkLFhkAqzTLbJl4qMQwYwhVtKEblBZZzhmSJF
 533NqR5cZ1JbeHElQcGyv6
X-Received: by 2002:a05:622a:1f0a:b0:532:b3ce:f38 with SMTP id
 d75a77b69052e-55d768a4649mr70267511cf.4.1795202583935; 
 Fri, 20 Nov 2026 11:23:03 -0800 (PST)
X-Received: by 2002:a05:622a:1f0a:b0:532:b3ce:f38 with SMTP id
 d75a77b69052e-55d768a4649mr70267231cf.4.1795202583486; 
 Fri, 20 Nov 2026 11:23:03 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:02 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:23 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-20-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1377;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bY/F36GSsrQSxv4Sy09Ri72jVgQ1Hfwuq0/APUBbrV8=;
 b=gQJiAXBKg1U1/l/32jxUUdmdATEoxA4lfczKByco+mx50lMJoPBNW7EV5EV3nP7RxogFrPa1K
 QpzfQqytvj0AdPPe+D/zB1tJZHLXFT08pb6aGuDJJeZ5bkRJ7WBx6UJ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXwM7xecsgAo12
 OkK+L7ry1XruZ0x66KtiOJBxLo+kqsYSIjdsRAiG3AgxHVXwDtB/rWhznm9N2ExdJHkwVPbVhzm
 DxYKCW3xNJYPNHQLYwT6TfAwdlL40tKy3N3SGZ+IHwFVh4FOz6OXcTyTqQp9d/O6+FOHbJ7mnxT
 daQ7eO1ZYVz+CnwdjT/J/8h2c2OROoE7rwMgcrTHdHMQkD+Vi4Z/gHyRjOt4EedoM4j0e8y15y2
 tSXHGD4U9mlLHeG7VJJbFYeWmPVOx73hrdfIJGBCjseS7YoU2CZYvTo8gi7g5Eqn5NL1paUCHsR
 C4mC4uJVaUfpfOoaVIzv422+693zuvwywwyMPvr+veaA5t6DWxA8YTJEsBbp110aaNe6RFYAse0
 RpTqixua3Cv4rIdvJGQO6ef/sTt3r7jLNrufS60jv2gYUmIrF6IKiYa5AvuUg7aHlLcRgeAudox
 SxNIjQDDfi53JgJ+bww==
X-Authority-Analysis: v=2.4 cv=CZydd7rl c=1 sm=1 tr=0 ts=6b009e18 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=1uWakOJVf5zxh1ct3dAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX/t4VaP94DNwT
 wFC8TY21gX//B2kWedHKXKzLuH4M8z1TpSbPoZQWp73ljiQLNlwlgUZ/grmjCmn3yMHtC9/4p9g
 +FMgAR2tkUYv1l8XQXgfyPPMO7iW2pkvj0lpUbNxItXlpSdtVOd+
X-Proofpoint-ORIG-GUID: tUIXZPMcMtpqKGwEDP_1ZP4LZen9ZN8-
X-Proofpoint-GUID: tUIXZPMcMtpqKGwEDP_1ZP4LZen9ZN8-
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=10 bulkscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCU-0000000018J-1ttv
Subject: [f2fs-dev] [PATCH 20/28] f2fs: convert f2fs_decompress_cluster() to
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

Read the cluster folios through rfolios, and compare each tpages entry
against the folio's page to tell whether it aliases the cluster folio.
This saves a hidden call to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b2622a51326f..edc8d4833692 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -820,21 +820,20 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 	 * the uptodate (possibly dirty) blocks is kept.
 	 */
 	for (i = 0; !ret && i < dic->nr_rpages; i++) {
-		struct page *rpage = dic->rpages[i];
-		struct folio *folio;
+		struct folio *folio = dic->rfolios[i];
 		pgoff_t lblk;
 		unsigned int b;
 
-		if (!rpage || dic->tpages[i] == rpage)
+		if (!folio || dic->tpages[i] == folio_page(folio, 0))
 			continue;
 
-		folio = page_folio(rpage);
 		lblk = f2fs_folio_lblk(sbi, folio);
 		for (b = 0; b < f2fs_blocks_per_folio(sbi, folio); b++) {
 			size_t off = F2FS_BLK_TO_BYTES(sbi, b);
 
 			if (!f2fs_ffs_test_blk_uptodate(folio, lblk + b))
-				memcpy_page(rpage, off, dic->tpages[i], off,
+				memcpy_page(folio_page(folio, 0), off,
+					    dic->tpages[i], off,
 					    F2FS_BLKSIZE(sbi));
 		}
 	}

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
