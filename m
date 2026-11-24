Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A03606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UzpVojuv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eCo49upl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XlbUrj2m;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3y88tmj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j5M2sCDFfml8gO/8TNVNMX8o8h/7mMwZdyEo/QgokhA=; b=UzpVojuvymQ48G3elM1svb/s2x
	CyLJiTp3rNH9qlZkZAxNKpkebg3jXlSLYQzyc1Kbq8+9rVI2D0zCi0KNwrWbs+cbW0rPqMqMICUHl
	pmIq7UcCIVUK70PskVgwloiEAH2K9QNqXmnEcxNEFSpyEBoLqBjFa1VcRwTbtSI86keM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVzgD-000000006xM-0dk7;
	Tue, 24 Nov 2026 23:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xVzgC-000000006xG-1znK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 23:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QXxayGQ5zDJmW5qRYFz3W+oneeyzIOwcisMq8eZ3yFw=; b=eCo49uplmSLo8Tr0EB2oN5I2Jn
 IQo46GdKJL1jhPtBY6Vi4sEtmVRX2iW3M+IFh4WWd4t63zpibjeLnsLXf31x7awmu4P0CB7l4Ifjk
 TsF6xBp7cbbRZRmOJDBdH6L/sMkiiAtKd/MOHVgMGX52kenPKmsF8F/9C36NIN8g5PWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QXxayGQ5zDJmW5qRYFz3W+oneeyzIOwcisMq8eZ3yFw=; b=XlbUrj2mt8ZK5REtfe3U5nKHVQ
 pz4cHtQVQtBsq4RS48tCne1/rr2su2aN18fDg+hlXzKXdaFmNexnenUfXTWzN2vUZATfLsFx7adfN
 Pa/mLRogFg1F/ELW07XeXsCZtmA96FElJxgYcdsPbxcRHQYE5ttrvbAfQxM9MJGj6EVQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVzgA-000000000WX-3mRi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 23:12:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87ED843EA2;
 Tue, 24 Nov 2026 23:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03D61F000C6;
 Tue, 24 Nov 2026 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795561917;
 bh=QXxayGQ5zDJmW5qRYFz3W+oneeyzIOwcisMq8eZ3yFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=W3y88tmj+TqN3sWdK2x05TghZqa+qDv9MXmU3/QPFA2AT98lD6/qJZ3933xeNZZUL
 mFbgAjZxP3YQfFNGN/E6aq6xHvwq3926/J7i7Ox/gvjyfKu/Jlr/F+6FE6JUy3P4Is
 6MdPs7dA0CFFOn8AwQK+1AsBSZLa2HZ0FGDt6VcRVLyFogg1MgzTckmIzazFX4Qe7P
 iFc01fx5AJywo5WpZQFnkHf0EnpzryblgxonC0zrk1gaPk9SkFDRC8a32P1yoFcKpj
 7HJT1DGrf8SZho5WvdsGUF3oCPgBlo4X/7mshT91A9EhlmNM3yivKhK6IJrlXuYV1U
 dUiEIUxoIk7dg==
Date: Tue, 24 Nov 2026 15:11:55 -0800
To: Thorsten Blum <blum@kernel.org>
Message-ID: <20261124231155.GB2001@quark>
References: <20261118002845.574426-6-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118002845.574426-6-blum@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVzgA-000000000WX-3mRi
Subject: Re: [f2fs-dev] [PATCH 0/4] fscrypt: Add FSTR() helper macro and
 convert initializers
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
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:28:46AM +0100, Thorsten Blum wrote:
> Similar to QSTR(), add FSTR() to initialize struct fscrypt_str from a
> NUL-terminated string without specifying its length.
> 
> Use the helper for 8 initializers in btrfs, F2FS, and UBIFS, replacing
> hard-coded lengths and explicit strlen() calls.
> 
> Thorsten Blum (4):
>   fscrypt: Add FSTR() helper macro
>   btrfs: Use FSTR() for the "default" name
>   f2fs: Use FSTR() in f2fs_do_make_empty_dir()
>   ubifs: Use FSTR() in ubifs_xattr_{set,get,remove}()
> 
>  fs/btrfs/inode.c        | 3 +--
>  fs/btrfs/ioctl.c        | 3 +--
>  fs/btrfs/super.c        | 3 +--
>  fs/f2fs/dir.c           | 7 ++-----
>  fs/ubifs/xattr.c        | 6 +++---
>  include/linux/fscrypt.h | 1 +
>  6 files changed, 9 insertions(+), 14 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
