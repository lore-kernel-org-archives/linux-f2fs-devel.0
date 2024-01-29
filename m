Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E15C47DA9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:28:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUb2v-0003XU-4Q;
	Mon, 29 Jan 2024 23:28:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1rUb2s-0003XN-O5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 23:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4BL9YkvsHxZF+N90otJjttq9jOeIS5iP5m+mMKWCFlc=; b=DbRwbVBqkZMhIwvUROEGl7GlN8
 PqQU0Abtk+FEq38Lw2GHiggRZbuOO7KnValIYLAMzIC6UH+yuwzP4saG/SAB09euzK9U/rbtUU7jb
 TJ7XZeXG3yvee6FehF0ngrEwkGTe6rihguFA5+B3qviAV6+C7C6BDvCSzH7lFZThmpis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4BL9YkvsHxZF+N90otJjttq9jOeIS5iP5m+mMKWCFlc=; b=deNtZdbzAK5i7pFSSq6OtU0PaB
 Oj/l8VoYZwx7MPe8kOzHFwq/niaBAiqu1u0Z0VxrcsFou1Y3wzAdWLrwRTRSs1c6YuwbyLmdlxeRa
 nMcXbgn52E+x7zccSX7GaaUkso/0WOOgU3Z9wo1sbDHW9mpq38tX4EDdinT3nJSDG8gQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUb2n-0007Xr-Jl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 23:28:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DAD506256D;
 Mon, 29 Jan 2024 23:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1237C433C7;
 Mon, 29 Jan 2024 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706570871;
 bh=Mdn+J9ySgQDC0oIOmuVaL01BXzHtXOiqj1R6pkOEXjg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jRmN35v5/TLg+E/6GKrLcZzc40NYxmcq8gYRNw3u3sie30Rz+d4av7V7MegSsvqxG
 KAiuOGk8tu1E8XEbv7dckuFrLaVvYOpq53UYRA227YbeEkM9B2tRSdYDDjlpShY8Rg
 t89UsvoRUr8Xjtv/+1ilsuMwibhwjrERvpTSDoPSFskCTLvL24IQNVeLqQduEKgJcC
 JqA7KuJS+iTk3EagquaUHipVQpJUytNEzUi33la2Et2MbK9oVD12OV2tPIqOg7zsY3
 ymEpmNGW3zFiJot8m6q+DnJAvGWXMjv93tIrljuszNfyQhfzZTx3LriKq9mqEaCvH0
 Ff5p4GJAKdBfw==
Message-ID: <cb6d6cc2-25bd-4ce1-baa8-9ba94672977b@kernel.org>
Date: Tue, 30 Jan 2024 08:27:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
X-Headers-End: 1rUb2n-0007Xr-Jl
Subject: Re: [f2fs-dev] [PATCH v3 4/5] f2fs: guard blkdev_zone_mgmt with
 nofs scope
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Guard the calls to blkdev_zone_mgmt() with a memalloc_nofs scope.
> This helps us getting rid of the GFP_NOFS argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
