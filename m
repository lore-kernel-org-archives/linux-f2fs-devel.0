Return-Path: <SRS0=ufY1=N5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E608C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Sep 2021 18:12:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D6E60ED8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Sep 2021 18:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56D6E60ED8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mNfaO-0004lw-6A; Tue, 07 Sep 2021 18:12:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1mNfaK-0004lp-Vl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Sep 2021 18:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RPQ+nPkyctiSoFwjYHe+5+zlrPTqX7VHvSEjcWmKOqU=; b=L+3ug7gf7oEf1gBz8FLK6dy6hl
 2u0RmSlKsuer11d+DAX90wb9kN+3GD7HBSt45tinDT90hO3K+Lee/7p+1AdxdJbOlYQbZq0vvlOwi
 s86MnfDLCd1GCKcBOkfYOoevW7VJy+cGGY0f+sAsDjV6SwPZKIyMTtEyzwnjlQvCzGL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RPQ+nPkyctiSoFwjYHe+5+zlrPTqX7VHvSEjcWmKOqU=; b=EbM9a1IU3d+ynIDw1ZPcYWb2US
 akDbx2P6/Z8KvTgGhuW8IhTyj6phmY5tkDd3UoNtw1JosFC36r+vHBzmzv2Qk4xGduj22Cmc2DclF
 88dARLR6Oyrz6DyTQztpXL13o1g0sogl65hwW2mDmDRx4uoLuvMRxDHgeEbJcKexZrE0=;
Received: from mail-lj1-f172.google.com ([209.85.208.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mNfaJ-001OeD-7F
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Sep 2021 18:12:40 +0000
Received: by mail-lj1-f172.google.com with SMTP id j12so17927901ljg.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 Sep 2021 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RPQ+nPkyctiSoFwjYHe+5+zlrPTqX7VHvSEjcWmKOqU=;
 b=IMcjfhvhnkuWBL6uN8LkHcuDiuYpvEWztGTZ/9xC+7AMWAesGHu+c4rL2RV3ZlrYsm
 8pqtiROpED/MITGIurNKLgLyJSxti0vQnUaIKth6teBZFx8R9hHmMjfEyYVNhocUDZOo
 Qi2CZ+mQqk6O+36YauxwGYF4LtBcgRaCk88okEgcqfRhq/20MFIaqvmnP45yNC00gzIx
 NIz00qc23/+N5Yq1vOs2dJVVgMPNSHJj4fjndKFupf+x4B8XQ7STaBvMgm+h1JPCtbeg
 mIHsxeQO0/MFLqLwuszsysjrICrvQEGY9ml1hMLErHJxGz003qjzopPanXCYAGioY4QT
 /rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RPQ+nPkyctiSoFwjYHe+5+zlrPTqX7VHvSEjcWmKOqU=;
 b=M6clSKseyoL4kcGA56iIYmkg0lYgcek5ymq/fRV2zQex/regE9A58E9aiKYcsixTvA
 BxN2oEGvtNKbig9XCO7xcwgM+3y1nfPgM6E/aMe6fqDIvC67LToKq2IE0HVAd/DXQAPt
 aqO/27mfnIba/5Y/zrhno0jtc/5V1Qa3DFL0EkQ5OYf5RabSkOzPHRp3xGXUfkAVXUea
 XOjlKYNJ5123O6Zeqjt+p9JL3Z1VxAgRdwasOaYDz00JBkAdvAllxATjI+JefLXVb/IG
 lbbdH9Mw5BkAlwSEgPAFxpUioDXye3gF+aBwhqBPHhZ5DhB/NJs+T6rNMO0M4kin8er6
 oJUg==
X-Gm-Message-State: AOAM5310dA60e3wP7QmIMglelw3B1hzzF06m/CNH1oKpgMF5i7TzZYYB
 +pTIrZzRz4tWvyAhZW1BbtflnxlOs/rMPdrN7mE=
X-Google-Smtp-Source: ABdhPJxj0iym9uah8XB56z0pqDOAWguqvVXa/WLkhjYxbkrLSWRCTbhBAHiUXNBIB67Z4s/bOmLnyAhAPafHUxvFYZA=
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr15482853ljc.30.1631038352606; 
 Tue, 07 Sep 2021 11:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
 <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
In-Reply-To: <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 7 Sep 2021 11:12:21 -0700
Message-ID: <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1mNfaJ-001OeD-7F
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

On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/9/4 12:40, Daeho Jeong wrote:
> >> As a per curseg field.
> >>
> >>> Maybe, we run into the same race condition issue you told before for
> >>> fragment_remained_chunk.
> >>> Could you clarify this more?
> >>
> >> e.g.
> >>
> >> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
> >> fragment_chunk_size = 384
> >> fragment_hole_size = 384
> >>
> >> When creating hole:
> >>
> >> - f2fs_allocate_data_block
> >>    - __refresh_next_blkoff
> >>      chunk locates in [0, 383] of current segment
> >>      seg->next_blkoff = 384
> >>      sbi->fragment_remained_chunk = 0
> >>      then we will reset sbi->fragment_remained_chunk to 384
> >>      and move seg->next_blkoff forward to 768 (384 + 384)
> >>    - __has_curseg_space() returns false
> >>    - allocate_segment() allocates new current segment
> >>
> >> So, for such case that hole may cross two segments, hole size may be truncated
> >> to left size of previous segment.
> >
> > First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
>
> Oh, correct.
>
> > I understand what you mean, so you mean we need to take the leftover
> > "hole" size over to the next segment?
> > In the example, the leftover hole size will be (384 - (512-384)). Do
> > you want to take this over to the next segment?
>
> Yes, the left 256 block-sized hole should be created before next chunk
> in next opened segment.
>

Chao,

Do you have any decent idea to pass the left hole size to the next
segment which will be allocated?

Thanks,

> Thanks,
>
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
