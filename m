Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2ABC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 03:40:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCv8W-0003I6-D3; Sun, 17 Jul 2022 03:40:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oCv8U-0003Hz-QL
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 03:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8gR5VQzRGjigdkQY3erLDRw8IhQPWcNDUplQ2FcOGU8=; b=hTIlWidnxRyNT5TkGJ2ADjUjBa
 PnYZFglb4N3Eq+cMhU5s5p0yT4nHZn1b4crP2rON4Ge83jszj5z25g0iQSXJyBJKEUOH4p8RlSCQJ
 FcVZJ5Hi3B0UPsR8NRT1grjiEKUN4b5gBM2cniJd9vlDiD9IItQgpKFnvMZ5I6Tlkz7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8gR5VQzRGjigdkQY3erLDRw8IhQPWcNDUplQ2FcOGU8=; b=VpEQCNwY02qBM0YDz5VRZyKmvx
 UMONY3/of3enL/jp665WN18EoWLSRuS1tFtPh2uUyxOjlQsW8zOSgAgKjc3KpOIC51NiO36qACpoM
 L3Nw6KR3DSfD3G0mMVI4crkBOZmPji1suQNJQa14UIkDaF24FC8FSdQ1F3qtAhpdAeC4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oCv8S-0005RZ-49
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 03:40:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CDD6BB80861;
 Sun, 17 Jul 2022 03:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1921C3411E;
 Sun, 17 Jul 2022 03:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658029192;
 bh=nZ+2A8d7tClOSNbCmHjm5CM73z9/azEyC+Joef9ZTiY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nZbZg85U+Q5nNyVfZhrycaSQvJL+a2BAlqU6B5s38Gmngu0n90m3ZhjL6zVg/eb4t
 3rv7fKDPLAg7zhAOGIJmtbIg5BqxLxkAMF8vM7G5/5zGoo8b4xN/t0wa82fArjcY0x
 Yki9f07jDuPrZbneMN/KGTlyrWiYefxYrAgEJdXjsl68uOmDbObzycRxEir8MvNGLo
 mKlcl06CcHrrljEI2Va8KLk5YwLkJMTVLw4nrmAzxi02b2D1wdZLgKhZzJlqkqNsXg
 M/eTJC6M8dsWatgBBMlkOghNI6ZMcl/EAag1+1Wt2WS29WRskB7tqb2ngZJlPWWVNK
 6DnqBSZmdv2Uw==
Message-ID: <a0a66c6e-3d29-25e8-ea28-4b7bb4e36071@kernel.org>
Date: Sun, 17 Jul 2022 11:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220623181208.3596448-1-bvanassche@acm.org>
 <20220623181208.3596448-6-bvanassche@acm.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220623181208.3596448-6-bvanassche@acm.org>
X-Headers-End: 1oCv8S-0005RZ-49
Subject: Re: [f2fs-dev] [PATCH v2 5/5] Use F2FS_BLKSIZE as the size of
 struct f2fs_summary_block
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/24 2:12, Bart Van Assche wrote:
> Since the size of struct f2fs_summary_block equals F2FS_BLKSIZE, use
> F2FS_BLKSIZE instead of PAGE_CACHE_SIZE as the size of struct
> f2fs_summary_block.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
