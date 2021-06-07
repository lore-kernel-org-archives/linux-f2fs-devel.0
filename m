Return-Path: <SRS0=2MSU=LB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A323BC48BCD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 15:46:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB4460231;
	Mon,  7 Jun 2021 15:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB4460231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lqHSb-0006q1-RP; Mon, 07 Jun 2021 15:46:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <djwong@kernel.org>) id 1lqHSa-0006pj-VE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 15:46:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtfMos+uZ4t3J9WDqdZERAeKNopXwbOjzCJ3bvCh8RI=; b=mRRYuHfSuP6XEtpC8MWwpfye+a
 D6uu+DBFFGHnkP1sCZQXssxtcws803SdDjQNaZyKeVpPp30ot/hDRVKLr7YekTlMzG47BdWYQ4JCW
 s4t5ub1VjQO0IglbZ2wX8is4EcK+JaVR4DCMp6/GC3FYrbqw2Micqr3XsSy3kBAkV2rE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UtfMos+uZ4t3J9WDqdZERAeKNopXwbOjzCJ3bvCh8RI=; b=jUOZJriQcSs20QCSAkEspyD0+O
 4TFUV/EH3uy3a7v3JRSbfDdZs5OpfYVad6o9ZMcYPuBsBs7nWZTAy4R1BhcP3+Kos6XimMfbV7NsR
 S8DGpvHPGSjdvDKLJ74KvSYg/ENv4kE7ARnDkllsXYYEIG0E2iNtMcw7o0l2+Qt6g7hU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lqHSN-0003mb-0B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 15:46:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E89D61029;
 Mon,  7 Jun 2021 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623080782;
 bh=HI9sxdPlDL3aHynFPkgW9uXuKBCOLyWBD+N0DWRCj2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lPwVfoMqlw+XEIfsv+kdzxNX8xhODaFTCI4bqlXwN7KkZp+iaz+EJ62t14aAWNsuC
 vYA6nfBE6J13L0Y3/m4VoZi6SGzXvq7pOudicJvOJc1r+9qWFHy3KDad8J21rx9pvs
 /DgvsxbS20QsQ8REiqdx02ut3lpWU6VU9Fj1C1hCIzpqS3Zgh1ch6yXKeTecb+6PW7
 CZNPV5q9NoHPdExrubdgnHKB7S3FQeSG0n8CfKQY5LMmbaxl5QuAaNYJAqB81RjwHZ
 ha1gKbkyjFs1r2Rjg2Lwz1V186iMcCy5tD24waMQJcvIAce13cWPSYGxHRSgFM44aC
 z5U0s0L18zPxg==
Date: Mon, 7 Jun 2021 08:46:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Message-ID: <20210607154622.GG2945738@locust>
References: <20210607144631.8717-1-jack@suse.cz>
 <20210607145236.31852-4-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607145236.31852-4-jack@suse.cz>
X-Headers-End: 1lqHSN-0003mb-0B
Subject: Re: [f2fs-dev] [PATCH 04/14] mm: Add functions to lock
 invalidate_lock for two mappings
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
Cc: linux-cifs@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve French <sfrench@samba.org>, Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 07, 2021 at 04:52:14PM +0200, Jan Kara wrote:
> Some operations such as reflinking blocks among files will need to lock
> invalidate_lock for two mappings. Add helper functions to do that.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Straightforward lift from xfs, though now with vfs lock ordering
rules...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/fs.h |  6 ++++++
>  mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d8afbc9661d7..ddc11bafc183 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -849,6 +849,12 @@ static inline void filemap_invalidate_unlock_shared(
>  void lock_two_nondirectories(struct inode *, struct inode*);
>  void unlock_two_nondirectories(struct inode *, struct inode*);
>  
> +void filemap_invalidate_lock_two(struct address_space *mapping1,
> +				 struct address_space *mapping2);
> +void filemap_invalidate_unlock_two(struct address_space *mapping1,
> +				   struct address_space *mapping2);
> +
> +
>  /*
>   * NOTE: in a 32bit arch with a preemptable kernel and
>   * an UP compile the i_size_read/write must be atomic
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c8e7e451d81e..b8e9bccecd9f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1009,6 +1009,44 @@ struct page *__page_cache_alloc(gfp_t gfp)
>  EXPORT_SYMBOL(__page_cache_alloc);
>  #endif
>  
> +/*
> + * filemap_invalidate_lock_two - lock invalidate_lock for two mappings
> + *
> + * Lock exclusively invalidate_lock of any passed mapping that is not NULL.
> + *
> + * @mapping1: the first mapping to lock
> + * @mapping2: the second mapping to lock
> + */
> +void filemap_invalidate_lock_two(struct address_space *mapping1,
> +				 struct address_space *mapping2)
> +{
> +	if (mapping1 > mapping2)
> +		swap(mapping1, mapping2);
> +	if (mapping1)
> +		down_write(&mapping1->invalidate_lock);
> +	if (mapping2 && mapping1 != mapping2)
> +		down_write_nested(&mapping2->invalidate_lock, 1);
> +}
> +EXPORT_SYMBOL(filemap_invalidate_lock_two);
> +
> +/*
> + * filemap_invalidate_unlock_two - unlock invalidate_lock for two mappings
> + *
> + * Unlock exclusive invalidate_lock of any passed mapping that is not NULL.
> + *
> + * @mapping1: the first mapping to unlock
> + * @mapping2: the second mapping to unlock
> + */
> +void filemap_invalidate_unlock_two(struct address_space *mapping1,
> +				   struct address_space *mapping2)
> +{
> +	if (mapping1)
> +		up_write(&mapping1->invalidate_lock);
> +	if (mapping2 && mapping1 != mapping2)
> +		up_write(&mapping2->invalidate_lock);
> +}
> +EXPORT_SYMBOL(filemap_invalidate_unlock_two);
> +
>  /*
>   * In order to wait for pages to become available there must be
>   * waitqueues associated with pages. By using a hash table of
> -- 
> 2.26.2
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
