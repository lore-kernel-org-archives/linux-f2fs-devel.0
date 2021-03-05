Return-Path: <SRS0=WIjR=ID=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EABC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Mar 2021 04:53:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C616064FEF;
	Fri,  5 Mar 2021 04:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C616064FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lI2Sa-00016a-O1; Fri, 05 Mar 2021 04:53:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lI2SY-00016S-HF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Mar 2021 04:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4n8qMtKnFvmXMuQGUev513J8KI8VnSUXq/UAs1qjeBw=; b=VQFcrE0q/Pkq8oulKZyXJgcWXi
 y7dsOstXjwGIVAxjTEkv3LpbM/uTW+hZ/b3LGy86DRuJencCY9pWaBNkQq2f63uUDGX/g2EOcXTMO
 rcpRcoCWTv0kyHcHZFJ4wE8eu6wPCICY1lKNwmModE41/yMmEirpiTFbCVjVBimjf6lA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4n8qMtKnFvmXMuQGUev513J8KI8VnSUXq/UAs1qjeBw=; b=LNzUGMbcAhpt+WMTbWJrA3d+a0
 w1nqvorWhsI208AFw/ezDoneXWvEH96X104lx2/PGrFWnSDEgDZHx0hBMpeRjj+8NRunW8yyExT8v
 cQ5Mc4sgNTIrpkO0+Pz85+c6uB40ST775yokrnjuVtObHUxqkN5VD6SOigBmy9BbsN/U=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lI2SO-0006Tp-PV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Mar 2021 04:53:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9660664EF6;
 Fri,  5 Mar 2021 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614919964;
 bh=zxC/9kcMnACFzH9ITkD6VZhydnGwzCTG1L8sFScG1+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NR5s6qZojEz91xa3HAt28QIC7ilr7VJvXJx9/mWCWO4FRBMVzUe4NKKfVaL0yCeJv
 H7+NaaXIyT2Ms980B/Wzm9QqtpLbdZhnzjfpfJqulai7y3eFrMwSAWCi03EsxMfvmD
 7Eas8GztpTBLgG+3KDOYLUDGBxegYRxxhklIrXKonWAlJ+YSU8/yridJ9IpZM+S524
 czMoWgLwnydRSUwX9c4wiaoNK47w3LU/KCrBswOx+z1aOD23pxzETX35iUvbWdGWeQ
 rZLHl355CVJweaeNblh+oh1YmOxqtkg4tL62hNaQ2LGCs5SlhEYrtIOt3/y76c9wT0
 hJhrJJ89om/SA==
Date: Thu, 4 Mar 2021 20:52:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YEG5G5d2YisF8zB0@sol.localdomain>
References: <20210302200420.137977-1-ebiggers@kernel.org>
 <20210302200420.137977-3-ebiggers@kernel.org>
 <9980e263-aa25-cf50-5a94-9f63a5ae667e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9980e263-aa25-cf50-5a94-9f63a5ae667e@huawei.com>
X-Headers-End: 1lI2SO-0006Tp-PV
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix error handling in
 f2fs_end_enable_verity()
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
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Mar 05, 2021 at 09:37:26AM +0800, Chao Yu wrote:
> > +cleanup:
> > +	/*
> > +	 * Verity failed to be enabled, so clean up by truncating any verity
> > +	 * metadata that was written beyond i_size (both from cache and from
> > +	 * disk) and clearing FI_VERITY_IN_PROGRESS.
> > +	 */
> > +	truncate_inode_pages(inode->i_mapping, inode->i_size);
> > +	f2fs_truncate(inode);
> 
> Eric,
> 
> Truncation can fail due to a lot of reasons, if we fail in f2fs_truncate(),
> do we need to at least print a message here? or it allows to keep those
> meta/data silently.

I suppose we might as well, although hopefully there will already be a message
for the underlying failure reason too.  Also, f2fs_file_write_iter() has the
same issue too, right?

> One other concern is that how do you think of covering truncate_inode_pages &
> f2fs_truncate with F2FS_I(inode)->i_gc_rwsem[WRITE] lock to avoid racing with
> GC, so that page cache won't be revalidated after truncate_inode_pages().

Yes, that does seem to be needed, due to the way the f2fs garbage collection
works.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
