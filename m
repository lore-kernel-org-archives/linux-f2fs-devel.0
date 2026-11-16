Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221B606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=erPYaAZ9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mghlKc4V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DpEBmX7S;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWPTS1+t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=34wh0ciFmo6PbLntgbR8gHC62zrHbjppWVAFyKKFZ0w=; b=erPYaAZ9TA8tIE0BR0WGes6Lhw
	fKkNRUUu8LwQT99Yo8z28NM4NJ5EkLSyqEg3rRe9jzWj4nHKKbWS7RZAkLtpyTDSO/PANIAQawJ6W
	KNWRUGW7PjbWErh9daUbfuMUsEN/nudzClnRqIbK5Wjqz/u8XQVGszeTtFUCBGhgtzls=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT2hE-000000003kN-3YeP;
	Mon, 16 Nov 2026 19:48:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xT2hD-000000003k5-1gsS
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=agI9AZcjlcABwNXd8gSX+qg6fWruBT4JR3ByMj7fWQM=; b=mghlKc4VKnGib6EpQpyVTfcgOr
 BjgnVXd7DAGpGXlM+cZyD4RmaELCnoXkSNf1MzzzNDXVDZco8f6yvaTYG1JBiB25JdTj0nlhvQGzG
 4S5FKBuYbAD/ThHA8ZhxreTNYk7x7+e010/fs93rs4iHZQ5P2p9tXY7XI+GVjnbQ38+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=agI9AZcjlcABwNXd8gSX+qg6fWruBT4JR3ByMj7fWQM=; b=DpEBmX7SVYOacgtgBHpI2dHVte
 dWVCqoQhkjg6vN+SvqBy8aVh5RxBFJ1ZYWr/ZAZTuO6F2b4oSn1oEAzSPbZ7jWn+OyEAVQew+wOIo
 aQ97fegdvnX57Fku1ff8sELdSjJ/pBe44kC4hSNstWs1R6UlGaycSl/RNNQah6KNX+Pw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT2hB-0000000054n-2rgJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:48:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 111EC60F4E;
 Mon, 16 Nov 2026 19:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696531F000C4;
 Mon, 16 Nov 2026 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794858527;
 bh=agI9AZcjlcABwNXd8gSX+qg6fWruBT4JR3ByMj7fWQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IWPTS1+tmPA+wbHrpEoNmkW2+4xuFyUqI8/tTVO0eHT5qiFzP0PyEPtB3qjTw7HNP
 sgQw2F4mSNLR3uwu3YinlW0x1EQAGT3U+EY9iehi9XqdxsKjHUAb6v8T7U/wgOF3wT
 rhnl05ZbIV0rscUno7cA8nlQ1sZwGLk8RwzhxF5Q6XG1VqttMKXdsG8f0oFFyTtoSZ
 9Bpp5irCk7K/Cc+Bed1jmzDXp7tOeSqnh8EHV5h5poeLxmMEl4r6hbUst3dmr1VjZ0
 QhqRsA6eoJSlJozWCF7BT73eyqA59dr5Y4DxW66xFHdc6YnV1RDuVUsQ5213YgikUD
 sqfZvvWevmHnw==
Date: Mon, 16 Nov 2026 19:48:45 +0000
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Message-ID: <20261116194845.GC229817@google.com>
References: <20261103030712.1514800-1-zhanxusheng1024@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261103030712.1514800-1-zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xT2hB-0000000054n-2rgJ
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: fold casefolded names of
 F2FS_NAME_LEN bytes
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
Cc: zhanxusheng@xiaomi.com, andrealmeid@igalia.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Gabriel Krisman Bertazi <krisman@kernel.org>, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[ +Cc Gabriel, who maintains fs/unicode/ ]

On Tue, Nov 03, 2026 at 11:07:12AM +0800, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> utf8_casefold() needs room for the terminating NUL, but
> f2fs_init_casefolded_name() gives it only F2FS_NAME_LEN bytes, so a
> name that folds to exactly 255 bytes is not folded. In a casefolded
> directory, creating 'A' x 255 fails with EINVAL under utf8:strict.
> Without strict, after creating 'A' x 255, stat of 'a' x 255 returns
> ENOENT and creating it adds a second entry.
> 
> Fold into F2FS_NAME_LEN + 1 bytes. Existing entries for these names
> are hashed by the name as given, so on a miss also try that hash.
> 
> Fixes: 43c780ba2624 ("f2fs: rework filename handling")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> RFC because new entries for these names get a different hash on disk.
> Results in a VM, with dentries dropped before each stat:
> 
>                                  'A'x255  'a'x255  'C'x255  'c'x255
>   current kernel creates 'A'        ok    ENOENT
>   this patch creates 'C', 'c'       ok    ENOENT     ok       ok
>                                     (one 'c' entry)
>   back on the current kernel        ok    ENOENT   ENOENT   ENOENT
>   strict, current kernel        create 'S' x 255: EINVAL
>   strict, this patch            create ok, found in both cases
> 
> Each fsck.f2fs version matches only one side. 1.16 folds into PATH_MAX
> and rewrote 'A' to the folded hash, after which the current kernel
> cannot find it. The dev branch rewrote 'C' to the raw hash, after
> which this patch finds it only as 'C'. fsck would need to accept both
> hashes for these names. Encrypted directories are not tested.
> 
> Is the second lookup acceptable? The alternative is to keep hashing
> these names as given, which fixes the EINVAL but leaves them
> case-sensitive.

Sorry about this bug!

I think it's actually worse than you say, and this commit doesn't fix it
entirely.  A filename can "casefold" (really NFD canonical decomposition
+ Default_Ignorable_Code_Point stripping + full casefolding) to much
more than F2FS_NAME_LEN bytes.  The decomposition stage in particular
can result in significant expansion, up to 3 * F2FS_NAME_LEN.

For ASCII though it is indeed as you say: they cannot expand, and only
max-length filenames are affected due to the off-by-one caused by
utf8_casefold() unexpectedly including a NUL terminator.

I think this shows that the 'casefold' feature` isn't really used for
anything other than ASCII in practice, and all the complexity of Unicode
normalization wasn't needed in the first place...

But I suppose this should be fixed anyway.  The approach of this patch
should generally be okay if you increase the buffer to the required
'3 * F2FS_NAME_LEN + 1'.

However, please check the Sashiko comments
https://sashiko.dev/#/patchset/20261103030712.1514800-1-zhanxusheng1024%40gmail.com
as some issues were found with the implementation.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
