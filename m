Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13865606A337
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dAFdw+rx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jYyMM8jM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kkt7Syhp;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=JgAC3hrk;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=vUtjB0x3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=12s4ERARyg0dqUFeIRteOYXPlfTEWpgvepQgXA04GW4=; b=dAFdw+rxc0hYQquz7IJVHZYpmR
	Sa8EK5Mdw3Au8voxyg8ag9dOzfOI1baw2kKOH5ztXZ3k49n+MUU67z/Nop4qAlMLHWva1uyKsRRn3
	aM8XBr26W1Ppic/OUtecpp5qvTc1quaPWvTtxYBsevKetZnIXHht9vftCjrp8v+s8rHA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCK-000000000Q4-3Jwp;
	Fri, 20 Nov 2026 19:23:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCH-000000000Pu-2zhZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Na9dAlwpQqkP4mJ+/22PpYI4/6C7XRHSdNFg6K5Vz0E=; b=jYyMM8jMIdbv2a/1iSN1S2Cg6f
 9ir8dfreyVCsXpXK87LiISyWgRHfD/Yk/wH1yO5NKWLIcTuzXjCV5BGGvk1JwCqb/tISJoRdof9NF
 QpnuvubLrhPjJRfvnhMQovtlTvRWB/h5ieoTnf4rioknsC6x7WY42eaEQkqxVhOcUC2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Na9dAlwpQqkP4mJ+/22PpYI4/6C7XRHSdNFg6K5Vz0E=; b=kkt7Syhpq9G3/cxRiAjx4+Rgwq
 yB/xR/5C6bSOsJhWddhBxDVgGcFPkg12KVBQIglro+IkEFBCmvaPNOnhT9Z2RLyhW/N7W/8S64Dol
 oTmMfbiyRkmnrwneKloiDTDHoS+uvun+hP/4ygYFgMpLWds8gt0Fsw3m4XLNvdpierPk=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCG-000000007CW-3kiP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:57 +0000
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIusuL499225
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=Na9d
 AlwpQqkP4mJ+/22PpYI4/6C7XRHSdNFg6K5Vz0E=; b=JgAC3hrksjhbz8L70Sj1
 yaDR1ZFKptOuOGQQpxROLa0JHTaD7zg+CK9Om4jlHO8p14iSHswPaqa0fX7jCaca
 v00QsOkGI/grZ81UqP1RS27MsXDkJE+3Rz0C1ffC5T+I4VenUqKIloJQt/5157GM
 wSRkkhf44qz58j9KSn/pkRqLVmnDGpAuZKKmF60AZY2fHENrhVD/MEQQ2I4AHzvk
 GwXol5ySDtXbAN2x/y4Gy2OqklHmvSIBZiwf1dgSddpmxql1FHbGIkHKkzVygKOd
 shwY7shKmOB66vyBIo7YAFrHTarRiRuCOx/r9yuxivubEupdzrV9y9ohoerTpNNi
 YQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2se8hr0x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:50 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-54af6c38092so17579991cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202570; x=1795807370;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Na9dAlwpQqkP4mJ+/22PpYI4/6C7XRHSdNFg6K5Vz0E=;
 b=vUtjB0x3wYwsgOaAPuhBdvuWBs6ondHiZ2+/K91302YoCGtR3KLKxBUSIeJpO4mkTh
 mYyG7hfv5eCHXdCiB9og9c80Cp+ym4rw1LGf/Mpp/cmIiaZ5fh2LhoBQ7OfUA20T2p45
 m2R8UYgFI+cqJjRm0mNXT5qqDGigRD+UC6qMEnFciltDR8UuLifQRba6/k5zK3Vm23Va
 gSbZS29B+G2888+56HYinU/LMzzMlUHHA9mfz7MlffNtg0JxZVZ6HC15WFH2HuHQHXmE
 gIHckKUKlPduTlPtSBmpUTFdQD6Xb+MY0j0j0sNmEQrdvR+CE78xZRIqvKJYeJgvijVK
 6Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202570; x=1795807370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Na9dAlwpQqkP4mJ+/22PpYI4/6C7XRHSdNFg6K5Vz0E=;
 b=WhZKhykY32UhnM1ahQTazk5w5I1AyyS4YD8rZXhFNOA6h1lZsfQ4dm1POfcYjTvPvE
 KC3L9TV1TlLKJdzG9C3ZNQ9T0SSsxtP81sbThqUQiqBUf3WAysjYH4ZCn5T0LKBjsLtO
 xNdJbr/K/qglxAJDv7o6SCi3w12t7U2RLsPkcfe3H3f2xCp2KF3Nzv+p6QcyloUCb6jD
 z9w8c7IUMFFnZyqUMDIXsZ0cqt6TrYAPgLD22KOnFB18TdYlXz1wV3KwUc6FO/x2hO24
 X4Mu2vj2A36TMxFHREgS/3BIJpY9SIa51GMc7El0d8iYsmDEhBds5Udr6NJyi0EOIIk8
 67iw==
X-Forwarded-Encrypted: i=1;
 AL+hErFXhmo07Z8GLqoC1Nd3SvWaMPvGUskGsWTvWfWmte3/F0QDQe3ikKgKxCsH43v07mUFnvQhmoX/qdb0u0hEQOif@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9md/UUzoR9TXyBfYVI+osgXbgMw02RlTnGGh1gNEUWyDlRsBoW
 aHo8VuPlEls1m3A6s4kXTj64q2Qblwxe3luPt7QW2sLALyjwfQ3ReHPLQJvEPpX1IHbiD5GvH0P
 oslj0313USk79f8XWCup+nM0kisMo0lhrqKOMXKuzcQukdePCeDL1Z3Ts6bidK6SMFFDiWn4+hS
 0=
X-Gm-Gg: AYBFou0JZL86lZzja0dpsiIQA11hNelNoMbOYhT0OLTg2Bt3ubEBPm/TJV+ygXeM5lE
 FrWwVG7Aqg1tVIUjRlh9sAepL15KLlf3QF1osPuCwc1utCIyuNS0BYagTsi/Cb4jlSxyvWTx8Ai
 Qcw5wT2psRCc2uVOO6x1nO1PL030j3C20OHN59ijBozt/q7kO1fEQrkdLn9XS7rt0C9vYrfSXUA
 ROM4fnH4lNLa9GzVEnwz2YMDjNU2jTklWbY+f6xgpWOGM9dHYTnn5p+KnxxTaIs4nI7hG7dw7tf
 +ZhfdTs8vydnC4vOTD9PtqpXXifbOS5vr5AgXZsQuq/b6AW8FqLrABpfUfaUSTUHrageaPH5gac
 eX9ATVKtkjvhWmikhgpt+YZ2jgDwc7DIUxG+aMz3GbjFUrk37mivwGJMmTBOJuhNZSt141guOnC
 lokNJwUfZqPaH9bGEC4etL
X-Received: by 2002:a05:622a:2609:b0:55b:d65c:665e with SMTP id
 d75a77b69052e-55d7688cd55mr81750821cf.5.1795202570214; 
 Fri, 20 Nov 2026 11:22:50 -0800 (PST)
X-Received: by 2002:a05:622a:2609:b0:55b:d65c:665e with SMTP id
 d75a77b69052e-55d7688cd55mr81750431cf.5.1795202569778; 
 Fri, 20 Nov 2026 11:22:49 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:11 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-8-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=3321;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=gZIKDEhtdM30E8azr2oDww0VFFiTPf1r+/YA76Q277E=;
 b=vvwHdjVnG9CTS0ABNs/28OyO25u66OW21IPMDGX1biTd90rmM6NXNeueM+C5ibHkIs6kSy1WB
 uOvAGUlw7LGATKBhexU/LeldJH0UA1mV5nWS3wcXeSBqTnnuxlnDXM6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 4Z_L6fJxco2rtIVqAtc8toFiVt63izQ6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXyouzo9w5pQuA
 KaCKPPhI455un/kU0xHoBc6dYr+OfXyzFuOgIsu+NTtBL4N7cW9hqpoGB+iL6iDDoQVcwOv8g3q
 6+3UESG0FGEHH7JfWD6i5UftOe7/SGlCzowVXAHrH+rrSIGZbRp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX1EGUyi688nD5
 6hO7GNtoIwG4DZ6je1V0m1NWtro3zAC/I//Yk8njhySNfhHWK0HO1PYQhIFQQ7zunguiq+e0s5c
 8fhE8mu3hm4EeLsG6pp8YjA+fWxVnqyQ1AuDNHNY+oFoCO+25kF3sD1zbjU3YoDcTqy4eDs6tSp
 1q41xVjHFAmDEO46PqyyZg1N4S8eqYOJ8Egyzmtzzd8I6E26MRaOWAZB/1Fz6fHMaoFhTtYg9iT
 s7Z1WXHp1ohtdgMym+FfL8GDJ3yT+AwSEpED59qk1wHzvUJeLhRGoBJRmkS7bb8DjzKWD0X9knk
 iJQidGfFN73cHkW7+RTsmabXH7FSbPfjsS4SDpsHJrjQim7qwueH5rhJ2kpVYEJ52YQzuBAvujS
 fAF1Lb1TqgnZdPrnq4A7GlMdtKVR82+HsVnPI+EfANL9qVLZItZjeuUgG5YqvKY0OVOAbJBK+ZY
 7fByUf47HqatXMbST/g==
X-Proofpoint-ORIG-GUID: 4Z_L6fJxco2rtIVqAtc8toFiVt63izQ6
X-Authority-Analysis: v=2.4 cv=VsS2kO2n c=1 sm=1 tr=0 ts=6b009e0a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=7Y99GAAVe_Lhl2P3Q-0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=10 bulkscore=10 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=10 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCG-000000007CW-3kiP
Subject: [f2fs-dev] [PATCH 08/28] f2fs: convert f2fs_compress_ctx_add_page()
 to store folios
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

f2fs_compress_ctx_add_page() takes a folio, then turns it back into a
page with folio_page() to store it in rpages. Store it in rfolios
instead, and rename the function to f2fs_compress_ctx_add_folio().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 8 ++++----
 fs/f2fs/data.c     | 4 ++--
 fs/f2fs/f2fs.h     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d9fbf1d75bb8..14e577010e34 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -168,7 +168,7 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 		cc->cluster_idx = NULL_CLUSTER;
 }
 
-void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
+void f2fs_compress_ctx_add_folio(struct compress_ctx *cc, struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	unsigned int cluster_ofs;
@@ -178,7 +178,7 @@ void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
 		f2fs_bug_on(sbi, 1);
 
 	cluster_ofs = offset_in_cluster(cc, lblk);
-	cc->rpages[cluster_ofs] = folio_page(folio, 0);
+	cc->rfolios[cluster_ofs] = folio;
 	cc->nr_rpages++;
 	cc->cluster_idx = cluster_idx(cc, lblk);
 }
@@ -1250,7 +1250,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		if (folio_test_uptodate(folio))
 			f2fs_folio_put(folio, true);
 		else
-			f2fs_compress_ctx_add_page(cc, folio);
+			f2fs_compress_ctx_add_folio(cc, folio);
 	}
 
 	if (!f2fs_cluster_is_empty(cc)) {
@@ -1282,7 +1282,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		}
 
 		f2fs_folio_wait_writeback(folio, true, true);
-		f2fs_compress_ctx_add_page(cc, folio);
+		f2fs_compress_ctx_add_folio(cc, folio);
 
 		if (!folio_test_uptodate(folio)) {
 			f2fs_handle_page_eio(sbi, folio->index, DATA);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1a6803835957..4489725efb57 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3669,7 +3669,7 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		if (ret)
 			goto set_error_page;
 
-		f2fs_compress_ctx_add_page(&cc, folio);
+		f2fs_compress_ctx_add_folio(&cc, folio);
 
 		goto next_page;
 read_single_page:
@@ -4645,7 +4645,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
 				folio_get(folio);
-				f2fs_compress_ctx_add_page(&cc, folio);
+				f2fs_compress_ctx_add_folio(&cc, folio);
 				continue;
 			}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 48f9898af48a..fb827034a58b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5027,7 +5027,7 @@ bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk);
 bool f2fs_all_cluster_folio_ready(struct compress_ctx *cc, struct folio **folios,
 				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
-void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio);
+void f2fs_compress_ctx_add_folio(struct compress_ctx *cc, struct folio *folio);
 int f2fs_write_multi_pages(struct compress_ctx *cc,
 						int *submitted,
 						struct writeback_control *wbc,

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
