Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE3606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FDt854hu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AHlK3OKq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bRIJ6lEh;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gA2XPuGA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ymsShAr0W+PWPK4vAwIn7fxmrsT5q5EPWKQeC0a24Zw=; b=FDt854huolGh83n6KN+5APXXB5
	cQVfOCM5hflDtQOPoFfXYRkVK4dI0glWvO6SuK3gwZHOAmOmzm3su+oXuvYgqCiNMH/LiKKQ1rI/A
	CXfcuk/OU44g8V/w+7KAzJqsgqANZ43yecF1B+Kf2voQRsPZba6S/VoYVADCByf5Vkx4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT9Js-000000006jG-2hQd;
	Tue, 17 Nov 2026 02:53:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3qr_7ag4KAHcnVmocVffpfmZodbjjbgZ.Xjh@flex--sarthakkukreti.bounces.google.com>)
 id 1xT9Jr-000000006jA-2a7F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 02:53:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yJ0z/cTDVgrB07z6XnWmnCa5Nm3W6f3XldUZrdDkL14=; b=A
 HlK3OKqRnqFCClSiI/+eilQQ2idM/YboPY2VM6Q+TctfN1DqzuoZicPKKDHrnteFxVZosEmSgk/0B
 ChcXDbTpDYSWk4my3egKnn/CcbeiK+gI4ZytXzCjpjj5mo2azAysbZSetjc3Wv81JPgQ4WJG8pGLc
 jh5x2mU+lS9svCMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yJ0z/cTDVgrB07z6XnWmnCa5Nm3W6f3XldUZrdDkL14=; b=bRIJ6lEhtey5pihrNzP3HQKDTT
 twhTm2TrSht96bcIZtlqW1oK7tlxRo7zSJlthJOm1qG+ID5FfFqeJy2owpEJKjuBBar5LPgLqBf9b
 1ETjOhwegynIs5aK7ef+DDFN5hFt9ZJ5oxaJk4SfAIubwAqvzvkbJxCdGvPaNp/wSmRw=;
Received: from mail-qk1-f199.google.com ([209.85.222.199])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT9Jq-000000003s6-0IRo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 02:53:15 +0000
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so1158150185a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 18:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794883988; x=1795488788;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yJ0z/cTDVgrB07z6XnWmnCa5Nm3W6f3XldUZrdDkL14=;
 b=gA2XPuGAK9aGSyTdK7KtLIRHLCmX4dTPyMN2lZ8bhDBic07mI8E7XrUrOgwOSkge+V
 gsm83r7rNPQaNEzSSkDEqjviLWZSoOONtJuYYRtFU0ElkZXFAUW34H9pNh1kJBsruLWi
 iE99guv6DA2MP8dBtQOkQ+tQxxKZ/HvI1arq29vpT7QAl2sWNAfDj4F5ljLsvoDvl/M/
 AkSPmppeK+uO4bZ2ZiHudUKnN8I/ytTHIqtEcj64sZDa+GuoxEdeqCknBkrQRDD/PFkn
 150bK2Wtf8dmuSeTpLCQjdNomFJLw1Jq7AITtHYaCnzHFW9zQgxvm94qzGI7ndzwUvoa
 lIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794883988; x=1795488788;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJ0z/cTDVgrB07z6XnWmnCa5Nm3W6f3XldUZrdDkL14=;
 b=xbGW9W+gTgtmcAVjHOz1zKDD6tjUmG2IEIDLGr+goZIksoQ5vmqs2YHiQBrfeCCfq2
 CfXfS+MeOZ5K6zkWBI5Rzi7TlhalRfQpaWesEmuXP670pqOiEf7lyFIYR3qugDmO8WSP
 Ms4HmzyEbkF2elInHffHHTKvTvrAWTN0uyVXyGri0PTgoy/6Qw3R8aeTZ43cjKfSs/Kc
 7681Dp7ToMIVvQDSn7fzs0sH57NOYzsRLd/I8nY+krR2JosZpthJYGLC+NptZKXMC5mz
 Sd1cm8kydbVojBiLGwiyy9yDPvaNr5zOPvT6PkJi8/gZoPGJecLBwe55vYLG/ff7csPL
 vwKw==
X-Forwarded-Encrypted: i=1;
 AL+hErG2aya8r12w4pF41kzppO+8q/JVgJpbcGCn7TSq3ocNBaDmYQjRbCrfLSArtOyBgpBLUvEcLvRSH3dQFZ6QE3SI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+9YdkzXnGRqV6SmO6/bBAW7RvfAd3URORVruhNz7b5pvuknbrz
 PNGtzDunc2+b3wtUEefpJJPB+K9nSIYFC9BhNo9uOpr6EMsiT9yNI3A5Ie+G2zV5W7tQDl3CYdV
 LAk4M/P4IHTOzwk61o3ND2eBKZmDvqJoTrJhjSA==
X-Received: from dlbqq13.prod.google.com ([2002:a05:7022:ed0d:b0:1a7:44f:3bc7])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4594:20b0:1b2:4871:b1f7 with SMTP id
 a92af1059eb24-1b50313a743mr10766037c88.39.1794883498730; 
 Mon, 16 Nov 2026 18:44:58 -0800 (PST)
Date: Mon, 16 Nov 2026 18:44:44 -0800
In-Reply-To: <878q2swoxp.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com> <878q2swoxp.fsf@cartola>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117024444.2653745-1-sarthakkukreti@google.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, "Theodore Ts'o" <tytso@mit.edu>,
 Eric Biggers <ebiggers@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xT9Jq-000000003s6-0IRo
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
From: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 02:34:26PM -0500, Gabriel Krisman Bertazi wrote:
> Ugh. I agree this is a problem, but I'm also trying to understand first
> the real impact beyond filesystem complaints during lookup, if any:
>
>   1. Looking up ".\u202e" folds to "." and matches the on-disk "." entry
>      (de->inode == dir->i_ino) in generic_ci_match(), triggering
>      EXT4_ERROR_INODE ("linked to parent dir") in ext4_lookup().
>   2. Looking up "..\u202e" folds to ".." and matches the on-disk ".."
>      entry, returning -ELOOP via d_splice_alias() (or triggering
>      EXT4_ERROR_INODE on the root directory).
>
> These two look like a "do stupid things, get stupid prizes" with no
> further repercussions beyond the error message.  Sure, we can fix them
> to throw EINVAL, but are there bigger repercussions I'm missing?

In addition to what Eric mentioned re: side-effects due to
errors=remount-ro and errors=panic, encountering EXT4_ERROR_INODE marks
the superblock with an error flag which can trigger a full fsck pass on
the next boot.

>   3. Filenames consisting solely of ignorable characters fold to "" (0
>      bytes), causing distinct ignorable-only filenames to hash and compare
>      equal and creating entries that e2fsck flags as corruption.
>
> This seems concerning. Do we actually writes multiple files to the disk?
> shouldn't they all be folded into the same empty string and rejected or
> at least written as a single file?  I'm not sure how it'd be writing
> multiple files to the disk, that seems like a bigger problem.

Sorry, that should have been specifically for f2fs: ext4 will only write
the first ignorable-only file to disk and subsequent files fail with
-EEXIST. On f2fs, f2fs_init_casefolded_name() treats `len <= 0` as a
fallback to raw bytewise hashing/matching, which allows multiple
ignorable-only files to be written to disk (which fsck.f2fs then flags
with hash mismatches).

> > Fixes: c843843e714c ("fs: Add standard casefolding support")
>
> This bug was just made generic by c843843e714c, but the issue was
> introduced by b886ee3e778e in ext4 and the equivalent f2fs support.

Ack, I will update the Fixes tags in v2.

> > +	if (name_is_dot_dotdot(str, len) ||
> > +	    name_is_dot_dotdot(name->name, name->len))
> > +		return 1;
>
> This is checking for strictly encoded '.' and '..'.  But I'm not sure
> that happens? Do we really reach the dcache for '.' and '..' instead of
> the name of the parent or cwd?
>
> > +	um = dentry->d_sb->s_encoding;
> > +	cf_len = utf8_casefold(um, name, buf, sizeof(buf));
> > +	if (cf_len == 0 || (cf_len > 0 && name_is_dot_dotdot(buf, cf_len)))
> > +		return 1;
>
> I think this is a bit too late in the lookup to detect these
> code-points.  I'd much rather we fail the lookup outright instead of
> attempting to treat them as different spellings of . and .. . But isn't
> this dead code because we are rejecting those strings in d_hash through
> your hunk below?  Is there a way we get here without the -EINVAL in
> d_hash first?

Ah right - let me get rid of this for v2.

> But the way I'd suggest be handled is by rejecting the ignorable code
> points lookup (all, but variant selectors for the reasons above), early
> in the lookup path for case-insensitive directories so they never even
> get to the filesystem.  Wdyt?

As Eric pointed out, since variation selectors are also
Default_Ignorable_Code_Point and stripped to 0 bytes by utf8_casefold(),
allowing variation selectors means names like ".\ufe00", "..\ufe00", and
"\ufe00" still fold to ".", "..", and "" and hit the exact same bug.

Thanks,
Sarthak


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
