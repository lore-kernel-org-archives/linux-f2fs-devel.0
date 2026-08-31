Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E44FC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oBTotVEuQJ1hO9UJ1k8/vWNfWixABZ4EaPUILxE23ac=; b=CNnaS9tDBgxUZTLDrdxrw/24mp
	20kZR7vdL72q3Nv66eyeJViGJTz+AFkeUDGVIwhxhLKjRmVQFsV5TNpU0WGLIg32VN9eCcyEt1ZRB
	eezgacHvx0+W9qhS6CTk8kxlYLRosD9jOwMlEp54lno6BDARAj4cnv9oq0sAZsaiDX5E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x10Sy-0001pQ-Ot;
	Mon, 31 Aug 2026 11:46:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=170363ab03=prabhakar.pujeri@dell.com>)
 id 1x10SW-0001oq-4u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 11:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x6knYLxBGqt2H4ZybVlyxcPpLJoFsdskIEriIIXWLDo=; b=ayrpxDp8RbNXhK0TN+RhTt4XI8
 8m70RkY2vEVY4YuCsBU5cz5ZCYvGR2kdRRVsR4dUinbD5WU1vRJwjre1x64izmIPciTJsz0PQ7ghK
 aQW4gS1RKODSx0ijzvFfi0HDG3Dx5kwbl+ymAdaMyaZbsGuHGpuOHJdOqU6ntWGuCdBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x6knYLxBGqt2H4ZybVlyxcPpLJoFsdskIEriIIXWLDo=; b=S
 a3X8ayzYXmbukyAk0uDkZe/dSkwoalYCfNPfE59EKz1Y5JXKgCmELbbubA14Ep0KxkhObwpdRcJFT
 af3ML1Ejym9n5rldmTQXyzUpfWQV/xxLzjYyyZKPlvB9l7L27GJTalNzac1u1HYaUu2b9ebe3EKlW
 ye6zGL1qN0ZCsJbs=;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x10SV-0001GO-4Q for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 11:45:52 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7x5FH2855346
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 06:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=smtpout1; bh=x6knYLxBGqt2H4ZybVlyxcPpLJoFsdskIEri
 IIXWLDo=; b=Zuo6oZDbg4COcsEBoBPwsEUUR6t3S50E2ix/4/BIVRGzrSTYqRlK
 fCYaGBrecGqKX9bjQEGRxGfgDiIriauU73QVThT7hnbRPUobZsWYYptLzNbaakIj
 k7HZeBbq+fuVueTFaOP8Mn5LV2ypmQY6ZBTKr1t+EgQlSXfMmUE/DTtZVe9gER++
 1SKlMjMGQlDUUYY7gV3IUQE5DqLtHzzqZ8b+T9jVZxS3xmo5hAsXz9bXNHg2EKEs
 nYq/Dp8tqLddLTHOUX+SDNXUFkF96r+h20MLnO6T4ufqcQDVW78tuDBwiO5XZJAl
 kIZk9neqCmgw+DTRnL5hUMzOd/kIj6jFjg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbu8snat2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 06:41:49 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VAbV7e2144275
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 06:41:49 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com
 [143.166.203.154])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gcnjksbb8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 06:41:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1788172909; x=1819708909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x6knYLxBGqt2H4ZybVlyxcPpLJoFsdskIEriIIXWLDo=;
 b=KMTQ3Vuxeu1nEqJJiLkeUkr3V8jhgirc8NawMKvB24ZKVMhjuBlKYhJw
 vaozX4uCOYdSrkctPjhOtH+tKorSH59AbJSypeAWw5CIQBTllW9uStbDM
 TFn9RyeToyxiGZHvi3sbDabnRbd37e+hBilhYDzYq7SPcxPi+Ntu2J/Mw
 +cV/R6QvcOXQwiBMsUrQy3NPp8tsa8esFqvNdOFezECwfmvNzNShv+qCW
 SpnU7BMPSJG9ue2SpM90cNxuawLL/cZ89kHlCluANNqYoqlAIAemcaKRy
 +TL8w17/N/Y4xZYtj3EsMP27/lgjEDaHE2VGiiRMKp3FyQ7nNwmW+a52v A==;
X-CSE-ConnectionGUID: 2fc6uPgOSra3dZg08u0HDA==
X-CSE-MsgGUID: IdHSqLpiRlmjLaMwJOutzA==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com)
 ([10.94.8.206])
 by esapsmtplv07.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Aug 2026 10:41:46 +0000
To: fstests@vger.kernel.org
Date: Mon, 31 Aug 2026 10:41:42 +0000
Message-ID: <20260831104142.2229-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX+WX9dyW/XVx+
 6xKzfUvyjPx2DhB01tdRwfXJcJ5qc5DS0I7gjJK4J55Wcw2r7iVsmsLOYiHxDpMYPZVBeUIAAfz
 vaKjLAtcNfKfZ3JgTXDBpVrLaG7A+2c=
X-Proofpoint-GUID: VBhx60q-hQvslH6guKUrnxuyxZu_ElDM
X-Authority-Analysis: v=2.4 cv=cLTQdFeN c=1 sm=1 tr=0 ts=6a955a6d cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=ZFVciXT5ayevmQCRhY8A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: VBhx60q-hQvslH6guKUrnxuyxZu_ElDM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX236saQwMxczy
 gvZcQKmO+PeAFFBmx/Rd7WSw3qGmynFI5Uu09+hr+eikemULh9BtZUIkNVkFBoxE7hythUioJ+t
 YrntI/pKxSmfQ90/qpdNgKftat5baH5HOmDPctwt6YULPv0UF11JHObMlD7MreOHF3ZJ0MUB40n
 pSUyJptBdjnpuLgAj7AzeWwxOLcjFiVPQeZZyoRa6JIkA/9b/N2F0sK2lqkehdRnDS0q7QgqOfb
 ZEyDTZPQL1IOOFkov6LIiUnYHSN4EI2OGPr/ButjwMGAWL9yp0/3JQ2uxOVSNJMfmSIyg4OPXmM
 +BgURB+LHcn2VQWZP2U1ybR5mAsjGfU4jPcSUbC/5nWbnDvee0YthCxzs1BjrueU/Tv2NQY05V4
 hcGiumI0sz9ABB3OrdUNd7RYLIpiRmNZ03dR7Iw4ph4rW2JcskuX9bGTBAG6PjCobzrZNozX2id
 KohRn2NfiJvFn7gOBZQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092
X-Headers-End: 1x10SV-0001GO-4Q
Subject: [f2fs-dev] [PATCH] f2fs/024: add missing execute permission
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Prabhakar Pujeri via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, Zorro Lang <zlang@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The test script was committed with mode 100644 while all other test
scripts are 100755, so check fails to execute it directly with
"Permission denied".  Fix the file mode.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/f2fs/024 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/f2fs/024

diff --git a/tests/f2fs/024 b/tests/f2fs/024
old mode 100644
new mode 100755
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
