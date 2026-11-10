Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966F606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bEYNbztY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ivgitTUv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GpqQKe7o;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ojv7JGOS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bLAOHW/bcMmEP3wX/7e2Ena+bEXVzlo+Lm+NO0hrxGo=; b=bEYNbztYeNq8RBnxta+mT1Qkq8
	74j0KUPC5ZbYluIrBDChVFS+sPQvp3Dx2f6AVQp5h2d1QALEyfbW1sGAc/q38EYZS0akSvI3UW0MD
	7eu0YtygoJLRLTy0HQb5NDeT5m5luSGg8Wnm+sgRQUlCle7PZBKdk+Tm92RoLTtV/0Ko=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQumB-000000008F3-1d34;
	Tue, 10 Nov 2026 22:57:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xQum9-000000008Ew-3jWY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zMRt6PxEL6Wb2BMxAkW75q5nCrNja3XGEsRDEq4iENw=; b=ivgitTUvaLJovK74eu61JknFZA
 19gDStV+PIY9GJ2WcE79O5mE8Jd4uJAbOwmTixridsPxwupuDF41tz+h8ji1/oKILwoT06/WFON8j
 SHv5siMN03vVjHmClrcodmpLzG+/X+p9fzFKPp7QE9j/ELExBYQnUDHTJYQ73+PwAix4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zMRt6PxEL6Wb2BMxAkW75q5nCrNja3XGEsRDEq4iENw=; b=GpqQKe7ohMANE/UbBvOT7F6Xwa
 MDfMqM4IRfYWCeS05DzAMGIMFNcGUwQNLcI1Tf3XzI0uetNhhC2HEqKss2NIZiLDE7JCVgJ2gMqiL
 cjXY2yeiWr4oBnWy0x6FihtIdixRMrYV7S0vBwU1OVhNouV79zlyJ6+/GHBTUrvvI0G8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQum9-000000003Lp-0GA4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:57:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 529F0609A2;
 Tue, 10 Nov 2026 22:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875021F0093C;
 Tue, 10 Nov 2026 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794351427;
 bh=zMRt6PxEL6Wb2BMxAkW75q5nCrNja3XGEsRDEq4iENw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ojv7JGOSi3XNYPhiz1NFjZjFtyIvIIfkCWUkrQJM2myd+KQysLMT6+MFgXCpigUrG
 SpzfWVOfHM7ZYNv1UZ+v/QRLRkpOKnk/FHJZTSD4vCT3tBjLbbQ2Dlm517GYNkEDfB
 x9ESehVJ1jovfuAHVBPWJyEQDR500o8rMdhM/f8UT/4K/KTFT170fl93Ghuh7YQJG+
 tyMom4SqIfHTgVJJz+Q1vXGcBqJkzE84onU5Rt1Nj8kJnQpPHgIU5vGA5woxVEPFEY
 +GLu/2NR9OpzpyceHd/Vs6d+b2VuxJt4fR7Pia5FB1V4uj+Zx+7vErQuyXYR6udgum
 4WlnjgFgHLddg==
Date: Tue, 10 Nov 2026 14:57:05 -0800
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261110225705.GG1907@quark>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-3-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQum9-000000003Lp-0GA4
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, brauner@kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> Every filesystem that supports fs-verity keeps a private runtime inode
> flag meaning Merkle tree is currently being built *_VERITY_IN_PROGRESS.
> They all serve the same two purposes: reject a concurrent enable with
> -EBUSY and let the write paths recognize the special writes done while
> the tree is under construction.
> 
> Hoist this flag into the VFS as a new inode state flag,
> I_VERITY_BUILDING, and manage its lifetime in the generic fs-verity
> enable path. The flag is set after ->begin_enable_verity() succeeds and
> cleared after ->end_enable_verity() returns (both on the success and the
> rollback paths). Add the concurrent-enable guard.
> 
> A new helper, fsverity_is_building(), is provided for filesystems to
> query the flag. No filesystem uses it yet; the per-fs flags are
> converted in following patches.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

A couple things missing:

    * Comment for fsverity_operations::begin_enable_verity needs to be
      updated, as it no longer has the -EBUSY case.

    * show_inode_state() is missing the new flag.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
