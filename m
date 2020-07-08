Return-Path: <SRS0=VsZi=AT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5DC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:36:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7ED21974
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="feMfv/Nj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="nSqu7L5i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="X5TyrYH0";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="a7N5EXkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7ED21974
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWaHxW5vVzNnC6Zm4sgDNqNVw36TWS1NfoWoEeWkVdA=; b=feMfv/NjviSFkauaUsYwmIUZyO
	cETfe6hR/m2WbnOdBSSRTe2B/cFU6ragkbsj9liCpuKpiOe7efsiu4MbIS9RGHDhR1sY7pZBv8S51
	9ooekBK/njI+hGLrUtGQ9xM1TDuC1Oa7Mi4JAbsimDUp/wcuxBBc6ZkYiwVFDIfPSmBw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jt5ZX-0002w8-Ib; Wed, 08 Jul 2020 08:36:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1jt5ZW-0002vx-EE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 08:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=; b=nSqu7L5iNamFEkZcxAfh1Ny5MA
 n+Lh9IekCRDf1sWDpXVX6emOjSWe8JA3VWcZUmssXkonpr5hRz2rCJK2vl4Qt62pYGV8CZgDiapOB
 esF+Rb0g20o+MUpbnZWxhxNi4797aF/5ttzhnwQYNgZSxiLjGX4JliQMt4A3dnqON8tQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=; b=X5TyrYH06i9/d1rtVPFtijMkkJ
 UY5wlXD2fIewiNhl4NBADPJEOW6YKDEkTmqd5tBnf4UB9yNyT+SOcwwWGu3UgcT7e9NDCZBio4bD1
 afu0cBbdn97uvDpoShHKubpZ23NMXxoMl9LBwXS9E5ej+o2rvbHDl5AlKSOEBBVhwLig=;
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jt5ZU-00E026-DT
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 08:36:54 +0000
Received: by mail-ot1-f68.google.com with SMTP id h1so14188341otq.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2020 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=;
 b=a7N5EXkH5q7VpSLTWAozI5gExPwpPLyEBtcnr+2Joyigm0wqh9O962IoDSEkQkNe24
 G0b7x3cdw0AGEOwCagxOmuU2zD2rueVP3jFwJ1lbf3nWWdqZWtyp4KjV6oVZfok6JToX
 b5iZD6fEW2fOrcX3fUDiv4C44gQbHmEgFQDXN+gKgfNQoiyXhwA+X+OmAU2s1fIInzLD
 8Fc1+guNZyjLcgN0szNlMFiaHA+C8wUa8soG5hVGc84IlOyq2splKLjARL+IhmghncC1
 Bv3M94PQA+S5+1aPAntPl45rQ9Ut5fxU8s3HhGRLBtk06ZEBoz9M7eo06qvjRzHsHzTl
 8GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=;
 b=IXNELdGju/gN0zeNOVHSy7r6y0a7qJuWhoaN+evXV0kwqew2teXteveS7Bqjejed+N
 pNxpyuoQY++obufk7oPMuOkS3t/2Oa32xFsY8yaV8zZRE6aLVQ2GkYYKjBwXRPZb9gbU
 xSLJdPrws3ehHs9p0/49j+7Rmvonw79Wl4co1NW5/dV1gmKSWFSdEH/HanUmcR6Wmdyt
 y2na7soTVtD1UJputKMoYqdgHIINZoBRSHEezinmW44vsbd1GPFkgDTB8qE1DTOAIHOr
 Hn7Ocmb6M+O5qOD/KjXDMy09jLAWtGrT7cvJuqhsArtFBVPWgPcmxN/1vkaSliX0m7C0
 E7tw==
X-Gm-Message-State: AOAM5300znxYqgZP+k0NAtN/QUWvfGWZ20/oDiFFk15NEK5lFBsYH6Sq
 Jf0HInWstb3Sm2HRxkEN31FFYnoFlygAoFS1RMFDdQ==
X-Google-Smtp-Source: ABdhPJwKsuIiJfQBK+Z2FyMDKuMkojZ6lgZ1RE3obfX6zdiVrn4CkzrMBfnMstVN4ibNoDkOfiQQ4zMF5Hlxev2KtTc=
X-Received: by 2002:a9d:6d98:: with SMTP id x24mr38406495otp.93.1594197404821; 
 Wed, 08 Jul 2020 01:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200708030552.3829094-1-drosen@google.com>
 <20200708030552.3829094-3-drosen@google.com>
 <20200708041230.GL839@sol.localdomain>
In-Reply-To: <20200708041230.GL839@sol.localdomain>
Date: Wed, 8 Jul 2020 01:36:33 -0700
Message-ID: <CA+PiJmQP+kJQeCZ0LFqRcN6JYWF6pAUHaTnFOThmDLtLTveOXg@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1jt5ZU-00E026-DT
Subject: Re: [f2fs-dev] [PATCH v11 2/4] fs: Add standard casefolding support
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 7, 2020 at 9:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 08:05:50PM -0700, Daniel Rosenberg wrote:
> > +/**
> > + * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
> > + * @dentry:  dentry whose name we are checking against
> > + * @len:     len of name of dentry
> > + * @str:     str pointer to name of dentry
> > + * @name:    Name to compare against
> > + *
> > + * Return: 0 if names match, 1 if mismatch, or -ERRNO
> > + */
> > +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> > +                       const char *str, const struct qstr *name)
> > +{
> > +     const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > +     const struct inode *inode = READ_ONCE(parent->d_inode);
>
> How about calling the 'inode' variable 'dir' instead?
>
> That would help avoid confusion about what is the directory and what is a file
> in the directory.
>
> Likewise in generic_ci_d_hash().
>
> > +/**
> > + * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
> > + * @dentry:  dentry whose name we are hashing
>
> This comment for @dentry needs to be updated.
>
> It's the parent dentry, not the dentry whose name we are hashing.
>
> > + * @str:     qstr of name whose hash we should fill in
> > + *
> > + * Return: 0 if hash was successful, or -ERRNO
>
> As I mentioned on v9, this can also return 0 if the hashing was not done because
> it wants to fallback to the standard hashing.  Can you please fix the comment?
>
> > +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
> > +{
> > +     const struct inode *inode = READ_ONCE(dentry->d_inode);
> > +     struct super_block *sb = dentry->d_sb;
> > +     const struct unicode_map *um = sb->s_encoding;
> > +     int ret = 0;
> > +
> > +     if (!inode || !needs_casefold(inode))
> > +             return 0;
> > +
> > +     ret = utf8_casefold_hash(um, dentry, str);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     return 0;
> > +err:
> > +     if (sb_has_strict_encoding(sb))
> > +             ret = -EINVAL;
> > +     else
> > +             ret = 0;
> > +     return ret;
> > +}
>
> On v9, Gabriel suggested simplifying this to:
>
>         ret = utf8_casefold_hash(um, dentry, str);
>         if (ret < 0 && sb_has_enc_strict_mode(sb))
>                 return -EINVAL;
>         return 0;
>
> Any reason not to do that?
>
> - Eric

Guh, I remember making those changes, must've lost them in a rebase :(
I'll resend shortly.
-Daniel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
