Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C255C10F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 01:24:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5Ezq-0008E8-CI;
	Fri, 10 May 2024 01:24:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1s5Ezo-0008Dq-Me
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:24:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dXCJeQrVdyQSuMQ53Eiz2R/x+SaFHgSyd1wUIQ7TY1A=; b=WRJN4BOfe2jYvGqy3cfcR3QsLl
 DoQBkK+rR4eNJqNRTFvjSgWZ+6Qj906lW3hsMXK9NP0gJLaF23YlD9f7X/zNRKmW8SEOCjoYA65rK
 Pd4eZWTdlYJK32BT01MMApxCLx6eeNyWl5SsnRRbMW26qKLhNA9Cj+0HEMOD0n84wos8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dXCJeQrVdyQSuMQ53Eiz2R/x+SaFHgSyd1wUIQ7TY1A=; b=PQSQm5N9OYnB2deFgaRld6O8I4
 IoLzY9Zv3vVqClpEUAw6yxLP9Q0++rtTT9Ag8TGIzgkVb7qLcvQcO3mPNlD+8mH1nukVv3VMi9Wfi
 uwGinBMFN0PoNC1yGbw20p9pq/4NML/4h8E6jhC2EsPKboa0myDPxhHzgv96pzjzateY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5Ezo-0007WS-Q8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:24:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AE78B61D79;
 Fri, 10 May 2024 01:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DD4C116B1;
 Fri, 10 May 2024 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715304253;
 bh=urrTXTTywRFtsj11Qs5I6AcHADvw2TrkRJTB0c5eGe4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bLz17kI4X02wMZUNr5OvfC48XIq3oJJ9HRAWlpYS3SHaIIfExDpXhTjedc+N5XzGR
 DZWdE4qnhAGvCKTxz04eYQwAniShrmvJfePAl3e5vqgxjqsXFKPZicw1Jf9eXfREpf
 ji4cFW+msOXy8wixr4JIHKAKwRigqAPVqIq9ZUgKL+RCh9QJlCuMXDhHLpLkDx3LBp
 xZBkjdJV7Lodpg2uKuPK/G/dCH9oQ79PjBb5nxN9+OYZo/S2p60x7zslYUiJF/QBpb
 Bl6MaLwjw4nM/CvuC1+17nFv2kLcndUOfPo9tzSUPO8MCjO9ZZQuiX40EztU59L/gN
 l4XBXFcKVxsZA==
Date: Fri, 10 May 2024 01:24:11 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240510012411.GD1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-6-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-6-eugen.hristev@collabora.com>
X-Headers-End: 1s5Ezo-0007WS-Q8
Subject: Re: [f2fs-dev] [PATCH v16 5/9] f2fs: Reuse generic_ci_match for ci
 comparisons
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 03:13:28PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Now that ci_match is part of libfs, make f2fs reuse it instead of having
> a different implementation.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c | 58 ++++-----------------------------------------------
>  1 file changed, 4 insertions(+), 54 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
