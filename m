Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B6606A6F1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jb4XSJQe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OzAUGU96;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SN6S4ne4;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=u0YDEn3z;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=x4o1pq+M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=OBve8ZqSZRlP1VJoQLPrvVlo0l172pe04eUlwOFdAqo=; b=jb4XSJQempNJnWCmnS8gySTBYD
	XjClbdceOjz79oYvSvJIdJoE8rm1h3Qn7mCfwA6ofQcLwN2Fv0+QHrAOmE0z7EfRKxBD+HAB02NlN
	sRFSyNurvOywOLNCbVBxUoZIFgy6g0XVL7sndhu6p4pqjCkGzugCTQhsHqshFeVb3ZPM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCR-000000000Sk-1bxD;
	Fri, 20 Nov 2026 19:23:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCO-000000000Rx-3gcv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GwxAxEDZy2abCB0fmumOOp+iDVkSgQG/UiR4P2ytg5g=; b=OzAUGU96cB54ytDZtk9uRyQILL
 A+tQBUhM8ThmXNc6q21to+OsXUBXumQfnhrpOuNOebiq9qM8SwEbRVZkGaAbnDD+vt5AeYCvEjo98
 hTPtYlh8XjuV9sRcY9Vaf0u/9K1mOPwD4hE8gN8v/yKP1uu1b8UfECRRu6x874DofV64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GwxAxEDZy2abCB0fmumOOp+iDVkSgQG/UiR4P2ytg5g=; b=SN6S4ne4Y0aBZUY2/hNK9EZ6tI
 dbltjv6iRQJfGqnfV77TwTN3AvMX+WYb0ecZq8Jg+njYLlf/xpgHO1WMxcsrAQksP030krOCm+a+c
 j9XMhfmzMrYo8BbbubJEfk0UEsRKkVHHK6V0x0V/HIK4Em4aHXr9395g5AoHoNkDdRp8=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCN-0000000017n-4BR5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:04 +0000
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIusTh3664541
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=GwxA
 xEDZy2abCB0fmumOOp+iDVkSgQG/UiR4P2ytg5g=; b=u0YDEn3zvhtXHPB4HO56
 CTTJxbDjxt0Qph5/Q6yL/nODwcXy/eYWJnqfuyOs3rlQVt1ULMJAwOeY7f4Rn7/w
 ULV4BuPJuaAXsxTxm2QeQ8nx7VebMF0dxpV7LVWc8j/n2ZRCbwUgS3EtY9mKB9BL
 2c0bcSWFOXmfdSbk+M+Gr3Sm2XMo5D9udqZIdbz3p3bPQlhFrQ/0hpQNhyaNBSgF
 quheGDClcnwGhtn4hLRv53alVjdcU09GfmSg2g/aXdBeqmO1ard+HD/1ZzjuKcqf
 8qNFHx0slZ9mnLnLUtwRtDwHhsKqRzUB+ztQHKFeAtvA1CFxn3BAvfoYr/fupUNa
 Nw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2tnu0xgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:58 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9213e04641dso14361526d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202577; x=1795807377;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GwxAxEDZy2abCB0fmumOOp+iDVkSgQG/UiR4P2ytg5g=;
 b=x4o1pq+MdmqglcbydCZUm9VuBktnCA3uRsePf4aPrflHB6aF48ZPGHc8Oc78+KFRLe
 SxSQ+JQerzPCzogn57xAOaSOTCc1jbqgen8SI6u3Zl3zZ7ItMIxmF6G2jyI39modvBjf
 Rtekfb79wCtZkIEmGe05IFfTgHxwPRNsyGLA61FjYhXjRr96RtQixE8E8a0EaeGAItbH
 eOyMeW3uyOtmsK9DCdJsBfsppK6pygz2P4PwvX1+FnAc34Ipd9ENEYALZEG8uuyMeEaY
 9WZi3JhRhLppWtpEatGmOKk6GuiniXeU+UWeZWXT/K8TF+bfvomtsQq5/HMKn8gX66wL
 0nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202577; x=1795807377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GwxAxEDZy2abCB0fmumOOp+iDVkSgQG/UiR4P2ytg5g=;
 b=ZdX157VV8W/rHKWxyelU9+o6b+wJTipbr/hlY0q1KljElbCLGVhbtmRYwpinWyTXzJ
 OM5NcXEqNbOQJ5kYXbdjHGmI8Wwr+hBgiWWM+ftgdPuG6fULK4G7Ywp4GN2B2JDNnKTL
 s+HbXl/4U2kFYNRIJTn93NRAbfRuEvP/IkfM7UOODX569q32fkbddPBuwYml3fvtFMNO
 +A9RpCy4kTYLK3NIaqURjUA1A+9igMeWmRsVptIVx2A6JcnDkXjtIWyHNOiYZS0RX+dA
 h42VPryZ2ZQKTOoE4DVHVzXmm0LhcqOsGpFhbCn1O4h58lBtTaTNivJaFBB18BbVpWZo
 j65Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH+TmsVyE1JHF/pdKMQfBFYMAL+Ccv3aL7Ue969I3VGTuZ82kQfbLObWCKQ0s7bKHx4bw7oQm+g2SEIHa/bdECL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+vhmiQPfEqlTaUgDBahSJ4JxDhpLW+HeUlKmKp1xJXnBVoARjc
 MMmlbuoHRg3vaCN4+CI6+8391inAgzha6jNKcsm88EiawppUSctDzbSmvpHrGetztEk7i1Hdgu7
 r9L04vqIaFvXn6l2uua6SHFxJROaUrT6UZDXd1tA2dvFiBBWgr1IByZYUAD5XDCXN39ZeE/bLdh
 vP5N8LVwg=
X-Gm-Gg: AZFdTZep8eApKOCQmyBry2lEIiu0GU47CYGMQRG3Ogm0aMAC7lIf+hpeML06kr/dLz4
 8CJx7NmGvMBcVnGbjk7D77IEqplTgTfdZ5//OtF/kfavW1jAFSuD7y/pYnoCfPXkvWZxSAeKah+
 WSjDJJzHxSN99aGhZP7wTx9uH5ClXSE5OkhnKCkWBhro8LT8vhpHS4ZcKEVUWu8Kdny1bLiFrdr
 7kMz1JFDlvZMtGIQB512bZ37JVCa5DEvnUgeux6pdL/B6hKaIzxhJ9bZpc2Jq++Odm539jpKYfk
 IGgLJB4IblbZqAt+CfgD7nd8fB4Khx/VdVWggnqjfAPRE7c/BVQNdcx1S7UJK/d1VFToLOFG4qO
 p/9W4U3IUIvcIrp41xpK6DX8kPLEgXQeb8bVwarIr9l5JAW2zZbXnKu/BwD+60Htl4jshLwHvNj
 wSZ+aQRru86c9l4qZcK4lv
X-Received: by 2002:a05:6214:2dc4:b0:91e:9309:ee5e with SMTP id
 6a1803df08f44-92134bab602mr69329446d6.56.1795202577486; 
 Fri, 20 Nov 2026 11:22:57 -0800 (PST)
X-Received: by 2002:a05:6214:2dc4:b0:91e:9309:ee5e with SMTP id
 6a1803df08f44-92134bab602mr69329116d6.56.1795202576920; 
 Fri, 20 Nov 2026 11:22:56 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:56 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:19 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-16-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=6163;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=5C5WBY9htYlQGEzY80LCnGnJDa7xp83UKZ28SENvRjM=;
 b=vZeIGo4id51xVGuyoP1zENr5P5q+x+sqxXAAwHmzNx/WbLrz6D91mYhhZWgI5v/AQPUDdqWZO
 oZgd3OyvhcFAAWZwIuCKgdP7A3pI+So/zDSJqdEZYZ72tLebF1b/aeA
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: W4WfjPWZo2DV12Semd92DijymlFHHy1W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX9Knegxo9MARp
 7Yf04XSimOyeTSnnQllMQCfi8mgnFBy5pQmX8N53B+rQDdnhD9NTlZH4ehIJOKpm1yEScv5MUOI
 CwBYajL+csO2pWE8dGXYY9q98QdvM3BBbafy7ztAvRQBb+N/c8Es
X-Authority-Analysis: v=2.4 cv=Dt3Da2/+ c=1 sm=1 tr=0 ts=6b009e12 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=GDWrYEunEdPjiql0F_cA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX06w6SIQ/URe0
 ABmYdBYQzZB1OPzQbdjWH76jD7jMg59jxx7V3pInHLm509d+DLPJv0hDDxppltk5qBm5YvoTIqd
 CZTMqyQsTA7FB6V+IxFysLhVxDuD7B3cnh5+vuF6Lyr297QBIbbIPrjQL7BNUboUn3HuqIQPgOr
 ag+71AYMB2rk886idkkVE00jIGHufaDvH8tcMdq4A2ej9nnN2apC7iNXdjSywSjSZHfY3e331FZ
 9THYNabGfLLL1SRTXk/NraMNbHQ9Jo6f+uYeUP96mpXbQ8wp3kvArymjo+3+HDCWweVmZIKRSUq
 aF1ibKdbtFd1FvWKVO5Oucw0xObU0B36JZxoYq5kv31PXezxDdtFmHLyZS6zXuNGSZOS0+1ftUI
 bBz6wxUybxlGtSrlNjr1se49kj/SjB55z0QzJmlt693GGAyfTSIYLkEnCgOKrghKiGO6Ioedxio
 ox9H3wxh8igx7k7+MHw==
X-Proofpoint-ORIG-GUID: W4WfjPWZo2DV12Semd92DijymlFHHy1W
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 spamscore=0 phishscore=0 bulkscore=10 impostorscore=10 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCN-0000000017n-4BR5
Subject: [f2fs-dev] [PATCH 16/28] f2fs: make
 f2fs_prepare_compress_overwrite() return folios
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

f2fs_prepare_compress_overwrite() returns the page for the block being
written and the cluster's page array. Return the folio and the folio
array instead, and update f2fs_write_begin(), f2fs_compress_write_end(),
and f2fs_truncate_partial_cluster() to use them. This saves three hidden
calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 26 +++++++++++++-------------
 fs/f2fs/data.c     |  8 +++-----
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5903fa034859..3a7b72c7cc72 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1213,7 +1213,7 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
-		struct page **pagep, pgoff_t lblk, void **fsdata)
+		struct folio **foliop, pgoff_t lblk, void **fsdata)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct address_space *mapping = cc->inode->i_mapping;
@@ -1271,7 +1271,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	for (i = 0; i < nr_folios; i++) {
 		pgoff_t f_index = f2fs_lblk_to_folio_index(sbi, start_idx) + i;
 
-		f2fs_bug_on(sbi, cc->rpages[i]);
+		f2fs_bug_on(sbi, cc->rfolios[i]);
 
 		folio = filemap_lock_folio(mapping, f_index);
 		if (IS_ERR(folio)) {
@@ -1293,8 +1293,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	}
 
 	if (likely(!ret)) {
-		*fsdata = cc->rpages;
-		*pagep = cc->rpages[offset_in_cluster(cc, lblk)];
+		*fsdata = cc->rfolios;
+		*foliop = cc->rfolios[offset_in_cluster(cc, lblk)];
 		return cc->cluster_size;
 	}
 
@@ -1307,7 +1307,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 }
 
 int f2fs_prepare_compress_overwrite(struct inode *inode,
-		struct page **pagep, pgoff_t lblk, void **fsdata)
+		struct folio **foliop, pgoff_t lblk, void **fsdata)
 {
 	struct compress_ctx cc = {
 		.inode = inode,
@@ -1319,7 +1319,7 @@ int f2fs_prepare_compress_overwrite(struct inode *inode,
 		.vi = NULL, /* can't write to fsverity files */
 	};
 
-	return prepare_compress_overwrite(&cc, pagep, lblk, fsdata);
+	return prepare_compress_overwrite(&cc, foliop, lblk, fsdata);
 }
 
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
@@ -1330,9 +1330,9 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 		.inode = inode,
 		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
 		.cluster_size = F2FS_I(inode)->i_cluster_size,
-		.rpages = fsdata,
+		.rfolios = fsdata,
 	};
-	struct folio *folio = page_folio(cc.rpages[0]);
+	struct folio *folio = cc.rfolios[0];
 	bool first_index = (lblk == f2fs_folio_lblk(F2FS_I_SB(inode), folio));
 
 	if (copied)
@@ -1348,8 +1348,8 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	void *fsdata = NULL;
-	struct page *pagep;
-	struct page **rpages;
+	struct folio *foliop;
+	struct folio **rfolios;
 	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
 	pgoff_t start_idx = (from >> (sbi->log_blocksize + log_cluster_size)) <<
 							log_cluster_size;
@@ -1368,7 +1368,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 		return f2fs_do_truncate_blocks(inode, from, lock);
 
 	/* truncate compressed cluster */
-	err = f2fs_prepare_compress_overwrite(inode, &pagep,
+	err = f2fs_prepare_compress_overwrite(inode, &foliop,
 						start_idx, &fsdata);
 	if (err < 0)
 		return err;
@@ -1376,10 +1376,10 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 		/* the cluster became non-compressed one due to race case */
 		goto repeat;
 
-	rpages = fsdata;
+	rfolios = fsdata;
 
 	for (i = nr_folios - 1; i >= 0; i--) {
-		struct folio *folio = page_folio(rpages[i]);
+		struct folio *folio = rfolios[i];
 		loff_t start = folio_pos(folio);
 		loff_t offset = from > start ? from - start : 0;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8755323963b8..74a5ef7681c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4563,7 +4563,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
 				void *fsdata = NULL;
-				struct page *pagep;
+				struct folio *foliop;
 				int ret2;
 				pgoff_t f_lblk = f2fs_folio_lblk(sbi, folio);
 
@@ -4592,7 +4592,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					goto lock_folio;
 
 				ret2 = f2fs_prepare_compress_overwrite(
-							inode, &pagep,
+							inode, &foliop,
 							f_lblk, &fsdata);
 				if (ret2 < 0) {
 					ret = ret2;
@@ -5601,7 +5601,6 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	if (f2fs_compressed_file(inode) &&
 	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
-		struct page *page;
 
 		*fsdata = NULL;
 
@@ -5610,13 +5609,12 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		if (len == PAGE_SIZE && !(f2fs_is_atomic_file(inode)))
 			goto repeat;
 
-		ret = f2fs_prepare_compress_overwrite(inode, &page,
+		ret = f2fs_prepare_compress_overwrite(inode, foliop,
 							f_lblk, fsdata);
 		if (ret < 0) {
 			err = ret;
 			goto fail;
 		} else if (ret) {
-			*foliop = page_folio(page);
 			return 0;
 		}
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5fd81b6cdef1..9b7d13cb6e78 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5008,7 +5008,7 @@ enum cluster_check_type {
 bool f2fs_is_compressed_page(struct folio *folio);
 struct folio *f2fs_compress_control_folio(struct folio *folio);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
-			struct page **pagep, pgoff_t lblk, void **fsdata);
+			struct folio **foliop, pgoff_t lblk, void **fsdata);
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 					pgoff_t lblk, unsigned int copied);
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
