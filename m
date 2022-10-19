Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49781C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Oct 2022 16:18:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olBm4-0003TQ-TD;
	Wed, 19 Oct 2022 16:18:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <quic_mojha@quicinc.com>) id 1olBm2-0003TB-TK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Oct 2022 16:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zD/R05w9rQH2nIBrqXkHmKmhtd3douq60/H0+KYKCxg=; b=efUbwvHjYPso7rTP4VEt+Z9kN3
 zKmOu6sq6bejyz9qNGl0DrvHKPMjoCfksyWsWYpBhvfU6wYPMrkYaMJVMf0rfbfmn2yCGTJlstr4t
 xWAeBIZZFUosWlLCYzQt/2CjpYw1+Z2SuVusVqtxZojkcrVHxhgCL8ulbc6WMH+Vx0Tk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zD/R05w9rQH2nIBrqXkHmKmhtd3douq60/H0+KYKCxg=; b=I
 lMDzFkEJ/m4IOP/Y6llAcWTFbEwzxkCvsC0uj8EfglWzrqPj9v1oHnBvuziOAcfu5uQZaUvXW4TxV
 zMJtyXvDms5qvTK1VX1Cx2qLLP+wMEgfBokd+22Xe4ngBIf5d92aj/kGCtXbdYFLybSZdy4RgBaEj
 5W3TWFjzrBYn8NE8=;
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olBly-0002jD-Nx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Oct 2022 16:18:30 +0000
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J8BHbV027441;
 Wed, 19 Oct 2022 16:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zD/R05w9rQH2nIBrqXkHmKmhtd3douq60/H0+KYKCxg=;
 b=dVzgO9Mb7K1f7zsB6P9QNWKeBgnGIC4mW7e8y5GbOzJZhbmnZQK+FsRXe0h4fCZleOe7
 4a1av88PjeZMEgtml36EmQvee2lE8j50hVPgtqBiapKg2Akbp3HUn76P1bL2aDiwJGPU
 1lfiYZhUxgeHLYh5SAaQohbC455CI7mBKvZYewEnahO371Ln+ugf1/ypphBC0gSSV/Pf
 LQzrIINbXWglqV5uTBkNhqnzPdTQuXSMym3Af2xNqZMHYHzJJbxwMFhgS5cfwSIbFW/C
 0OLnKaLWE4yeuiA77wB/TO+pPCW82OVYkEswIjIgLEjODuJAZKuGh9xkqRHKMvfeyMF0 7A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka3j1uhqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Oct 2022 16:18:13 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com
 [10.53.140.1])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29JGID2D028693
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Oct 2022 16:18:13 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 19 Oct 2022 09:18:11 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <mhiramat@kernel.org>
Date: Wed, 19 Oct 2022 21:47:57 +0530
Message-ID: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: mjlz_ZOW_AuU4Z9v5eIXSpeO4_68gAL8
X-Proofpoint-GUID: mjlz_ZOW_AuU4Z9v5eIXSpeO4_68gAL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=875 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190092
X-Headers-End: 1olBly-0002jD-Nx
Subject: [f2fs-dev] [PATCH] f2fs: fix the assign logic of iocb
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
Cc: quic_mojha@quicinc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
introduces iocb field in 'f2fs_direct_IO_enter' trace event
And it only assigns the pointer and later it accesses its field
in trace print log.

Fix it by correcting data type and memcpy the content of iocb.

Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 include/trace/events/f2fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index c6b3724..7727ec9 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -940,7 +940,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(struct kiocb *,	iocb)
+		__field_struct(struct kiocb,	iocb)
 		__field(unsigned long,	len)
 		__field(int,	rw)
 	),
@@ -948,17 +948,17 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->iocb	= iocb;
+		 memcpy(&__entry->iocb, iocb, sizeof(*iocb));
 		__entry->len	= len;
 		__entry->rw	= rw;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
-		__entry->iocb->ki_pos,
+		__entry->iocb.ki_pos,
 		__entry->len,
-		__entry->iocb->ki_flags,
-		__entry->iocb->ki_ioprio,
+		__entry->iocb.ki_flags,
+		__entry->iocb.ki_ioprio,
 		__entry->rw)
 );
 
-- 
2.7.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
