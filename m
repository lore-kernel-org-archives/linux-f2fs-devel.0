Return-Path: <SRS0=ofO9=K6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93AC4708F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 05:54:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE5361414
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE5361414
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naDPUEV/7ZXLUelJ/rccGvxkNCWTmr/l8AI1AdjnQP4=; b=VQ9+wjXzXxi/getHNzk7dF98U5
	4D39LAHqCeCt+RaD2ItmbJTu3uPTPV29gIfiZJzWnjHGsIXAfdOWqnqCasiFKQkRb9DmmWVv6uJSN
	LJtKDbooTXCiDSIQYpZFl4QWRksRouo8eT3g6SHwvPPkLApml4UylxBPo5Nfa9SeAzM8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lp2my-0005IH-HZ; Fri, 04 Jun 2021 05:54:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <drosen@google.com>) id 1lp2mx-0005I4-0F
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 05:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s006idCoojr2jJ8QdaJf4VEixIzc94xt+tDzBqU8cPk=; b=fYoQN+ENudBAPIrSZrBokL0zF7
 qg3cVad3HyyjHwAy9TpYshUpMDEcFZNPsyIMfHbwr81a1sbHeqfnTIs5xaCcxNX8ebrLYps4ysWZm
 GtYGke1KqVLtVLhBiBxwIrVSFTV+tgyO1RHJnj/Qd9D5sB6QSNXJvhcMQBGm9JNdK+Qg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s006idCoojr2jJ8QdaJf4VEixIzc94xt+tDzBqU8cPk=; b=C5W7WRqGtQFD9NNl1kT18wEYcJ
 vCrBDfWLwYaJDvoq6wVW1j6uGXjWMh7DabQTT9spXYrorFurgK2XNdvIbr73QtrHpCIs5KAK3nnHW
 5R5CMfyaBaFVo2iamVjGWIpq8QOvl4IbDJAR7CthGF5vGtciCK4L8g2yVKzEqdxR4Exw=;
Received: from mail-ot1-f53.google.com ([209.85.210.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lp2mp-0000ZA-Ow
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 05:54:35 +0000
Received: by mail-ot1-f53.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so3664537oth.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Jun 2021 22:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s006idCoojr2jJ8QdaJf4VEixIzc94xt+tDzBqU8cPk=;
 b=uTFU7vK1vBckKcoyEsNg3Vn2q+BMLItUy/iXLu3kEWoBiM3+UcpQBTV9w4esXfS+FA
 YOFP24wKEOsZhL0lydipSDXjCj2b6PGbmq018PcCLF1ZQCr+fAqmrzBoQGKRPHkj/Tjo
 GE/JFEvUacQ4ELG8Xus8wNQy88BwYTiX/LIMCwH/9QX1MJXr6yCK8jEpCYIz6FhCm8hI
 PgbZQ/2ApudPj3f3jKx27FX+B9W3sFwtzXVZWHqUUpAVZSfswJ3CbE6gMX19JkztLcWd
 V52Ba/Zj1wQ51wfDEdBri/xXVNY7OlPMjcJaAPmQHr/MdXaN46v7A3E/XaoEYGbYryK6
 5Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s006idCoojr2jJ8QdaJf4VEixIzc94xt+tDzBqU8cPk=;
 b=URgjhfbzwi9bfTva94L9BfZNa4PRgD2LOH9zpJsVhtWqhVAxi6rKLxQdGE08L6CeWE
 TYeE0co1zM3NasWmBGgUumZ1nMCOmHPrpAVEwYwW5q/hQxkP4IubIq8xbs1h3OreVwaG
 vlah6XFdnr4DGYNlwpkSag77PyHOSPvCL6f4w3NtF33WgKD5psgXJJVllr7gA/gCVtj+
 Nu+XZ+W2zpUuZQi0X0V3jHMiw3+d8mW7V659ltMMCdGM3nBssCdJ87p3V6dWbUf/nOUF
 CL+5TWfRzh76LqJczSoce6o/L2bz/LJQrn6zPLwQRPwmeh39voV+HNYVwW/7qI9tYgdX
 gzaA==
X-Gm-Message-State: AOAM532LABe6jPzmtQR3AUr0XhssfaK/EUg9zgMnqzlvikdgZAhIhT4v
 gy6+5c5Mvg4Lg5G724Ok4OCrFdr8ITTZdhgamAS2UZjOloQ=
X-Google-Smtp-Source: ABdhPJwGWRPvPMIN8OgwyDuOuM+Wo5CoYGxkMillRS2TPqQKzaFBnLherOQn9+h6FspuZ+JM+swQcD0pUGctYZThbWc=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr2400445otl.18.1622786062749; 
 Thu, 03 Jun 2021 22:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-3-drosen@google.com>
 <YLlj+h4RiT6FvyK6@sol.localdomain> <YLmv5Ykb3QUzDOlL@google.com>
 <YLmzkzPZwBVYf5LO@sol.localdomain> <YLm8aOs6Sc/CLaAv@google.com>
In-Reply-To: <YLm8aOs6Sc/CLaAv@google.com>
Date: Thu, 3 Jun 2021 22:54:11 -0700
Message-ID: <CA+PiJmTcE8ULNoUXH=u-r=rFXjVG_7okaBYgngsFvhjWkYzsLA@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1lp2mp-0000ZA-Ow
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: Advertise encrypted casefolding
 in sysfs
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
Cc: kernel-team@android.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 3, 2021 at 10:38 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> On 06/03, Eric Biggers wrote:
> > On Thu, Jun 03, 2021 at 09:45:25PM -0700, Jaegeuk Kim wrote:
> > > On 06/03, Eric Biggers wrote:
> > > > On Thu, Jun 03, 2021 at 09:50:38AM +0000, Daniel Rosenberg wrote:
> > > > > Older kernels don't support encryption with casefolding. This adds
> > > > > the sysfs entry encrypted_casefold to show support for those combined
> > > > > features. Support for this feature was originally added by
> > > > > commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > > >
> > > > > Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> > > > > Cc: stable@vger.kernel.org # v5.11+
> > > > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > > > ---
> > > > >  fs/f2fs/sysfs.c | 15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > > index 09e3f258eb52..6604291a3cdf 100644
> > > > > --- a/fs/f2fs/sysfs.c
> > > > > +++ b/fs/f2fs/sysfs.c
> > > > > @@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
> > > > >         if (f2fs_sb_has_compression(sbi))
> > > > >                 len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > >                                 len ? ", " : "", "compression");
> > > > > +       if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
> > > > > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > > +                               len ? ", " : "", "encrypted_casefold");
> > > > >         len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> > > > >                                 len ? ", " : "", "pin_file");
> > > > >         len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> > > > > @@ -579,6 +582,7 @@ enum feat_id {
> > > > >         FEAT_CASEFOLD,
> > > > >         FEAT_COMPRESSION,
> > > > >         FEAT_TEST_DUMMY_ENCRYPTION_V2,
> > > > > +       FEAT_ENCRYPTED_CASEFOLD,
> > > > >  };
> > > >
> > > > Actually looking at it more closely, this patch is wrong.
> > > >
> > > > It only makes sense to declare "encrypted_casefold" as a feature of the
> > > > filesystem implementation, i.e. /sys/fs/f2fs/features/encrypted_casefold.
> > > >
> > > > It does *not* make sense to declare it as a feature of a particular filesystem
> > > > instance, i.e. /sys/fs/f2fs/$disk/features, as it is already implied by the
> > > > filesystem instance having both the encryption and casefold features enabled.
> > > >
> > > > Can we add /sys/fs/f2fs/features/encrypted_casefold only?
> > >
> > > wait.. /sys/fs/f2fs/features/encrypted_casefold is on by
> > > CONFIG_FS_ENCRYPTION && CONFIG_UNICODE.
> > > OTOH, /sys/fs/f2fs/$dis/feature_list/encrypted_casefold is on by
> > > on-disk features: F2FS_FEATURE_ENCRYPT and F2FS_FEATURE_CASEFOLD.
> > >
> >
> > Yes, but in the on-disk case, encrypted_casefold is redundant because it simply
> > means encrypt && casefold.  There is no encrypted_casefold flag on-disk.
>
> I prefer to keep encrypted_casefold likewise kernel feature, which is more
> intuitive to users.
>
> >
> > - Eric

When I added the feature_show one, I had been mistakenly thinking of
cases where both were enabled in the filesystem, but not on the same
directory. That case doesn't actually exist, since before the patch to
support both on the same directory, we just wouldn't mount a
filesystem that reported both as on. I think it'd make more sense
without that part. The kernel feature one definitely makes sense,
since previously the kernel could support either, but not both.

-Daniel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
