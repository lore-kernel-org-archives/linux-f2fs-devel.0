Return-Path: <SRS0=GX/p=3O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B8C32771
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jan 2020 03:35:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418392072C;
	Sat, 25 Jan 2020 03:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CsQrq1MM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="E88Fd2LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418392072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ivCEh-0004Yr-2m; Sat, 25 Jan 2020 03:35:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1ivCEe-0004YY-VO
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Jan 2020 03:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N8zMhI150you8/NvC9e+c/YVi+8vyTTCgq1MjPie2uU=; b=CsQrq1MMa6jsH/Jdr0BUi5t/AQ
 htyB5XfwaB9ECQEH5QqkCBaGePzYQeyo2LeUct+DxAdTrIE+rs7PQiJk2nnXhUuWpUEjSG7WupIRD
 a3hJG3y96j+9w7m4gkL+Xh5OpCev+o9EyflNv8i693rgrlg5cKjc7TMJ2MbqwuJDEy2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N8zMhI150you8/NvC9e+c/YVi+8vyTTCgq1MjPie2uU=; b=E88Fd2LU1grR6OGWWTE36FdQ8K
 7AT3ImXyRVoWphD9mEDUmAnwHwhFd7MxYb9rDl+K0OiCRBtFWKpbrJ5UKP6nzw5sQMn2/r5P/Y9U9
 IBs3Jd7l+8Aivo/tOadZoSfGgS+LaYmxIqrd10XjtLNxCclQX2l1dYr90f2mArMgGaE0=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ivCEZ-0001kG-SJ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Jan 2020 03:35:48 +0000
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com
 [67.53.201.206]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P3ZNia013355
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2020 22:35:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id DA14842014A; Fri, 24 Jan 2020 22:35:22 -0500 (EST)
Date: Fri, 24 Jan 2020 22:35:22 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200125033522.GM147870@mit.edu>
References: <20200124041234.159740-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200124041234.159740-1-ebiggers@kernel.org>
X-Headers-End: 1ivCEZ-0001kG-SJ
Subject: Re: [f2fs-dev] [PATCH] ext4: fix race conditions in ->d_compare()
 and ->d_hash()
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
Cc: Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 23, 2020 at 08:12:34PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since ->d_compare() and ->d_hash() can be called in RCU-walk mode,
> ->d_parent and ->d_inode can be concurrently modified, and in
> particular, ->d_inode may be changed to NULL.  For ext4_d_hash() this
> resulted in a reproducible NULL dereference if a lookup is done in a
> directory being deleted, e.g. with:
> 
> 	int main()
> 	{
> 		if (fork()) {
> 			for (;;) {
> 				mkdir("subdir", 0700);
> 				rmdir("subdir");
> 			}
> 		} else {
> 			for (;;)
> 				access("subdir/file", 0);
> 		}
> 	}
> 
> ... or by running the 't_encrypted_d_revalidate' program from xfstests.
> Both repros work in any directory on a filesystem with the encoding
> feature, even if the directory doesn't actually have the casefold flag.
> 
> I couldn't reproduce a crash in ext4_d_compare(), but it appears that a
> similar crash is possible there.
> 
> Fix these bugs by reading ->d_parent and ->d_inode using READ_ONCE() and
> falling back to the case sensitive behavior if the inode is NULL.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
> Cc: <stable@vger.kernel.org> # v5.2+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
