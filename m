Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BE8C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 21 May 2023 23:44:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q0siz-0002vI-Hv;
	Sun, 21 May 2023 23:44:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1q0siw-0002vB-6u
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 May 2023 23:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D3ON52/oBoiDPPEwPVEo7ufvfEHAk3mG/WX3TEQY1Ow=; b=kqKbjfKm31+wliGHuCtErT9MkX
 DdYV3lNyoRn9IoxglcmaArShz0MUC+D50sGh8j7hgTRolSI0AOzUuSQnctHIju8xJeuRkp0dDgQni
 Wgc3KrjSSKXyj+KDSIb8ObCJh3bDOGG3GFjJ1SlwbmXYF0bp0h54Zi8KjT+o0WFHcQIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D3ON52/oBoiDPPEwPVEo7ufvfEHAk3mG/WX3TEQY1Ow=; b=SBxQuCJcjFOV7iRXDjm5oSfU9G
 JsSj7KYpqQnqG8sDG+bIhsNwUA+n4etStHxk4s8weQkyH9c4gMAdbo5cEPKHn9FrCDw6x1bVsHbaw
 tf9/uNtAXxO6QANdgOfghR0yHE2v3ugJ+S2sloihHKwpJmjKmGJqg/WKxExUboT4g6HI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q0siu-0004Wt-V5 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 May 2023 23:44:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8504D614C7;
 Sun, 21 May 2023 23:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575A8C433EF;
 Sun, 21 May 2023 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684712659;
 bh=rN0pgHH364PGD+YbnxODmAiedsQk+sR/miSpfYq1jG0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B01HdAPFZNpXSANwj/AR66SsyvdifehJ3h1PPX+3t5dhQlViDal2O1TfIz0ZR/l1+
 nWRp26BJPxq1xulOdyjJxBPQFYsZi4oOoIiZy95llY8Vpy9+T3XIicMZVbexOWWdx6
 aPmpOFog+AFn7kPaWaFyD7Zkc7qmhAYTysqlisd6I0upsE/lJvleFWkJqdPeBQUrhJ
 /qk96Ki0QX7a8xyjGjhDmPzSxEtzRViITwpML49uUWd3BM4vuAWHX43lz0K7EkKekd
 SxswSxIkzlIcQd9/WA+JdT9SYjDE3w5Hio7Z+4H+xfj4WBDhshhfMKwRRVvz3n+dYJ
 jBdlwTDfxyd2Q==
Message-ID: <600202a3-25dd-a404-9051-637fcbc90db6@kernel.org>
Date: Mon, 22 May 2023 08:44:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-4-hch@lst.de>
X-Headers-End: 1q0siu-0004Wt-V5
Subject: Re: [f2fs-dev] [PATCH 03/13] filemap: assign
 current->backing_dev_info in generic_perform_write
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/19/23 18:35, Christoph Hellwig wrote:
> Move the assignment to current->backing_dev_info from the callers into
> generic_perform_write to reduce boiler plate code and reduce the scope
> to just around the page dirtying loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
