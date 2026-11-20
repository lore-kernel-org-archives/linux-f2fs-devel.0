Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE2606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DVRvjhpb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ERM9PkMl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L7Jdne7+;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=OkT3CCre;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=G+JtuUVp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=UZhFbssJIHbqLijm4JXPdfTBLGrxHcJyMcLweSnB2BU=; b=DVRvjhpbHp23FXMDTJvUfnlaJF
	JM+J7VYqiWrrrxuWO9OMUwUaEPblv5vLJFGl1CZR0BMdYs6aNuQApKr2ze/e2jU51WItEHsbGGKTi
	Er/D8RzOGYPXAWnH93zDEYdXf9NGNgHPTM7GvL/ediCLSnqUpv0Bh21+fLMfPjLdBI6Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCZ-000000003BL-30iP;
	Fri, 20 Nov 2026 19:23:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCY-000000003B4-1PJv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gBIHKE0mrhYIXc8d8e4IW6tKdT5qToIE1UQ6KEYPenw=; b=ERM9PkMldCCCdpwrNDoQbV4urS
 MMn8OaNaMeY8uJ0n2Xm6wRUgvGjG7Dyar2FOew8f8eADBbREX4M8u33TCqo/P6MBHqnSmwBqPJ79f
 X/85Iav+d5Y3lJungnTtbtms/gw1vW/EmFUEa0mvfU0xh8GyAXUBq+SwyWd7bqkusZnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gBIHKE0mrhYIXc8d8e4IW6tKdT5qToIE1UQ6KEYPenw=; b=L7Jdne7+/Ab2wSGkiBUGjLzECa
 Qt9xzm7gxBHeTtyZx3M7PtdI5bI/BAr81+8Oz6d4FxRs/t0EisHMJEbACxuS3j415zt6XarYjP5wg
 P4+tag349LvSpSntvkJx3+6oBlYeh5cxXTfsxPuLCyrfhycgADq+HA7fUi5LYSWyBkfo=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCW-0000000018V-3QDP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:14 +0000
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKJ1vtJ3343173
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=gBIH
 KE0mrhYIXc8d8e4IW6tKdT5qToIE1UQ6KEYPenw=; b=OkT3CCrehWmVrGJG9d4N
 4o/BYgG4chiDAD8SxHcUZD6werOD9yZfnm4iRnsTxwKRs0JsjI/gxcxctVHbPJ2R
 lY5zA5Gbl2FzKzcS2tO86jfQiibAJAigevW56uqCE2Ne3QLhoB7BXmUUrtn4pgmT
 dP5FMvOkUyXBPDsqyYhQXjKF8G6TazeVacHdw9FTvLXAXy6OdkDcuqkzp74viWp0
 e6K2SwnM4kNVKz2E4gWbUT5S4hxguBovm6+8Oezj7FFU8gei/3Z/xPodfU/WoHUs
 wcyDk+p0rNStrEWL+3wlOMb5YW+8pOlfKSnx1i++3y987X3AppmrbkXR6PdDLFPR
 bw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2kncm9xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:06 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-55d53d0bd3dso21314191cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202586; x=1795807386;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gBIHKE0mrhYIXc8d8e4IW6tKdT5qToIE1UQ6KEYPenw=;
 b=G+JtuUVpH53k8FUzBGcnAfc+GZL67LBS0k9hALmerdvqr9qeO7WPhaqNM3gRzq8sT8
 9rWHQdGIl/s9aJG+kijuGnISeAPVlBJ0pb4bGT+G1eCYPh87Q3UeKEkm5byJFFLf+DTy
 sHwH2bTzRjx0fl0omcWLVC8p4tsvCTLVxrZbScjga0yrUb4INaPuUUsN7EHR/zk3z2qU
 roOXHwXsx2YEWotjjctFEv0Elx+5lV0S5kw4/bB0bTgVLNVYYxD9uleErXtneaPRRcMI
 tJ0PZDHorX1PHS5s92jWz2O+hdbwizB8IL3kYoe3aq1lHeXK/Y7xadfmGgXLxlLdZw0h
 AztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202586; x=1795807386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gBIHKE0mrhYIXc8d8e4IW6tKdT5qToIE1UQ6KEYPenw=;
 b=V1YPL/J8W7w5gjnr2ai9Iq2To19dmJRj5oF8nCIorqtqijxf26w3rvy2wxVPkt5A7R
 yfe0q2jTPnzSM4CCNEQ2BervzWAd+bbw6+d7As+da8otfvJuZSeNEv3eFuxS3Ps3OXYf
 71m2oy1+ZExqUB7BMjS3b++vHFYlA66LFlKELUs69wQIbAdPGwoQ4Xj8VtZpotbhqwwB
 /+daHBpoxaUeNia/Ac0C3+f/kek3Y+yR0zYHSj1OT5deaHvYzbuKVOHJeKlhU7VahH7N
 IyvPByPUeM4MVZi19KtCR7z1tKxVpNGfAXJk2/yWg77ukLwlqzQmTHT04vbQut/3c9Av
 625w==
X-Forwarded-Encrypted: i=1;
 AL+hErE+F4xQbnFfNcpYJP6l3pMkpfNsd78wFqK75byF8uKtdS6i7DfHTfvaGCbzSQt7oRP4UgJOJUCuRv2nSfaGn4ib@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+nezGiBbc+CDai2ICje4JtuhastY0OyL8LDIxNPLh0vW/8SxaP
 X9WyojMm1qI7BZxeEIeckXLiv/Tn2+l2LZzRfjUonlwO7HBtgulSRv7oSPBhIy6gSgK5dRN5YdT
 WjYnmL8bSWuvAwdqSj0kxIIlrgswmyxc0yC5z447FXm3Nymzg06kNmcYxk4mDyV2Zw6NstEjrfE
 M=
X-Gm-Gg: AYBFou2PH5PWVDSWX8ayPvKaCpv3/7YFQAeA/caxUoKi2Ejjm+yNn1biBWwd0xE4hHk
 qFrOjIWGfz0ukpK/LO0k0/r+Em8YuElucITkmJZJLp1DJlDcsDiG9wlLXvV5o2KqPZqXLav+5pq
 ugF5QmchUYHL1lDgYg/ZmLw4HmQJbcuzRE+Dr3CBP5U9tVwK2vBXZQlWcUMxDSwBsikfZ1HyZmv
 r3Brl4DG+dGUnTBLJd/voHq9LBSfmIR26OqjCq3cxUl9j2x/CHQPeeL2eWkIGeCTavXEWa1DCDo
 JMRWJFcAaxNBa0UbvLf/J60Rqj3Spnp0WqTQ5W0WNntw8F8Rgr1dpeE1o2IT/n2FH/2JKqY4VNT
 XOHxGtiIg1kDJaQP4S+byun1Czb3jDqQCaDopGkJqZFgi5JHflHmGVyNsZtN2UxBmPgCbkZsO5r
 jY+nFL3KQOdrXk0XLContA
X-Received: by 2002:a05:622a:4d86:b0:55c:22b:6b2 with SMTP id
 d75a77b69052e-55d6fcabbfemr84237991cf.7.1795202586307; 
 Fri, 20 Nov 2026 11:23:06 -0800 (PST)
X-Received: by 2002:a05:622a:4d86:b0:55c:22b:6b2 with SMTP id
 d75a77b69052e-55d6fcabbfemr84237691cf.7.1795202585886; 
 Fri, 20 Nov 2026 11:23:05 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:05 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:25 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-22-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=925;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=f6MnKkqt4rERA+FTrhbVUsURHuA4mDKwOr3YzgguFns=;
 b=nGaK8RGjZNudJj+BHrrgOyLyUz4Igte+NCmO/2aLOeiQIK9SB/jGbgSIpgTRKarz8akTjK1eJ
 Glck+3FDFWwDoRT9Fv1NZ78Dx6rcaRUU+tNpbpxWNcjwbrk+7KwJI6y
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: BKDbzjzCwbXeMOJBSnZCe6zPjia1EcoA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX2ppsGZn5CtO3
 m6kOszNl5xo49qFb57Rh+6XX0ozmXMphZmK5B5cQVhkDYOAsXFf/qjXbSnn7TZtg6Pq1kP9evub
 d8Soq+1+HaekSCObCqRYVKwVMWhDWHutm2mbdPpRpYq7vaM/Na5A
X-Proofpoint-ORIG-GUID: BKDbzjzCwbXeMOJBSnZCe6zPjia1EcoA
X-Authority-Analysis: v=2.4 cv=P9GvFSAu c=1 sm=1 tr=0 ts=6b009e1a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=4dI7kqpCLflqraMsSBUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXxyz2tjHw1YRy
 kuijPsGQGL1YfJVhJYCjD+2ziKzA34GwvG1cGFe29nA8Mo5hYFW2YmGCux6Oj8F6Fe6tMU9UiKA
 NIqUtqsPGl711Jn0N3BoQjq3Qec5p5LXCl7DmAe0N51P+y4/Dzn5s+s1JkpZ1FfbNVk7OISYf6T
 YXRvr+/HrxFOlvouTOqV9hiNkjztuAqZaDCUkr1Fs1qaM+1+fRo78imwgFYeZxoEUTwKZ+99Zdo
 SGKEtFceew0IyjcDbWTdhm3jMTRsJfYoGcsx53VFX/1DTqMvsbKdsz8xLaFJPK1rOHKeahOAfxF
 JE7MKN/UUn5HCA8sCWU4fcW8VZxN62MUGNBhMyjHZjVT7lOrbx8snvscocv9TIxGtAol0gpmh28
 kSvBh0cUmpV1irU4be7fCGhvFp+yNwETrVSlQ2/I6VMpAPwoa0+Q/txzC2RINoSFbqhlsA73UWm
 fMRZaspyHN/Kst26new==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 adultscore=0 bulkscore=10 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCW-0000000018V-3QDP
Subject: [f2fs-dev] [PATCH 22/28] f2fs: convert f2fs_verify_cluster() to
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

Read the cluster folios through rfolios. This saves a hidden call to
compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ed5096dabe3b..4deff5ff5360 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -2039,12 +2039,10 @@ static void f2fs_verify_cluster(struct work_struct *work)
 
 	/* Verify, update, and unlock the decompressed pages. */
 	for (i = 0; i < dic->nr_rpages; i++) {
-		struct page *rpage = dic->rpages[i];
-		struct folio *rfolio;
+		struct folio *rfolio = dic->rfolios[i];
 
-		if (!rpage)
+		if (!rfolio)
 			continue;
-		rfolio = page_folio(rpage);
 		if (fsverity_verify_folio(dic->vi, rfolio)) {
 			if (f2fs_is_multiblock_folio(dic->sbi, rfolio))
 				f2fs_ffs_mark_subrange_uptodate(rfolio, 0,

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
