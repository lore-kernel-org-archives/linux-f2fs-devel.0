Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4F606A6EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RTe7YKIL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AjCucN68;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QqrDqJI3;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=OIwu8bwm;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=x9iRhb0O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=COe84IVYtM+sEuxQ9wt6swqoRIYalbjX9Zobbu2sI58=; b=RTe7YKILN/pzjBMhDxzGHkYMJO
	wSJN2ynJOlpJSYroZlIEwzUc9xocYsYf0iWhjyHh6EhP5YqBEFt2udCQYi/4EKHAMCwHuCkvqbR3y
	B/pn2VAdycmXPCXq+gNeo1LYGYGXCC0RXJvtsUbnTGXySiV7/D1IFsIQwNqFbCbQpkc8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCO-000000000eE-0cjX;
	Fri, 20 Nov 2026 19:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCK-000000000cZ-0jLu
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ugfhdT9KyzH3B550wrtyCzc/9AtLbaAc0ztqV3chDM=; b=AjCucN68mGuXscwDKXW2W0g4lp
 1sf0oQ34sQwp0iXX+zyiZtP5Cs7tFScrvF6Y569BIr2OifEWyWfFx/thqrvwIduAci+Sp29lKP+qU
 XpOUcsq4k4MSLfru1GdWGVZ1cfZlogX4HTGavO0XOZr9yOfVM33tRT+Sgt+EFlX4CLyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ugfhdT9KyzH3B550wrtyCzc/9AtLbaAc0ztqV3chDM=; b=QqrDqJI3pAh8Jsx07OjBwHMeeq
 +htGBeT/DQujwOcqmhmENztpIyu14n5kucu+MMFEjqJJibe/sVYRNY1bjfyhAv/AVuIjdszgPYY1g
 g14nfjqN+agxGhLzon4rFttwaIs3x5v9SsPddJCgwlzUWXzGvHK7ZKu07ypwy786KeL4=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCJ-0000000017a-2WdJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:00 +0000
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIunxw2977545
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=7ugf
 hdT9KyzH3B550wrtyCzc/9AtLbaAc0ztqV3chDM=; b=OIwu8bwm1gPyKSMiFZHw
 zSa9pG4f33uiNYDei5MnDDneu8rBvg9Atzgt6xz2kfgZPZC6I4ZYUPaU8a0uJNN9
 UMyv7u/iV8UM6Lt7Vfsd0pc4VEnbSmkrLBixFgateIBb3VMjrreJ5566maXYDit0
 0YJhUUl+Bg7VhTO0YJsYJgtveIY/xjRhri7g5v1AVUojS/i3KEQ7mBPPVs9EHJWr
 2SysnLvSkNO99fo10AMV6ViWcbyK6A9vfX1lhVbd8C1rSlhLHpPl2Iaj3V6N0a/M
 puUI/Jn1Ev2wH9+Slo+E2/QqcseDLWouMDQOlg/oIRBjJE4qRy5bfuFA9qjaD8q5
 4w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2r0aaq80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:53 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55bc8181defso24715131cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202573; x=1795807373;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ugfhdT9KyzH3B550wrtyCzc/9AtLbaAc0ztqV3chDM=;
 b=x9iRhb0OhmY8Gzm81TLFr9lzGnIcfTEf6b26EzLIO3Pmcs9n3DaaqZq56ZJdmEEr2i
 1+5E7HV8q9+VxSYasMwtHQNAXlAQzvgjoeQfOnHqG5hFC9f8Y8UpkQ4nU/EAJYea3crE
 UAPLJ3AmSOpUFaGRMlJ0BZxEUhXOiv37GBVzCiv9m2vo4dhEWGYMnCub1XpUjA2zk7Gw
 4rcCoeZnFbmpWt2IxIpJhtiOa0caa7QZGcXWK6kQ3cwG+lHGAMPRBTOFsTJkNq0A2ufZ
 bGTzXE3LF24DWRj6T263eQCyebUSLRI7/yMHWEgxqzSCIEUBQ3vazAJbruzZREmk1J0y
 ZsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202573; x=1795807373;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7ugfhdT9KyzH3B550wrtyCzc/9AtLbaAc0ztqV3chDM=;
 b=amf1iK0Qu55D5KM7JQ1HPxVYg+FkEipq9ZRnlpSBL22VZTu2putYAaR2bMoSl5wssa
 lsGLembe5nvx+tEWg1Ck1zjnSsHR9uA2vmWQNh+xb99pjk1iZWE+PALK/qNKegqwGD8D
 lwVfqkNukjtBw3f7hrjYoCjbX3LJ739STGyC+M1ko2wxU/B6zbDpqALavkJnjuUaoln4
 I8Burm36ctb8J2LXXKf5EcH5H1kt45CTpRpqGJqjwTfVUMz68Dh9pXLlWDHbHMrUecIr
 pKM7d9wfv6lCcqc5u9HtPPjxCYojvyOykbgfgv/Fa8gzkB6ZC35LHzckjqKZALlNuQOU
 KkzA==
X-Forwarded-Encrypted: i=1;
 AL+hErFJixVNDX6AcZFb4uB11OhuTZ7pM25s/ws3KHaBaEpL/97PqNc5c9rmmcokrJzdXsmQzwFnbKOj0bJaEdsk6l4M@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ekuFhnrYk5chD8yOfG0dJkIud/KU7drWtXMVMOTA951JRLLUQ
 n7sizz+5yrTBm1Apo8tWn3WoOspTgjSe+casBU24DXhUk8x6zfMMUrVy/kmAffWCNAZ4hsGy3bh
 K9uujg3StlxKDSnpqgDghQR9ptQiF/qPd8txUuadYHBn1w7yviK39nFUPUoxPBTq/4ZRKrJn2xu
 Y=
X-Gm-Gg: AYBFou0nBvqrI70j27nTJCHtipiV9ktlQgcbXUN0dtrEJ0ZL3yi/QCI3vp0uUtabyO/
 PGWbwFxexpb+xBxtaues3JLbmL0QRnf7flqGblXd21UW3v1vTw1o9ELqFvuJ0EhRkp4zCyy/GYF
 oXssrrGeofpioQtYM3DpL8cZ/XGo0J3abcvBp8dxCIPbcQq+5/hl3iLt9t1EbIk+VKHeojpDA1L
 w4p0puy0nv0YUDgCKSwXblbz3svI3sL1scxkYeTdjQoeqG2hMbSwwTO7X+Iu2lxoYMmOkzqY6zQ
 7P1jM0OZyEP+ADoNMfxGRMr2g8Z6i+RHuWGplKBm79sjEPKBue4MMxY3a/xaVqTzJT9nbpIWkqO
 mHUk6JOBo9utE8behzYHQ8vQewbCIwzhBM702hhiQ0qbxC71xlC5E9o4a0zOLm5h3cLnnVUkCPC
 GLKW5m+0s/iSi4GSgr05aw
X-Received: by 2002:ac8:5d49:0:b0:536:6047:5223 with SMTP id
 d75a77b69052e-55d76a89c91mr75199891cf.49.1795202573006; 
 Fri, 20 Nov 2026 11:22:53 -0800 (PST)
X-Received: by 2002:ac8:5d49:0:b0:536:6047:5223 with SMTP id
 d75a77b69052e-55d76a89c91mr75199641cf.49.1795202572642; 
 Fri, 20 Nov 2026 11:22:52 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:52 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:14 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-11-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1012;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=3gYt552hLBbfm6gBNQYB0mNfZEpVgtoUYAH3tXr2S7s=;
 b=QJUwLcNfdJMjNSUPKMURIvAYAF7GnZ8j7n+0jHv1LGliZ2B7uoVWf0bKOq977E+YxIkMX0Mib
 3QVdd6ezzfvBALYOhcMG5o0OCaabuemi2J5ZyR3s3NodgU2DjyLlpV3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: Ch79mneU8RSihRQn4rw5skr21RPZrM5N
X-Authority-Analysis: v=2.4 cv=ft9J914f c=1 sm=1 tr=0 ts=6b009e0d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=0yNAlvi3j6Xw37SKTNsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX7pm49EozWR1s
 EGXH9b7dS+g/1Z+leDl+4X3m+QHy/+DvWajBxrqY9n3Dv3twqlEHlLFIw6GvXcOj/GnIp6NwfsN
 5UFk7D1BXvDuHkvG0/b1SBIhqePxMNntLKnjXsEowzMn3Nltzpps
X-Proofpoint-ORIG-GUID: Ch79mneU8RSihRQn4rw5skr21RPZrM5N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXw2dAPjtqsyqa
 DUYGcCsHK0aT8Mi1tbpEnABYaDqd70LaVWFRU/8TsAz5dBuBvBnjjhCMPduD6uS9UWfs1hUR3+1
 uF3nc4s/o4w2DGmtSbRgBA6ATKqC2d836NPEL97w7vQcG2JIfOy81BAzeieClBFbaysxyxa3qBV
 lLgshkLUFL/0GlZkhZpX1FyE5mJ6DM0Jv+4LuwfiehMdN9qhF/mb0+MYz0GIypZbMaI3TaSR1c+
 o7+kAH1ULpK4CE7HcE5nnzPZ/BN97guu34blGv9kJT8tHdcoX7cpYQkX0LTnrrkQFW1x6xsyOaZ
 Wz0St0mqwBd1tGIggLGxA6rZrLfqR1bENRfK+kSnI9ixgVAS1joajnCn9mHMdUKnCIqApa/xuB0
 ax71qRJzMPh31tTfgiTL3UDQPewoM8cPPQOFR7OWNr2tfPG5QpaZLaLsubEgx2DFFR/X6tDd7TP
 xwiZhKQtFt62snGr9SQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=10 impostorscore=10 bulkscore=10
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCJ-0000000017a-2WdJ
Subject: [f2fs-dev] [PATCH 11/28] f2fs: convert set_cluster_writeback() to
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

Read the cluster folios through rfolios, and start writeback with
folio_start_writeback(). This removes the last caller of
set_page_writeback() and saves two hidden calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2569b5744287..39b157b4d3ba 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1130,13 +1130,12 @@ static void set_cluster_writeback(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio;
+		struct folio *folio = cc->rfolios[i];
 
-		if (!cc->rpages[i])
+		if (!folio)
 			continue;
 
-		folio = page_folio(cc->rpages[i]);
-		set_page_writeback(cc->rpages[i]);
+		folio_start_writeback(folio);
 		/*
 		 * Attach a folio state before the I/O, as the raw write path
 		 * does, so that the write completion, which does not hold the

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
