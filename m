Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA26C5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9OpxwUjuFENPmV+mE8T9bmPWWSoWM/7op4NJsYdlQWo=; b=LXwVTO727cdFB/Pp66Wct5M+uI
	3y9XyHlQ5CAjDcah7qmjhV7DoNV4XosSqqvKNGw8aUUlA0jTeirzV+gpPi/SembpqBMKqiDA7ptHo
	xfNrTt3+4PIBuW7S3Dq+qoXnaV14Bv4aHP3iWpm8oZ67LynSKlN2UQkOIftIsaEO7PE0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwQ2j-00055h-Fk;
	Tue, 18 Aug 2026 20:04:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wwQ2e-00055U-Ni
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 20:04:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vbCCyg5sm7N31JtWz3P7kk2HB2PMgWsMJFM5NtR7eEA=; b=gPpUPY+zgn/fzYhGBNXUTqoiUp
 jps2bIlsv9dXfnjw3ji+tMIlJHs84PvelygwpH1CSTF41gt3N120vtCelagJqqs8OELSeSYLSFPKl
 w3Goo7ukBc0Lp0eFsIM3RJzaTns+UyH96o9mB696JYvVhym6b6TA1qCeKCOR9E4nAx9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vbCCyg5sm7N31JtWz3P7kk2HB2PMgWsMJFM5NtR7eEA=; b=ebY8n3Jpqy/FkYZm3MMlV0uXzq
 KFsI293RW5EZoCz/+Z0M3eNGxeLk8UvXmYijj0G4QTZmrEOQ6fBoWSW5yFTamaNAzNYDEqFRCVqnI
 YK3ZKkz21wnExrFUGEvUwVMKPOj9cPZP21WN8X8ZON/5xfsNyNINGw9BIgSV/+CZuDzo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwQ2e-0003wh-As for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 20:04:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23BAD601DE;
 Tue, 18 Aug 2026 20:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860981F000E9;
 Tue, 18 Aug 2026 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787083442;
 bh=vbCCyg5sm7N31JtWz3P7kk2HB2PMgWsMJFM5NtR7eEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Htin19sBw5FGl9bXvHD/IAJ1ZNtjWkBpfMGtPQouBX8e6s6kCArPq90vI0JsvTDy5
 NWRk2SY/QaN9/9DOYw/FyOfYZVK0o0/5jExtWGKLYYb2YZzXgPj2wPXONP7lOAAn8j
 sm6grTYWLguT4lT14y9J8fzW2FCHfhPyTI+BznJul0KTQ3V+1yyw/1X3gY+s8JKlUX
 SUEySbwDFRLjf8rJL7qVjw71Yqq+h/bHTHYK/nYWUxM2ndudUxGhKFUhxHvpb4MBdv
 hAWsARR6ZguNKXlfS1dosUind7KWRGOxJs3t+JCLTcg+breIX/q3yhZiWro2UV1eBX
 1qEK2Cxz6ct4Q==
Date: Tue, 18 Aug 2026 20:04:01 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <aoS6sWz-hvdda1OJ@google.com>
References: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
 <20260815051820.GA660827@ZenIV>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260815051820.GA660827@ZenIV>
X-Headers-End: 1wwQ2e-0003wh-As
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Wenjie Qi <qwjhust@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/15, Al Viro wrote:
> On Mon, Aug 10, 2026 at 09:38:32PM +0800, Wenjie Qi wrote:
> > F2FS writes long symlink data with page_symlink() and then flushes the
> > symlink mapping to reduce the chance of exposing a broken symlink.
> > 
> > That flush result is currently ignored. If the writeback fails, symlink()
> > still returns success even though the symlink is not durable and the same
> > operation can already surface -EIO through syncfs().
> > 
> > Return the writeback error to userspace and skip the dirsync flush once the
> > symlink data flush has failed.
> 
> >  	if (!err) {
> > -		filemap_write_and_wait_range(inode->i_mapping, 0,
> > -							disk_link.len - 1);
> > +		err = filemap_write_and_wait_range(inode->i_mapping, 0,
> > +						   disk_link.len - 1);
> >  
> > -		if (IS_DIRSYNC(dir))
> > +		if (!err && IS_DIRSYNC(dir))
> >  			f2fs_sync_fs(sbi->sb, 1);
> > -	} else {
> > -		f2fs_unlink(dir, dentry);
> >  	}
> >  
> > +	if (err)
> > +		f2fs_unlink(dir, dentry);
> 
> That looks fishy.  At that point you already have dentry hashed and
> AFAICS f2fs_unlink() will leave it hashed and attached to the same
> inode; sure, memory pressure will eventually evict the sucker, but
> until that point any lookups will simply pick it from dcache.

Thanks, yeah..it seems we don't need to do f2fs_unlink() at this stage, since
IMHO, this code block is a nice-to-succeed as there'll be another chance to
flush dirty pages containing the symlink path.

IMO, we need to handle the error like this:

    1. f2fs_new_inode
    2. f2fs_add_link
    3. page_symlink
      -> if it fails, we should unlink and drop the inode

    4. flush dirty pages and or checkpoint
      -> leave as is and wait for writeback again

RFC: https://lore.kernel.org/linux-f2fs-devel/20260818200121.2684318-1-jaegeuk@kernel.org/T/#u

> 
> It's not introduced by this patch; the same issue, AFAICS, already exists
> in mainline.  Why do we even bother with d_instantiate_new() before we
> know that everything's fine, nevermind doing that when we already know
> the operation has failed?
> 
> Incidentally, is there any reason to add a directory entry before the
> inode is set up?  Usually that's the last step, and cleanup tends to
> be simpler that way; are there f2fs-specific reasons to do it in the
> unusual order?

I don't think there's a special reason in f2fs to do so. It seems ext4 does
it similarily like calling d_instantiate_new() in ext4_add_nondir() after
ext4_add_entry()?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
