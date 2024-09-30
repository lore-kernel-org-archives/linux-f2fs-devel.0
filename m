Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75254CEB2CD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:58:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1svPLv-00007t-4c;
	Mon, 30 Sep 2024 22:58:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1svPLt-00007m-J0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Sep 2024 22:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dS4n3QnHh+PpiA6wC6wy+lguQrFTlkvW33TBYRPVFoY=; b=D58xhuUBmT6PeNgQbNdeROvpPH
 Kxo0Z2ph5/ffFxj+sv8x5RVoWFjWjIFsmZUr51H1sXh0/IqkgG0MsY5OQ5K1ak6EpnhlIZrMGx8RH
 Ws39q9glu4g8OPrezbTz6Yb59KUmcjbso/9/kRzy8+YESb2rub7MJGRJ0uiEJBqU75XQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dS4n3QnHh+PpiA6wC6wy+lguQrFTlkvW33TBYRPVFoY=; b=WvadbD0bf+F9pn/uGzRH6JG5W6
 ixzj1TTG1McQwE5X3//vaJkAW1JfH+jnpVjFccf2vOTyPsxpvzPdx6wakwshd2irI5zfWYKHrkrgu
 JAXPssnD8SkJVxgjA564ZUpQbmXX7mrfD/Tt/d6CNeD4hVmj9Gbn7gigWd5AhCArjOK0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1svPLs-0000be-TA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Sep 2024 22:58:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4A4935C4083;
 Mon, 30 Sep 2024 22:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946CFC4CEC7;
 Mon, 30 Sep 2024 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727737122;
 bh=MFG/hKEGiIm7gD4UtzPR9o5FvknYmjbixdWJbVryyLQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AmK8S4jcmacgW3nxCQGf39B6DLurLzrRW2UoNTUquIt9BYul23uLhgSQF4pSjXlxV
 SqJfazNTX3FjcWVBLBds7K5/NA9xZGt7Dppv9Ure8AW6fPs70mhaKT9bvFM3M8iHks
 Ql/pAenPCrTGFr8Ptwhid1l5DT9b+QES/yVzszfJsyOOI1esnUCDooGmQmYUgy6U53
 2FrKs1em64GBX92a2ZcTDf7I2QJHWzgL/zpNMq8PtgQHcX2q9tz6raha/EtAbugzyv
 Zh68nAdAwsD4wKclyiyXCn1G3BRCwNSjc4Uqv1LmyzhZtOLNfWX88C5K+0of4z4M3a
 x8uOUhrp3hmqQ==
Date: Mon, 30 Sep 2024 22:58:39 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ZvstH7UHpdnnDxW6@google.com>
References: <20240926140121.203821-1-kernel@pankajraghav.com>
 <ZvVrmBYTyNL3UDyR@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZvVrmBYTyNL3UDyR@casper.infradead.org>
X-Headers-End: 1svPLs-0000be-TA
Subject: Re: [f2fs-dev] [PATCH] fs/writeback: convert
 wbc_account_cgroup_owner to take a folio
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Zefan Li <lizefan.x@bytedance.com>,
 Jonathan Corbet <corbet@lwn.net>, gost.dev@samsung.com,
 "Pankaj Raghav \(Samsung\)" <kernel@pankajraghav.com>,
 linux-ext4@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 cgroups@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 mcgrof@kernel.org, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 akpm@linux-foundation.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 09/26, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 04:01:21PM +0200, Pankaj Raghav (Samsung) wrote:
> > Convert wbc_account_cgroup_owner() to take a folio instead of a page,
> > and convert all callers to pass a folio directly except f2fs.
> > 
> > Convert the page to folio for all the callers from f2fs as they were the
> > only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
> > already in the process of converting to folios, these call sites might
> > also soon be calling wbc_account_cgroup_owner() with a folio directly in
> > the future.
> 
> I was hoping for more from f2fs.  I still don't have an answer from them
> whether they're going to support large folios.  There's all kinds of
> crud already in these functions like:
> 
>         f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
>                         page_folio(fio->page)->index, fio, GFP_NOIO);
> 
> and this patch is making it worse, not better.  A series of patches
> which at least started to spread folios throughout f2fs would be better.
> I think that struct f2fs_io_info should have its page converted to
> a folio, for example.  Although maybe not; perhaps this structure can
> carry data which doesn't belong to a folio that came from the page cache.
> It's very hard to tell because f2fs is so mind-numbingly complex and
> riddled with stupid abstraction layers.

Hah, I don't think it's too complex at all tho, there's a somewhat complexity to
support file-based encryption, compression, and fsverity, which are useful
for Android users. Well, I don't see any strong needs to support large folio,
but some requests exist which was why we had to do some conversion.

> 
> But I don't know what the f2fs maintainers have planned.  And they won't
> tell me despite many times of asking.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
