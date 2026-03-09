Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE94FFCA187
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jb2CLRGD469QHQPSwzKCYNWKu0KAOxax1RJZcrrgjjM=; b=NGYNO3MYmmp6orivqIoRdw0PDe
	zGjLq/iDuiWCO7SUQTqDkbNr2e/CqlM/JBG6byG4GIofRrDhgNzuIuwNHOgg3BorYfCTM9H5XvJJD
	D+c51j8AGnxR8pUpLPLsSTMqX32P/6t5NP9cbYzLhk8FVMb6kZko8HDEajx+dhblV5d0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzhRk-0001ji-7z;
	Mon, 09 Mar 2026 20:43:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vzhRj-0001ja-65
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 20:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fi4UVye4gem2axpOsQaO5hKAYC0fKut1CdhkW1Dvc0M=; b=FPdvKkQfdRKMmrJG/dDMHMz7/2
 QnxOD0w98v6BJ4sFRcilUdiBpMmln1Y9V1kxvIP+URVIYTuHFwBx+PqyOi4pP0Iz7JFb7FbeToKdS
 8IdJXchr2xrTplGQeWLkqQnt2u+fkgn5jtsOwunxBVQ1C/Crq5ty2xftR5YrFhseP7ZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fi4UVye4gem2axpOsQaO5hKAYC0fKut1CdhkW1Dvc0M=; b=HYNLh/C98xREpoc2laOeGB8K8r
 ySQBadF/oA7WoPJAulrCXGZcxv8rm5/+CjOYWFkmM2+4q7rZHShJoQIT2BBSHLJd+aF3uk3h8IWia
 RF5Myk6B9rmQ5pLRJFeyFwusg4WEdhaVN3AUaE4si5CRrXDKms803GZFtkq/rR5QoAFQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzhRi-0005Gb-Lu for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 20:43:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 15D4F60097;
 Mon,  9 Mar 2026 20:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EB9C2BC87;
 Mon,  9 Mar 2026 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773088991;
 bh=LgbkmLMqtuYdFY11z23RJwEuy3ulRqnM9TgZfuz+WJI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pECjVXrpy9OUbNbNVsH0KaVo3LTgKu7FDofzwVvojZhIC+oT6MSC7DHR8ef/by7ob
 6itzmOmMCDtY972OYbTjZloNCOdo12p/r7AZtpteRKJldBv5Y+dkbk0XAiZSauZaWk
 Ry2KCfqFQjZQLW4k7GutSWPCjM9o/zS1hAdjswBVo+dSe9ObPKKDYWs1y1+2WcrNOk
 1f0DEmAI22rCPgKEbpxbYJWLJWj/5Ivx/yvvdTN+kraZXbARq5F3NAo1aTaKxeBiux
 X4cY4t6ohPYFgAmqCeHJEO1LYVn9h3S5DBWKYllkI67xDjgNSpHQLz/IaIjfboBojx
 izjvSIggQsg4Q==
Date: Mon, 9 Mar 2026 13:43:09 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260309204309.GB2048@quark>
References: <20260302141922.370070-1-hch@lst.de> <20260303223507.GA56397@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260303223507.GA56397@quark>
X-Headers-End: 1vzhRi-0005Gb-Lu
Subject: Re: [f2fs-dev] fscrypt API cleanups v3
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 03, 2026 at 02:35:07PM -0800, Eric Biggers wrote:
> On Mon, Mar 02, 2026 at 06:18:05AM -0800, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series cleans up various fscrypt APIs to pass logical offsets in
> > and lengths in bytes, and on-disk sectors as 512-byte sector units,
> > like most of the VFS and block code.
> > 
> > Changes since v2:
> >  - use the local bio variable in io_submit_init_bio
> >  - use folio instead of io_folio (and actually test the noinline mode,
> >    which should have cought this for the last round)
> >  - add an extra IS_ENABLED(CONFIG_FS_ENCRYPTION) to safeguard
> >    against potentially stupid compilers
> >  - document the byte length needs to be a multiple of the block
> >    size
> >  - case to u64 when passing the byte length
> >  - move a hunk to an earlier patch
> > Changes since v1:
> >  - remove all buffer_head helpers, and do that before the API cleanups
> >    to simplify the series
> >  - fix a bisection hazard
> >  - spelling fixes in the commit logs
> >  - use "file position" to describe the byte offset into an inode
> >  - add another small ext4 cleanup at the end
> 
> This looks good now.  I'll plan to apply this to fscrypt.git#for-next in
> a bit.  Other reviews and acks appreciated.

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
