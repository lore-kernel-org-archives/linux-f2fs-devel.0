Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A391C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 02:11:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrVdb-0007WM-Nk; Thu, 19 May 2022 02:11:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tytso@mit.edu>) id 1nrVdF-0007WB-Lx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 02:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G8AwOJ7aNH9K4G4CQ4xdeR2aO3xM2mJKQnu9NPGy5xU=; b=TuLtPE10/cd1vGLH5I/eHyyWph
 cUdYTXHL6zu/SvbM8P+jY/hTr5YRH/DgqOJJZpRlJ1uptqL8/bnBOhTb+WoCDr8VNuUekh+mRqwnV
 fzkyz8PtIf1pokTvZQ67fyu1uSpE6zZiOAHAFGjIbiwDAZABdOtc2HP7ON1bFff01me0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G8AwOJ7aNH9K4G4CQ4xdeR2aO3xM2mJKQnu9NPGy5xU=; b=ALqv+TkviZXftJrZoZTd1AK4sq
 OZnFMhZbP1Vq1XtKKxXa3KUEieAco4GLsagXtmG4cXno25Ytf2OhGDpvAo27dHDB2gvhk1Awd5BgM
 fau+lTNKwBnP6dyA28DeoETgBuKvwZgeLMhrOoTTQTiP/TB9jhQyoOKxYBjmcvcVqfyE=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrVdF-0081YY-3K
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 02:11:17 +0000
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net
 [108.7.220.252]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24J2B3JG020839
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 22:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1652926265; bh=G8AwOJ7aNH9K4G4CQ4xdeR2aO3xM2mJKQnu9NPGy5xU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CFbTgQcXF8r4oLV3cOeIo8/HxrBG5BvkcDzWUG7rE7elqhW1seFqHmLu49mk7jrXB
 aSx9ERO4Py3NjEwiaPtZkNC+vRYhbGOH6Y5zHDH6Torgqw+n5mZNQ21Rdkk6K+bZYp
 NGAon6ivzr6JixkwCoBncs2RLDAPe5bl4EymWmcgaF36lutDapYKFUJ7bd5N2N5rtc
 JSeGLJexcRnJFP2yTNK0b2PzcBVAyPOsvlAQvMXPgdC1shQ2e7K0X1/V4CZu4O8KVd
 x3rP7o8DmMkwBYLUQbuSlruhTzmvg/rkhSQ1frc10tvoqohIapgoxBmL2bEsFVaasl
 sSr41wGfnd9vw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 1EDB815C3EC0; Wed, 18 May 2022 22:11:03 -0400 (EDT)
Date: Wed, 18 May 2022 22:11:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YoWnN/qY30ly9znS@mit.edu>
References: <20220513231605.175121-1-ebiggers@kernel.org>
 <20220513231605.175121-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220513231605.175121-3-ebiggers@kernel.org>
X-Headers-End: 1nrVdF-0081YY-3K
Subject: Re: [f2fs-dev] [PATCH v3 2/5] ext4: only allow
 test_dummy_encryption when supported
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 13, 2022 at 04:16:02PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make the test_dummy_encryption mount option require that the encrypt
> feature flag be already enabled on the filesystem, rather than
> automatically enabling it.  Practically, this means that "-O encrypt"
> will need to be included in MKFS_OPTIONS when running xfstests with the
> test_dummy_encryption mount option.  (ext4/053 also needs an update.)
> 
> Moreover, as long as the preconditions for test_dummy_encryption are
> being tightened anyway, take the opportunity to start rejecting it when
> !CONFIG_FS_ENCRYPTION rather than ignoring it.
> 
> The motivation for requiring the encrypt feature flag is that:
> 
> - Having the filesystem auto-enable feature flags is problematic, as it
>   bypasses the usual sanity checks.  The specific issue which came up
>   recently is that in kernel versions where ext4 supports casefold but
>   not encrypt+casefold (v5.1 through v5.10), the kernel will happily add
>   the encrypt flag to a filesystem that has the casefold flag, making it
>   unmountable -- but only for subsequent mounts, not the initial one.
>   This confused the casefold support detection in xfstests, causing
>   generic/556 to fail rather than be skipped.
> 
> - The xfstests-bld test runners (kvm-xfstests et al.) already use the
>   required mkfs flag, so they will not be affected by this change.  Only
>   users of test_dummy_encryption alone will be affected.  But, this
>   option has always been for testing only, so it should be fine to
>   require that the few users of this option update their test scripts.
> 
> - f2fs already requires it (for its equivalent feature flag).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
