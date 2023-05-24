Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BD8C7EE2D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 May 2023 03:01:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1eki-0007ZV-BD;
	Wed, 24 May 2023 03:01:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q1ekf-0007ZO-CO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 May 2023 03:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mY8nBdi7dpGnGi1i3UayNuIVlU6vdOn+YOiK4ER+Eew=; b=QLoOnsYaEXB6E893/6alrb0jaA
 9rb53+BG62RAnWR1V0YLEkEn/CNlxvxjqcEzjkje73r0/azJlbuK03Vc7IhHTf9ex+2/8l4oYInqv
 TMzD4f5OJwMaaCQEVoDTUR4tdBcCjlYzpzOA45ChOKnqh+8ET4sRCzpf9MX8h/X8WNf8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mY8nBdi7dpGnGi1i3UayNuIVlU6vdOn+YOiK4ER+Eew=; b=gECQ88Bfle3M1ycsA/aZOvgf8r
 oXrwY1VW5qQ5sje3zLfGeYuoirM2fIwJ8bKL0gg9oq8w6jnhfqPKFlt9gcVzlO2D+YnA6qeWIGyoa
 E2Zph2eEFN54HF4zMeCZam0zyZe1v5Z5i4lVM0YLV0mxsnk05e4IqmN5el6e0op/xS7E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1ekb-0011R7-HZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 May 2023 03:01:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 18CFB637DA;
 Wed, 24 May 2023 03:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A927DC433EF;
 Wed, 24 May 2023 03:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684897275;
 bh=sp/Ume+GBHLoTEpuvlf0XK+PE025ykhly6ak9SBq7zc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nTS9dwJzGsrZhhAO/qQVIjlko93ei9TBykrirrxG88FPV5qcJx4rbo4agbRfIJWQU
 7gziVN323mxBE/6wANpWwBJTvUYdkQMmZpX/MNLxrjv1cuPNsUuVE+XykJx4Vx9u8T
 WPT/iPluDmiYsc7s4Ah2Q1NyN8k9pgO6irD5s8mDw4xp9kt/KyVxS5cnhcQy5lZgyP
 nfvuJHUO4BiZ9crJD1uIQHmS/ICJ46kxXsjLRHrg8dnGGR6KJKHsKyXJtSU1OANj+0
 UJYHjSqK8T6cxs8pAAqhC2DPanxRex3cVZxsbYVR/1Mx61NbW/7v3bp9uGO9e/SLnH
 8iFk5/cu49fAg==
Message-ID: <bccac3a3-cc5d-9be7-cfc2-f00fc4af5c62@kernel.org>
Date: Wed, 24 May 2023 11:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@infradead.org>
References: <20230522135018.2742245-1-dhowells@redhat.com>
 <20230522135018.2742245-20-dhowells@redhat.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230522135018.2742245-20-dhowells@redhat.com>
X-Headers-End: 1q1ekb-0011R7-HZ
Subject: Re: [f2fs-dev] [PATCH v22 19/31] f2fs: Provide a splice-read wrapper
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
Cc: Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@nvidia.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/22 21:50, David Howells wrote:
> Provide a splice_read wrapper for f2fs.  This does some checks and tracing
> before calling filemap_splice_read() and will update the iostats
> afterwards.  Direct I/O is handled by the caller.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jaegeuk Kim <jaegeuk@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: linux-f2fs-devel@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
