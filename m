Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212CDC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 May 2022 23:36:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1noCvN-0007ys-QB; Mon, 09 May 2022 23:36:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1noCvN-0007ym-1O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 May 2022 23:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kJUYa9pwc9tHwIPb4szCCAz7gxbf4ZzScOjejq7qdao=; b=WyK9T0Gtuy6cwtIfBmiFnOlAHF
 D/vKwUfslvQvlwt4NzZvrdEFI9Nf6oJelfio0rfSeGZlWhNfjxBMjyd3BFtrr7sQgp0HMUyHQG+7Z
 RWXcEqi/EjqIGWyBNfGz6VqRJGE0sFpczgWm3bIGDHmJw8e8LgpHAG5AVVw1xxvBHHMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kJUYa9pwc9tHwIPb4szCCAz7gxbf4ZzScOjejq7qdao=; b=dk56GPhYwOh5WoFQy3PG5dUzD6
 qDnretZ+C1i6fLLHvk9bPqlA2JZp10sGAIlTvp7Wmey3sX3Ju6MHvNBOHeHmlZgWyEg1sgtwRzi6+
 Fr3VNyV2m0wKqEiNkJpftxD2PuMYR3HPzQH54FOVd+9qRlmqUAAxr6wrRffZtpmZ+8Gw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1noCvL-006oKB-JM
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 May 2022 23:36:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEC7612EC;
 Mon,  9 May 2022 23:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65899C385C3;
 Mon,  9 May 2022 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652139369;
 bh=q2Anzy7Vn7+KTWoXEccZSkJLiAE4Av2Zp9ltchMZy8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZqIVr/lAHT4J6IYo+xFJTjXJnf9ROi3nTQkIEu8M2R6xb3HrXFtq/slugDTE52hj5
 R8IB7UOM/OSqknz40bEA1Mo7YnlRMaqmFuPZrF+hgizcHcbiU1VqKOeZuW0GeuIeqW
 2L/Z1khugBcEf3jZrqceyJ1WxJZ1FV9TJf9ssyRDfFO6eLdeISgmH4d55AImOoME08
 AhUuGgpjtKP4SMgmP5ibBMtIDIXp/uvuiuKGTxLUNUuuRTh+C6gbRqulXJ+aQt4sT8
 pUvy5ATNPDxAnbL2iCjlqcgC0VCKqjlmNxL8E1QzJ8EtK0/IxrL97JPtfLJrfH0MBM
 zayNYphe6CUlg==
Date: Mon, 9 May 2022 16:36:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Message-ID: <YnmlZ15YPS1cy4aV@sol.localdomain>
References: <20220501050857.538984-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220501050857.538984-1-ebiggers@kernel.org>
X-Headers-End: 1noCvL-006oKB-JM
Subject: Re: [f2fs-dev] [PATCH v2 0/7] test_dummy_encryption fixes and
 cleanups
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
Cc: Lukas Czerner <lczerner@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Apr 30, 2022 at 10:08:50PM -0700, Eric Biggers wrote:
> This series cleans up and fixes the way that ext4 and f2fs handle the
> test_dummy_encryption mount option:
> 
> - Patches 1-2 make test_dummy_encryption consistently require that the
>   'encrypt' feature flag already be enabled and that
>   CONFIG_FS_ENCRYPTION be enabled.  Note, this will cause xfstest
>   ext4/053 to start failing; my xfstests patch "ext4/053: update the
>   test_dummy_encryption tests" will fix that.
> 
> - Patches 3-7 replace the fscrypt_set_test_dummy_encryption() helper
>   function with new functions that work properly with the new mount API,
>   by splitting up the parsing, checking, and applying steps.  These fix
>   bugs that were introduced when ext4 started using the new mount API.
> 
> We can either take all these patches through the fscrypt tree, or we can
> take them in multiple cycles as follows:
> 
>     1. patch 1 via ext4, patch 2 via f2fs, patch 3-4 via fscrypt
>     2. patch 5 via ext4, patch 6 via f2fs
>     3. patch 7 via fscrypt
> 
> Ted and Jaegeuk, let me know what you prefer.
> 
> Changed v1 => v2:
>     - Added patches 2-7
>     - Also reject test_dummy_encryption when !CONFIG_FS_ENCRYPTION
> 
> Eric Biggers (7):
>   ext4: only allow test_dummy_encryption when supported
>   f2fs: reject test_dummy_encryption when !CONFIG_FS_ENCRYPTION
>   fscrypt: factor out fscrypt_policy_to_key_spec()
>   fscrypt: add new helper functions for test_dummy_encryption
>   ext4: fix up test_dummy_encryption handling for new mount API
>   f2fs: use the updated test_dummy_encryption helper functions
>   fscrypt: remove fscrypt_set_test_dummy_encryption()

Since I haven't heard from anyone, I've gone ahead and applied patches 3-4 to
fscrypt#master for 5.19, so that the filesystem-specific patches can be taken in
5.20.  But patches 1-2 could still be applied now.

Any feedback on this series would be greatly appreciated!

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
