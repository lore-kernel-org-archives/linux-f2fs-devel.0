Return-Path: <SRS0=MGGM=V2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48CBC76186
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2019 20:46:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE8E206A2;
	Mon, 29 Jul 2019 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iijxRG4v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="m+gaAHcH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K79oGysD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE8E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsCXX-0004zu-SH; Mon, 29 Jul 2019 20:46:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hsCXV-0004zl-8f
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 20:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pf5AMvh1xxgs/Bq5LKamHgjq2spjhAoE1QhEizd9KJc=; b=iijxRG4vBXmyp8aPN8dy3b9rpD
 mMd8rG4KcsN5Uan9Fov+pu4deQh/364UoPwaJxMbvjXcEAllxh828xm4SDF0YzdyX4GS1pEE0syZ7
 vvROYbQQkvlK6sVr3rnJwM3toVnvS5wXaMjV5c9JYvX686Fb3WJMNmBAQmoezye86KMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pf5AMvh1xxgs/Bq5LKamHgjq2spjhAoE1QhEizd9KJc=; b=m+gaAHcHdgqY+Vap/LHeDeNdGl
 Zq9AL0PLUQq/oQtXf6kNtzWLjgJpsFMU4NqYg1ZQ8LgSwGagaQgOFcqbPBlOb6w4zjJzhYb/+R3zP
 UeRkrXxPNwP4oiaRS74y0U7bjZvUWCSsy426+OCC94FKfMUN68wJbXx+sp5iYIrSnvgA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsCXU-003hzu-3k
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 20:46:37 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D6B0206A2;
 Mon, 29 Jul 2019 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564433190;
 bh=DNMh2YRc0dQISTUq/gkVxZiJ3MfUwE+LBvvMLd0sx0w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K79oGysDbp1R9KcVqj1mKpfGB23D0dx9KzJwL1URFJI/8PotFaTXB1QXv/9jPmJ5e
 cd4dzd2ixOf8QsiHSDEd5r1iJBny2qYoC0vd1z0wpsTIbfCpr52p94FTMkHI78oJ2t
 NisulN2mchZN4cYXAX27Nu925MXHkVW50WusaYRo=
Date: Mon, 29 Jul 2019 13:46:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20190729204627.GH169027@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
 linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>,
 Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-11-ebiggers@kernel.org>
 <20190728211730.GK6088@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190728211730.GK6088@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hsCXU-003hzu-3k
Subject: Re: [f2fs-dev] [PATCH v7 10/16] fscrypt: v2 encryption policy
 support
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
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jul 28, 2019 at 05:17:30PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 26, 2019 at 03:41:35PM -0700, Eric Biggers wrote:
> > @@ -319,6 +329,31 @@ int fscrypt_ioctl_add_key(struct file *filp, void __user *_uarg)
> >  	if (!capable(CAP_SYS_ADMIN))
> >  		goto out_wipe_secret;
> >  
> > +	if (arg.key_spec.type != FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR) {
> 
> This should be "== FSCRYPT_KEY_SPEC_TYPE_INDENTIFIER" instead.  That's
> because you use the identifier part of the union:
> 
> > +		/* Calculate the key identifier and return it to userspace. */
> > +		err = fscrypt_hkdf_expand(&secret.hkdf,
> > +					  HKDF_CONTEXT_KEY_IDENTIFIER,
> > +					  NULL, 0, arg.key_spec.u.identifier,
> 
> If we ever add a new key specifier type, and alternative in the union,
> this is going to come back to bite us.

Well, I did it this way because the next patch changes the code to:

	if (arg.key_spec.type == FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR) {
		...
	} else {
		...
	}

We already validated that it's either TYPE_DESCRIPTOR or TYPE_IDENTIFIER.

But I guess to be more clear I'll just make it handle the default case again.

	switch (arg.key_spec.type) {
	case FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR:
		...
		break;
	case FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER:
		...
		break;
	default:
		err = -EINVAL;
		break;
	}

> 
> > +	if (policy->version == FSCRYPT_POLICY_V1) {
> > +		/*
> > +		 * The original encryption policy version provided no way of
> > +		 * verifying that the correct master key was supplied, which was
> > +		 * insecure in scenarios where multiple users have access to the
> > +		 * same encrypted files (even just read-only access).
> 
> Which scenario do you have in mind?  With read-only access, Alice can
> fetch the encryption policy for a directory, and introduce a key with
> the same descriptor, but the "wrong" key, but that's only going to
> affect Alice's use of the key.  It won't affect what key is used by
> Bob, since Alice doesn't have write access to Bob's keyrings.
> 
> If what you mean is the risk when there is a single global
> filesystem-specific keyring, where Alice could introduce a "wrong" key
> identified with a specific descriptor, then sure, Alice could trick
> Bob into encrypting his data with the wrong key (one known to Alice).
> But we don't allow keys usable by V1 policies to be used in the
> filesystem-specific keyring, do we?
> 

The scenario is that Alice lists the directory with the wrong key, then Bob
lists the directory too and gets the wrong filenames.  This happens because the
inode, fscrypt_info, dentry cache, page cache, etc. are the same for everyone.
Bob's key is never looked up because the inode already has a key cached.

This also applies to regular files and symlinks.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
