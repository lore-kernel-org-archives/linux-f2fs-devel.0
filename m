Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046ECC7EE30
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 May 2023 16:03:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1UTo-0003Zi-OV;
	Tue, 23 May 2023 16:03:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1q1UTR-0003ZN-8I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 16:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Id1VKkE56aIEmPBnec0ekPBXZTL3cL113Co8IBTMxVE=; b=fHjfr7DPq/ZHjEMckVkAETQTYF
 haUrLSC1LH+VXMY9brOwjmN8VtlbPbJpAQIAufKDkSf4D7wmZ726r6Ucea6iKx+SySYEFcZ+mRlVE
 gy3pHcMsNe0xpkyIdjHmrBiKXLL3F4fnSRSf/H/51qckwmwibhk/ZTkrUnmPESW2jaqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Id1VKkE56aIEmPBnec0ekPBXZTL3cL113Co8IBTMxVE=; b=KvL0ynuDpnV8KYqnZB/GsfW/HG
 U9kXI/MbUTxIWsSeJzht65JNtwY7MMJmYwJqrAWvaWwuveSUz/j0zhcdleUFi/6k3fzNJWCbFddzJ
 dCvNrKhun41fz9bIYDRFvZHUCpAyPQJ2qRs568oHypKrBVy7TEOItsWXZvNtBNjxU0XM=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1UTM-00069o-IH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 16:02:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C16D767373; Tue, 23 May 2023 18:02:44 +0200 (CEST)
Date: Tue, 23 May 2023 18:02:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20230523160244.GC15391@lst.de>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-9-hch@lst.de> <20230523010627.GD11598@frogsfrogsfrogs>
 <ZGwza3fdkBHyVG3+@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZGwza3fdkBHyVG3+@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1q1UTM-00069o-IH
Subject: Re: [f2fs-dev] [PATCH 08/13] iomap: assign
 current->backing_dev_info in iomap_file_buffered_write
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
Cc: NeilBrown <neilb@suse.de>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 23, 2023 at 04:30:51AM +0100, Matthew Wilcox wrote:
> AFAICT (the code went through some metamorphoses in the intervening
> twenty years), the last use of it ended up in current_may_throttle(),
> and it was removed in March 2022 by Neil Brown in commit b9b1335e6403.
> Since then, there have been no users of task->backing_dev_info, and I'm
> pretty sure it can go away.

Oh, nice.  I hadn't noticed it finally went away.  The next iteration
of the series will just remove it.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
