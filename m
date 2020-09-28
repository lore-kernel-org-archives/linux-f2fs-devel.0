Return-Path: <SRS0=Han9=DF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D4DC2D0A8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:55:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE392100A;
	Mon, 28 Sep 2020 21:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZEObyGec";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HbXFnl3t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeRoDOX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE392100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kN17T-0003nJ-R3; Mon, 28 Sep 2020 21:55:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kN17T-0003n7-4V
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Sep 2020 21:55:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qyOyFtEYsGEXnuLN/bywwhuVWose1c+9P+/MCyNpYi0=; b=ZEObyGecB2bXhxz1yhNIdMDgwM
 X2BV754/7o2xOzDlJ5ioGVtUFiDq6/22s4qvo3kxofzZk8VclHgFRiEa8yAPbuu/45S7Nkm9UUsOS
 hZFvW1Ahu166DhIDDsQ46XKMb8Yi6qymKNw4fZOpQM5yAQdDgHRqJHlmaqXxWTwfaW8U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qyOyFtEYsGEXnuLN/bywwhuVWose1c+9P+/MCyNpYi0=; b=HbXFnl3tc4aIqeaaZlGH3oLImd
 dVnvzUA7RFszh/N+cnJDRZtbdJEkumMIYHeAKWEfw0yCDG8d4hLoCesLoskX2aMARzGxCJDhdCOx7
 M/oXjg1ZMp7tosojf3U1g5vkbhCtyR8+OBjGr5bX2GJi8aR1c74rwCFRRLLAylQFMCr4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kN17O-009K4E-3Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Sep 2020 21:55:39 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 77F1121775;
 Mon, 28 Sep 2020 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601330121;
 bh=htsG7cgCjOWP+vwgIjl2Fqt34Hd6Ri+elKAS7Sa4s9I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JeRoDOX5fGNEqD17+mt8alMS/Ia9anUvzJ/J58HMWp75rczK5TvFc7upYr25aFTI8
 bTg4Nx/nPXozSDG5jlQS/tXr1awsFaY2y51DJRpQEEk2ieG+nhP8Ujyvy03NzcunRo
 7kVX8u2ZU2gx42MvnDioqFMgJ0OtAzWZ2S6ug+FU=
Date: Mon, 28 Sep 2020 14:55:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20200928215520.GC1340@sol.localdomain>
References: <20200924042624.98439-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924042624.98439-1-ebiggers@kernel.org>
X-Headers-End: 1kN17O-009K4E-3Y
Subject: Re: [f2fs-dev] [PATCH 0/2] fscrypt: avoid ambiguous terms for
 "no-key name"
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
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Sep 23, 2020 at 09:26:22PM -0700, Eric Biggers wrote:
> This series fixes overloading of the terms "ciphertext name" and
> "encrypted name" to also sometimes mean "no-key name".
> The overloading of these terms has caused some confusion.
> 
> No change in behavior.
> 
> Eric Biggers (2):
>   fscrypt: don't call no-key names "ciphertext names"
>   fscrypt: rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME
> 
>  fs/crypto/fname.c       | 16 ++++++++--------
>  fs/crypto/hooks.c       | 13 ++++++-------
>  fs/f2fs/dir.c           |  2 +-
>  include/linux/dcache.h  |  2 +-
>  include/linux/fscrypt.h | 25 ++++++++++++-------------
>  5 files changed, 28 insertions(+), 30 deletions(-)

Applied to fscrypt.git#master for 5.10.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
