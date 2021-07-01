Return-Path: <SRS0=edr7=LZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BFC11F64
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jul 2021 15:37:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C8E613FC;
	Thu,  1 Jul 2021 15:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C8E613FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lyylI-0006Vt-PO; Thu, 01 Jul 2021 15:37:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1lyylG-0006VO-Iq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 15:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4AawkGCXS8076zqa2ceQS9Q+T6ktDkZLlSiDG0RFEDc=; b=IJdyOXQimKRJbYxjvJIi7xY+xR
 2qT0foqXw1eYGrzFFk3fFOkHdWSADlBfC2G9O+VmDtYwSzBgbnBvM8i5i9h6+PJFglCfaU8DlE34/
 QkHzOYqjNtb4eLx/al2sTrK4dt6MSTQe0cwGk8OSYvhuYJfK3ZFlJ2U8oIeyA2oPnXvg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4AawkGCXS8076zqa2ceQS9Q+T6ktDkZLlSiDG0RFEDc=; b=JStWlViI5S++G7H1RMxd9CDfuy
 Ud5JR7HPGhbus7pKLjTYUh8Zd2zz3MiWuZTLNpDEyvB0O9LuBx+FjLWcxENr3sNcCa52eJlkR2ijN
 CNcNYhRtX6fRf3VDtD1lrH32kDhqiifDGNwk+WNuowbz4IPS7t9dU9SaRUdxTxJtyyHE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lyylC-006B0l-Vb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 15:37:54 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 m9-20020a05600c3b09b02901f246b43bbeso4382468wms.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Jul 2021 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4AawkGCXS8076zqa2ceQS9Q+T6ktDkZLlSiDG0RFEDc=;
 b=MJKdeO/ZRwo92yK/m4HDNEVwfcJnNgUjgPXa0GIXoXtxhcFf2eduSinBeG2lfRf7N8
 arfHhzmKJc6OjgZ3u80Wnav/tMMO/PvDQ64/1bltYZ4fbwjhOruxijD9bekyyEMA5k2+
 VHEDfg3BaTZO7tHm6DhTfiALkkBlE7c1wphVoiYiNW/EtgTYQjOBynRZRb3eygsNhTYz
 /fzYMkpljjvNMTswP5ouLQ4uY6vi1GEuPlUHb8mIRzwqEYvfGm160rmdE/pBHP5fTeG+
 FO+LVWd6kmajhXkRpUmPxx+F4Ff7lAoKkynlmf7lVimZAJtUlm06XjxAXqsieNzldK9C
 hn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4AawkGCXS8076zqa2ceQS9Q+T6ktDkZLlSiDG0RFEDc=;
 b=SqtiRcwm4ODgqqQJB8InLf4MFUdsyamz0ACwFlxxxDSOm/dJgpGBQ9Xfk7jjc06d6e
 1lljugUHyzR24+Ovce/uV2xl56A3WKcxpKNoUiP7nrYtfER/TnifX5HIaM2/7HUhvGlY
 9NigyVWPiilSXiYmAPivQGcu6hHcPv5pyvckywBhKHAs/DHv3Z6vrahpwTKeNDPJvTgQ
 RxTMto963GcqhiJLT/cd9+FwPVL2oo1hb4+GLTKjcF2GxsBGilPeLtgRPwsNoxLw0aK8
 sbiBpGmWDLXJBYBDN3vwO6o04xOWr14w4epFk+66AM990XAxPSXGtiK5m/PXvxYale7S
 J1iQ==
X-Gm-Message-State: AOAM533LB7oK772PvGsAovHjkspt5iv9d4wvPPPxVI3RSC533iJd100/
 PziG4O9vE6DsFg8JxYCgKfWQrPvFoDwClM11N1o=
X-Google-Smtp-Source: ABdhPJw83WgbDLafRLinqmNHcEfgEMwgPJTNgx2lfoPjuMO6IZwQYVdVB2s5O0sbbb4w6nVh2gP6BADr/5Fvpd4lOgU=
X-Received: by 2002:a05:600c:21c8:: with SMTP id
 x8mr11345208wmj.167.1625153864584; 
 Thu, 01 Jul 2021 08:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210628123801.3511-1-wangshilong1991@gmail.com>
 <20210628223403.GE664593@dread.disaster.area>
In-Reply-To: <20210628223403.GE664593@dread.disaster.area>
From: Wang Shilong <wangshilong1991@gmail.com>
Date: Thu, 1 Jul 2021 23:37:33 +0800
Message-ID: <CAP9B-QnCjz4UTALx0W4QA=7qTcEHTVOVid+kJW8Te-dgJoobHg@mail.gmail.com>
To: Dave Chinner <david@fromorbit.com>
X-Headers-End: 1lyylC-006B0l-Vb
Subject: Re: [f2fs-dev] [PATCH v2] fs: forbid invalid project ID
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 29, 2021 at 6:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jun 28, 2021 at 08:38:01AM -0400, Wang Shilong wrote:
> > fileattr_set_prepare() should check if project ID
> > is valid, otherwise dqget() will return NULL for
> > such project ID quota.
> >
> > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > ---
> > v1->v2: try to fix in the VFS
> > ---
> >  fs/ioctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 1e2204fa9963..5db5b218637b 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -845,6 +845,9 @@ static int fileattr_set_prepare(struct inode *inode,
> >       if (fa->fsx_cowextsize == 0)
> >               fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> >
> > +     if (!projid_valid(KPROJIDT_INIT(fa->fsx_projid)))
> > +             return -EINVAL;
>
> This needs to go further up in this function in the section where
> project IDs passed into this function are validated. Projids are
> only allowed to be changed when current_user_ns() == &init_user_ns,
> so this needs to be associated with that verification context.
>
> This check should also use make_kprojid(), please, not open code
> KPROJIDT_INIT.

You are right, let me send a V3

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
