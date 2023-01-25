Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85274C27C76
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Jan 2023 09:53:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pKcT4-00027q-0O;
	Wed, 25 Jan 2023 09:53:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <glider@google.com>) id 1pKcSV-00026k-OP
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Jan 2023 09:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OuciH5zAUURnBDw16GG9WV+6Jm2kIAhFJoGWXvuLyzY=; b=SJgsDjZdrbAkTUEtx2QPj4HSUK
 YSU/JNWvritMzvt2Q40VeJ2kF+3krz46mXdgRzcrlWvCzU2vY7Gp0k5mt2K3Fm+funJXIszxhvtrr
 spQ8y2tmj4339k1PsRMevm6iHYbqKUT2q0bswdP/u5q2d67Ic5rob4gsx8gGcv3dL/F8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OuciH5zAUURnBDw16GG9WV+6Jm2kIAhFJoGWXvuLyzY=; b=CLhXdV301vPvK8klwCmSdX8iV6
 n5ARRcWBQCOVZz0h0xuLZF2xhATHUTNlTCMAU+aGOlOk82e0LAJxz2f8vfaWJotzsJJj6F661TLfE
 Y0be22puyq7CPkjo2hmpUICG2PHvS58WdLVYbsypn2X8TyDu2aczlK2AfBFVayvAqGgk=;
Received: from mail-il1-f180.google.com ([209.85.166.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pKcSO-0003Bk-Do for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Jan 2023 09:52:43 +0000
Received: by mail-il1-f180.google.com with SMTP id i1so8545886ilu.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Jan 2023 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OuciH5zAUURnBDw16GG9WV+6Jm2kIAhFJoGWXvuLyzY=;
 b=A1AB+qgY+bNcqCoh6g/QPfcTbHSdfM703fBk6MwZVQpdjKXroZK1oH0ns7MrSkqpEh
 EOFNTevaPYrK/s2JxRXzjpxKJuFDLK0q2y5rZGlM4eYwU42FRyAmNuFKT7Bg1y72UQr6
 97toi8YHPu1hdYbPDOUE8UH3Qse8M8RNx9XwKsItw/AX5ZjEdGoF6VszDeJWjYB0aicF
 ydXIqaQhWbVJDKjQyaFJQGQ8Tb4O2relzLKrriy0p8DNZHpby7I/ajeseKccsiM2etXU
 gc06b1Ly5AKuKaPMG0ZIbCmyoYgFf9iOl8HavzkcQOMATVBkyu4NrQfUDAIvJdVcxVmJ
 W1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuciH5zAUURnBDw16GG9WV+6Jm2kIAhFJoGWXvuLyzY=;
 b=b+fsleOPhHw0LgkCs+suhBOcrZKqqiFWWpXbYH5JzJW3QPUZfjgqeJKfebLwKrRHRr
 bQ4c2sajhH+5FHZ3l9YGyD8z6nSMqPRIeYMg/t4v/W7jJ/budFPSKH93lStO/nyqOHUm
 GoZ0LjvTDmXtrhH6t2fGmF2DMFlo1ONWLJ2/JC1zuVgyaAvpkoFwSba3WYAA65uPAbhl
 NgXIGSiZNKGwjd5TnrcoisUVO7oA6waF2il51yAYd9f96Bqjd4abdCxJes9HSgdrlQJB
 zwVuOvVI04RylURnMEj3dx7FFMSdaNshFwJSYZ+3Crhc4LvQFgscdtRH3QmOyNOv4FCm
 nf2Q==
X-Gm-Message-State: AO0yUKWqdHO3vdBZMr7EKXZibeUa6keTEb9zZNcYZq8eMAkNR0OKTakj
 PUURoD3YM9NJWsDIpo2Qvo9tJMTC5XlJ7/TxmkwOgA==
X-Google-Smtp-Source: AK7set/RqxBYpDySUQ4Hf1TOiGHp0yJPE0emZ8yXer/udU2W95b7BNk2ZoGFsf4v/GnYc+LqXkIFjxHDeLUfWqc82qo=
X-Received: by 2002:a05:6e02:b23:b0:310:9cb4:223d with SMTP id
 e3-20020a056e020b2300b003109cb4223dmr495004ilu.164.1674640351299; Wed, 25 Jan
 2023 01:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-4-glider@google.com>
 <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com>
 <20230124130401.eb5d453213d557cf3b7a8ed6@linux-foundation.org>
In-Reply-To: <20230124130401.eb5d453213d557cf3b7a8ed6@linux-foundation.org>
Date: Wed, 25 Jan 2023 10:51:54 +0100
Message-ID: <CAG_fn=XgBL00Oo5v7se5ZyP+uBbFSOaed4KReZVgpg3n8Nu95g@mail.gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-Headers-End: 1pKcSO-0003Bk-Do
Subject: Re: [f2fs-dev] [PATCH 4/5] fs: hfs: initialize fsdata in
 hfs_file_truncate()
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
From: Alexander Potapenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Alexander Potapenko <glider@google.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 24, 2023 at 10:04 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jan 2023 11:51:30 +0100 Alexander Potapenko <glider@google.com> wrote:
>
> > On Mon, Nov 21, 2022 at 12:21 PM Alexander Potapenko <glider@google.com> wrote:
> > >
> > > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > > an error passing the latter to aops->write_end().
> > >
> > > Fix this by unconditionally initializing fsdata.
> > >
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > Dear FS maintainers,
> >
> > HFS/HFSPLUS are orphaned, can someone take this patch to their tree?
> > Thanks in advance!
> > (same for "fs: hfsplus: initialize fsdata in hfsplus_file_truncate()":
> > https://lore.kernel.org/all/20221121112134.407362-5-glider@google.com/)
>
> I grabbed both.
>
> I removed the
>
>         Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> because that might provoke the backport bots to backport this fix
> across eight years worth of kernels.  Before KMSAN existed!

Right, makes sense.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
