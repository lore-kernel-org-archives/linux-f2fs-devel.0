Return-Path: <SRS0=40Qh=ET=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C6C4742C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2020 09:38:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0071C22272;
	Fri, 13 Nov 2020 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NdjvQhl6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EEBzN8hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0071C22272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kdVXA-0004u1-R1; Fri, 13 Nov 2020 09:38:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lkp@intel.com>)
 id 1kdVWl-0004ro-6M; Fri, 13 Nov 2020 09:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IDsZZloztLQtW6PKaiGxaWDsq1F4PCNPz8ICVF4b5Nw=; b=NdjvQhl6WT3QxBSXp3SA4+sPu0
 korna5sitIBqOh5SQxrH+ARa2K4GX86rU++14aY0fAWwrnEEBKdBsVk1Mm2b0n8yPGmNFFzzgd55g
 XjaDF02gurji8JXtOPbJ8v8krp+vrLYoJOEm0Ws+EYH4ybsk7XzfCLMcl5tD7/1Hcft0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IDsZZloztLQtW6PKaiGxaWDsq1F4PCNPz8ICVF4b5Nw=; b=EEBzN8hnVorgT7I99pbcZaaZHw
 lcAvomQjyza37Y+VpGBFBeMUA+zWatFkVEVHfyrxmsGILw9ow4GufpJlRoiOaGyb8PrivNCyIWokZ
 aM4HPEVXcOB5eOAKjbyhXEpg4nz+E9lg8kXC2z0HhopxKn7GigtZ+JZF8v0zqxTqCIgU=;
Received: from mga09.intel.com ([134.134.136.24])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kdVWW-00AGNl-Fl; Fri, 13 Nov 2020 09:37:53 +0000
IronPort-SDR: 3W+qVe2Y8hFscj2Vk+pV4FGwl6AxNTd5yM25QbjU8yzxTD9Sp52XjYA68AByHX41r9xAYyi0RY
 0q7mkoy8gsnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170618557"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; d="scan'208";a="170618557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2020 01:37:16 -0800
IronPort-SDR: pkCiIuJ3vAohRMIQ5wcxeQ8L2HvSI6/VSvhBxT8W7NUE2E1iw1mw3v91fPFaChgFHZdAo+cf8v
 jLgYvl2c9k7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; d="scan'208";a="328822947"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 13 Nov 2020 01:37:14 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kdVW5-0000CJ-CH; Fri, 13 Nov 2020 09:37:13 +0000
Date: Fri, 13 Nov 2020 17:36:13 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Terrell <nickrterrell@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20201113093613.GA67196@d51e9608dff7>
References: <20201103060535.8460-4-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103060535.8460-4-nickrterrell@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1kdVWW-00AGNl-Fl
Subject: [f2fs-dev] [PATCH] lib: zstd: fix semicolon.cocci warnings
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
Cc: squashfs-devel@lists.sourceforge.net,
 Chris Mason <chris.mason@fusionio.com>, kbuild-all@lists.01.org,
 Nick Terrell <nickrterrell@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Petr Malat <oss@malat.biz>,
 linux-crypto@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: kernel test robot <lkp@intel.com>

lib/zstd/compress/zstd_compress.c:3248:24-25: Unneeded semicolon


 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

CC: Nick Terrell <terrelln@fb.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

url:    https://github.com/0day-ci/linux/commits/Nick-Terrell/lib-zstd-Add-zstd-compatibility-wrapper/20201103-150617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master

 zstd_compress.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -3245,7 +3245,7 @@ size_t ZSTD_compress(void* dst, size_t d
     ZSTD_CCtx* cctx = ZSTD_createCCtx();
     RETURN_ERROR_IF(!cctx, memory_allocation, "ZSTD_createCCtx failed");
     result = ZSTD_compressCCtx(cctx, dst, dstCapacity, src, srcSize, compressionLevel);
-    ZSTD_freeCCtx(cctx);;
+    ZSTD_freeCCtx(cctx);
     return result;
 }
 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
