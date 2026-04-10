Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E23F364DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uvNTUFUmx7rUmF1jhWvMn6+Yi+sWn/gohI2ILxStGCY=; b=TsAJRlHve6xbmukWzlXbcTqkN7
	dEGcpd2ogmUVFegislMAd35aoaJJh70jz/D7rBLh8XJ/z0lRty30++11cz0hxn62QfoLgwFsXNWlc
	C96ArOdTo0GtT+Po+ZyTU75nuOFi2JEQwciZ5GnUW5qlTMfg2BL9g8BNNA6VAsIUSziE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wB9UP-0002JH-Qw;
	Fri, 10 Apr 2026 10:53:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <xiaosenh@qualcomm.com>) id 1wB9UO-0002JB-7T
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 10:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=89rQyFre5Ptb3rlpFgnulWmAPPiGK/K4LM6Wo5JK8U0=; b=RYVCYjVnhebcrelmjsW3MBQ4Fl
 BtAIrW2jTlj+rQVCG6kMxjnjPlzJC0rbIO58LXUL3PKr0QvnXA7LxgXRxXQDZpx7yRlF17MqRS2Lc
 pYj40hsoMWUWVpdLW54q60wF8KGGI7wkePWuwwETw0fwp/PgwxPTANtEanfgh2rkAlLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=89rQyFre5Ptb3rlpFgnulWmAPPiGK/K4LM6Wo5JK8U0=; b=S
 b0jgL0IG2tL/rXRE8gJotVD+7sD4YCMmMMaMik0pUCFkv88KdHAaENmbFpL52eW1MFXNZWtiHruA3
 NtdxuvhGTAgruf8bweamkb4o+6XrU7OB/wN2NpPzth74VmEDkPp/8rvEPXtCrLrEvMJQqgjCbhudB
 Zlg9dQAapaVkZ3Fo=;
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wB9UN-0004eM-RT for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 10:53:28 +0000
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AAJDMN708265; Fri, 10 Apr 2026 10:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=89rQyFre5Ptb3rlpFgnulWmAPPiGK/K4LM6
 Wo5JK8U0=; b=ot+ZrwpNZtnBPEEBGqb0d5esc8P881hfg6RZxHb7t49Td3SDntO
 PB9RHDsJ6EQoyLAuomET9Gqefo2SpMmqYR6frwQylBNsTSdszrFQ1yWzWV6R5iVc
 Ym0FUuJZxErbMw0cuiKi7ccAj+pdhhVJgUHFJts+pjNVK1/NJqvCyfc/y3YntuQr
 rgo7wnNTy0/9XeEU/3TldZy4Cde/45POM1osjKXVT0s7MSE0gSs6ryWD3+z5txs7
 nUj6kXL7SeHJUP5gYo5jNackVPLwFq/UFAbqX4pykJpUYURDWYD4IFaftDnAGYit
 /0c6x0JwnfPujmcYdxlbokpe9oSqXQrGh5g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudj13sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:53:15 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63AArFwO017795; 
 Fri, 10 Apr 2026 10:53:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4denmueg6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:53:15 +0000 (GMT)
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63AArEKu017782;
 Fri, 10 Apr 2026 10:53:14 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-xiaosenh-lv.qualcomm.com
 [10.81.27.218])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 63AArEvZ017781
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:53:14 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4148646)
 id 4433F6C1; Fri, 10 Apr 2026 03:53:14 -0700 (PDT)
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 10 Apr 2026 03:53:10 -0700
Message-Id: <20260410105311.3260515-1-xiaosen.he@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: zdhJJPTNQwxQzVhxrU_KfDmnHQ3eBTse
X-Proofpoint-GUID: zdhJJPTNQwxQzVhxrU_KfDmnHQ3eBTse
X-Authority-Analysis: v=2.4 cv=cKfQdFeN c=1 sm=1 tr=0 ts=69d8d69b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=abl5StS1tz2Q0GuixDUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwMSBTYWx0ZWRfX0+7J2/uBKAMb
 LSR1ZmXTTYn769JLRGXh82WKaNyWE4jLwrHS4lTx4dD9LuEljetEPpMnXXwc9Y3g+SnNVCrWmLu
 Qe8jU0kJYNw3kjKqqQONHtWLiYsswLq80ZrkHLzAN8TBMzY41lGM6UoDoiO9EC1RwFuBuBkMsd8
 fGmoMm7aUruUeFXhdd+ngjGl//ZpmsjAbXjHhXFNscxrZzMWDwe31B7a/CLL7Ps8QKqOhK8G8Il
 4ptbvkOrCrxp5HBJxLctBXiJBaX6QaA7wvH76eyqVIlhFBAF+cSdejqb5JzGdJVVI0HTimQ/WYd
 irTv2fm2LA+7rgg8IYs+kkwBR8Gbne494UXC8DEbdfXMl+/vF6IRU5NqS4fus3hGhY1G4tqCDkG
 JlOAZ0qoMOTIbse/kkMD2NILLSLv0jFcvVHV+15f5yPjVoT5JjvJcz/hzEcGPNA26JjGg/671Dq
 gFLF82WLX1+nnr6w1cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100101
X-Headers-End: 1wB9UN-0004eM-RT
Subject: [f2fs-dev] [PATCH v3 0/1] f2fs: fix deadlock in serializing io
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
From: Xiaosen He via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Xiaosen He <xiaosen.he@oss.qualcomm.com>
Cc: can.guo@oss.qualcomm.com, xiaosen.he@oss.qualcomm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Change in v3:
if get mutex by mutex_trylock(), do not call mutex_lock() later.

Change in v2:
call blk_flush_plug() if mutex_trylock(&sbi->writepages) failed,
so that the plug list is empty when blk_flush_plug() is called in
sched_submit_work to fix the deadlock.

Xiaosen He (1):
  f2fs: fix deadlock in serializing io

 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
