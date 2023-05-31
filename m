Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACE0C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 May 2023 09:09:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4HpF-0003KB-KV;
	Wed, 31 May 2023 09:09:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1q4HpE-0003Jr-8U
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 09:09:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JubkPk4gPDeN9b7yimB7oHd7wZ3DFjoxys5W0ASlmQk=; b=CwpBGA1Nm1iauOXIKErPjWzDAv
 bSTLSckEco/n9duyz99M7+AF1F9xtpf50eDaoHAz7OWaZePn7pa0+zoHye07KTkkwepoVcKprm0Sp
 FoARU+8QxXBCnRV8SnhJGwVw3TmJxRLFB9XHfvSLjsD8/nxRF/K6BDahyIysHDQFbY3I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JubkPk4gPDeN9b7yimB7oHd7wZ3DFjoxys5W0ASlmQk=; b=VJJMqfBptczMv3ykmjv7l+JdGr
 czICnYq/PFMs58PJsTC4VxFLt8ivgQRDpwGM8yz+UErsCfz7c5BAygYZvkCT8FZdVX0LysYLElaVG
 JmHaQdf27saMlofAlFGUDIGG73LjGoy0+6AlYVLk98IXrZdl82yElnLnEJrijd5O8Q6g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4HpD-0001Rs-Ml for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 May 2023 09:09:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD02634A9;
 Wed, 31 May 2023 09:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414AEC433EF;
 Wed, 31 May 2023 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685524133;
 bh=axEkNRQxOw2SsrEsKVeeUf3LFs4+Ez60j1wdXzIL3N8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=E4gFHy8TJgSROxww8OVcO6e3p3dd7vo4i5KSweH0NOnDdcWZRx6VhzGl/tF5voshC
 UdmJJJ49kI5kmDv8uxIQcXuTasv67aBuZrAX/nFEXNjew8xfFV3/Tv9o4t/50sX560
 4osRYtHft7VGmBwOugY2d3gckgf798HrCVdO8An/XzC3FA/TtXWsZVzkSXWlRu/3m1
 UcmBmqSm6PgzPnQ6YZuJR6SC10cam6xiaiwNt5PMth2Lvq3oHSe/HVHMr8zaZl9OXp
 N3UA7Kz7at7Iul2UL15fIZVbY2+75CmNbSF/oiTJWoy68QDXpRnZJj8Do8LRZ7JegV
 xaP9uJgHiusmg==
Message-ID: <54b4a89c-4023-526e-62e3-8f7fadc2861d@kernel.org>
Date: Wed, 31 May 2023 18:08:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-10-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230531075026.480237-10-hch@lst.de>
X-Headers-End: 1q4HpD-0001Rs-Ml
Subject: Re: [f2fs-dev] [PATCH 09/12] fs: factor out a direct_write_fallback
 helper
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
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/31/23 16:50, Christoph Hellwig wrote:
> Add a helper dealing with handling the syncing of a buffered write fallback
> for direct I/O.
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
