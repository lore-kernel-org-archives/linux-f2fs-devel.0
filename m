Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A130C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sjymLoeXBHYmcT11TBXiQcx6lTR/XpJiZN/Rwxbcw+U=; b=ltUXvWnyltfqze79/esPrlFae/
	8aRu3BD2xu4JGy7uCyUZEF6doTqg7u17z38+o5vU61YbtlQDnkYHUnGilXDQbhxgJXBUXwXV/Y7pV
	ckwg2LJtURv/nUMPqbMZU2v6Gr96ZC6n78te9cOx8Qrli6hoGPIGftgCed7b3gSlceeY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wob0P-0001IM-B5;
	Tue, 28 Jul 2026 06:09:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wob0O-0001ID-VN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:09:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lDNd1D8ooHkbyGjHA6UcmCnxY9qHLFiB/wayD816snE=; b=W0sJxeQfXT3ciM2yaO4VSE8bMn
 Bdgy3+NvfJrPzU6aQbZtrm5p3Q1y/XzGtoOZv5fer24eibAMAV5jzvb0mEXLPk9s8OOzklke/pGYY
 mudbi/qSfNejMiTg0ZAa73JIyxOu3AcN0mEwBPMoTg5PlqW/FvThLML25QcYWh+7lEM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lDNd1D8ooHkbyGjHA6UcmCnxY9qHLFiB/wayD816snE=; b=ixzk0L+uQgV/vCaV2HC4uFDb9b
 zt23xsKJbRhIVk2unoFZUhjBsR7TxGErItbjGDiBtD3s3vwk8OwCYd4NiqIxn+949twnOOd8dUyLI
 ED6JtNVd7OUm1bQfCPi/Y/B1xrWAJ/TkMLVMFFF/ur0/WVpReW+rOt7q14TJv0zKxJjE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wob0Q-0000lW-GF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:09:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4194A600FC;
 Tue, 28 Jul 2026 06:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1001F000E9;
 Tue, 28 Jul 2026 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785218965;
 bh=lDNd1D8ooHkbyGjHA6UcmCnxY9qHLFiB/wayD816snE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=M70NaZTMczMcW6kreE90OnxKmFXc/B/f9SZN6hg5rS7wyYg9RSvyxAozJPNsHs/jm
 ggZ5fFYa7jgKv3hvmxObVx9K2/++KwOB3FschJW7rqxbVSCBRrQRQpksyVIkE/qq/O
 RCZuImHMX74Jj+HJmsytYYYzJp1aev6whaFnQeAba4Yyp9akgYnjgSov/LNANVtjVF
 fc1hCU0L785OgYy0fxSaF5XgKlQIx9Hr/IsEhltOMy/tEOUQuxC4cSJDgBHhipHESi
 wCrk9j4MD5NmR1vTHYLepTPzNrDQJfSjf9vOLg3aM1bBMBRVrM+vXO+vMzZvO/bePX
 1hwL2GPGcXd0A==
Date: Mon, 27 Jul 2026 23:07:30 -0700
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20260728060730.GC99797@sol>
References: <20260724133328.1837318-1-neelx@suse.com>
 <amgfuk12imPN2XJe@infradead.org>
 <CAPjX3Fd1KPswrsNe=BeDpkDwi8CmL9HNKcPScMsgGN16MDyVEQ@mail.gmail.com>
 <20260728054847.GB99797@sol> <amhGiIsvNIni_VAE@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <amhGiIsvNIni_VAE@infradead.org>
X-Headers-End: 1wob0Q-0000lW-GF
Subject: Re: [f2fs-dev] [PATCH 00/12] fstests: introduce fscrypt support for
 btrfs
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
Cc: zlang@redhat.com, djwong@kernel.org, Daniel Vacek <neelx@suse.com>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 27, 2026 at 11:04:56PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 27, 2026 at 10:48:47PM -0700, Eric Biggers wrote:
> > Please keep sending out the tests along with the kernel patches.  But
> > yes, they aren't for immediate merging and should be tagged with RFC,
> > and the cover letter should mention that the kernel patches are pending.
> > Thanks!
> 
> I think the split of the v1 vs v2 policy tests might actually be useful
> as-is now, but I'll defer to you.
> 

Yes, I haven't looked at those closely yet, but splitting them out
should work.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
