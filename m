Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AADAC46CD2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:23:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUyNk-0005Fz-GF;
	Wed, 31 Jan 2024 00:23:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rUyNj-0005Ft-Iv
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 Jan 2024 00:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ED+roD9mzDndzR24BJXX1xkTwyet9MXt9L11gGKkyaI=; b=ZF0qbP9nOttQPxbX5MRWSKU0SK
 daHU5899WLTDLzT1DwUxPkpPJ4kQ6tNQZ9kObcWfd5C11Rl2rh81zpfAOpqNvTMC6SqdDlXRo0AFj
 25J6zbRYdZ6Dw+AOGUhHiFUhMVGpcAg/REk8nbPfD6PB3yNYSNzhxyilV0Cas74niq+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ED+roD9mzDndzR24BJXX1xkTwyet9MXt9L11gGKkyaI=; b=XobejhZ2htYr+i/L1nNpoOPuxF
 tCLa+uMjznU6qVhPAkUkpKQruDQTf0Meixya3dgt0eDDuVQA3XZKlIc54jE0lYc06k7VK4bbe52Rb
 i7X5m+HpVhRhflj768ALYtoB1LwHGseRrPlCvJNS5W8FhAR6PS0HcusL+yDH5vk7UgIE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUyNf-00024K-PB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 Jan 2024 00:23:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7FD4ECE1D1D;
 Wed, 31 Jan 2024 00:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D3CC433F1;
 Wed, 31 Jan 2024 00:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706660580;
 bh=ZHcmK97bEwj2r3qzU94neICtQokjkJ+hHC+srZkKdz8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PDTNjGjypkWJm6CTVfPNj3ZBHYWA9TADsGf+ary7R9O5cPhHWun/I+BStulvVfXtW
 2U8o2IOFEkvbyEKBSV4rcnqvG3DXCGrWzPeutmmYgQQGW0oHtqwoNUgmLWAAwtyz88
 sWtr7nggk9zY/yDLPe9NBRALy2O6cc9OJW2Q+wm58C6shrPDs1aCrEIX3K33tpeT2W
 f2A6U8T8XU7Mz/I9D/P9CC6UA51duIvSCNHg94zj6xwo7pDlw9UzWRlgsdybfp7vd7
 laIj59dS6GVYbPxaGgZmkNGRYXUwaAzpJ6zElEPG9N52waM7TN/UFOs4ibFjUq4Erd
 uDgCv/MmLnbaQ==
Date: Tue, 30 Jan 2024 16:22:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20240131002258.GA2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-2-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-2-krisman@suse.de>
X-Headers-End: 1rUyNf-00024K-PB
Subject: Re: [f2fs-dev] [PATCH v5 01/12] ovl: Reject mounting over
 case-insensitive directories
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
Cc: tytso@mit.edu, amir73il@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 29, 2024 at 05:43:19PM -0300, Gabriel Krisman Bertazi wrote:
> ovl: Reject mounting over case-insensitive directories

Maybe:

    ovl: Reject mounting over rootdir of case-insensitive capable FS

or:

    ovl: Always reject mounting over case-insensitive directories

... since as your commit message explains, overlayfs already does reject
mounting over case-insensitive directories, just not in all cases.

> Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
> d_ops"), we set ->d_op through a hook in ->d_lookup, which
> means the root dentry won't have them, causing the mount to accidentally
> succeed.

But this series changes that.  Doesn't that make this overlayfs fix redundant?
It does improve the error message, which is helpful, but your commit message
makes it sound like it's an actual fix, not just an error message improvement.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
