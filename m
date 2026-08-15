Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC7BC5AD5A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Aug 2026 05:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyhtmAs1TCVLKREzJJR0Zr48KHw98IP9Ea3OX5VkTts=; b=gH16vlq3gJGmtsVUeiWO/fOj4b
	/qSXHmo8HwOZIBZ8w25b3kXmPjYE3ppyKCEl/2vIoBSd5LTgBOmd0oeGbRYA37LFAXvd5HaFVpunY
	/eLJ/Wcw7KPxvkuwCWeo7oO7JKsaDy0u7Yjq5Dd7O5X5zY3waQod9U8bVaxLNhJNBhYY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wv7B5-0005nj-W8;
	Sat, 15 Aug 2026 05:43:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1wv7B5-0005nd-5K
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 05:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Wj8F+XMiZI2N6GRMpnpH5FloVq8sMifI2CGpvpLA9I=; b=mPVR0tb6tI8wqPO5weqynFY3DP
 u8Nh8zmvipx+sGE65ZxYvo7EXNDNskelkiF1hG1Tamlc6qnIB0fdC0/mv1Nr1tEhOO9CtlHXO2CK8
 a9j7OTiYbqX8jXcBNMGFoCmsl+NQg3+sZJkKM2h8ygmm3Acnu2U230OhGUxG/1telptk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Wj8F+XMiZI2N6GRMpnpH5FloVq8sMifI2CGpvpLA9I=; b=GvFjENVE4gXvpErCt6Y64RjZJD
 KTkN7UJnSxky6pbxQrhb6DklcW8ncTbY7mmO86uy3J9DeeQx3RfRm/dbHDvLeVJnwrNYrFPYgb9IV
 gTTFOHdVWsKv4E7CE1aWIgOilf0NCjShJ1TBpFd70StkT3ydbRjyYJZphfO2V8z32BD8=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wv7B1-00068r-Ng for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 05:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6Wj8F+XMiZI2N6GRMpnpH5FloVq8sMifI2CGpvpLA9I=; b=YFDqCFCZxhcUqItPGIIKnAFrf7
 ssCmVfOUP5du0NM61Xp5qaFTKmX2OqJiZecyAeC7OUbXQLsXATcI4dZ/BFZ3Xb68paw6mmuZQRFC0
 9ARW+S0CfevPArR/G86h1tTncp7JM/TuRpLRe8T0klV8KKeK/b84PUsNWCr87cQpaWjLClsRWwUTC
 Mtgx2EocqmT3duJ+leIBq9D1c5dzH4EITP2HeSLnhtNQbOXpHjfdzj7lzkv7baDYhpk7v16JkkVFQ
 mD+xKWekUYHqlA8L8XTbEKX5hN8FuMwlxz0srq+0SREcj9s47Fn0j9JotTSX/GCVysv+jmK27RkYG
 CQmrq/RQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat
 Linux)) id 1wv6mi-000000034PS-2ooo; Sat, 15 Aug 2026 05:18:21 +0000
Date: Sat, 15 Aug 2026 06:18:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <20260815051820.GA660827@ZenIV>
References: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wv7B1-00068r-Ng
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: return symlink writeback errors
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 10, 2026 at 09:38:32PM +0800, Wenjie Qi wrote:
> F2FS writes long symlink data with page_symlink() and then flushes the
> symlink mapping to reduce the chance of exposing a broken symlink.
> 
> That flush result is currently ignored. If the writeback fails, symlink()
> still returns success even though the symlink is not durable and the same
> operation can already surface -EIO through syncfs().
> 
> Return the writeback error to userspace and skip the dirsync flush once the
> symlink data flush has failed.

>  	if (!err) {
> -		filemap_write_and_wait_range(inode->i_mapping, 0,
> -							disk_link.len - 1);
> +		err = filemap_write_and_wait_range(inode->i_mapping, 0,
> +						   disk_link.len - 1);
>  
> -		if (IS_DIRSYNC(dir))
> +		if (!err && IS_DIRSYNC(dir))
>  			f2fs_sync_fs(sbi->sb, 1);
> -	} else {
> -		f2fs_unlink(dir, dentry);
>  	}
>  
> +	if (err)
> +		f2fs_unlink(dir, dentry);

That looks fishy.  At that point you already have dentry hashed and
AFAICS f2fs_unlink() will leave it hashed and attached to the same
inode; sure, memory pressure will eventually evict the sucker, but
until that point any lookups will simply pick it from dcache.

It's not introduced by this patch; the same issue, AFAICS, already exists
in mainline.  Why do we even bother with d_instantiate_new() before we
know that everything's fine, nevermind doing that when we already know
the operation has failed?

Incidentally, is there any reason to add a directory entry before the
inode is set up?  Usually that's the last step, and cleanup tends to
be simpler that way; are there f2fs-specific reasons to do it in the
unusual order?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
