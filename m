Return-Path: <SRS0=JHSz=OA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6573C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 15:25:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9FE611C5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 15:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D9FE611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mOiOl-00053C-46; Fri, 10 Sep 2021 15:25:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1mOiOk-000536-Bm
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 15:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZjKxxJhljDYpS5pxLUIvBKfKDGClyt9lfbrixdEiN4=; b=DRe7y7iplEO0H+6qXH2mM3ID0f
 2YKjOnDQxLOx8+FK4TjJV15t1QfhhPMMDlWbt6SWV1kqtmBgCF+e6ibNfmJqRpQwvyx5xzPx9mCSH
 0v8rmXKwBnbQjNTg8xQNc6zmPIetSgRJzfVCl6dGpLqvk0b5xjRDSYEoZrKPoBLS9Td0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HZjKxxJhljDYpS5pxLUIvBKfKDGClyt9lfbrixdEiN4=; b=PuNwsuDri1xsrnlD4C9xfyGTq/
 xgvwLvgenxIE/ZxReUo5ktGrZBjqyvYIrYC3eLF+L8gjpSwb4R1OG3UAZDrj+ksm7unzfrHW0+Ww4
 MtZFsrby3idNRRwu3xHidtXSUbFFR/6E0Ewm4t0yzLtn91XLLJGNEvLQmLYz+eEOlW0c=;
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mOiOi-006Lr9-JA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 15:25:02 +0000
Received: by mail-lj1-f179.google.com with SMTP id f2so3799156ljn.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Sep 2021 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HZjKxxJhljDYpS5pxLUIvBKfKDGClyt9lfbrixdEiN4=;
 b=CZk4eHjRRB0S9IDx1rrvd74xMZaLkjNkabIbLnVpAD5dYl1SUSxOxZs+Yyz4LS2dMj
 6Lfmu9lfrmJ+1/KsSIOPy5baFmFjfnMjUK+pW3Mi5+0/ifGafMfzw8iWZ/WSyX1DhB41
 XNMftHbTzzlwa1mAJUW0m1RgL52Kcjg4K6MfALvHsiOUBVwDxbAXLzVR0/79zrqh9PGv
 54UeGbiPKNYtvbZOzCcNhQYfxyJnFjO63aikC+ijKSjptGbD8qM2w6rU11pGccdhHaj+
 zO+zDBFqNNMGU/T8DfCmQgXhNUVggWpq6+GIpAWQRJbh9zZlVom1NUGPKUp7hmWqYJUu
 f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HZjKxxJhljDYpS5pxLUIvBKfKDGClyt9lfbrixdEiN4=;
 b=AS7UYb3T/39PnpvE59UHlSi/XF5APwyP/ogtiCa7a9MdOsuxlB05WaPNc/Fcj7FNMu
 0AXPD8iB8HjEg6+gtDm16VXdUszMcJxIk2G83qAlKLUe5+Ypea540Di0v+se5vxwE6yN
 jlvVhN32Lf+QdXHw4ZEXfpQMcUj0H04Ji6XESrhb1zKP3NT7RahVRH+/NOETw2Now2h3
 77WrRW4cqVarGRgWwSsBL4aRzAO4aHsrvR8lFjWT7czch91Wl6egvkYo1+inBUqbIh/N
 k2n9YGePg2tGT/mA+xz2ekZEeETmljMUdX7SS/ylMRylZadszQ/zVrh8au6Bsw3AHguD
 742A==
X-Gm-Message-State: AOAM5312dJfPt151GPdCzy0j4tRwGgGNdJ0IxREfIHK90KREYNBS9apj
 bDnWfn8Qbr1dIpr7/s2tgyuoveBmlHCH30xTaTXFmK8w3Is=
X-Google-Smtp-Source: ABdhPJzmV9HMQrYPGkgG2aWLS9B2OTLtQ7N720iigCvWL3xhTZlgn8ddrP3+7jnZSJJVHrjQSlCp0YddqRNbPvFLS3Q=
X-Received: by 2002:a05:651c:88e:: with SMTP id
 d14mr4541154ljq.472.1631287493966; 
 Fri, 10 Sep 2021 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
 <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
 <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
 <a59d23b9-961f-4129-7491-59f88923366a@kernel.org>
 <CACOAw_z+yfNN3p3U3Ji0vLe7xDP4vkVy11RdzwwcRwwnSTjsFg@mail.gmail.com>
In-Reply-To: <CACOAw_z+yfNN3p3U3Ji0vLe7xDP4vkVy11RdzwwcRwwnSTjsFg@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 10 Sep 2021 08:24:42 -0700
Message-ID: <CACOAw_y24AdH2Mpx4uhYbhmHnVRtUU2_4USUmi0Q61HGtE95RA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1mOiOi-006Lr9-JA
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 10, 2021 at 7:34 AM Daeho Jeong <daeho43@gmail.com> wrote:
>
> On Thu, Sep 9, 2021 at 4:50 PM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2021/9/8 2:12, Daeho Jeong wrote:
> > > On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
> > >>
> > >> On 2021/9/4 12:40, Daeho Jeong wrote:
> > >>>> As a per curseg field.
> > >>>>
> > >>>>> Maybe, we run into the same race condition issue you told before for
> > >>>>> fragment_remained_chunk.
> > >>>>> Could you clarify this more?
> > >>>>
> > >>>> e.g.
> > >>>>
> > >>>> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
> > >>>> fragment_chunk_size = 384
> > >>>> fragment_hole_size = 384
> > >>>>
> > >>>> When creating hole:
> > >>>>
> > >>>> - f2fs_allocate_data_block
> > >>>>     - __refresh_next_blkoff
> > >>>>       chunk locates in [0, 383] of current segment
> > >>>>       seg->next_blkoff = 384
> > >>>>       sbi->fragment_remained_chunk = 0
> > >>>>       then we will reset sbi->fragment_remained_chunk to 384
> > >>>>       and move seg->next_blkoff forward to 768 (384 + 384)
> > >>>>     - __has_curseg_space() returns false
> > >>>>     - allocate_segment() allocates new current segment
> > >>>>
> > >>>> So, for such case that hole may cross two segments, hole size may be truncated
> > >>>> to left size of previous segment.
> > >>>
> > >>> First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
> > >>
> > >> Oh, correct.
> > >>
> > >>> I understand what you mean, so you mean we need to take the leftover
> > >>> "hole" size over to the next segment?
> > >>> In the example, the leftover hole size will be (384 - (512-384)). Do
> > >>> you want to take this over to the next segment?
> > >>
> > >> Yes, the left 256 block-sized hole should be created before next chunk
> > >> in next opened segment.
> > >>
> > >
> > > Chao,
> > >
> > > Do you have any decent idea to pass the left hole size to the next
> > > segment which will be allocated?
> >
> > Daeho,
> >
> > I guess we can record left hole size in seg->fragment_remained_hole.
> >
>
> I understand we need a new fragment_remained_hole variable in segment structure.
> But, I mean.. How can we pass over the left hole size from the
> previous segment to the next segment?
>

I mean we don't know which segment will be the next segment, do we?

> Thanks,
>
> > Thanks,
> >
> > >
> > > Thanks,
> > >
> > >> Thanks,
> > >>
> > >>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
