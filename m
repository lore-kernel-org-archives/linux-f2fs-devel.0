Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E596EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jul 2023 16:47:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLnrS-000761-R4;
	Tue, 18 Jul 2023 16:47:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qLnrP-00075t-Qh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jul 2023 16:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0gG/SrZGF5/s3yIgwzjFlba62tVC4bEASQFHFHTinDw=; b=DR8375cQQC5ekkWaoRmNVh/i/5
 0xCdI4YCV44ZqVL1TXllHg9l9+2VTl1XGFyIW4Ewf/H9pKoDc/kPnKhcbw4F5QHrQZhN9jXf/HV6X
 kicsRa46iB3YCkmBac4iDNSH+NHSMXJVkDDmZ956Iy4hzumt7NLZRyPcBUNLflh6otNo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0gG/SrZGF5/s3yIgwzjFlba62tVC4bEASQFHFHTinDw=; b=DXj8fURwBiXpeDtSLPYG2/15ef
 ZgF0488MwN8DUDEhg/4lauO6WzvqyYkTSitWE3o32pu+hBZqnQzkdR3A9T5j+LvLy8FdlV20JycuN
 vLHu/LcryW2IyEgz6BemK2NP0aaY95qI6BhKNUJsRygLonKBoVnb5BGneOd4/26w+r8k=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qLnrL-00C4cc-8g for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jul 2023 16:47:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02C3D21835;
 Tue, 18 Jul 2023 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689698847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gG/SrZGF5/s3yIgwzjFlba62tVC4bEASQFHFHTinDw=;
 b=sCqIZIaeY+lZmLjsOPsAbQI7GvoRp+QnzyxAweo04VRhB02G7zlyPODdtnMibPbRArJBXD
 EmKHbQr2G1Hg/mlor+k1OhYUl6g3r4QossnKRSkX+YcTTQxPScxqx/r35yGnTw3fNEyVf5
 ghYS+pV/sSq88EFejZe58ccHS7UeR7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689698847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gG/SrZGF5/s3yIgwzjFlba62tVC4bEASQFHFHTinDw=;
 b=5Agcg3CzsovgtmLs9P2htHWvOOKunhSV4WopA6/9BhjEF+Ts1aNnzWoRaa1U1bHqG+xwJc
 Fil0WRvm5Z4c3BAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0405134B0;
 Tue, 18 Jul 2023 16:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id llAuKR7CtmTiUwAAMHmgww
 (envelope-from <krisman@suse.de>); Tue, 18 Jul 2023 16:47:26 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-4-krisman@suse.de>
 <20230714050028.GC913@sol.localdomain>
Date: Tue, 18 Jul 2023 12:47:25 -0400
In-Reply-To: <20230714050028.GC913@sol.localdomain> (Eric Biggers's message of
 "Thu, 13 Jul 2023 22:00:28 -0700")
Message-ID: <87pm4p5fqa.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1qLnrL-00C4cc-8g
Subject: Re: [f2fs-dev] [PATCH v2 3/7] libfs: Validate negative dentries in
 case-insensitive directories
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
Cc: brauner@kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Eric Biggers <ebiggers@kernel.org> writes:

> I notice that the existing vfat_revalidate_ci() in fs/fat/namei_vfat.c behaves
> differently in the 'flags == 0' case:
>
>
> 	/*
> 	 * This may be nfsd (or something), anyway, we can't see the
> 	 * intent of this. So, since this can be for creation, drop it.
> 	 */
> 	if (!flags)
> 		return 0;
>
> I don't know whether that's really needed, but have you thought about this?

Hi Eric,

I didn't look much into it before because, as you know, the vfat
case-insensitive implementation is completely different than the
ext4/f2fs code. But I think you are on to something.

The original intent of this check was to safeguard against the case
where d_revalidate would be called without nameidata from the filesystem
helpers. The filesystems don't give the purpose of the lookup
(nd->flags) so there is no way to tell if the dentry is being used for
creation, and therefore we can't rely on the negative dentry for ci. The
path is like this:

lookup_one_len(...)
  __lookup_hash(..., nd = NULL)
     cached_lookup(...)
       do_revalidate(parent, name, nd)
         dentry->d_op->d_revalidate(parent, nd);

Then !nd was dropped to pass flags directly around 2012, which
overloaded the flags meaning. Which means, d_revalidate can
still be called for creation without (LOOKUP_CREATE|...). For
instance, in nfsd_create.  I wasn't considering this.

This sucks, because we don't have enough information to avoid the name
check in this case, so we'd also need memcmp there.  Except it won't be
safe. because callers won't necessarily hold the parent lock in the path
below.

 lookup_one_unlocked()
   lookup_dcache()
      d_revalidate()  // called unlocked

Thus, I'll have to add a similar:

  if (!flags)
    return 0;

Ahead of the is_creation check.  It will solve it.

But i think the issue is in VFS.  the lookup_one_* functions should have
proper lookup flags, such that d_revalidate can tell the purpose of the
lookup.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
