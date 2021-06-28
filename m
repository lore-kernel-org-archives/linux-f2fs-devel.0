Return-Path: <SRS0=QpjO=LW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D98CC2B9F4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 12:41:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74FF61C31
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 12:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74FF61C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lxqZk-0007U9-9z; Mon, 28 Jun 2021 12:41:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <wangshilong1991@gmail.com>) id 1lxqZi-0007U1-13
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 12:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s5/zTfNR70aTjv1xZrZ4pWS2DjzkypAd9rzw9Aphd6w=; b=G2xtYug2yeiwnDnTNw3wIsoJxn
 gCzx9T/XS3HFgN45X+eD3TsoL/6kWO6j1YrtaY20v1pb0bYYZAS+u699gQdzyiYqQQVvtbmZ5t+Zg
 Xy3lxSplJGPwSdUF6O6ANPwPcfeQUr8okT4iAzrd++KD6eiG+mcB37g0mILOYOTNSaCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s5/zTfNR70aTjv1xZrZ4pWS2DjzkypAd9rzw9Aphd6w=; b=dheVTyzUaFtI+5M+Vbch7vJEK6
 hPg/Z5a/yVuROJlm9310P0fUBzyYHl3PjJhPyf19fZKePlGPgnNeo+yZYVnFpw/Nx/oYbTm3B8LZ3
 VzE0OXYqWilhDfxNDT6o8eO31FtaZMzPKETVGbvLpK9N1p07eUpqc9/dhzXeo66eYhDc=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lxqZY-001r8y-Ue
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 12:41:20 +0000
Received: by mail-wr1-f52.google.com with SMTP id g7so16495672wri.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Jun 2021 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s5/zTfNR70aTjv1xZrZ4pWS2DjzkypAd9rzw9Aphd6w=;
 b=J5C0U2TwFeyCBDnIXoh3fP4g+kemM+leAvGcZn3foDep/O4eEbLPEHD8c25RsxPbL6
 eLFJSDTvy0lQYFSyIPj2imVd6MYmx9mRVdn8ntbJZ6B9u1AwL8FAlbil4duTRBhmmOBc
 4r8zqxSccb5W7KIUsF+GwWXpH/h2ezdeg7GRZ8qg/8dIt8nORbww+6mLfY32NDkeyejI
 tE9JdcVzfnjcuTn48V5VmyRvQj9D3rAzFqB8Hf3TAcDNcBERorlvqrNmHzLkunKFAw6p
 nkkhJE3M9BZLS/CBHm3OnV5yECJQiniRE30MvuSGstI1Eatl5BjqZ2aOZBqhQ3BFkxu4
 rdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s5/zTfNR70aTjv1xZrZ4pWS2DjzkypAd9rzw9Aphd6w=;
 b=agvhoHnua30RppStAgMD/fwzi0CTVsoxqTi2DYyx0f8UEmYYLMNv/JadMdwFh5KNjl
 EsVisYRJPukxvxvckhpOAfdZDHSt9SEU0zjoTHL28FvLDzQb20cklHaKxH54fLAGX7aF
 wG3v2P56TNgbP+iDpin3qSs+/6xkTB5ApfOnLnhcilR/7s2T5kTX8WEsAFfpUHqaqR1q
 7odd6CtDXDG5zH0hnMahSQfOoVDL2X00vu0JdJ6iVdFWIzNJBr1+cg17dxGI+cNcoN3H
 28LKgEb+vEmaJ6AIhqHJgahA4hGKNyhAorSELkZCMy1mCUfA2THRbDep8vsmCl8F7VKY
 sP8g==
X-Gm-Message-State: AOAM530aOLfe7KgRghnGftLBsQ3LRqITBEllZZ6FFi91inNEmJRsLLkM
 wsqORnmkkfa3ZvXaSShFCG0huT8+slCRV+2xLHk=
X-Google-Smtp-Source: ABdhPJyHhX/JQxTm87Pus/NqKviVZfAbV9vG8LFegKu2AjKeS8GhZeo8uVu0UQM1AFUbp+TR2jkxwAO+9jx3YKl+fK8=
X-Received: by 2002:a5d:6291:: with SMTP id k17mr27150390wru.225.1624884062719; 
 Mon, 28 Jun 2021 05:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210625125026.5796-1-wangshilong1991@gmail.com>
 <9f6d607a-6b43-a3e2-7002-426f58513f9c@kernel.org>
In-Reply-To: <9f6d607a-6b43-a3e2-7002-426f58513f9c@kernel.org>
From: Wang Shilong <wangshilong1991@gmail.com>
Date: Mon, 28 Jun 2021 20:40:51 +0800
Message-ID: <CAP9B-Qn+eV5LSCtfbLAeXZpOJ3UDMzb7a9i6vJwfDN_zfKjHYA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1lxqZY-001r8y-Ue
Subject: Re: [f2fs-dev] [PATCH] f2fs: forbid U32_MAX project ID
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
Cc: Wang Shilong <wshilong@ddn.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

On Mon, Jun 28, 2021 at 8:32 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/6/25 20:50, Wang Shilong wrote:
> > From: Wang Shilong <wshilong@ddn.com>
> >
> > U32_MAX is reserved for special purpose,
> > qid_has_mapping() will return false if projid is
> > 4294967295, dqget() will return NULL for it.
> >
> > So U32_MAX is unsupported Project ID, fix to forbid it.
> >
> > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > ---
> >   fs/f2fs/file.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index ceb575f99048..861edf3c01d5 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3066,6 +3066,8 @@ int f2fs_fileattr_set(struct user_namespace *mnt_userns,
> >       u32 iflags;
> >       int err;
> >
> > +     if (fa->fsx_projid >= U32_MAX)
>
> unlikely()? if this is really a corner case.
>
> > +             return -EINVAL;
> >       if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
> >               return -EIO;
> >       if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
>
> I prefer to check fsx_projid here to keep line with check order in other
> f2fs interfaces.

Just sent a v2 which tried to fix the problem in the VFS.

>
> Thoughts, Shilong?
>
> Thanks,
>
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
