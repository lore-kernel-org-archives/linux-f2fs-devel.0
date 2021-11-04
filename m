Return-Path: <SRS0=DfLr=PX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD36C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Nov 2021 07:36:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F19861166
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Nov 2021 07:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F19861166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1miXI3-0007Ev-AJ; Thu, 04 Nov 2021 07:36:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mudongliangabcd@gmail.com>) id 1miXI1-0007ET-0l
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 07:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FkZPWkcdepIuZo7m0/533Igkr9SAQLK/i8PmfbIafTs=; b=NFRDjW/4yRhQbAWN79UdGX0qDh
 SmlLHmSF017a+A2wl1daRDbSdRI0Gfvw91ifWMj21/v+xOBi7xjDmPL728JdOHyNMjuUAyYjx+zfC
 eM3mwJM7AuIc9UPNFL/8WHtAMYCgmKI3fmVedKMrl4CvWe2ptyBkMtewEEY6De8UwDHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FkZPWkcdepIuZo7m0/533Igkr9SAQLK/i8PmfbIafTs=; b=RsvIOohicAQDjRAZJMUziaYkLa
 psTvOnbFZQPMtlXbq2xLrtVq6dbzvJfYB9hZg37viKRBunWWbuFSCw8jZpJY7kf9p7tAhfwo6jHbM
 nWdmW7zETJotAw8IBUcyUWBNVU1ag3XVu5N3jyKjYWlK/20TSG7C51nHvTHu/wFN3S8s=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1miXHw-0016yL-PE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 07:35:59 +0000
Received: by mail-ed1-f53.google.com with SMTP id g10so18038999edj.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 04 Nov 2021 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FkZPWkcdepIuZo7m0/533Igkr9SAQLK/i8PmfbIafTs=;
 b=RZ1mIsBX2B5iiKW33Ms55dq6bCbcofRa4BEKyKeUVX8dawsMuR9uQ+5egTuzFzqUMZ
 XGnVjCXALSeqTwJ/i4s6T/4s9C6ulISyfX6c2v0lupMH/Nc0e9Ss4Zq1yvB6saC1NU0t
 NVh263p5XkK+P1PmtSVNm7/M1GDKqr9Vd1gOTFzEt2YIblWOocS+9eSE2KxmUsX06HoC
 gaSqpRfQ+BuFhtdpMXZzbn8p7hkVIvek8ecgBhbBrylDxpSxhre9HqxB1N5/sbDNdPLS
 ompN9XZunFsU9RPIlPMycZjGGG7n6aMCflv6UTcaYh7oK5jUnObe7BQyzhPxfNyu+XZO
 SO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FkZPWkcdepIuZo7m0/533Igkr9SAQLK/i8PmfbIafTs=;
 b=657qata+mBE0JP4wTQmAFa8n/42y2WdmW61b5yZs+efmSh3eCWgdHoZq1KRDLC7oev
 BLIr52JptGvj1ZyMfq9sH+DtTHrTDYLZiH7t11RncE+YuRolTtta3cs3FjXQOX4/pPJg
 22KoFdV3SSgniQLlU3KeOfgCoa0PMcsCW7edZHlRFEzeklefYe6NzPOzGThSt+1Lzfx4
 lxW59Jk2GXZ2VQQL7dLeChSqpXIGxS4laCU+YXWXhhOAI5Xdw33Bn742gK5CPPwmMJpg
 URrphm3Lr9cxXU0v9TjOkyutKujIj3tRhPe6dcl7SZgSAaAOw3xEP3x1w6KY5ka4sceG
 zw/g==
X-Gm-Message-State: AOAM531KhfDncWIvHVxxpAQzIPo1GE40Xr+yZ5iY04wBbkeFA9yZfMxM
 DZ09+RuD8LYHnyqVQymx2lFLqFPYeLazlGKqknOf4sYpkFEajw==
X-Google-Smtp-Source: ABdhPJzGY2xuGJJWHXYPhzEDFln+ygLq5IoLRcxHXVEFymXekm4J5416Aal05F91IRbzHf+K6Pa9WzZHBLE8uKWC23c=
X-Received: by 2002:a05:6402:5109:: with SMTP id
 m9mr15208877edd.15.1636011350318; 
 Thu, 04 Nov 2021 00:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
 <bff77e5c-7e14-32c5-6ffe-78e35271532b@kernel.org>
In-Reply-To: <bff77e5c-7e14-32c5-6ffe-78e35271532b@kernel.org>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 4 Nov 2021 15:35:24 +0800
Message-ID: <CAD-N9QVq4Lc3gEe8yZw3bBWo3Yzf=K_+KXDratJp=oyXhS_gPg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1miXHw-0016yL-PE
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix UAF in
 f2fs_available_free_memory
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Nov 4, 2021 at 3:16 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/11/3 22:22, Dongliang Mu wrote:
> > f2fs_fill_super
> > -> f2fs_build_segment_manager
> >     -> create_discard_cmd_control
> >        -> f2fs_start_discard_thread
> >
> > It invokes kthread_run to create a thread and run issue_discard_thread.
> >
> > However, if f2fs_build_node_manager fails, the control flow goes to
> > free_nm and calls f2fs_destroy_node_manager. This function will free
> > sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
> > after the deallocation, but before the f2fs_stop_discard_thread, it will
> > cause UAF(Use-after-free).
> >
> > -> f2fs_destroy_segment_manager
> >     -> destroy_discard_cmd_control
> >        -> f2fs_stop_discard_thread
> >
> > Fix this by switching the order of f2fs_build_segment_manager
> > and f2fs_build_node_manager.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/f2fs/super.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 78ebc306ee2b..1a23b64cfb74 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4135,18 +4135,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >       }
> >
> >       /* setup f2fs internal modules */
> > -     err = f2fs_build_segment_manager(sbi);
> > -     if (err) {
> > -             f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> > -                      err);
> > -             goto free_sm;
> > -     }
> >       err = f2fs_build_node_manager(sbi);
> >       if (err) {
> >               f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
> >                        err);
> >               goto free_nm;
> >       }
> > +     err = f2fs_build_segment_manager(sbi);
> > +     if (err) {
> > +             f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> > +                      err);
> > +             goto free_sm;
> > +     }
> >
> >       /* For write statistics */
> >       sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
> > @@ -4351,10 +4351,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >       sbi->node_inode = NULL;
> >   free_stats:
> >       f2fs_destroy_stats(sbi);
> > -free_nm:
> > -     f2fs_destroy_node_manager(sbi);
> >   free_sm:
> >       f2fs_destroy_segment_manager(sbi);
> > +free_nm:
> > +     f2fs_destroy_node_manager(sbi);
>
> IIRC, above two functions shouldn't not be called reversely due to some
> resource dependency, Jaegeuk, please help to confirm this.
>
> So I suggest to call destroy_discard_cmd_control() before
> f2fs_destroy_node_manager(), is it fine to you?

Maybe f2fs_stop_discard_thread is better than
destroy_discard_cmd_control. It only stops the kthread, leading to
fewer side effects.

How do you think?

>
> Thanks,
>
> >       f2fs_destroy_post_read_wq(sbi);
> >   stop_ckpt_thread:
> >       f2fs_stop_ckpt_thread(sbi);
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
