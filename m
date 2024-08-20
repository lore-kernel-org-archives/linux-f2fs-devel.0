Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E8CC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 01:20:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgDXk-0006QU-78;
	Tue, 20 Aug 2024 01:20:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgDXi-0006QK-T5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 01:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ro3kiUVHOnrN9Nqa6siVRh6XZeyqSlGLGYDzGBS11MY=; b=QjfI4x22FkgBHUtHena59KumWa
 qmxS4RQ4Jb0SdEDILgVTRN5lrHSKl++Hfaule0yn156eGtWw+IoaRoraph0tNcX0sxZecXenX7u6O
 8I83cbIAm8CDJMaDjYK6SB6ldMqTErwPgBxQH4sD3wLZV1Xndcj22JYehVa7avtwhmm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ro3kiUVHOnrN9Nqa6siVRh6XZeyqSlGLGYDzGBS11MY=; b=aJA0lCixpUwey7pTwD8eqXKITM
 6cZM1GBhLxKB3IyKzAEVRWfeGcX2Eum2gHIMmXveah3VB7uB2Wf9mZdj5qRAVAaHKE0xx6kE/Otc/
 w7toOg3rtCFJ+Da94sLrQyLgA6HasSmvANIphvv4AsgEU7/r6pshrV/mGhntf6ESB9Ok=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgDXi-0006Lc-1i for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 01:20:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 54F8FCE0B61;
 Tue, 20 Aug 2024 01:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9027C32782;
 Tue, 20 Aug 2024 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724116806;
 bh=VjhEBDGS9iYKFsN2C3UZNPQFoThzUMhspy3TWnKLR4M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lOi9vDyjwCzXcfIo8fifN33o5TQ43g3hICp3VVPzlzw331EYhSzml+lqU86x3319R
 FPLdemQFvUQvC0Ljjbjuez4EbQ9hGn/b9/7W7i/fnf/JPnFXI7H0CwlA48lwXvdEQd
 vzAeN1Ja7awOoRnmTGbJbrQTxSJrG+BGZYYlkq25BE5Dzw5SIYDPeWVac5Ma3Or/f+
 lHwdZv9ItWV8qgpi4kCuS4UfM6ImAOZUIoeHc5EY+MPozMgUErOT0Mc9AxXaDYKGNY
 j2tIcuYWxoZu00vU0RvTNB4SqZfvXtqqhUdXBJFyxyBSddM6odIIbhdunRrpBuaDMz
 zx5nx1onEdxvA==
Message-ID: <4b916314-4d0a-493e-a04a-8148643e600b@kernel.org>
Date: Tue, 20 Aug 2024 09:20:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yeongjin Gil <youngjin.gil@samsung.com>, jaegeuk@kernel.org,
 daehojeong@google.com
References: <CGME20240819083433epcas1p3861b773a5b21eea6f0332036a71bb5d7@epcas1p3.samsung.com>
 <20240819083430.31852-1-youngjin.gil@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240819083430.31852-1-youngjin.gil@samsung.com>
X-Headers-End: 1sgDXi-0006Lc-1i
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: don't redirty sparse
 cluster during {, de}compress
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
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Jaewook Kim <jw5454.kim@samsung.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/8/19 16:34, Yeongjin Gil wrote:
> In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
> writepage considering that it has been already truncated.
> This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
> cleared during the writeback process for a compressed file including
> NULL_ADDR in compress_mode=user.
> 
> This is the reproduction process:
> 
> 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
> 2. f2fs_io compress testfile
> 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
> 4. f2fs_io decompress testfile
> 
> To prevent the problem, let's check whether the cluster is fully
> allocated before redirty its pages.
> 
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Tested-by: Jaewook Kim <jw5454.kim@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
