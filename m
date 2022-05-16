Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7976C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 May 2022 17:22:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nqeQW-00054p-DQ; Mon, 16 May 2022 17:22:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nqeQV-00054i-2d
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 May 2022 17:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gCt/MCwVkZjomDJVuc7gWNhs8zU3CXgTdAaAXkIqbOc=; b=F4Rr+NJhg/maM/jTNhrMWkGjBF
 sdUbdoLpybYcOzd6KKPh6slfOtNEzRuBPK1KmIizLvdn0kTWM+HIcDdafBR/QZ0b1FaxRxWaXQtpM
 CtOoXE+sKPjMmN033xEifXL6uUdxPGCGrVPoAZa2m9Hb5gssXh75Okv/pmfSiWG2m9zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gCt/MCwVkZjomDJVuc7gWNhs8zU3CXgTdAaAXkIqbOc=; b=ZAjVctR5I3TWp6pi0SC30gL8ZH
 58Ln+TbyxLWZOVBy9nznLgIh2o0nImxe2+bVscfYJMDYKrudskpqYhndj3IqoT5Es0iACDmDg3kVM
 GCsBmtRpjYX+KQXT5XfijEZRH7Z5fPhIcKl+++Z5bIkg5oxy9A9++2roA7R/dET/0A+g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nqeQU-0006eK-3N
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 May 2022 17:22:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B86DA6129A;
 Mon, 16 May 2022 17:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED44CC385AA;
 Mon, 16 May 2022 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652721748;
 bh=NBGepjyX3p9GxdWdL3gWlKrcd6kEqJlE6R/ujFg1F30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TEeRn5rYaCsKqCkKjF1Lj3VSnWdl/pH0nEXS7kExWvMwXL7jibuTwKkGfOH9HFtWI
 DxKfk2KqvgXzwwx3RQW1R3RyGoKlOBn7aeXhyE6qrOvxXDO2JOChJKwrVGocm0LXIa
 m3OOHWf2lXWSpvH5QJRcZec4t+32vNyXzCtW+AKLHufgXIzDhuQ67BV84ydrExthTJ
 YgkIj2xm+TTKL6sPIx4ez7h09HgxnUY4hK1cygrOMvac+HzSqPYEch9mVNQ7mU/IZ5
 HO4GcN0TMm3ODD3BiMIxDFpKsNfZ2c2mG0pR8vUqAMI+I0QdFLqd2KD0M81QiXtK88
 ls7bLY7OtOtDg==
Date: Mon, 16 May 2022 10:22:26 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YoKIUgM4ckAC1n/O@google.com>
References: <20220514175929.44439-1-ebiggers@kernel.org>
 <87r14txyrx.fsf@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r14txyrx.fsf@collabora.com>
X-Headers-End: 1nqeQU-0006eK-3N
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't use casefolded comparison for
 "." and ".."
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks, applied.

On 05/16, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Tryng to rename a directory that has all following properties fails with
> > EINVAL and triggers the 'WARN_ON_ONCE(!fscrypt_has_encryption_key(dir))'
> > in f2fs_match_ci_name():
> >
> >     - The directory is casefolded
> >     - The directory is encrypted
> >     - The directory's encryption key is not yet set up
> >     - The parent directory is *not* encrypted
> >
> > The problem is incorrect handling of the lookup of ".." to get the
> > parent reference to update.  fscrypt_setup_filename() treats ".." (and
> > ".") specially, as it's never encrypted.  It's passed through as-is, and
> > setting up the directory's key is not attempted.  As the name isn't a
> > no-key name, f2fs treats it as a "normal" name and attempts a casefolded
> > comparison.  That breaks the assumption of the WARN_ON_ONCE() in
> > f2fs_match_ci_name() which assumes that for encrypted directories,
> > casefolded comparisons only happen when the directory's key is set up.
> >
> > We could just remove this WARN_ON_ONCE().  However, since casefolding is
> > always a no-op on "." and ".." anyway, let's instead just not casefold
> > these names.  This results in the standard bytewise comparison.
> >
> > Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > Cc: <stable@vger.kernel.org> # v5.11+
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/f2fs/dir.c  |  3 ++-
> >  fs/f2fs/f2fs.h | 10 +++++-----
> >  fs/f2fs/hash.c | 11 ++++++-----
> >  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> Hi Eric,
> 
> This looks good to me:
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Thanks,
> 
> -- 
> Gabriel Krisman Bertazi
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
