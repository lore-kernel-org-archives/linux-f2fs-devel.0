Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD4DC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXeFPGbv8MVIV7rc2+88mf1qLKv48NB3mXf+efhNrO8=; b=K1kes3GlJWtaygaCCwTX0MMKIn
	EMlXcHLSWkTBNEDgt1PUXvzqVELj+TYhp46/eawE3P5D6My1ui9/Oe+SJAfJIBrb6HEBceX6o68pJ
	Bc3O6+pEVtRqNWxA9S/Jr05tFy0OUWx6pGR+E5EngqkXoRGBpDv1poM4i5tox5qPkXHo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1yWg-0001cO-2r;
	Thu, 03 Sep 2026 03:54:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=1706157dba=prabhakar.pujeri@dell.com>)
 id 1x1yWe-0001c9-4h for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 03:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f5J0fn45pArxq0JfaDQY3sOKocEePmivLTiwXXuaOdU=; b=Lg/oGnCikh2spaaP71SZBiK9zt
 /01g76SeZiJsEFn1FENdmCrl2jGdoom8YyX9mvA4AIxrmZa26ogBMd9yf7zuYDVhEc3II/JyExFKU
 DPTsyofNdQdge17rJw63ldAtFgNVNf6N1DQfUBvzwk5iSpAP7DOmaCv9UqmKigiuSMz0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f5J0fn45pArxq0JfaDQY3sOKocEePmivLTiwXXuaOdU=; b=KOpDpsm3HofxXyPrhU4f1K2kdO
 nocVDRutoyf5ixBo0Svgn/z6WqOZ/U3K3EWKaFh05uobb8Veb+EPtmKyR4UEedFJaC2Zexg7DsRNb
 0cLXKAWehVG+VACaAa5Pyp009bNqroDVzFQrDYP7zyr2dctUiL8PCALLl1Ys6kRqOtMk=;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1yWZ-0007rJ-7d for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 03:54:08 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832voH92798404
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 23:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=smtpout1; bh=f5J0fn45pArx
 q0JfaDQY3sOKocEePmivLTiwXXuaOdU=; b=bgXTlEmQH6MxP8vYCXQiASoB8Zp1
 GaseSgZEuFtFrFKnFg3LeBsxPvkeuUQn2CpQELh1lTqrn9SgGmljWABU7gt/Hef6
 yBGwfPuf1mgNB9xx1dD1UZnoaL/I/5b7QTrpMkmTYsqehXVx6zxrMggND9i4h1ly
 tPbfMAvpkc5cWB40ng7UBFOJ0jiYt2+MOBMfOExvy1AO4SX/0Pl5YCkLc+oiLmaT
 bQnqaB/R9+WF5l3dP5lWjahPV7HHaYhUJxOYXSB8E+l4C6aRJ/Ml5A4B77D1PpPA
 HusJBTq6piQbfSNQPRGqgL3N3mqSkHY119TY8KyCllZdgZdk0QDkoOm7AA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbrgqn9uh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 23:53:56 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832xOuI2023266
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 23:53:56 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com
 [143.166.211.146])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4geuvfud81-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 23:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1788407636; x=1819943636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f5J0fn45pArxq0JfaDQY3sOKocEePmivLTiwXXuaOdU=;
 b=gkFADVzCw89G/bP0YuuZdwYJpY4qy9FyR0GZSDLsVm2E2pbx2oVH7Ta4
 N3kTneds/ZDnMQwrM2S+o1WPxQxq/j/9MdwQT1V+Iyld6SwWkA4KtuIay
 7+o1ugU1V2PNlpB7BredDAwHvdrrKra5uCt/uc4AiK5XrkkQ6MLLhZSMn
 Yz/GCgbBssJUC5qaFPQnxI2YjdHEPAfjxwIgDxrtLMipiCSKn65piBMRi
 ad/L8ZhaPKsdGYv3o46CG0etZROpooOd6huIxH4eoptrVjeFZkWuD/BlB
 NoGzmmJ95aKafnnYO7236OsHTAu9FXwdss37qXYxm5ndI0v4agdA/KFQT w==;
X-CSE-ConnectionGUID: acv4rW54Q9S1IhE3C1pMUA==
X-CSE-MsgGUID: JL7eoqxfShuYZZ36zFPtZQ==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com)
 ([10.94.14.196])
 by esapsmtpat01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 03 Sep 2026 03:53:53 +0000
To: fstests@vger.kernel.org
Date: Thu,  3 Sep 2026 03:53:44 +0000
Message-ID: <20260903035344.752-4-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903035344.752-1-prabhakar.pujeri@dell.com>
References: <20260903035344.752-1-prabhakar.pujeri@dell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030032
X-Proofpoint-GUID: QaUFM347O-5zpJ6vP4AdOjSFOV7NvgkL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX9Tt6TLvUVgzF
 r+c2vZEp5gCUPm2y3xZUVYmTqFJLEL708FonWLLxftIyNFeLGBgaHkZSSHKpufhkUsg5qb1t424
 xi9dCuT9uXxgzUjuFyvlTEVVRrwdwKJmG2hvrEkBg18XnPisP3QEzFa45pkCPeVwvRlEtr3LmRF
 h8RxzSQrW/WdQm4lZQi9su5bBCUkagFJZbPLtKdVoYf1XuNW+sXq85zezdMLrLG85e4NyKd4pAW
 X8+vafi33/Ey+zjMUNYxQNxLxa2YFIQP+xe2CivGXsWWDB/IvQXyaYZxM7Ny7R3RO/YY7WxN3sB
 keGVnqOGIAIc2YLjKyVMyH5uFMdpZ/pYhEoPAxUNQSNy70mmSEixdqLEm2OoD9DDEz8prcsiCdR
 XwK2GOdpCTZKqYdwAYPxptbaUV4THlPZc8VHNPCKAZBTW7Ky6nit+pEYtBGynEVnrQ7j5GLjUHz
 A/yLXJbW22K5JcBQ6YA==
X-Proofpoint-ORIG-GUID: QaUFM347O-5zpJ6vP4AdOjSFOV7NvgkL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzMSBTYWx0ZWRfX63d6hJueuE/F
 0FspyqsKIk+Y86x99FXL+qgGsqBSlzkUPYXwSAN6o/HLGWUfKQTmgfxyyG6+ps+X3g6tiHlhQmq
 SAuLp+DJISYdDZXTM0pJBWM3gFT5nDc=
X-Authority-Analysis: v=2.4 cv=IoQutr/g c=1 sm=1 tr=0 ts=6a98ef55 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=itNknoWdtTBfkXsrupcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030031
X-Headers-End: 1x1yWZ-0007rJ-7d
Subject: [f2fs-dev] [PATCH v2 3/3] f2fs/015,
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
