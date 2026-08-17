Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AACC5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVrXseCz+iYaEps2+ComuP7yotQZirMUc9/1Z39S0LA=; b=axgQ54CThRdscrsTg4aZdQj3v8
	fTWQzxZfabOr+pbUKpHeDXEKF7t4k6XCenyEwvH7DX9AcUFwTVqQTbzlKftqe3m8ZkH5RosjxeT57
	hTiP57thjPwBiQzrrrGNLPxDWGftICEuSsRJ4frHxHZfUbq0XiB8ToS2nVbCiCzOiixE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvrMz-0003ld-Qw;
	Mon, 17 Aug 2026 07:02:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wvrMy-0003lT-BQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EaYzkcBC9A1PcWOausXxABHrW115rCeEkPNENw/81+A=; b=aN4a2H/5pZK6PpFq9TMGXpctP5
 di8kC2SzTxk+Zz1GEpxET+zt2/1ZRkzm62F3IR1hpMtXHDG3Pb8EK3t2KJethix9kDosOgj1k7W5N
 d/fiwe28RhmO7DMj3rFQ0Sxb9pfz+lhSr93iC0YHwOhEip9x6UnXPHEh6d/+Ho9VEpbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EaYzkcBC9A1PcWOausXxABHrW115rCeEkPNENw/81+A=; b=nUvoreqiuA5mpyYEyYn3eFxZPR
 gmkRa8q3cziWkGQZ//7bxiuByIqZBcxjY3pSgyt5SwxGI4AAR9ipbktsHTNqjXXBaOWw9lXDbOW5H
 ggkuQGZut8ixDFnUTZMMTCvDqHcvU0maxMjmOl/Jiu8s3kMCg3QS5WGV7S3pC+hS/oc0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvrMx-0006j1-MK for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:02:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 437CF68CFE; Mon, 17 Aug 2026 09:02:41 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:02:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260817070240.GA17371@lst.de>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wvrMx-0006j1-MK
Subject: Re: [f2fs-dev] [PATCH v15 00/25] fs-verity support for XFS with
 post EOF merkle tree
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
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 linux-ext4@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-xfs@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 14, 2026 at 11:24:17AM +0200, Andrey Albershteyn wrote:
> Hi all,
> 
> This is next revision of fsverity for XFS.
> 
> Range-diff with v14 also below.
> 
> Patches without review:
> [PATCH v15 07/25] block: add task-context bio completion
> [PATCH v15 08/25] block: don't delay bio task completions
> [PATCH v15 16/25] xfs: handle fsverity I/O in write/read path
> [PATCH v15 18/25] xfs: make xfs_free_eofblocks() work with fsverity
> 
> The patchset include some patches from lazy-bounce@hch-misc series for
> BIO completion in task context

A different version of that landed in the block tree.  So let's hash
out how we want to handle this for the 7.4-rc merge window after the
dust for the current merges settles.  I can have the lazy bounce series
ready early for the merge window, and should be able to send it out
once all depdendency trees hit mainline.  Does that sound good?  Or
should we split the minimum requirements into a separate branch?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
