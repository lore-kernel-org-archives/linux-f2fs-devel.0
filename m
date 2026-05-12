Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACF7CD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aHuu1BXixKrFARdplazUYCmoTmIPPEYpQz4xSvpSAoQ=; b=d6ffX2EhGzx4NQMHipkdSQHFxH
	m0qOUWxo62wZLCewWiGlEbWCbnTH5l+Zjoq/QO+5myxEsW1ZT4yUHq87DnjtqOJQ0SsAtVlpx3DT3
	gFKHmYh1qj6neYmIOx/JAH1U5dU52XFVfBJsd9In15RXGOqTDM+SBXumXBfcM7yahBXE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhk1-0005tt-U8;
	Tue, 12 May 2026 07:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhk0-0005tn-Uo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UywdvZwZh2rj7+kkQt0ERW4ZHo2QGonfqFX8tXYpecg=; b=DsvHmeLVZMdq8eyTk3/dxvM4MU
 SCmRrkUsRSgzTGPfWC5PycRnw+tWU+o6T4zzyYOurqTXUYDAq2KQ4++KQ+A4Z6tFyHvuNNEwXYn67
 Ju5qQIdtV+GEmiJywFsv/3FNWRRit+4/6D387ODjnDoyPMWVlteEydT06FapWj4niHj8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UywdvZwZh2rj7+kkQt0ERW4ZHo2QGonfqFX8tXYpecg=; b=ZO92hjxn4pCc2ePSdBfLcIPBmV
 Lpdlh4itpQspVwfSlQ1ObbKdP30hf1CPuYUkV2uv9/mhP79NgB5Y5CaabWZ5Ru/eCNjDS6ZAHQcU3
 JZLYhIE0xc6kexiv4fs5aC8SSPmifo88kIWfaP/XI05CpPftcWx3QGM7DsIQ6CrIM9ko=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhjz-0002yb-If for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:41:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 64043600CB;
 Tue, 12 May 2026 07:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C56C2BCB0;
 Tue, 12 May 2026 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778571674;
 bh=uHgramlR2UsacSFL8Nsu5N5X+GjYLWlhcrhT4BezNyc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O9sk2Vp/6GejyLBdgb0tqXl6XI8Ee217W/WOaFreEgpDwIvDrdcYs5L+UvVMSDEtr
 VQS8spmPo1GjuFg8lOqv6BgC/h2D4BVJV7320DvGlZ0uQw9DMip1t5wzR+QZ+PZqvX
 4euKkWF/7dSzn05IMr0YYsxImiQ5qB0q+sVlxBJaaa2seN5mPMPKL9DHtjsuYB7qn5
 VPCiIaEbt797FILjsA9YdVx/DZCl4+YtNpBHarBuSuyC5IfT8VPCxxOsG44wp00wG0
 nipgyIPW9XvlM+VpiwqXL2eRV69/I7/NkoZhH5IsZAm++5jfr2M3jbXO5AbKZHbT+w
 9wE+XnHRqTRmA==
Message-ID: <ec8ae080-56de-490d-a1a3-e646e4a2d629@kernel.org>
Date: Tue, 12 May 2026 16:41:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-13-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-13-hch@lst.de>
X-Headers-End: 1wMhjz-0002yb-If
Subject: Re: [f2fs-dev] [PATCH 12/12] swap: move swap_info_struct to
 mm/swap.h
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/12/26 14:35, Christoph Hellwig wrote:
> swap_info_struct is now internal to the MM subsystem, so remove it from
> the public header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
