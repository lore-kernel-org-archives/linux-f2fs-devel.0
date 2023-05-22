Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B73C7EE2A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 May 2023 00:21:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q0tIU-0003O4-4l;
	Mon, 22 May 2023 00:21:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1q0tIS-0003Nx-SB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 May 2023 00:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C6oYnjVx9ie7Txv29XEiipji565OvD93nKT1/kcO+18=; b=AMpOetkIBOM0D2eoq/9/SmBuna
 oGanmzTuPAef4U8YAr0/VC2f7wRW+OtK5Kj2YZRks5W+iSN1b13tIYvV0zU6/3SDGTcZB0jnoCw1f
 9wRNV5xNJ9IiMo6Lh4FzsORftY2gZ94j2pQwkRTvzUSWjLo0gGu37eSAV+L1haVqaG4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C6oYnjVx9ie7Txv29XEiipji565OvD93nKT1/kcO+18=; b=jq0rQ4BZbqf3pLJeXWhRzrqvsT
 S1/FmuHVxd6NIMUCHPQIomRY1TRanh0oov2oKsgCAIMRz0KnhLqWzUc+rrvsRWyE3tvqOKNUt7Aiq
 ackR0PLgErGyKQBy0ToadrHLKhIu5uBIu4SOqiQeOCdratDO/VIQonkFSPn6pyNwvtSM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q0tIS-00FIMq-Bs for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 May 2023 00:21:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F2CDC60EBD;
 Mon, 22 May 2023 00:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EDBC433EF;
 Mon, 22 May 2023 00:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684714862;
 bh=mxFY5Ys3GsQsIss7C7Uz0yTTtJAH+VljEJbbEGeCG9A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AOSxZ5qfdalhJdXdqKVodV1oVuts2OqvnSzs7CTgxOnTnxICRLF1NjMt0rmrBCifR
 FnRkh25eQpaY3arFCHzeVWQYhArz18DlwxhSxTKNFTaKsTOc33VlWLcTMHN7SrA9K2
 Pb/N/mgjzTqIbnnqBSkGmlHWaFqlGoPh6nNSwg/6eWqnl0A87XlA30iI8m6OjlVUfR
 E72Ao23rJ7IPJ4Lr+0yXY3HSz2wEG+iKkXIZKu7UsZEkxBT1DOtA2rwaXY8rwyEKMu
 U9RBxJviCJziKLvv/U6tQZEHqEusoH4w8cssD3GHKeKYOR80V0NqT/J5czvUfZgHIt
 H1ox3tSLA8Rbg==
Message-ID: <46f0818c-a04e-466a-3037-7cad41290512@kernel.org>
Date: Mon, 22 May 2023 09:20:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-14-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-14-hch@lst.de>
X-Headers-End: 1q0tIS-00FIMq-Bs
Subject: Re: [f2fs-dev] [PATCH 13/13] fuse: use direct_write_fallback
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
> Use the generic direct_write_fallback helper instead of duplicating the
> logic.
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
