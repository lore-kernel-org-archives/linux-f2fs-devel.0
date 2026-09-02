Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3921CC61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZLL6ohdgs7vhPhnO2n3XJtaLLR0oa8TCyhIyF+fBKBs=; b=H9kjwN6MBtSNn4FU1Js3HY3ILv
	BFOx5XGL7XGQbxqOtBrtiDWffTrlkkZTMPR+HEfwn+djsOl37YkwSSvNtOCjahLSPRqCfXwT1zleG
	2ytzn/QQTk2CJpDzeQIyPQ8qFoA0Qd9ojJtwypx/1QHtSxs4vggEiVFH95sro/6qQl0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1d6c-0002yW-F8;
	Wed, 02 Sep 2026 05:01:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=1705562396=prabhakar.pujeri@dell.com>)
 id 1x1d6b-0002xF-AP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 05:01:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1/KLKRiVPfcZsBxemYIk6m3oWKrc/kl7djnjssGxzRU=; b=PdzrJNK5vPmRtNBmyaIxVldxUn
 JLIkM4sCw9JCC6ix2rpCbu634QKmWMnnTQ9qGHwGSGQVcsDHDQrhraf0kpffG6krlbv0gplX1HuGU
 cUD4kyyS9QP4SvInhlNHWtUdXVi+FNlW6viFz+ukP6tF7MF0E69c1XkyTbuJZeDQTWyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1/KLKRiVPfcZsBxemYIk6m3oWKrc/kl7djnjssGxzRU=; b=Q
 IIaVooucBfXELgftCpdZpX5KE+855AMC3r9MFzOC4oKHN7CBW7sFMHx1VopVeV9fy6P9dXMmjYCwz
 yBYyFRQHttg6c03Q+JKEhPs0Sfmf+w/yyqwn2Z6B+MlsOC4ALGZAZO1RSanxHRA/8zFLi5Zk33w/b
 iBIxnQh2NwXUAB54=;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1d6Z-0005Bz-15 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 05:01:49 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KS8Hq3620623
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 01:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=smtpout1; bh=1/KLKRiVPfcZsBxemYIk6m3oWKrc/kl7djnj
 ssGxzRU=; b=sR5hM8S9Ix7cZFD6eh5diGTiFJ4Q6yPwLmreUj7PsQw7pntMMvbU
 /HOr8A/ME1FCudz/OFjU4d3Lyxr0ZMfopEgKeMK+MJgAzFCpC0vfa+s6jC+Mt5Z/
 sfsrJGAngze3OIv3rahXuGhBe+66Rn4Y4l3ns97x1vMr8mBq/4vxB+0e6JEsJZNG
 pTnSra0D1TL07eA/zav44L2FqPa+uuVf0hZKAKxFxjUzaqKeBrlLkW7B8cl02uUi
 OOazCbDN0sHL0R6/Ie48QblLU5n3417cYbHBQsZMhDtCaKddykI5LmDDNbgDQWT2
 FIMqkV18gSP4cKpxCACgIExrbhs7VRQ7Kw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbv3gfmd9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 01:01:40 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6820vwO51525788
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 01:01:40 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ge9qc25u9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 01:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1788325299; x=1819861299;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1/KLKRiVPfcZsBxemYIk6m3oWKrc/kl7djnjssGxzRU=;
 b=PMRScVaAsxnX6FQJXmNEroSVEH+M8QMpwTs6XntNLzUN1EnGPDbbX049
 e3vMaTgJnTTcJUGR5r3e/oNJKU0MdtN3f7II4XxJL1fz4F+RLfOF7dD6v
 YlCl2LV+rWTat/WuBpgtXHEX82uKqYWTzl6v32foo99t+SceDq241NYtu
 k766otfKMIx8VA/dctEc1yz8qXujiWUZRdk2xxk9nruWOsLvK5gTtsj1r
 Iu+hRvXw+wK9Blg4whJWIpx9salKtLg3SXqVva5jN1taAZXy4yiCWY7B4
 f4qTtQnFWHffVxj2UOF7divQE8R7q5YI2NYp7jfOEdAIz4T8vLBAYiSaZ Q==;
X-CSE-ConnectionGUID: xmtYXp9vS+ifyVFkURmwYg==
X-CSE-MsgGUID: 6PYL9kzaTbmITLdTWme2FQ==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com)
 ([10.94.14.196])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Sep 2026 05:01:37 +0000
To: fstests@vger.kernel.org
Date: Wed,  2 Sep 2026 05:01:33 +0000
Message-ID: <20260902050133.2413-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020042
X-Proofpoint-ORIG-GUID: uqMEuZeznnWJAmo6ohBmH46ZPCTJhoIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX/1XG15zmbbQz
 g99Jtpjn+gjPn+q29Da57qnYqd+zpRwWa9XR/HqrpjaIaLxqrSrkoJTcAOyyDOUTc+ZE2/BSo0e
 YLGjl7FA0GDQKPoL26IfI2BMr34WmA+u69tQFhhP4Lc+AJvynd87rb90Z6qRD/JM+y1d5syzpMI
 sIylmWtdXu7P3Gc68QPLD1LprFUWNh4ZMnh8331fs0hKd4wto6DiQqtDNOFMLqnWYVey9cMJadm
 g91B0RFvq4qIPxJ/lfyWf+CrJE4bCTScQ61Pebs84lB92h3yoZkRzBfGywYqVOayIhZGe09HjPj
 AsxSycixw9g2rFbo9I7cvaWMPGtpOv9m9VFFvkhnoSAAdRXvBMUc25jx/wnusbq4dmexfw9W0N8
 qqkAErKUPrPnfFz9SOPU0q6N1O9HvZdHeGnJHASOum+86Lehaz8mjooWD1CR3BbkE7NeV5c0Ixm
 PoI+CeZnaEkVCV2R8cg==
X-Proofpoint-GUID: uqMEuZeznnWJAmo6ohBmH46ZPCTJhoIX
X-Authority-Analysis: v=2.4 cv=B7SJFutM c=1 sm=1 tr=0 ts=6a97adb4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=mO6Rr1tav0zkpb9LypEA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfXwgWWxLsn8SWZ
 mGs0uYFDQFW19/tDfT8rW4ae90Xw2QpKGwiIFQ4kok0eHm8ZcvCJKVe4Rmd8spMrq/JC+1SphOG
 JRWaCm79uBkRsmgx+LyFiYPPnUg2O8A=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020043
X-Headers-End: 1x1d6Z-0005Bz-15
Subject: [f2fs-dev] [PATCH] f2fs/015,
 016: add missing _require_scratch checks
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 Prabhakar Pujeri <prabhakar.pujeri@dell.com>, Zorro Lang <zlang@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Both tests run _scratch_mkfs in a loop without first requiring a scratch device, so they fail messily instead of skipping when no scratch device is configured.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tests/f2fs/015 | 1 +
 tests/f2fs/016 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/f2fs/015 b/tests/f2fs/015
index 54cada4a..75ae91f2 100755
--- a/tests/f2fs/015
+++ b/tests/f2fs/015
@@ -12,6 +12,7 @@ _begin_fstest auto quick mount
 _require_kernel_config CONFIG_F2FS_FS_XATTR
 _require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
 _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
+_require_scratch
 
 options=(
 #	mount_option			mkfs_option
diff --git a/tests/f2fs/016 b/tests/f2fs/016
index a6df827d..e0857e0a 100755
--- a/tests/f2fs/016
+++ b/tests/f2fs/016
@@ -15,6 +15,7 @@ _require_kernel_config CONFIG_F2FS_FS_LZORLE
 _require_kernel_config CONFIG_F2FS_FS_LZ4
 _require_kernel_config CONFIG_F2FS_FS_LZ4HC
 _require_kernel_config CONFIG_F2FS_FS_ZSTD
+_require_scratch
 
 options=(
 #	mount_option			mkfs_option
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
