Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9845606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ya/mXeBT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HZ3JX3M5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DKxXX4kl;
	dkim=neutral header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=uPUfOMor
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Q5+NOM4wEiCyYxYh6hmBd7BN1B0HGzfAtjfOCdiZwb4=; b=Ya/mXeBTFTY3DX1/EbiKAzXjmd
	8z1zMkO+SDOV+7qD3Krr5YUbBrjPVv44t7GRLVDyahaxdxSC1yBlKMQa1Fy4cY5iwoC59KVImYruP
	S+QAVp6uxD7g7zX2HRT9H5QMdKVbttshVRgOtZPevTVdcnv6uNS+FLZuqA5H2zEFthzs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTNqR-000000007Zk-09EG;
	Tue, 17 Nov 2026 18:23:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1xTNpz-000000007ZN-3gvs
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k/LpWY5KUfJWDsk5FQz9MJ7AFM3pBZFBjow0OZbAt5g=; b=H
 Z3JX3M5OhaVwcdX2/KBs74XyfJr3ZyQgKEH80DTSmmGL9jy87tnAMpMuzj94SCEyiZHvtYfQDeFgX
 I+zkTTh2GsdGDpymJ5+mUh56bUXBbnnd2wN4RmXA66OiRlBgN78WWafx7XA0Yrip+zA6/6VwtdZ61
 PMbklkYfz5iD89+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k/LpWY5KUfJWDsk5FQz9MJ7AFM3pBZFBjow0OZbAt5g=; b=DKxXX4klNQVrIASZfltkZJ1nQW
 CfBrkOfIxGUOHEJnwJ5ZCGBtjqUd0Hb84eaFqvCzTPjpicbW9DqmzV4ZtMWe0erNskZuFTWdi0PwB
 VpaUXQA0sqfrPG79VOXC+5f4kZ7CfVMQCJOH7FGrApcu/ssNONOj3XtJHrBi2JNiFYII=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTNpv-000000001Fq-3zyT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=k/LpWY5KUfJWDsk5FQz9MJ7AFM3pBZFBjow0OZbAt5g=; b=uPUfOMorYVWSloBmur3+jTWfN0
 /cucEqJPX9ROXNS2Nts4ejxMitj7HKce5BP223k/EVYDvr6meZVWcSR2bDaawotGyswtu3/9RgBdQ
 AM+ACyr1j9xK/5VZyXDH8KM7kA/6anBcqZxRuPjG8zfAFPMgFMBD9KrOE+CaSf37vOfUO0TLsaRTd
 im/RcrikIEZHnc6zmCFGfzF1R7mCFc/8qx6j80lHa9otWtWhRUbjLGB6XfPsB8Z6/f0PdlSnLHkBP
 TuKeIF9ztx35seJ03QlLJqpfLfZMGX4HSJFLM/njHPzgrPvXQcY3cyUbMGy5W0eQGY4CX+x1AZ+LT
 8AuxY6ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.100.1 #2 (Red Hat
 Linux)) id 1xTNSf-00000001zpb-0Jnf; Tue, 17 Nov 2026 17:59:17 +0000
Date: Tue, 17 Nov 2026 17:59:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Tso <tytso@mit.edu>
Message-ID: <20261117175917.GO989762@ZenIV>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola> <avu0X5E298dHRBHY@mit.edu>
 <20261117084727.0cfa196a@pumpkin> <avxe5v6r1C7ZG7E2@mit.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <avxe5v6r1C7ZG7E2@mit.edu>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTNpv-000000001Fq-3zyT
Subject: Re: [f2fs-dev] [PATCH 1/3] libfs: reject casefolded names that fold
 to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 Christian Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>,
 David Laight <david.laight.linux@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 09:54:32AM -0500, Theodore Tso wrote:
> On Tue, Nov 17, 2026 at 08:47:27AM -0500, David Laight wrote:
> > > Sigh... I really think these characters are *evil*.  I wonder if we
> > > should simply drop those code points unconditionally when they are fed
> > > to the kernel --- not only folding to themselves, but *not* preserving
> > > them when a misguided application tries to create a file with one of
> > > these misbegotten Unicode charactesr.
> > 
> > Doesn't that assume that filenames are UTF8 rather than just sequences
> > of bytes with everything except '\0' and '/' being valid.
> > Casefolding is itself so evil/impossible it shouldn't have been allowed.
> 
> We would only do this if casefolding is enabled.

Which is to say, on any distro kernel.  Besides, it's not just a matter of
filtering that dreck out on getname() and friends (syscall boundary won't
do at all due to the things like binfmt_misc opening files, etc.) - you'd
need to scan what you get upon ->get_link() as well.

> For better or for
> worse, it's better than what it replaced which was this terrible
> wrapfs hack that was a trivial to trigger deadlocks using fsstress ---
> which was even more evil.
> 
> The other way we can deal with this is that if case folding is
> enabled, we change the VFS to call the case-folding for incoming
> filename *before* it does its special case checking for '.' and '..'
> if casefolding is enabled.

That would penalize every pathname resolution, whether that misfeature is
stepped into or not; hash_name() is fairly hot.

'.' and '..' should be recognized only as literal octet sequences 0x2e
and 0x2e 0x2e; if some misguided filesystem decides to treat something
else as equivalent to those, it bloody well ought to recognize and reject
that something else in its ->lookup() (or ->d_hash(), for that matter).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
