Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E1606A339
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=enzNgYve;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PLda9pAN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f/uofdhP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeOv4qBy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=fCfLBlIseVhiZ66K3I5k6Kg9iJ4bMLDy7MpMRc6lVdk=; b=enzNgYveQw0n5Yr4YsAfVtB6YJ
	f+rYokzY3EYcNLerpp/uYSvkaCJGE2P4rA7NFdog0VhCDmgprkDsIu4Z4+MutE0d94s7qqQTjspb3
	HQUh3VclWb6WcL+9m7HVQZ31rQHgzVhhvBgPkx3XkhZcY8T0SHOyTy/lYWfDbyrgwft8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTP1m-000000005fZ-2Igl;
	Tue, 17 Nov 2026 19:39:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <david.laight.linux@gmail.com>)
 id 1xTP1k-000000005fT-1lTt
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 19:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=; b=PLda9pANa50zljRHe5g/w84TR1
 KQuaEUtOb5CNc6W+61UuQJusqhHN9W84pKcE5ij3TVsiNENU1k6wJbSjw/1UOTu+bVW8RHVQjSL4p
 +tk94+lnmnnjFH8vhkCivRyUhWEYgI2Wp+885sCJqlFx2Si6kfNWLa0kQtPa+dNhVsVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=; b=f/uofdhPBDG2a4H5kXqeAVlGR0
 4MNhgKabvWfcypuhqEgpg7fm3p9JDKdh5B7Xzel8UItRLK1iZR7aTpvE9ThZS4tJr+XZXJ1m6y+92
 OJhU06iNXqkJhKuFGb88mTHBxW+4m1mGEBF57WojsZ0R8AEceh3ov3kmgb54myCj0Sq0=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTP1g-000000003Tj-0nvi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 19:39:36 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso83342f8f.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794944365; x=1795549165; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=;
 b=PeOv4qBywiT+q7nbA0wYrDsrY/0pS+iRC1AZi0ng/EBSIRaASpuMwgfs7mg0J9X0HO
 P6roiVPiIKku8D+mJT5uJIRIz6Gc2JpOjziYFbjkp7dEjO799ri2O/iFYuHM9kbQfjcw
 wg/WOzz8B0srpcjCQqDNycy5K33UUG+vsIlXtP8z9NacwXeLonxIGMeQkbeFlIiZFEwI
 VaJyR5QpdnPfly9gTcO6oqxKMdvtJFzM3qT1EQWSm5ahXVQwugnaKoURBFjq/03cd14Y
 BmH8WT28rAMnjddM8HSTtv3cotbh25IXqhj6KmwOhud3fqnfq20ELaNVQ53dC766Xwev
 X+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794944365; x=1795549165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=;
 b=Bj8uesgy0LWZUGXResbiSd0xWH3NTxJPfHFBPXfiDxmXxswYowV+fsgmfbNxw8a65D
 w7KkonNAnIR2VJHpIapaKAopIGwHkfWcwovS4rcZOdNwMP37dvu04YXciAOfUme06KtI
 7lfHce1UMqYbuqfIyZiF3m4uGAp3bC3TfvQRKMIrY9JgmL8nXGFRdvq+c7Prz6uNTci4
 PNfikYlHu0lc0DSmhSQgkV6AcMGdFIUhkN8zvr8qLNObW6IhGPG0wLw9BXjSuth8jads
 Qa9HtC/knmU1FF9sE2Q1/BZuJugR1QEnHLkrtTeJEnsawOSS+ruErrxQyguxHDvYoxcA
 fW4w==
X-Forwarded-Encrypted: i=1;
 AL+hErHxyQNm+XFYlBo3tBVun9dCW1TM8k01pWEkaz5f+Bw9Ol3FpPx3/vXwrP2f9IOzORMX0pmMfqAzTaEDa1MNhQCE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9p7Fq0ZDNHpsXf4/mxsbd2F4/pVxAK6+NmLtN2CHObU3O3UjNB
 oKXV+7O1H/LmMEnMiR7wiIcvPeRxXWEBCutcG+IvGg086xbAmGP0I9jf
X-Gm-Gg: AZFdTZdLHxSpADF1RdxC+fqQTPpv1ej8af6Eir2EL0QqR4PODrU9ZOOCKhvlD7zou0z
 vmeHhV6ddAHr3jZu13VM/qcL9jNfG6yvdUE4rcXsa/5hln1d/+uekZSTJ8l1WIwAly1VIv7kCaK
 SrJjVy6jQmmrhvKAfgl+IU8PoiYfKwFqzyEndsH4NO5DUDtkYHdhP9i5srUukwf5QyFx5rPOWkH
 BgJafyHId7dzm98lxGZW0Wd/sIGKd3duBEX7HQsA2adu6Lis+idtLhH050twn3OfVAvkY9+M32C
 t1SV5NAJaogLQk/cBGWJmJV7LZUsILkg4q584q9OmPMG06jY4gv4FcsCtkOEsgZSq+jpTrBW3Am
 R1OKlsQdliDNwnkdU+FuIoK7v9HFgTVbj7/JmJRwRXgV+nhrrGuSfzw+v4W78M5qKy5vnfEk+4A
 pXUU6DJ8EMbdOR5YL1lSEdDqdmwMCt779kewnteLGDD58amjannqJLq3TBU7pite/riKnycXYWE
 YTFXo+tiLoNAjwNSvVrFPT8OLth8gE4BDJey/YCKVk2a0tKlutF5nDRVkxcJwOGwIr3UEkziThY
 KYEbg+3GWc9JlH6EOHSHhniGN3D3U3MSXoGalfPxmxBsjMPlnEzXUrLKVl5zstpR/w==
X-Received: by 2002:a05:6000:200c:b0:48e:bf0:352 with SMTP id
 ffacd0b85a97d-4a6346da7e2mr1023911f8f.5.1794944365440; 
 Tue, 17 Nov 2026 11:39:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c1145esm424374f8f.52.2026.11.17.11.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 11:39:25 -0800 (PST)
Date: Tue, 17 Nov 2026 19:39:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20261117193923.795e6129@pumpkin>
In-Reply-To: <20261117175917.GO989762@ZenIV>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola> <avu0X5E298dHRBHY@mit.edu>
 <20261117084727.0cfa196a@pumpkin> <avxe5v6r1C7ZG7E2@mit.edu>
 <20261117175917.GO989762@ZenIV>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTP1g-000000003Tj-0nvi
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
 Christian Brauner <brauner@kernel.org>, Theodore Tso <tytso@mit.edu>,
 Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 17:59:17 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Nov 17, 2026 at 09:54:32AM -0500, Theodore Tso wrote:
> > On Tue, Nov 17, 2026 at 08:47:27AM -0500, David Laight wrote:  
> > > > Sigh... I really think these characters are *evil*.  I wonder if we
> > > > should simply drop those code points unconditionally when they are fed
> > > > to the kernel --- not only folding to themselves, but *not* preserving
> > > > them when a misguided application tries to create a file with one of
> > > > these misbegotten Unicode charactesr.  
> > > 
> > > Doesn't that assume that filenames are UTF8 rather than just sequences
> > > of bytes with everything except '\0' and '/' being valid.
> > > Casefolding is itself so evil/impossible it shouldn't have been allowed.  
> > 
> > We would only do this if casefolding is enabled.  
> 
> Which is to say, on any distro kernel.  Besides, it's not just a matter of
> filtering that dreck out on getname() and friends (syscall boundary won't
> do at all due to the things like binfmt_misc opening files, etc.) - you'd
> need to scan what you get upon ->get_link() as well.

I also hope it is a mount option?
So you could cross mountpoints several times (in both directions) to and from
fs with utf8 casefold un/supported while processing a single pathname.

> > For better or for
> > worse, it's better than what it replaced which was this terrible
> > wrapfs hack that was a trivial to trigger deadlocks using fsstress ---
> > which was even more evil.
> > 
> > The other way we can deal with this is that if case folding is
> > enabled, we change the VFS to call the case-folding for incoming
> > filename *before* it does its special case checking for '.' and '..'
> > if casefolding is enabled.  
> 
> That would penalize every pathname resolution, whether that misfeature is
> stepped into or not; hash_name() is fairly hot.
> 
> '.' and '..' should be recognized only as literal octet sequences 0x2e
> and 0x2e 0x2e; if some misguided filesystem decides to treat something
> else as equivalent to those, it bloody well ought to recognize and reject
> that something else in its ->lookup() (or ->d_hash(), for that matter).

I remember when "." and ".." weren't actually special.
You could have great 'fun' using the 'link' system call to make them
refer to unexpected places.

David




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
