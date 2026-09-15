Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EABC88E53
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2jokCJl54gB02ElVoNSMATQrfje282pGe7XOqrLdYk=; b=PxyRbE1KZT9SyzrgFJQXyWWKe8
	FeAG3N/Nf266tTDcSW26xpnhrhyOJohgnqvxhH9WQgn0KLFgYqxxHeNoSWrkXGoyMwbJwVoW9/9Ud
	8EgM+ust7jaMu81jVwe6b+Rppb86Ms8Z6udt+ZXerk4n9WpwYv3cTXeKU0kfQ7VrZccw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6TzD-0001if-0l;
	Tue, 15 Sep 2026 14:18:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=17186df5e4=prabhakar.pujeri@dell.com>)
 id 1x6TzB-0001iY-51 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 14:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i0ql3NkidXtkaKoJVbDJSny1HBM1HO1hMPEuXNyrd+M=; b=jcKDX29y1LpP51iEZbbHbZ3x0/
 HF33v9Mjbqb7J8/t/os0mx2edvGBCSy9Azz5jbmlNsTiwtAMDqlz8zX8qVpWbnq7XaoYMg9C350iE
 BJrZxGEX0rvKk+XJ83F2zYuhtPEIpAIMiBRFkFUqUwDfeiUVVM8nJBzsrT66KTIB2v2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i0ql3NkidXtkaKoJVbDJSny1HBM1HO1hMPEuXNyrd+M=; b=E33uXZu/WASrO4KUX64bM6xdaB
 1CGqmgDiVmuS5FOdDz5szc/RmbgXADuDKJLz1dZCQcjkty/Bi6PlbENl4uPEGMpcpULmNCMYw3xUS
 7gwtba9CToxtUSz5WqDJlwyOq9x8k/Y6ZGoIZ+VuB40enBI7cKfYB2QLxPBmjSarU388=;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6Tz6-0001eZ-Jx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 14:18:10 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FD1kV61055693
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 15 Sep 2026 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=smtpout1; bh=i0ql3NkidXtk
 aKoJVbDJSny1HBM1HO1hMPEuXNyrd+M=; b=zEQW4V5q4yWgrgth9Rh2e4TeWPcT
 J0anyuYenSNU6tQk8qHZPDn16uLVd0RItmfq0RO2l6Am8gl/cbDhZ8GqpW3RxDz9
 6He6GpoMQc32aOYGPYP6uw942XbHJnvQzgnepHHW89uPdDsujs3D+LPDDDFxYnhr
 TT1IA1nfGf8IHpmnjIYr9UY8cmYM+fd75qj8KNGR8q6ZqlJteA8r2TpHPa/oaHxF
 SUQNjeJmofnrxD3QDGQImk1daWoh+yhYMRSCjon7iJmtkb7os5wcUlAd/TtYchdG
 dsuGlF16mtOPMr/NxR5Xpc44WudjHlkuTryN01CwMJ87dBk0aZ68AeYluw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gn3dhbgr8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 10:18:02 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FE6cVh751414
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 15 Sep 2026 10:18:01 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com
 [143.166.211.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gpv5x99m4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 10:18:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1789481881; x=1821017881;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i0ql3NkidXtkaKoJVbDJSny1HBM1HO1hMPEuXNyrd+M=;
 b=cFGWrC+XF7RcuuPC9z+wVVqdOC9t7xVu+5f0YF3Wk97ypde00sTpOKW3
 nQlaz6YNFBLiyjTn0Lbujb9rsJXTGebsEoHUQYma46+M8BiV5seDRoUiH
 7jmpE4zwQljoHxj3IrXwxmvSDHJoNQN+DL5DOGHvZWOieE/LV5muaV4K3
 DilsB3w59HAfAb8p9RtjR8zJsPbo0SjoonkmISx4KCsYJqe+LFXP5Baxu
 Xl+IomAjwXOPnMyyuWeAjcwOFR+0rg3KPOF5TGFofv5+PuUPXMEm7YQFX
 6WKM77yuh4EY9spfB55pW+0e9SHbDMVkcHW8BC1z1G4adG/VviO7VPmud A==;
X-CSE-ConnectionGUID: fCOpgZVrTiqRoE2b+NAeOw==
X-CSE-MsgGUID: kWkOdiIlRMqFoelc5ykeMA==
X-LoopCount0: from 10.94.9.174
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com)
 ([10.94.9.174])
 by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Sep 2026 14:17:58 +0000
To: fstests@vger.kernel.org
Date: Tue, 15 Sep 2026 14:17:42 +0000
Message-ID: <20260915141745.4299-4-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915141745.4299-1-prabhakar.pujeri@dell.com>
References: <20260915141745.4299-1-prabhakar.pujeri@dell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150207
X-Authority-Analysis: v=2.4 cv=JpBkP84C c=1 sm=1 tr=0 ts=6aa9539a cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=itNknoWdtTBfkXsrupcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: DQEzQD21e20hrAZMJtpX3-45iigBOSCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfX7T49f8hiWanr
 tCYo4UZ89Jto9owBsnBTJGExwKbsQxEKIr3mgGEqYXYoYGDxEbAS76boC6g0kJKd9DrPsFrMyHp
 v9pFswIUSiF92V0r6MmboZ0CZPMi5gPR91kBC5IBbnGhRH4LAKptFGDPCFTOaJF0yIZoebT2Ttm
 /vxeRRus8Y8jPZK8LdRA30omfkUh/6YOMBtd4hFy5kpQQZ8RB6+rxh5aLCp85oh6z4veoo5hvx8
 OUsKOYVX/w6dkiCwC0ZxXkHnS8xh4bXWAEC5vCq4+gJEVvSP6LInkxkntKry4PQq7H2juoazhih
 08l1Zg63ZePLB18BfZE2CI0dHsVjafo1fBSRVddfxdVVbfl8VAnxuJlKAqaFWzf/tuzkzmm634a
 v6jyBiqiDnx+Cak/ZkE7kCc94BvWqm+1R/b2U5+YYC9yU+obxqWSgGdxddTYr89tVey9MKQziBD
 fJcDIWJ0E9YTiyGBv0w==
X-Proofpoint-ORIG-GUID: DQEzQD21e20hrAZMJtpX3-45iigBOSCK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwOCBTYWx0ZWRfXwV8AuqhK5+iS
 KXLUJwsfgWOu+zJ4OI5WEhbnvBz4hP3KPfVR2cCUH/GSynKLxjMDXBY6oMCUyMTcrw2vz/lzSsO
 V5YJ3eD45xo7GBqRs8Wj1vSkFTS7IOs=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150208
X-Headers-End: 1x6Tz6-0001eZ-Jx
Subject: [f2fs-dev] [PATCH v3 3/6] f2fs/015,
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

Both tests run _scratch_mkfs in a loop without first requiring a
scratch device, so they fail messily instead of skipping when no
scratch device is configured.

Reviewed-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
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
